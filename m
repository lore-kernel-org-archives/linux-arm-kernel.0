From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 13:58:41 +0000
Subject: [PATCH 2/2] ALSA: AACI: fix timeout duration
Message-ID: <20110125135841.GL11507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Relying on the access time of peripherals is unreliable - it depends
on the speed of the CPU and the bus.  On Versatile Express, these
timeouts were expiring, causing the driver to fail.

Add udelay(1) to ensure that they don't expire early, and adjust
timeouts to give a reasonable margin over the response times.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |   42 +++++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 21ff629..24d3013 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -30,6 +30,8 @@
 
 #define DRIVER_NAME	"aaci-pl041"
 
+#define FRAME_PERIOD_US	21
+
 /*
  * PM support is not complete.  Turn it off.
  */
@@ -64,8 +66,8 @@ static void aaci_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 			    unsigned short val)
 {
 	struct aaci *aaci = ac97->private_data;
+	int timeout;
 	u32 v;
-	int timeout = 5000;
 
 	if (ac97->num >= 4)
 		return;
@@ -81,10 +83,13 @@ static void aaci_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	writel(val << 4, aaci->base + AACI_SL2TX);
 	writel(reg << 12, aaci->base + AACI_SL1TX);
 
-	/*
-	 * Wait for the transmission of both slots to complete.
-	 */
+	/* Initially, wait one frame period */
+	udelay(FRAME_PERIOD_US);
+
+	/* And then wait an additional eight frame periods for it to be sent */
+	timeout = FRAME_PERIOD_US * 8;
 	do {
+		udelay(1);
 		v = readl(aaci->base + AACI_SLFR);
 	} while ((v & (SLFR_1TXB|SLFR_2TXB)) && --timeout);
 
@@ -101,9 +106,8 @@ static void aaci_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	struct aaci *aaci = ac97->private_data;
+	int timeout, retries = 10;
 	u32 v;
-	int timeout = 5000;
-	int retries = 10;
 
 	if (ac97->num >= 4)
 		return ~0;
@@ -117,10 +121,13 @@ static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	 */
 	writel((reg << 12) | (1 << 19), aaci->base + AACI_SL1TX);
 
-	/*
-	 * Wait for the transmission to complete.
-	 */
+	/* Initially, wait one frame period */
+	udelay(FRAME_PERIOD_US);
+
+	/* And then wait an additional eight frame periods for it to be sent */
+	timeout = FRAME_PERIOD_US * 8;
 	do {
+		udelay(1);
 		v = readl(aaci->base + AACI_SLFR);
 	} while ((v & SLFR_1TXB) && --timeout);
 
@@ -130,17 +137,13 @@ static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 		goto out;
 	}
 
-	/*
-	 * Give the AC'97 codec more than enough time
-	 * to respond. (42us = ~2 frames at 48kHz.)
-	 */
-	udelay(42);
+	/* Now wait for the response frame */
+	udelay(FRAME_PERIOD_US);
 
-	/*
-	 * Wait for slot 2 to indicate data.
-	 */
-	timeout = 5000;
+	/* And then wait an additional eight frame periods for data */
+	timeout = FRAME_PERIOD_US * 8;
 	do {
+		udelay(1);
 		cond_resched();
 		v = readl(aaci->base + AACI_SLFR) & (SLFR_1RXV|SLFR_2RXV);
 	} while ((v != (SLFR_1RXV|SLFR_2RXV)) && --timeout);
@@ -179,6 +182,7 @@ aaci_chan_wait_ready(struct aaci_runtime *aacirun, unsigned long mask)
 	int timeout = 5000;
 
 	do {
+		udelay(1);
 		val = readl(aacirun->base + AACI_SR);
 	} while (val & mask && timeout--);
 }
@@ -874,7 +878,7 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
 	 * Give the AC'97 codec more than enough time
 	 * to wake up. (42us = ~2 frames at 48kHz.)
 	 */
-	udelay(42);
+	udelay(FRAME_PERIOD_US * 2);
 
 	ret = snd_ac97_bus(aaci->card, 0, &aaci_bus_ops, aaci, &ac97_bus);
 	if (ret)
-- 
1.6.2.5

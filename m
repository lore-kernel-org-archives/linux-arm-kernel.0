From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 13:57:29 +0000
Subject: [PATCH 1/2] ALSA: AACI: fix timeout condition checking
Message-ID: <20110125135729.GK11507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that a timeout coincident with the condition being waited for
results in success rather than failure.  This helps avoid timeout
conditions being inappropriately flagged.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 91acc9a..21ff629 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -88,7 +88,7 @@ static void aaci_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 		v = readl(aaci->base + AACI_SLFR);
 	} while ((v & (SLFR_1TXB|SLFR_2TXB)) && --timeout);
 
-	if (!timeout)
+	if (v & (SLFR_1TXB|SLFR_2TXB))
 		dev_err(&aaci->dev->dev,
 			"timeout waiting for write to complete\n");
 
@@ -124,7 +124,7 @@ static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 		v = readl(aaci->base + AACI_SLFR);
 	} while ((v & SLFR_1TXB) && --timeout);
 
-	if (!timeout) {
+	if (v & SLFR_1TXB) {
 		dev_err(&aaci->dev->dev, "timeout on slot 1 TX busy\n");
 		v = ~0;
 		goto out;
@@ -145,7 +145,7 @@ static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 		v = readl(aaci->base + AACI_SLFR) & (SLFR_1RXV|SLFR_2RXV);
 	} while ((v != (SLFR_1RXV|SLFR_2RXV)) && --timeout);
 
-	if (!timeout) {
+	if (v != (SLFR_1RXV|SLFR_2RXV)) {
 		dev_err(&aaci->dev->dev, "timeout on RX valid\n");
 		v = ~0;
 		goto out;
-- 
1.6.2.5

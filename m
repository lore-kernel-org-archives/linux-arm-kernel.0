From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:08 +0900
Subject: [PATCH 3/8] ARM: shmobile: R-Car: Break infinite loop
In-Reply-To: <cover.1436510166.git.horms+renesas@verge.net.au>
References: <cover.1436510166.git.horms+renesas@verge.net.au>
Message-ID: <2f575fcff1fad24e97b8e7d793ad9af9ae5b8a17.1436510166.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

rcar_sysc_update() loops (with interrupts disabled and while holding a
spinlock) until submitting a power shutoff or resume request fails, or
until the submitted request was accepted.
If none of these conditions becomes true, this forms an infinite loop.

Put a limit on the maximum number of loop iterations, and add a small
delay to each iteration, to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rcar.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 56ea82a851cb..a5e4c3a88ec4 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -42,6 +42,9 @@
 #define SYSCSR_RETRIES		100
 #define SYSCSR_DELAY_US		1
 
+#define PWRER_RETRIES		100
+#define PWRER_DELAY_US		1
+
 #define SYSCISR_RETRIES		1000
 #define SYSCISR_DELAY_US	1
 
@@ -95,14 +98,23 @@ static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
 	/* Submit power shutoff or resume request until it was accepted */
-	do {
+	for (k = 0; k < PWRER_RETRIES; k++) {
 		ret = on_off_fn(sysc_ch);
 		if (ret)
 			goto out;
 
 		status = ioread32(rcar_sysc_base +
 				  sysc_ch->chan_offs + PWRER_OFFS);
-	} while (status & chan_mask);
+		if (!(status & chan_mask))
+			break;
+
+		udelay(PWRER_DELAY_US);
+	}
+
+	if (k == PWRER_RETRIES) {
+		ret = -EIO;
+		goto out;
+	}
 
 	/* Wait until the power shutoff or resume request has completed * */
 	for (k = 0; k < SYSCISR_RETRIES; k++) {
-- 
2.1.4

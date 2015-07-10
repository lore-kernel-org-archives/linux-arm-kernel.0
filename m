From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:06 +0900
Subject: [PATCH 1/8] ARM: shmobile: R-Car: Improve documentation
In-Reply-To: <cover.1436510166.git.horms+renesas@verge.net.au>
References: <cover.1436510166.git.horms+renesas@verge.net.au>
Message-ID: <577d104d85f05c1de6e56784a5da3e0fb4746f3a.1436510166.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add more SYSC register documentation.
Use definitions instead of hardcoded numbers.
Comment important operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rcar.c | 46 ++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 00022ee56f80..56ea82a851cb 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -15,21 +15,35 @@
 #include <asm/io.h>
 #include "pm-rcar.h"
 
-/* SYSC */
-#define SYSCSR 0x00
-#define SYSCISR 0x04
-#define SYSCISCR 0x08
+/* SYSC Common */
+#define SYSCSR			0x00	/* SYSC Status Register */
+#define SYSCISR			0x04	/* Interrupt Status Register */
+#define SYSCISCR		0x08	/* Interrupt Status Clear Register */
+#define SYSCIER			0x0c	/* Interrupt Enable Register */
+#define SYSCIMR			0x10	/* Interrupt Mask Register */
 
-#define PWRSR_OFFS 0x00
-#define PWROFFCR_OFFS 0x04
-#define PWRONCR_OFFS 0x0c
-#define PWRER_OFFS 0x14
+/* SYSC Status Register */
+#define SYSCSR_PONENB		1	/* Ready for power resume requests */
+#define SYSCSR_POFFENB		0	/* Ready for power shutoff requests */
 
-#define SYSCSR_RETRIES 100
-#define SYSCSR_DELAY_US 1
+/*
+ * Power Control Register Offsets inside the register block for each domain
+ * Note: The "CR" registers for ARM cores exist on H1 only
+ *       Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
+ */
+#define PWRSR_OFFS		0x00	/* Power Status Register */
+#define PWROFFCR_OFFS		0x04	/* Power Shutoff Control Register */
+#define PWROFFSR_OFFS		0x08	/* Power Shutoff Status Register */
+#define PWRONCR_OFFS		0x0c	/* Power Resume Control Register */
+#define PWRONSR_OFFS		0x10	/* Power Resume Status Register */
+#define PWRER_OFFS		0x14	/* Power Shutoff/Resume Error */
+
+
+#define SYSCSR_RETRIES		100
+#define SYSCSR_DELAY_US		1
 
-#define SYSCISR_RETRIES 1000
-#define SYSCISR_DELAY_US 1
+#define SYSCISR_RETRIES		1000
+#define SYSCISR_DELAY_US	1
 
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
@@ -39,6 +53,7 @@ static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
 {
 	int k;
 
+	/* Wait until SYSC is ready to accept a power request */
 	for (k = 0; k < SYSCSR_RETRIES; k++) {
 		if (ioread32(rcar_sysc_base + SYSCSR) & (1 << sr_bit))
 			break;
@@ -48,6 +63,7 @@ static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
 	if (k == SYSCSR_RETRIES)
 		return -EAGAIN;
 
+	/* Submit power shutoff or power resume request */
 	iowrite32(1 << sysc_ch->chan_bit,
 		  rcar_sysc_base + sysc_ch->chan_offs + reg_offs);
 
@@ -56,12 +72,12 @@ static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
 
 static int rcar_sysc_pwr_off(struct rcar_sysc_ch *sysc_ch)
 {
-	return rcar_sysc_pwr_on_off(sysc_ch, 0, PWROFFCR_OFFS);
+	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_POFFENB, PWROFFCR_OFFS);
 }
 
 static int rcar_sysc_pwr_on(struct rcar_sysc_ch *sysc_ch)
 {
-	return rcar_sysc_pwr_on_off(sysc_ch, 1, PWRONCR_OFFS);
+	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_PONENB, PWRONCR_OFFS);
 }
 
 static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
@@ -78,6 +94,7 @@ static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
 
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
+	/* Submit power shutoff or resume request until it was accepted */
 	do {
 		ret = on_off_fn(sysc_ch);
 		if (ret)
@@ -87,6 +104,7 @@ static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
 				  sysc_ch->chan_offs + PWRER_OFFS);
 	} while (status & chan_mask);
 
+	/* Wait until the power shutoff or resume request has completed * */
 	for (k = 0; k < SYSCISR_RETRIES; k++) {
 		if (ioread32(rcar_sysc_base + SYSCISR) & isr_mask)
 			break;
-- 
2.1.4

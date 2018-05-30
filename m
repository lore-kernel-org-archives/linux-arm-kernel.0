From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 May 2018 17:25:16 +0200
Subject: [PATCH 6/6] soc: renesas: rcar-sysc: Drop legacy handling
In-Reply-To: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
References: <1527693916-11215-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527693916-11215-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the R-Car platform code no longer supports DTBs lacking a SYSC
device node in DT, all legacy handling can be dropped from the R-Car
SYSC driver:
  - Make rcar_sysc_ch private to the driver,
  - Make rcar_sysc_power_{down,up}() static (they have been replaced by
    rcar_sysc_power_{down,up}_cpu()),
  - Remove the legacy wrapper rcar_sysc_init(), and the check for double
    initialization (only the early_initcall is left).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c       | 38 ++++++++---------------------------
 include/linux/soc/renesas/rcar-sysc.h | 11 ----------
 2 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 4ad6dcd19420a045..41af9c7b912f09ca 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -58,6 +58,12 @@
 
 #define RCAR_PD_ALWAYS_ON	32	/* Always-on power area */
 
+struct rcar_sysc_ch {
+	u16 chan_offs;
+	u8 chan_bit;
+	u8 isr_bit;
+};
+
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
@@ -143,12 +149,12 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	return ret;
 }
 
-int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
+static int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_power(sysc_ch, false);
 }
 
-int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
+static int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_power(sysc_ch, true);
 }
@@ -323,9 +329,6 @@ static int __init rcar_sysc_pd_init(void)
 	unsigned int i;
 	int error;
 
-	if (rcar_sysc_base)
-		return 0;
-
 	np = of_find_matching_node_and_match(NULL, rcar_sysc_matches, &match);
 	if (!np)
 		return -ENODEV;
@@ -428,31 +431,6 @@ void __init rcar_sysc_nullify(struct rcar_sysc_area *areas,
 		}
 }
 
-void __init rcar_sysc_init(phys_addr_t base, u32 syscier)
-{
-	u32 syscimr;
-
-	if (!rcar_sysc_pd_init())
-		return;
-
-	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
-
-	/*
-	 * Mask all interrupt sources to prevent the CPU from receiving them.
-	 * Make sure not to clear reserved bits that were set before.
-	 */
-	syscimr = ioread32(rcar_sysc_base + SYSCIMR);
-	syscimr |= syscier;
-	pr_debug("%s: syscimr = 0x%08x\n", __func__, syscimr);
-	iowrite32(syscimr, rcar_sysc_base + SYSCIMR);
-
-	/*
-	 * SYSC needs all interrupt sources enabled to control power.
-	 */
-	pr_debug("%s: syscier = 0x%08x\n", __func__, syscier);
-	iowrite32(syscier, rcar_sysc_base + SYSCIER);
-}
-
 #ifdef CONFIG_ARCH_R8A7779
 static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 {
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 9020da2111fdeea9..00fae6fd234d7895 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -2,17 +2,6 @@
 #ifndef __LINUX_SOC_RENESAS_RCAR_SYSC_H__
 #define __LINUX_SOC_RENESAS_RCAR_SYSC_H__
 
-#include <linux/types.h>
-
-struct rcar_sysc_ch {
-	u16 chan_offs;
-	u8 chan_bit;
-	u8 isr_bit;
-};
-
-int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
-int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
-void rcar_sysc_init(phys_addr_t base, u32 syscier);
 int rcar_sysc_power_down_cpu(unsigned int cpu);
 int rcar_sysc_power_up_cpu(unsigned int cpu);
 
-- 
2.7.4

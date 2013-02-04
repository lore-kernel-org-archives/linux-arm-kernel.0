From: Barry.Song@csr.com (Barry Song)
Date: Mon, 4 Feb 2013 13:41:36 +0800
Subject: [PATCH] ARM: MARCO: fix the build issue due to gic-vic-to-irqchip move
Message-ID: <1359956496-8997-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Fix the issue:
tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/soc
head:   6ed05a2aab3763b58922247543d7079106b254dc
commit: af70fdc947dbe835acc26c6ee9e8e930f38935f8 [4/8] Merge branch 'marco-timer-cleanup-rebase' of
git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel into next/soc
config: make ARCH=arm prima2_defconfig

All error/warnings:

>> arch/arm/mach-prima2/platsmp.c:20:30: fatal error: asm/hardware/gic.h: No such file or directory
   compilation terminated.
--
>> arch/arm/mach-prima2/common.c:15:30: fatal error: asm/hardware/gic.h: No such file or directory
   compilation terminated.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Xie ChanglongX <changlongx.xie@intel.com>
---
 arch/arm/mach-prima2/common.c  |   16 ++--------------
 arch/arm/mach-prima2/platsmp.c |    8 +-------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 00a6564..2d57aa4 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -8,11 +8,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/of_irq.h>
+#include <linux/irqchip.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include "common.h"
@@ -61,16 +60,6 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_MARCO
-static const struct of_device_id marco_irq_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ /* sentinel */ }
-};
-
-static void __init marco_init_irq(void)
-{
-	of_irq_init(marco_irq_match);
-}
-
 static const char *marco_dt_match[] __initdata = {
 	"sirf,marco",
 	NULL
@@ -80,9 +69,8 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.smp            = smp_ops(sirfsoc_smp_ops),
 	.map_io         = sirfsoc_map_io,
-	.init_irq	= marco_init_irq,
+	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_marco_timer_init,
-	.handle_irq     = gic_handle_irq,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 2395022..4b78831 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -11,13 +11,13 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/irqchip/arm-gic.h>
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
-#include <asm/hardware/gic.h>
 #include <mach/map.h>
 
 #include "common.h"
@@ -142,18 +142,12 @@ static int __cpuinit sirfsoc_boot_secondary(unsigned int cpu, struct task_struct
 	return pen_release != -1 ? -ENOSYS : 0;
 }
 
-static void __init sirfsoc_smp_init_cpus(void)
-{
-	set_smp_cross_call(gic_raise_softirq);
-}
-
 static void __init sirfsoc_smp_prepare_cpus(unsigned int max_cpus)
 {
 	scu_enable(scu_base);
 }
 
 struct smp_operations sirfsoc_smp_ops __initdata = {
-        .smp_init_cpus          = sirfsoc_smp_init_cpus,
         .smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
         .smp_secondary_init     = sirfsoc_secondary_init,
         .smp_boot_secondary     = sirfsoc_boot_secondary,
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

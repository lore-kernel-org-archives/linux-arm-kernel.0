From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 09:36:43 +0800
Subject: [PATCH V2 5/9] ARM: sirf: move platsmp to support atlas7 SoC
In-Reply-To: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420249007-8262-6-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

this patch breaks marco SMP support, but marco project has been dropped.
so its correct cpu1 jump/flag address for atlas7 and remove scu related
logic as scu doesn't expose in cortex-a7.

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c  |  1 -
 arch/arm/mach-prima2/platsmp.c | 52 +++++++++++-------------------------------
 2 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index bc53cc4..a20b8d4 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -23,7 +23,6 @@ static void __init sirfsoc_init_late(void)
 static __init void sirfsoc_map_io(void)
 {
 	sirfsoc_map_lluart();
-	sirfsoc_map_scu();
 }
 
 #ifdef CONFIG_ARCH_ATLAS6
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 335c12e..fc2b03c 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -20,30 +20,10 @@
 
 #include "common.h"
 
-static void __iomem *scu_base;
-static void __iomem *rsc_base;
+static void __iomem *clk_base;
 
 static DEFINE_SPINLOCK(boot_lock);
 
-static struct map_desc scu_io_desc __initdata = {
-	.length		= SZ_4K,
-	.type		= MT_DEVICE,
-};
-
-void __init sirfsoc_map_scu(void)
-{
-	unsigned long base;
-
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
-
-	scu_io_desc.virtual = SIRFSOC_VA(base);
-	scu_io_desc.pfn = __phys_to_pfn(base);
-	iotable_init(&scu_io_desc, 1);
-
-	scu_base = (void __iomem *)SIRFSOC_VA(base);
-}
-
 static void sirfsoc_secondary_init(unsigned int cpu)
 {
 	/*
@@ -60,8 +40,8 @@ static void sirfsoc_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static struct of_device_id rsc_ids[]  = {
-	{ .compatible = "sirf,marco-rsc" },
+static struct of_device_id clk_ids[]  = {
+	{ .compatible = "sirf,atlas7-clkc" },
 	{},
 };
 
@@ -70,27 +50,27 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	unsigned long timeout;
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, rsc_ids);
+	np = of_find_matching_node(NULL, clk_ids);
 	if (!np)
 		return -ENODEV;
 
-	rsc_base = of_iomap(np, 0);
-	if (!rsc_base)
+	clk_base = of_iomap(np, 0);
+	if (!clk_base)
 		return -ENOMEM;
 
 	/*
-	 * write the address of secondary startup into the sram register
-	 * at offset 0x2C, then write the magic number 0x3CAF5D62 to the
-	 * RSC register at offset 0x28, which is what boot rom code is
+	 * write the address of secondary startup into the clkc register
+	 * at offset 0x2bC, then write the magic number 0x3CAF5D62 to the
+	 * clkc register at offset 0x2b8, which is what boot rom code is
 	 * waiting for. This would wake up the secondary core from WFE
 	 */
-#define SIRFSOC_CPU1_JUMPADDR_OFFSET 0x2C
+#define SIRFSOC_CPU1_JUMPADDR_OFFSET 0x2bc
 	__raw_writel(virt_to_phys(sirfsoc_secondary_startup),
-		rsc_base + SIRFSOC_CPU1_JUMPADDR_OFFSET);
+		clk_base + SIRFSOC_CPU1_JUMPADDR_OFFSET);
 
-#define SIRFSOC_CPU1_WAKEMAGIC_OFFSET 0x28
+#define SIRFSOC_CPU1_WAKEMAGIC_OFFSET 0x2b8
 	__raw_writel(0x3CAF5D62,
-		rsc_base + SIRFSOC_CPU1_WAKEMAGIC_OFFSET);
+		clk_base + SIRFSOC_CPU1_WAKEMAGIC_OFFSET);
 
 	/* make sure write buffer is drained */
 	mb();
@@ -132,13 +112,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return pen_release != -1 ? -ENOSYS : 0;
 }
 
-static void __init sirfsoc_smp_prepare_cpus(unsigned int max_cpus)
-{
-	scu_enable(scu_base);
-}
-
 struct smp_operations sirfsoc_smp_ops __initdata = {
-	.smp_prepare_cpus       = sirfsoc_smp_prepare_cpus,
 	.smp_secondary_init     = sirfsoc_secondary_init,
 	.smp_boot_secondary     = sirfsoc_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.2.1

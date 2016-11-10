From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Nov 2016 12:54:44 +0100
Subject: [PATCH v3 1/2] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <1478693755-11953-2-git-send-email-pankaj.dubey@samsung.com>
References: <1478693755-11953-1-git-send-email-pankaj.dubey@samsung.com>
 <1478693755-11953-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5066943.nydi3GQ3KP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 9, 2016 5:45:54 PM CET Pankaj Dubey wrote:
> Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC based
> boards. Instead use mapping from device tree node of SCU.
> 
> NOTE: This patch has dependency on DT file of any such CORTEX-A9 SoC
> based boards, in the absence of SCU device node in DTS file, only single
> CPU will boot. So if you are using OUT-OF-TREE DTS file of CORTEX-A9 based
> Exynos SoC make sure to add SCU device node to DTS file for SMP boot.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

With CONFIG_SMP disabled, I now get this build failure:

arch/arm/mach-exynos/pm.o: In function `exynos_enter_aftr':
pm.c:(.text.exynos_enter_aftr+0xec): undefined reference to `exynos_scu_enable'
arch/arm/mach-exynos/suspend.o: In function `exynos_pm_resume':
suspend.c:(.text.exynos_pm_resume+0x78): undefined reference to `exynos_scu_enable'

Please fix. I have applied a patch locally (see below), but don't know
if that is the best solution. As we seem to duplicate that code across
several platforms, I wonder why we don't just put it into the core scu
implementation.

	Arnd


commit ad63b863bb78188fbe9608cfad629c86bd579dc0
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Nov 10 12:51:43 2016 +0100

    ARM: exynos: move exynos_scu_enable to main file
    
    arch/arm/mach-exynos/pm.o: In function `exynos_enter_aftr':
    pm.c:(.text.exynos_enter_aftr+0xec): undefined reference to `exynos_scu_enable'
    arch/arm/mach-exynos/suspend.o: In function `exynos_pm_resume':
    suspend.c:(.text.exynos_pm_resume+0x78): undefined reference to `exynos_scu_enable'
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index fa08ef99b4ad..784c6d47af17 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -39,6 +39,27 @@ static struct platform_device exynos_cpuidle = {
 void __iomem *sysram_base_addr;
 void __iomem *sysram_ns_base_addr;
 
+/**
+ * exynos_scu_enable : enables SCU for Cortex-A9 based system
+ * returns 0 on success else non-zero error code
+ */
+int exynos_scu_enable(void)
+{
+	struct device_node *np;
+	void __iomem *scu_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base) {
+		pr_err("%s failed to map scu_base\n", __func__);
+		return -ENOMEM;
+	}
+	scu_enable(scu_base);
+	iounmap(scu_base);
+	return 0;
+}
+
 void __init exynos_sysram_init(void)
 {
 	struct device_node *node;
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 94405c72d245..4ad376637a34 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -168,27 +168,6 @@ int exynos_cluster_power_state(int cluster)
 		S5P_CORE_LOCAL_PWR_EN);
 }
 
-/**
- * exynos_scu_enable : enables SCU for Cortex-A9 based system
- * returns 0 on success else non-zero error code
- */
-int exynos_scu_enable(void)
-{
-	struct device_node *np;
-	void __iomem *scu_base;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
-	scu_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!scu_base) {
-		pr_err("%s failed to map scu_base\n", __func__);
-		return -ENOMEM;
-	}
-	scu_enable(scu_base);
-	iounmap(scu_base);
-	return 0;
-}
-
 static void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)

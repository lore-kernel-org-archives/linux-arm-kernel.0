From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:48 -0800
Subject: [PATCH 06/35] davinci: cpuidle: move mapping of DDR2 controller
	registers out of driver
In-Reply-To: <1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

When suspend is supported, both cpuidle and suspend code
need to work on DDR2 registers. Instead of mapping the
DDR2 registers twice, do it once outside of cpuidle
driver and let cpuidle driver get the virtual base address
of DDR2 registers.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/cpuidle.c              |   33 +++----------------------
 arch/arm/mach-davinci/devices-da8xx.c        |   16 +++++++++++-
 arch/arm/mach-davinci/include/mach/cpuidle.h |    1 +
 arch/arm/mach-davinci/include/mach/da8xx.h   |    1 +
 4 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index beda3b5..bd59f31 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -106,8 +106,6 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 	int ret;
 	struct cpuidle_device *device;
 	struct davinci_cpuidle_config *pdata = pdev->dev.platform_data;
-	struct resource *ddr2_regs;
-	resource_size_t len;
 
 	device = &per_cpu(davinci_cpuidle_device, smp_processor_id());
 
@@ -116,28 +114,12 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	ddr2_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!ddr2_regs) {
-		dev_err(&pdev->dev, "cannot get DDR2 controller register base");
-		return -ENODEV;
-	}
-
-	len = resource_size(ddr2_regs);
-
-	ddr2_regs = request_mem_region(ddr2_regs->start, len, ddr2_regs->name);
-	if (!ddr2_regs)
-		return -EBUSY;
-
-	ddr2_reg_base = ioremap(ddr2_regs->start, len);
-	if (!ddr2_reg_base) {
-		ret = -ENOMEM;
-		goto ioremap_fail;
-	}
+	ddr2_reg_base = pdata->ddr2_ctlr_base;
 
 	ret = cpuidle_register_driver(&davinci_idle_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register driver\n");
-		goto driver_register_fail;
+		return ret;
 	}
 
 	/* Wait for interrupt state */
@@ -164,18 +146,11 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 	ret = cpuidle_register_device(device);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register device\n");
-		goto device_register_fail;
+		cpuidle_unregister_driver(&davinci_idle_driver);
+		return ret;
 	}
 
 	return 0;
-
-device_register_fail:
-	cpuidle_unregister_driver(&davinci_idle_driver);
-driver_register_fail:
-	iounmap(ddr2_reg_base);
-ioremap_fail:
-	release_mem_region(ddr2_regs->start, len);
-	return ret;
 }
 
 static struct platform_driver davinci_cpuidle_driver = {
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 8de5f9f..5df27f7 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -489,6 +489,19 @@ int da8xx_register_rtc(void)
 	return platform_device_register(&da8xx_rtc_device);
 }
 
+static void __iomem *da8xx_ddr2_ctlr_base;
+void __iomem * __init da8xx_get_mem_ctlr(void)
+{
+	if (da8xx_ddr2_ctlr_base)
+		return da8xx_ddr2_ctlr_base;
+
+	da8xx_ddr2_ctlr_base = ioremap(DA8XX_DDR2_CTL_BASE, SZ_32K);
+	if (!da8xx_ddr2_ctlr_base)
+		pr_warning("%s: Unable to map DDR2 controller",	__func__);
+
+	return da8xx_ddr2_ctlr_base;
+}
+
 static struct resource da8xx_cpuidle_resources[] = {
 	{
 		.start		= DA8XX_DDR2_CTL_BASE,
@@ -514,6 +527,7 @@ static struct platform_device da8xx_cpuidle_device = {
 
 int __init da8xx_register_cpuidle(void)
 {
+	da8xx_cpuidle_pdata.ddr2_ctlr_base = da8xx_get_mem_ctlr();
+
 	return platform_device_register(&da8xx_cpuidle_device);
 }
-
diff --git a/arch/arm/mach-davinci/include/mach/cpuidle.h b/arch/arm/mach-davinci/include/mach/cpuidle.h
index cbfc6a9..74f088b 100644
--- a/arch/arm/mach-davinci/include/mach/cpuidle.h
+++ b/arch/arm/mach-davinci/include/mach/cpuidle.h
@@ -12,6 +12,7 @@
 
 struct davinci_cpuidle_config {
 	u32 ddr2_pdown;
+	void __iomem *ddr2_ctlr_base;
 };
 
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index bddc4d4..cab4a25 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -94,6 +94,7 @@ void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
 int da8xx_register_rtc(void);
 int da850_register_cpufreq(void);
 int da8xx_register_cpuidle(void);
+void __iomem * __init da8xx_get_mem_ctlr(void);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.6.6.rc2.1.g42108

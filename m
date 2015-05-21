From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 14:06:30 +0200
Subject: [PATCH] ARM: imx: make imx51/3 suspend optional
Message-ID: <2236337.NNZMvqcbY8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to the imx53 power management caused a build
regression when CONFIG_SOC_IMX53 is disabled:

mach-imx/built-in.o:(.init.rodata+0x60): undefined reference to `imx53_suspend'
mach-imx/built-in.o:(.init.rodata+0x64): undefined reference to `imx53_suspend_sz'

This avoids the problem by compiling the code in question
conditionally on the presence of CONFIG_SOC_IMX53. For
consistency, I'm also changing the same thing for
CONFIG_SOC_IMX51.

An additional benefit of this approach is reduced code size
for kernels that only include support for one of the two
SoCs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 41c1b15afa2c7 ("ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.")
---
Please apply on top of the broken commit

diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index a8d00b9c9236..0309ccda36a9 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -413,10 +413,12 @@ static int __init imx5_pm_common_init(const struct imx5_pm_data *data)
 
 void __init imx51_pm_init(void)
 {
-	imx5_pm_common_init(&imx51_pm_data);
+	if (IS_ENABLED(CONFIG_SOC_IMX51))
+		imx5_pm_common_init(&imx51_pm_data);
 }
 
 void __init imx53_pm_init(void)
 {
-	imx5_pm_common_init(&imx53_pm_data);
+	if (IS_ENABLED(CONFIG_SOC_IMX53))
+		imx5_pm_common_init(&imx53_pm_data);
 }

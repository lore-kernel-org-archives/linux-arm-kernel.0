From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 24 Aug 2011 13:04:34 +0800
Subject: [[PATCH v2 3/6] ARM: mx27: Print silicon revision on boot
In-Reply-To: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
References: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314162277-2840-4-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silicon revision is useful information to have during kernel boot.

Print the MX27 silicon revision.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Resend: The patch based on Fabio initial patch, I did some change to
use generic function for displaying silicon revision and also some
naming change to avoid using the generic name
---
 arch/arm/mach-imx/clock-imx27.c |    2 ++
 arch/arm/mach-imx/cpu-imx27.c   |   28 +++++++++++++---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 6912b82..e6b1beb 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -751,6 +751,8 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_enable(&gpio_clk);
 	clk_enable(&emi_clk);
 	clk_enable(&iim_clk);
+	imx_print_silicon_rev("i.MX27", mx27_revision());
+	clk_disable(&iim_clk);
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart1_clk);
diff --git a/arch/arm/mach-imx/cpu-imx27.c b/arch/arm/mach-imx/cpu-imx27.c
index 3b117be..ff38e15 100644
--- a/arch/arm/mach-imx/cpu-imx27.c
+++ b/arch/arm/mach-imx/cpu-imx27.c
@@ -26,12 +26,12 @@
 
 #include <mach/hardware.h>
 
-static int cpu_silicon_rev = -1;
-static int cpu_partnumber;
+static int mx27_cpu_rev = -1;
+static int mx27_cpu_partnumber;
 
 #define SYS_CHIP_ID             0x00    /* The offset of CHIP ID register */
 
-static void query_silicon_parameter(void)
+static int mx27_read_cpu_rev(void)
 {
 	u32 val;
 	/*
@@ -42,20 +42,18 @@ static void query_silicon_parameter(void)
 	val = __raw_readl(MX27_IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR
 				+ SYS_CHIP_ID));
 
+	mx27_cpu_partnumber = (int)((val >> 12) & 0xFFFF);
+
 	switch (val >> 28) {
 	case 0:
-		cpu_silicon_rev = IMX_CHIP_REVISION_1_0;
-		break;
+		return IMX_CHIP_REVISION_1_0;
 	case 1:
-		cpu_silicon_rev = IMX_CHIP_REVISION_2_0;
-		break;
+		return IMX_CHIP_REVISION_2_0;
 	case 2:
-		cpu_silicon_rev = IMX_CHIP_REVISION_2_1;
-		break;
+		return IMX_CHIP_REVISION_2_1;
 	default:
-		cpu_silicon_rev = IMX_CHIP_REVISION_UNKNOWN;
+		return IMX_CHIP_REVISION_UNKNOWN;
 	}
-	cpu_partnumber = (int)((val >> 12) & 0xFFFF);
 }
 
 /*
@@ -65,12 +63,12 @@ static void query_silicon_parameter(void)
  */
 int mx27_revision(void)
 {
-	if (cpu_silicon_rev == -1)
-		query_silicon_parameter();
+	if (mx27_cpu_rev == -1)
+		mx27_cpu_rev = mx27_read_cpu_rev();
 
-	if (cpu_partnumber != 0x8821)
+	if (mx27_cpu_partnumber != 0x8821)
 		return -EINVAL;
 
-	return cpu_silicon_rev;
+	return mx27_cpu_rev;
 }
 EXPORT_SYMBOL(mx27_revision);
-- 
1.7.4.1

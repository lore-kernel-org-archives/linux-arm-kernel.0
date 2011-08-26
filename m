From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 26 Aug 2011 13:35:21 +0800
Subject: [[PATCH v3 4/6] ARM: mx31: use generic function for displaying
	silicon revision
In-Reply-To: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
References: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314336923-25162-5-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update to use generic function for displaying silicon revision

Tested on mx31pdk board as print the following information:
CPU identified as i.MX31, silicon rev 2.0

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>

---
V3: print .rev not .srev
V2: remove .v member and call imx_print_silicon_rev inside to avoid print twice
---
 arch/arm/mach-imx/clock-imx31.c       |    4 +-
 arch/arm/mach-imx/cpu-imx31.c         |   49 ++++++++++++++++++---------------
 arch/arm/plat-mxc/include/mach/mx3x.h |   11 +------
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index d973770..85b8885 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -611,11 +611,11 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_enable(&gpt_clk);
 	clk_enable(&emi_clk);
 	clk_enable(&iim_clk);
+	mx31_revision();
+	clk_disable(&iim_clk);
 
 	clk_enable(&serial_pll_clk);
 
-	mx31_read_cpu_rev();
-
 	if (mx31_revision() >= IMX_CHIP_REVISION_2_0) {
 		reg = __raw_readl(MXC_CCM_PMCR1);
 		/* No PLL restart on DVFS switch; enable auto EMI handshake */
diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index a378070..3f2345f 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -13,45 +13,50 @@
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <mach/iim.h>
+#include <mach/common.h>
 
-unsigned int mx31_cpu_rev;
-EXPORT_SYMBOL(mx31_cpu_rev);
+static int mx31_cpu_rev = -1;
 
 static struct {
 	u8 srev;
 	const char *name;
-	const char *v;
 	unsigned int rev;
-} mx31_cpu_type[] __initdata = {
-	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev = IMX_CHIP_REVISION_1_0	},
-	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev = IMX_CHIP_REVISION_1_1	},
-	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev = IMX_CHIP_REVISION_1_1	},
-	{ .srev = 0x12, .name = "i.MX31",    .v = "1.15", .rev = IMX_CHIP_REVISION_1_1	},
-	{ .srev = 0x13, .name = "i.MX31L",   .v = "1.15", .rev = IMX_CHIP_REVISION_1_1	},
-	{ .srev = 0x14, .name = "i.MX31",    .v = "1.2",  .rev = IMX_CHIP_REVISION_1_2	},
-	{ .srev = 0x15, .name = "i.MX31L",   .v = "1.2",  .rev = IMX_CHIP_REVISION_1_2	},
-	{ .srev = 0x28, .name = "i.MX31",    .v = "2.0",  .rev = IMX_CHIP_REVISION_2_0	},
-	{ .srev = 0x29, .name = "i.MX31L",   .v = "2.0",  .rev = IMX_CHIP_REVISION_2_0	},
+} mx31_cpu_type[] = {
+	{ .srev = 0x00, .name = "i.MX31(L)", .rev = IMX_CHIP_REVISION_1_0 },
+	{ .srev = 0x10, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
+	{ .srev = 0x11, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
+	{ .srev = 0x12, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
+	{ .srev = 0x13, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
+	{ .srev = 0x14, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_2 },
+	{ .srev = 0x15, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_2 },
+	{ .srev = 0x28, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_2_0 },
+	{ .srev = 0x29, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_2_0 },
 };
 
-void __init mx31_read_cpu_rev(void)
+static int mx31_read_cpu_rev(void)
 {
 	u32 i, srev;
 
 	/* read SREV register from IIM module */
 	srev = __raw_readl(MX31_IO_ADDRESS(MX31_IIM_BASE_ADDR + MXC_IIMSREV));
+	srev &= 0xff;
 
 	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
 		if (srev == mx31_cpu_type[i].srev) {
-			printk(KERN_INFO
-				"CPU identified as %s, silicon rev %s\n",
-				mx31_cpu_type[i].name, mx31_cpu_type[i].v);
-
-			mx31_cpu_rev = mx31_cpu_type[i].rev;
-			return;
+			imx_print_silicon_rev(mx31_cpu_type[i].name,
+						mx31_cpu_type[i].rev);
+			return mx31_cpu_type[i].rev;
 		}
 
-	mx31_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
+	imx_print_silicon_rev("i.MX31", IMX_CHIP_REVISION_UNKNOWN);
+	return IMX_CHIP_REVISION_UNKNOWN;
+}
+
+int mx31_revision(void)
+{
+	if (mx31_cpu_rev == -1)
+		mx31_cpu_rev = mx31_read_cpu_rev();
 
-	printk(KERN_WARNING "Unknown CPU identifier. srev = %02x\n", srev);
+	return mx31_cpu_rev;
 }
+EXPORT_SYMBOL(mx31_revision);
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 388a407..e1850f4 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -187,15 +187,6 @@
 /* Mandatory defines used globally */
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
-
-extern unsigned int mx31_cpu_rev;
-extern void mx31_read_cpu_rev(void);
-
-static inline int mx31_revision(void)
-{
-	return mx31_cpu_rev;
-}
-
 extern unsigned int mx35_cpu_rev;
 extern void mx35_read_cpu_rev(void);
 
@@ -203,6 +194,8 @@ static inline int mx35_revision(void)
 {
 	return mx35_cpu_rev;
 }
+
+extern int mx31_revision(void);
 #endif
 
 #endif /* ifndef __MACH_MX3x_H__ */
-- 
1.7.4.1

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  5 Jun 2012 11:30:30 +0200
Subject: [PATCH 2/2] ARM i.MX5: Hard reset the IPU during startup
In-Reply-To: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx5.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index a4cb441..3b028ef 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -214,6 +214,15 @@ static void __init imx51_ipu_mipi_setup(void)
 		hsc_addr + 0x800);
 }
 
+static void __init imx51_ipu_hardreset(void)
+{
+	u32 val;
+
+	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+}
+
 void __init imx51_soc_init(void)
 {
 	/* i.mx51 has the i.mx31 type gpio */
@@ -233,6 +242,16 @@ void __init imx51_soc_init(void)
 	platform_device_register_simple("imx31-audmux", 0, imx51_audmux_res,
 					ARRAY_SIZE(imx51_audmux_res));
 	imx51_ipu_mipi_setup();
+	imx51_ipu_hardreset();
+}
+
+static void __init imx53_ipu_hardreset(void)
+{
+	u32 val;
+
+	val = readl(MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
 }
 
 void __init imx53_soc_init(void)
@@ -257,6 +276,7 @@ void __init imx53_soc_init(void)
 	/* i.mx53 has the i.mx31 type audmux */
 	platform_device_register_simple("imx31-audmux", 0, imx53_audmux_res,
 					ARRAY_SIZE(imx53_audmux_res));
+	imx53_ipu_hardreset();
 }
 
 void __init imx51_init_late(void)
-- 
1.7.10

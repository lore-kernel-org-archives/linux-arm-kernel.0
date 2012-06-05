From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  5 Jun 2012 11:30:29 +0200
Subject: [PATCH 1/2] ARM i.MX51: setup mipi
In-Reply-To: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338888630-25930-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mipi unit has to be brought to a sane default state. This
unit is not present on i.MX53, so we add the setup here instead
of the ipu driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx5.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index feeee17..a4cb441 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -194,6 +194,26 @@ void __init imx50_soc_init(void)
 					ARRAY_SIZE(imx50_audmux_res));
 }
 
+/*
+ * The MIPI HSC unit has been removed from the i.MX51 Reference Manual by
+ * the Freescale marketing division. However this did not remove the
+ * hardware from the chip which still needs to be configured for proper
+ * IPU support.
+ */
+static void __init imx51_ipu_mipi_setup(void)
+{
+	void __iomem *hsc_addr;
+
+	hsc_addr = MX51_IO_ADDRESS(MX51_MIPI_HSC_BASE_ADDR);
+
+	/* setup MIPI module to legacy mode */
+	__raw_writel(0xf00, hsc_addr);
+
+	/* CSI mode: reserved; DI control mode: legacy (from Freescale BSP) */
+	__raw_writel(__raw_readl(hsc_addr + 0x800) | 0x30ff,
+		hsc_addr + 0x800);
+}
+
 void __init imx51_soc_init(void)
 {
 	/* i.mx51 has the i.mx31 type gpio */
@@ -212,6 +232,7 @@ void __init imx51_soc_init(void)
 	/* i.mx51 has the i.mx31 type audmux */
 	platform_device_register_simple("imx31-audmux", 0, imx51_audmux_res,
 					ARRAY_SIZE(imx51_audmux_res));
+	imx51_ipu_mipi_setup();
 }
 
 void __init imx53_soc_init(void)
-- 
1.7.10

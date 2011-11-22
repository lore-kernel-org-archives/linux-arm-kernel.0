From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 22 Nov 2011 10:07:26 +0100
Subject: [PATCH 1/2] ARM: imx/mm-imx3: conditionally compile i.MX31 and i.MX35
 code
In-Reply-To: <20111122090622.GC19986@pengutronix.de>
References: <20111122090622.GC19986@pengutronix.de>
Message-ID: <1321952847-3178-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes building a kernel for only one of the two SOCs. Without this
patch an i.MX31 only build fails with:

	arch/arm/mach-imx/built-in.o: In function `imx35_init_early':
	mach-bug.c:(.init.text+0x2c): undefined reference to `mxc_iomux_v3_init'
	arch/arm/mach-imx/built-in.o: In function `imx35_soc_init':
	mach-bug.c:(.init.text+0xe4): undefined reference to `mx35_revision'

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx3.c |   58 +++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 9f0e82e..72613c4 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -108,6 +108,7 @@ void imx3_init_l2x0(void)
 	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
 }
 
+#ifdef CONFIG_SOC_IMX31
 static struct map_desc mx31_io_desc[] __initdata = {
 	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
 	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
@@ -126,19 +127,6 @@ void __init mx31_map_io(void)
 	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
 }
 
-static struct map_desc mx35_io_desc[] __initdata = {
-	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
-	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
-};
-
-void __init mx35_map_io(void)
-{
-	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
-}
-
 void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
@@ -147,25 +135,11 @@ void __init imx31_init_early(void)
 	imx_ioremap = imx3_ioremap;
 }
 
-void __init imx35_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX35);
-	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
-	imx_idle = imx3_idle;
-	imx_ioremap = imx3_ioremap;
-}
-
 void __init mx31_init_irq(void)
 {
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 }
 
-void __init mx35_init_irq(void)
-{
-	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
-}
-
 static struct sdma_script_start_addrs imx31_to1_sdma_script __initdata = {
 	.per_2_per_addr = 1677,
 };
@@ -199,6 +173,35 @@ void __init imx31_soc_init(void)
 
 	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
 }
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+#ifdef CONFIG_SOC_IMX35
+static struct map_desc mx35_io_desc[] __initdata = {
+	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
+	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
+};
+
+void __init mx35_map_io(void)
+{
+	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
+}
+
+void __init imx35_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX35);
+	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
+	imx_idle = imx3_idle;
+	imx_ioremap = imx3_ioremap;
+}
+
+void __init mx35_init_irq(void)
+{
+	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
+}
 
 static struct sdma_script_start_addrs imx35_to1_sdma_script __initdata = {
 	.ap_2_ap_addr = 642,
@@ -254,3 +257,4 @@ void __init imx35_soc_init(void)
 
 	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
 }
+#endif /* ifdef CONFIG_SOC_IMX35 */
-- 
1.7.7.2

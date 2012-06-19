From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 19 Jun 2012 21:19:53 +0800
Subject: [RFC PATCH 1/1] ARM: imx: enable SPARSE_IRQ for imx
In-Reply-To: <20120619130145.GD10387@shlinux2.ap.freescale.net>
References: <20120619130145.GD10387@shlinux2.ap.freescale.net>
Message-ID: <1340111993-6676-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding irqdomain support for both tzic and avic irq chip,
the original defined hw irq number in <soc>.h file like mx53.h
can not be directly used by the driver anymore.
This issue can be found when enable SPARSE_IRQ because when
SPARSE_IRQ is enabled the linux virtual irq and hw irq is not the same
anymore even using legacy irqdomain after mapping.
User should always call irq_find_mapping() to get the correct linux virtual
irq number to use in driver level.

Tested on i.MX53 LOCO.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-imx/clk-imx21.c                   |    3 +-
 arch/arm/mach-imx/clk-imx27.c                   |    3 +-
 arch/arm/mach-imx/clk-imx31.c                   |    3 +-
 arch/arm/mach-imx/clk-imx35.c                   |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c             |    7 +-
 arch/arm/mach-imx/mm-imx1.c                     |    8 +-
 arch/arm/mach-imx/mm-imx21.c                    |   14 +++--
 arch/arm/mach-imx/mm-imx25.c                    |   15 +++--
 arch/arm/mach-imx/mm-imx27.c                    |   14 +++--
 arch/arm/mach-imx/mm-imx3.c                     |   24 +++++---
 arch/arm/mach-imx/mm-imx5.c                     |   74 +++++++++++++++++------
 arch/arm/plat-mxc/avic.c                        |   13 +++-
 arch/arm/plat-mxc/include/mach/common.h         |    3 +
 arch/arm/plat-mxc/include/mach/devices-common.h |   28 ++++++++-
 arch/arm/plat-mxc/include/mach/irqs.h           |   44 -------------
 arch/arm/plat-mxc/irq-common.h                  |    3 +
 arch/arm/plat-mxc/tzic.c                        |   13 +++-
 drivers/media/video/mx1_camera.c                |    1 +
 sound/soc/fsl/imx-pcm-fiq.c                     |    1 +
 20 files changed, 168 insertions(+), 110 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1b2752..c9c28c6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -447,6 +447,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index ea13e61..0c3aeb9 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -180,7 +180,8 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[sdhc1_ipg_gate], "sdhc1", NULL);
 	clk_register_clkdev(clk[sdhc2_ipg_gate], "sdhc2", NULL);
 
-	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR), MX21_INT_GPT1);
+	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR),
+			avic_irq_find_mapping(MX21_INT_GPT1));
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 295cbd7..49b3446 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -263,7 +263,8 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[ssi1_baud_gate], "bitrate" , "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_baud_gate], "bitrate" , "imx-ssi.1");
 
-	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
+	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
+			avic_irq_find_mapping(MX27_INT_GPT1));
 
 	clk_prepare_enable(clk[emi_ahb_gate]);
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index c9a06d8..119ae4e 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -175,7 +175,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
-	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
+	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR),
+				avic_irq_find_mapping(MX31_INT_GPT));
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 920a8cc..cb48dd9 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -267,9 +267,11 @@ int __init mx35_clocks_init()
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
 #ifdef CONFIG_MXC_USE_EPIT
-	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
+	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR),
+			avic_irq_find_mapping(MX35_INT_EPIT1));
 #else
-	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
+	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR),
+			avic_irq_find_mapping(MX35_INT_GPT));
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index a2200c7..387d595 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -366,7 +366,8 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_set_rate(clk[esdhc_b_podf], 166250000);
 
 	/* System timer */
-	mxc_timer_init(MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR), MX51_INT_GPT);
+	mxc_timer_init(MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
+			tzic_irq_find_mapping(MX53_INT_GPT));
 
 	clk_prepare_enable(clk[iim_gate]);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
@@ -451,8 +452,8 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_set_rate(clk[esdhc_b_podf], 200000000);
 
 	/* System timer */
-	mxc_timer_init(MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR), MX53_INT_GPT);
-
+	mxc_timer_init(MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
+			tzic_irq_find_mapping(MX53_INT_GPT));
 	clk_prepare_enable(clk[iim_gate]);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
 	clk_disable_unprepare(clk[iim_gate]);
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 6d60d51..332f8c8 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -51,12 +51,12 @@ void __init mx1_init_irq(void)
 void __init imx1_soc_init(void)
 {
 	mxc_register_gpio("imx1-gpio", 0, MX1_GPIO1_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTA, 0);
+				avic_irq_find_mapping(MX1_GPIO_INT_PORTA), 0);
 	mxc_register_gpio("imx1-gpio", 1, MX1_GPIO2_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTB, 0);
+				avic_irq_find_mapping(MX1_GPIO_INT_PORTB), 0);
 	mxc_register_gpio("imx1-gpio", 2, MX1_GPIO3_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTC, 0);
+				avic_irq_find_mapping(MX1_GPIO_INT_PORTC), 0);
 	mxc_register_gpio("imx1-gpio", 3, MX1_GPIO4_BASE_ADDR, SZ_256,
-						MX1_GPIO_INT_PORTD, 0);
+				avic_irq_find_mapping(MX1_GPIO_INT_PORTD), 0);
 	pinctrl_provide_dummies();
 }
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index d056dad..de42bf5 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -81,12 +81,14 @@ static const struct resource imx21_audmux_res[] __initconst = {
 
 void __init imx21_soc_init(void)
 {
-	mxc_register_gpio("imx21-gpio", 0, MX21_GPIO1_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 1, MX21_GPIO2_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 2, MX21_GPIO3_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 3, MX21_GPIO4_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 4, MX21_GPIO5_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	int int_gpio = avic_irq_find_mapping(MX21_INT_GPIO);
+
+	mxc_register_gpio("imx21-gpio", 0, MX21_GPIO1_BASE_ADDR, SZ_256, int_gpio , 0);
+	mxc_register_gpio("imx21-gpio", 1, MX21_GPIO2_BASE_ADDR, SZ_256, int_gpio , 0);
+	mxc_register_gpio("imx21-gpio", 2, MX21_GPIO3_BASE_ADDR, SZ_256, int_gpio , 0);
+	mxc_register_gpio("imx21-gpio", 3, MX21_GPIO4_BASE_ADDR, SZ_256, int_gpio , 0);
+	mxc_register_gpio("imx21-gpio", 4, MX21_GPIO5_BASE_ADDR, SZ_256, int_gpio , 0);
+	mxc_register_gpio("imx21-gpio", 5, MX21_GPIO6_BASE_ADDR, SZ_256, int_gpio , 0);
 
 	pinctrl_provide_dummies();
 	imx_add_imx_dma();
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 388928f..6338bd0 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -90,14 +90,19 @@ static const struct resource imx25_audmux_res[] __initconst = {
 void __init imx25_soc_init(void)
 {
 	/* i.mx25 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX25_GPIO1_BASE_ADDR, SZ_16K, MX25_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX25_GPIO2_BASE_ADDR, SZ_16K, MX25_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
-	mxc_register_gpio("imx31-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
+	mxc_register_gpio("imx31-gpio", 0, MX25_GPIO1_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX25_INT_GPIO1), 0);
+	mxc_register_gpio("imx31-gpio", 1, MX25_GPIO2_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX25_INT_GPIO2), 0);
+	mxc_register_gpio("imx31-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX25_INT_GPIO3), 0);
+	mxc_register_gpio("imx31-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX25_INT_GPIO4), 0);
 
 	pinctrl_provide_dummies();
 	/* i.mx25 has the i.mx35 type sdma */
-	imx_add_imx_sdma("imx35-sdma", MX25_SDMA_BASE_ADDR, MX25_INT_SDMA, &imx25_sdma_pdata);
+	imx_add_imx_sdma("imx35-sdma", MX25_SDMA_BASE_ADDR,
+			avic_irq_find_mapping(MX25_INT_SDMA), &imx25_sdma_pdata);
 	/* i.mx25 has the i.mx31 type audmux */
 	platform_device_register_simple("imx31-audmux", 0, imx25_audmux_res,
 					ARRAY_SIZE(imx25_audmux_res));
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index e7e24af..2710fdf 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -81,13 +81,15 @@ static const struct resource imx27_audmux_res[] __initconst = {
 
 void __init imx27_soc_init(void)
 {
+	int int_gpio = avic_irq_find_mapping(MX27_INT_GPIO);
+
 	/* i.mx27 has the i.mx21 type gpio */
-	mxc_register_gpio("imx21-gpio", 0, MX27_GPIO1_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 1, MX27_GPIO2_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 2, MX27_GPIO3_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 3, MX27_GPIO4_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-	mxc_register_gpio("imx21-gpio", 5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio("imx21-gpio", 0, MX27_GPIO1_BASE_ADDR, SZ_256, int_gpio, 0);
+	mxc_register_gpio("imx21-gpio", 1, MX27_GPIO2_BASE_ADDR, SZ_256, int_gpio, 0);
+	mxc_register_gpio("imx21-gpio", 2, MX27_GPIO3_BASE_ADDR, SZ_256, int_gpio, 0);
+	mxc_register_gpio("imx21-gpio", 3, MX27_GPIO4_BASE_ADDR, SZ_256, int_gpio, 0);
+	mxc_register_gpio("imx21-gpio", 4, MX27_GPIO5_BASE_ADDR, SZ_256, int_gpio, 0);
+	mxc_register_gpio("imx21-gpio", 5, MX27_GPIO6_BASE_ADDR, SZ_256, int_gpio, 0);
 
 	pinctrl_provide_dummies();
 	imx_add_imx_dma();
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index fe96105..3525634 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -176,9 +176,12 @@ void __init imx31_soc_init(void)
 
 	imx3_init_l2x0();
 
-	mxc_register_gpio("imx31-gpio", 0, MX31_GPIO1_BASE_ADDR, SZ_16K, MX31_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX31_GPIO2_BASE_ADDR, SZ_16K, MX31_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX31_GPIO3_BASE_ADDR, SZ_16K, MX31_INT_GPIO3, 0);
+	mxc_register_gpio("imx31-gpio", 0, MX31_GPIO1_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX31_INT_GPIO1), 0);
+	mxc_register_gpio("imx31-gpio", 1, MX31_GPIO2_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX31_INT_GPIO2), 0);
+	mxc_register_gpio("imx31-gpio", 2, MX31_GPIO3_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX31_INT_GPIO3), 0);
 
 	pinctrl_provide_dummies();
 
@@ -188,7 +191,8 @@ void __init imx31_soc_init(void)
 		imx31_sdma_pdata.script_addrs = &imx31_to1_sdma_script;
 	}
 
-	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
+	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR,
+			avic_irq_find_mapping(MX31_INT_SDMA), &imx31_sdma_pdata);
 
 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
@@ -273,9 +277,12 @@ void __init imx35_soc_init(void)
 	imx3_init_l2x0();
 
 	/* i.mx35 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
+	mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX35_INT_GPIO1), 0);
+	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX35_INT_GPIO2), 0);
+	mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K,
+				avic_irq_find_mapping(MX35_INT_GPIO3), 0);
 
 	pinctrl_provide_dummies();
 	if (to_version == 1) {
@@ -284,7 +291,8 @@ void __init imx35_soc_init(void)
 		imx35_sdma_pdata.script_addrs = &imx35_to1_sdma_script;
 	}
 
-	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
+	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR,
+			avic_irq_find_mapping(MX35_INT_SDMA), &imx35_sdma_pdata);
 
 	/* Setup AIPS registers */
 	imx_set_aips(MX35_IO_ADDRESS(MX35_AIPS1_BASE_ADDR));
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 1d00305..d5b067f 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -182,12 +182,24 @@ static const struct resource imx53_audmux_res[] __initconst = {
 void __init imx50_soc_init(void)
 {
 	/* i.mx50 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
-	mxc_register_gpio("imx31-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
-	mxc_register_gpio("imx31-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
+	mxc_register_gpio("imx31-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX50_INT_GPIO1_LOW),
+			tzic_irq_find_mapping(MX50_INT_GPIO1_HIGH));
+	mxc_register_gpio("imx31-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX50_INT_GPIO2_LOW),
+			tzic_irq_find_mapping(MX50_INT_GPIO2_HIGH));
+	mxc_register_gpio("imx31-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX50_INT_GPIO3_LOW),
+			tzic_irq_find_mapping(MX50_INT_GPIO3_HIGH));
+	mxc_register_gpio("imx31-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX50_INT_GPIO4_LOW),
+			tzic_irq_find_mapping(MX50_INT_GPIO4_HIGH));
+	mxc_register_gpio("imx31-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX50_INT_GPIO5_LOW),
+			tzic_irq_find_mapping(MX50_INT_GPIO5_HIGH));
+	mxc_register_gpio("imx31-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX50_INT_GPIO6_LOW),
+			tzic_irq_find_mapping(MX50_INT_GPIO6_HIGH));
 
 	/* i.mx50 has the i.mx31 type audmux */
 	platform_device_register_simple("imx31-audmux", 0, imx50_audmux_res,
@@ -197,15 +209,24 @@ void __init imx50_soc_init(void)
 void __init imx51_soc_init(void)
 {
 	/* i.mx51 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_INT_GPIO1_LOW, MX51_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_INT_GPIO2_LOW, MX51_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_INT_GPIO3_LOW, MX51_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_INT_GPIO4_LOW, MX51_INT_GPIO4_HIGH);
+	mxc_register_gpio("imx31-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX51_INT_GPIO1_LOW),
+			tzic_irq_find_mapping(MX51_INT_GPIO1_HIGH));
+	mxc_register_gpio("imx31-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX51_INT_GPIO2_LOW),
+			tzic_irq_find_mapping(MX51_INT_GPIO2_HIGH));
+	mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX51_INT_GPIO3_LOW),
+			tzic_irq_find_mapping(MX51_INT_GPIO3_HIGH));
+	mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX51_INT_GPIO4_LOW),
+			tzic_irq_find_mapping(MX51_INT_GPIO4_HIGH));
 
 	pinctrl_provide_dummies();
 
 	/* i.mx51 has the i.mx35 type sdma */
-	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
+	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR,
+			tzic_irq_find_mapping(MX51_INT_SDMA), &imx51_sdma_pdata);
 
 	/* Setup AIPS registers */
 	imx_set_aips(MX51_IO_ADDRESS(MX51_AIPS1_BASE_ADDR));
@@ -219,17 +240,32 @@ void __init imx51_soc_init(void)
 void __init imx53_soc_init(void)
 {
 	/* i.mx53 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX53_GPIO1_BASE_ADDR, SZ_16K, MX53_INT_GPIO1_LOW, MX53_INT_GPIO1_HIGH);
-	mxc_register_gpio("imx31-gpio", 1, MX53_GPIO2_BASE_ADDR, SZ_16K, MX53_INT_GPIO2_LOW, MX53_INT_GPIO2_HIGH);
-	mxc_register_gpio("imx31-gpio", 2, MX53_GPIO3_BASE_ADDR, SZ_16K, MX53_INT_GPIO3_LOW, MX53_INT_GPIO3_HIGH);
-	mxc_register_gpio("imx31-gpio", 3, MX53_GPIO4_BASE_ADDR, SZ_16K, MX53_INT_GPIO4_LOW, MX53_INT_GPIO4_HIGH);
-	mxc_register_gpio("imx31-gpio", 4, MX53_GPIO5_BASE_ADDR, SZ_16K, MX53_INT_GPIO5_LOW, MX53_INT_GPIO5_HIGH);
-	mxc_register_gpio("imx31-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
-	mxc_register_gpio("imx31-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);
+	mxc_register_gpio("imx31-gpio", 0, MX53_GPIO1_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO1_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO1_HIGH));
+	mxc_register_gpio("imx31-gpio", 1, MX53_GPIO2_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO2_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO2_HIGH));
+	mxc_register_gpio("imx31-gpio", 2, MX53_GPIO3_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO3_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO3_HIGH));
+	mxc_register_gpio("imx31-gpio", 3, MX53_GPIO4_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO4_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO4_HIGH));
+	mxc_register_gpio("imx31-gpio", 4, MX53_GPIO5_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO5_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO5_HIGH));
+	mxc_register_gpio("imx31-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO6_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO6_HIGH));
+	mxc_register_gpio("imx31-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K,
+			tzic_irq_find_mapping(MX53_INT_GPIO7_LOW),
+			tzic_irq_find_mapping(MX53_INT_GPIO7_HIGH));
 
 	pinctrl_provide_dummies();
 	/* i.mx53 has the i.mx35 type sdma */
-	imx_add_imx_sdma("imx35-sdma", MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
+	imx_add_imx_sdma("imx35-sdma", MX53_SDMA_BASE_ADDR,
+			tzic_irq_find_mapping(MX53_INT_SDMA), &imx53_sdma_pdata);
 
 	/* Setup AIPS registers */
 	imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS1_BASE_ADDR));
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 4fe1d9b..cac7fd5 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -52,10 +52,15 @@
 #define AVIC_NUM_IRQS 64
 
 void __iomem *avic_base;
-static struct irq_domain *domain;
+struct irq_domain *avic_domain;
 
 static u32 avic_saved_mask_reg[2];
 
+int avic_irq_find_mapping(unsigned int irq)
+{
+	return irq_find_mapping(avic_domain, irq);
+}
+
 #ifdef CONFIG_MXC_IRQ_PRIOR
 static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
 {
@@ -163,7 +168,7 @@ asmlinkage void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 		if (nivector == 0xffff)
 			break;
 
-		handle_IRQ(irq_find_mapping(domain, nivector), regs);
+		handle_IRQ(irq_find_mapping(avic_domain, nivector), regs);
 	} while (1);
 }
 
@@ -198,9 +203,9 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	WARN_ON(irq_base < 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
-	domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
+	avic_domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
 				       &irq_domain_simple_ops, NULL);
-	WARN_ON(!domain);
+	WARN_ON(!avic_domain);
 
 	for (i = 0; i < AVIC_NUM_IRQS / 32; i++, irq_base += 32)
 		avic_init_gc(i, irq_base);
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index e429ca1..dbe14d6 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -98,6 +98,9 @@ extern void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
 extern void imx_print_silicon_rev(const char *cpu, int srev);
 
+extern int avic_irq_find_mapping(unsigned int irq);
+extern int tzic_irq_find_mapping(unsigned int irq);
+
 void avic_handle_irq(struct pt_regs *);
 void tzic_handle_irq(struct pt_regs *);
 
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index a7f5bb1..2a84cbb 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -9,6 +9,8 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
 #include <mach/sdma.h>
 
 extern struct device mxc_aips_bus;
@@ -16,7 +18,7 @@ extern struct device mxc_ahb_bus;
 
 static inline struct platform_device *imx_add_platform_device_dmamask(
 		const char *name, int id,
-		const struct resource *res, unsigned int num_resources,
+		struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data, u64 dmamask)
 {
 	struct platform_device_info pdevinfo = {
@@ -28,12 +30,34 @@ static inline struct platform_device *imx_add_platform_device_dmamask(
 		.size_data = size_data,
 		.dma_mask = dmamask,
 	};
+
+	int i;
+
+	/* convert to linux virtual irq for driver to use */
+	for (i = 0; i < num_resources; i++) {
+		if (res[i].flags & IORESOURCE_IRQ) {
+#ifdef CONFIG_MXC_AVIC
+			if (cpu_is_mx1() || cpu_is_mx21()
+				|| cpu_is_mx25() || cpu_is_mx27()
+				|| cpu_is_mx31() || cpu_is_mx35())
+				res[i].start = avic_irq_find_mapping(res[i].start);
+#endif
+
+#ifdef CONFIG_MXC_TZIC
+			if (cpu_is_mx50() || cpu_is_mx51() || cpu_is_mx53())
+				res[i].start = tzic_irq_find_mapping(res[i].start);
+#endif
+			WARN_ON(!res[i].start);
+			res[i].end = res[i].start;
+		}
+	}
+
 	return platform_device_register_full(&pdevinfo);
 }
 
 static inline struct platform_device *imx_add_platform_device(
 		const char *name, int id,
-		const struct resource *res, unsigned int num_resources,
+		struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data)
 {
 	return imx_add_platform_device_dmamask(
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index fd9efb0..d73f5e8 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -11,50 +11,6 @@
 #ifndef __ASM_ARCH_MXC_IRQS_H__
 #define __ASM_ARCH_MXC_IRQS_H__
 
-#include <asm-generic/gpio.h>
-
-/*
- * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
- * have 128 IRQs, and those with AVIC have 64.
- *
- * To support single image, the biggest number should be defined on
- * top of the list.
- */
-#if defined CONFIG_ARM_GIC
-#define MXC_INTERNAL_IRQS	160
-#elif defined CONFIG_MXC_TZIC
-#define MXC_INTERNAL_IRQS	128
-#else
-#define MXC_INTERNAL_IRQS	64
-#endif
-
-#define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
-
-/*
- * The next 16 interrupts are for board specific purposes.  Since
- * the kernel can only run on one machine at a time, we can re-use
- * these.  If you need more, increase MXC_BOARD_IRQS, but keep it
- * within sensible limits.
- */
-#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + ARCH_NR_GPIOS)
-
-#ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
-#define MXC_BOARD_IRQS  80
-#else
-#define MXC_BOARD_IRQS	16
-#endif
-
-#define MXC_IPU_IRQ_START	(MXC_BOARD_IRQ_START + MXC_BOARD_IRQS)
-
-#ifdef CONFIG_MX3_IPU_IRQS
-#define MX3_IPU_IRQS CONFIG_MX3_IPU_IRQS
-#else
-#define MX3_IPU_IRQS 0
-#endif
-/* REVISIT: Add IPU irqs on IMX51 */
-
-#define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
-
 extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
 
 /* all normal IRQs can be FIQs */
diff --git a/arch/arm/plat-mxc/irq-common.h b/arch/arm/plat-mxc/irq-common.h
index 6ccb3a1..1cc07e4 100644
--- a/arch/arm/plat-mxc/irq-common.h
+++ b/arch/arm/plat-mxc/irq-common.h
@@ -19,6 +19,9 @@
 #ifndef __PLAT_MXC_IRQ_COMMON_H__
 #define __PLAT_MXC_IRQ_COMMON_H__
 
+extern struct irq_domain *tzic_domain;
+extern struct irq_domain *avic_domain;
+
 struct mxc_extra_irq
 {
 	int (*set_priority)(unsigned char irq, unsigned char prio);
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index abc90e4..e6bb72b 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -51,10 +51,15 @@
 #define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
 
 void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
-static struct irq_domain *domain;
+struct irq_domain *tzic_domain;
 
 #define TZIC_NUM_IRQS 128
 
+int tzic_irq_find_mapping(unsigned int irq)
+{
+	return irq_find_mapping(tzic_domain, irq);
+}
+
 #ifdef CONFIG_FIQ
 static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 {
@@ -141,7 +146,7 @@ asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
 			while (stat) {
 				handled = 1;
 				irqofs = fls(stat) - 1;
-				handle_IRQ(irq_find_mapping(domain,
+				handle_IRQ(irq_find_mapping(tzic_domain,
 						irqofs + i * 32), regs);
 				stat &= ~(1 << irqofs);
 			}
@@ -183,9 +188,9 @@ void __init tzic_init_irq(void __iomem *irqbase)
 	WARN_ON(irq_base < 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,tzic");
-	domain = irq_domain_add_legacy(np, TZIC_NUM_IRQS, irq_base, 0,
+	tzic_domain = irq_domain_add_legacy(np, TZIC_NUM_IRQS, irq_base, 0,
 				       &irq_domain_simple_ops, NULL);
-	WARN_ON(!domain);
+	WARN_ON(!tzic_domain);
 
 	for (i = 0; i < 4; i++, irq_base += 32)
 		tzic_init_gc(i, irq_base);
diff --git a/drivers/media/video/mx1_camera.c b/drivers/media/video/mx1_camera.c
index 4296a83..d2e6f82 100644
--- a/drivers/media/video/mx1_camera.c
+++ b/drivers/media/video/mx1_camera.c
@@ -43,6 +43,7 @@
 #include <asm/fiq.h>
 #include <mach/dma-mx1-mx2.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/mx1_camera.h>
 
 /*
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 456b7d7..ee27ba3 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -29,6 +29,7 @@
 
 #include <asm/fiq.h>
 
+#include <mach/irqs.h>
 #include <mach/ssi.h>
 
 #include "imx-ssi.h"
-- 
1.7.0.4

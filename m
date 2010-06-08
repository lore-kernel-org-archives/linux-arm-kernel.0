From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:03:00 +0200
Subject: [PATCH 6/8] i.MX25: add AUDMUX and SSI support
In-Reply-To: <1275987782-16094-5-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
	<1275987782-16094-2-git-send-email-eric@eukrea.com>
	<1275987782-16094-3-git-send-email-eric@eukrea.com>
	<1275987782-16094-4-git-send-email-eric@eukrea.com>
	<1275987782-16094-5-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-6-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* add clocks for audmux and ssi 1 & 2
* add irq for ssi 1 & 2
* add devices platform for ssi1 & 2
* update audmux-v2 for i.MX25
* add base addresses for audmux & ssi 1 & 2
* add iomux configuration for GPIO for AUD5 port

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/clock.c                  |   18 ++++++++++++
 arch/arm/mach-mx25/devices.c                |   38 +++++++++++++++++++++++++++
 arch/arm/mach-mx25/devices.h                |    2 +
 arch/arm/plat-mxc/Kconfig                   |    1 +
 arch/arm/plat-mxc/audmux-v2.c               |   15 ++++++++++-
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    4 +++
 arch/arm/plat-mxc/include/mach/mx25.h       |    7 ++++-
 7 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index d2835ff..bdf6e76 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -109,6 +109,16 @@ static unsigned long get_rate_uart(struct clk *clk)
 	return get_rate_per(15);
 }
 
+static unsigned long get_rate_ssi2(struct clk *clk)
+{
+	return get_rate_per(14);
+}
+
+static unsigned long get_rate_ssi1(struct clk *clk)
+{
+	return get_rate_per(13);
+}
+
 static unsigned long get_rate_i2c(struct clk *clk)
 {
 	return get_rate_per(6);
@@ -171,6 +181,8 @@ static void clk_cgcr_disable(struct clk *clk)
 
 DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
 DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(ssi1_per_clk, 0, CCM_CGCR0, 13, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(ssi2_per_clk, 0, CCM_CGCR0, 14, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
@@ -194,6 +206,9 @@ DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
 DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
 DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
+DEFINE_CLOCK(ssi1_clk,  0, CCM_CGCR2, 11, get_rate_ssi1, NULL, &ssi1_per_clk);
+DEFINE_CLOCK(ssi2_clk,  1, CCM_CGCR2, 12, get_rate_ssi2, NULL, &ssi2_per_clk);
+DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -228,6 +243,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 };
 
 int __init mx25_clocks_init(void)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 032a347..1382fcf 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -513,3 +513,41 @@ struct platform_device mxc_wdt = {
 	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
 	.resource = mxc_wdt_resources,
 };
+
+static struct resource imx_ssi_resources0[] = {
+	{
+		.start	= MX25_SSI1_BASE_ADDR,
+		.end	= MX25_SSI1_BASE_ADDR + 0x3fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= MX25_INT_SSI1,
+		.end	= MX25_INT_SSI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource imx_ssi_resources1[] = {
+	{
+		.start	= MX25_SSI2_BASE_ADDR,
+		.end	= MX25_SSI2_BASE_ADDR + 0x3fff,
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= MX25_INT_SSI2,
+		.end	= MX25_INT_SSI2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_ssi_device0 = {
+	.name = "imx-ssi",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(imx_ssi_resources0),
+	.resource = imx_ssi_resources0,
+};
+
+struct platform_device imx_ssi_device1 = {
+	.name = "imx-ssi",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(imx_ssi_resources1),
+	.resource = imx_ssi_resources1,
+};
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index cee12c0..f886e82 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -22,3 +22,5 @@ extern struct platform_device mxc_nand_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
+extern struct platform_device imx_ssi_device0;
+extern struct platform_device imx_ssi_device1;
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 7f7ad6f..902ba9e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -25,6 +25,7 @@ config ARCH_MX25
 	select CPU_ARM926T
 	select ARCH_MXC_IOMUX_V3
 	select HAVE_FB_IMX
+	select ARCH_MXC_AUDMUX_V2
 	help
 	  This enables support for systems based on the Freescale i.MX25 family
 
diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 0c2cc5c..ab94d78 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -191,6 +191,7 @@ static int mxc_audmux_v2_init(void)
 {
 	int ret;
 
+#if defined(CONFIG_ARCH_MX3)
 	if (cpu_is_mx31())
 		audmux_base = MX31_IO_ADDRESS(MX31_AUDMUX_BASE_ADDR);
 
@@ -204,7 +205,19 @@ static int mxc_audmux_v2_init(void)
 		}
 		audmux_base = MX35_IO_ADDRESS(MX35_AUDMUX_BASE_ADDR);
 	}
-
+#endif
+#if defined(CONFIG_ARCH_MX25)
+	if (cpu_is_mx25()) {
+		audmux_clk = clk_get(NULL, "audmux");
+		if (IS_ERR(audmux_clk)) {
+			ret = PTR_ERR(audmux_clk);
+			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
+					ret);
+			return ret;
+		}
+		audmux_base = MX25_IO_ADDRESS(MX25_AUDMUX_BASE_ADDR);
+	}
+#endif
 	audmux_debugfs_init();
 
 	return 0;
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index f39220d..5bea603 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -386,15 +386,19 @@
 #define MX25_PAD_KPP_ROW3__GPIO_3_0	IOMUX_PAD(0x3ac, 0x1b4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL0__KPP_COL0	IOMUX_PAD(0x3b0, 0x1b8, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL0__AUD5_TXD	IOMUX_PAD(0x3b0, 0x1b8, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL0__GPIO_3_1	IOMUX_PAD(0x3b0, 0x1b8, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL1__KPP_COL1	IOMUX_PAD(0x3b4, 0x1bc, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL1__AUD5_RXD	IOMUX_PAD(0x3b4, 0x1bc, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL1__GPIO_3_2	IOMUX_PAD(0x3b4, 0x1bc, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL2__KPP_COL2	IOMUX_PAD(0x3b8, 0x1c0, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL2__AUD5_TXC	IOMUX_PAD(0x3b8, 0x1c0, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL2__GPIO_3_3	IOMUX_PAD(0x3b8, 0x1c0, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL3__KPP_COL3	IOMUX_PAD(0x3bc, 0x1c4, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL3__AUD5_TXFS	IOMUX_PAD(0x3bc, 0x1c4, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL3__GPIO_3_4	IOMUX_PAD(0x3bc, 0x1c4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_FEC_MDC__FEC_MDC	IOMUX_PAD(0x3c0, 0x1c8, 0x10, 0, 0, NO_PAD_CTRL)
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index bc0ba27..2a5cd18 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -29,17 +29,22 @@
 
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
+#define MX25_AUDMUX_BASE_ADDR		0x43fb0000
 
 #define MX25_FEC_BASE_ADDR		0x50038000
+#define MX25_SSI2_BASE_ADDR		0x50014000
+#define MX25_SSI1_BASE_ADDR		0x50034000
 #define MX25_NFC_BASE_ADDR		0xbb000000
 #define MX25_DRYICE_BASE_ADDR		0x53ffc000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
 #define MX25_OTG_BASE_ADDR		0x53ff4000
 
+#define MX25_INT_SSI2	11
+#define MX25_INT_SSI1	12
 #define MX25_INT_DRYICE	25
-#define MX25_INT_FEC	57
 #define MX25_INT_NANDFC	33
 #define MX25_INT_LCDC	39
+#define MX25_INT_FEC	57
 
 #if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
 #define UART1_BASE_ADDR			MX25_UART1_BASE_ADDR
-- 
1.6.3.3

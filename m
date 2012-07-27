From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Fri, 27 Jul 2012 17:50:03 +0530
Subject: [PATCH v3 1/2] ARM: davinci: dm365: add support for v4l2 video display
In-Reply-To: <1343391604-25578-1-git-send-email-prabhakar.lad@ti.com>
References: <1343391604-25578-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <1343391604-25578-2-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Hadli <manjunath.hadli@ti.com>

Create platform devices for various video modules like venc,osd,
vpbe and v4l2 driver for dm365.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    4 +-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm365.c           |  214 +++++++++++++++++++++++++++++--
 3 files changed, 207 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 688a9c5..ac1f20d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -564,8 +564,6 @@ static struct davinci_uart_config uart_config __initdata = {
 
 static void __init dm365_evm_map_io(void)
 {
-	/* setup input configuration for VPFE input devices */
-	dm365_set_vpfe_config(&vpfe_cfg);
 	dm365_init();
 }
 
@@ -597,6 +595,8 @@ static __init void dm365_evm_init(void)
 
 	davinci_setup_mmc(0, &dm365evm_mmc_config);
 
+	dm365_init_video(&vpfe_cfg, NULL);
+
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
 
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 8db0fc6..94d867f 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -84,7 +84,7 @@ void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
 void __init dm365_init_rtc(void);
 void dm365_init_spi0(unsigned chipselect_mask,
 			const struct spi_board_info *info, unsigned len);
-void dm365_set_vpfe_config(struct vpfe_config *cfg);
+int __init dm365_init_video(struct vpfe_config *, struct vpbe_config *);
 
 /* DM644x function declarations */
 void __init dm644x_init(void);
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a50d49d..c839ccb 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1232,6 +1232,210 @@ static struct platform_device dm365_isif_dev = {
 	},
 };
 
+#define DM365_OSD_REG_BASE		0x01C71C00
+
+static struct resource dm365_osd_resources[] = {
+	{
+	.start	= DM365_OSD_REG_BASE,
+	.end	= DM365_OSD_REG_BASE + 0x100,
+	.flags	= IORESOURCE_MEM,
+	},
+};
+
+static u64 dm365_video_dma_mask = DMA_BIT_MASK(32);
+
+static struct osd_platform_data dm365_osd_data = {
+	.vpbe_type	= VPBE_VERSION_2,
+};
+
+static struct platform_device dm365_osd_dev = {
+	.name		= VPBE_OSD_SUBDEV_NAME,
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm365_osd_resources),
+	.resource	= dm365_osd_resources,
+	.dev		= {
+		.dma_mask		= &dm365_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &dm365_osd_data,
+	},
+};
+
+#define DM365_VENC_REG_BASE		0x01C71E00
+#define DM3XX_VDAC_CONFIG		0x01C4002C
+
+static struct resource dm365_venc_resources[] = {
+	{
+		.start	= IRQ_VENCINT,
+		.end	= IRQ_VENCINT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	/* venc registers io space */
+	{
+		.start	= DM365_VENC_REG_BASE,
+		.end	= DM365_VENC_REG_BASE + 0x180,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* vdaccfg registers io space */
+	{
+		.start	= DM3XX_VDAC_CONFIG,
+		.end	= DM3XX_VDAC_CONFIG + 4,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource dm365_v4l2_disp_resources[] = {
+	{
+		.start	= IRQ_VENCINT,
+		.end	= IRQ_VENCINT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	/* venc registers io space */
+	{
+		.start	= DM365_VENC_REG_BASE,
+		.end	= DM365_VENC_REG_BASE + 0x180,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static int dm365_vpbe_setup_pinmux(enum v4l2_mbus_pixelcode if_type,
+			    int field)
+{
+	int ret = 0;
+
+	switch (if_type) {
+	case V4L2_MBUS_FMT_SGRBG8_1X8:
+		davinci_cfg_reg(DM365_VOUT_FIELD_G81);
+		davinci_cfg_reg(DM365_VOUT_COUTL_EN);
+		davinci_cfg_reg(DM365_VOUT_COUTH_EN);
+		break;
+	case V4L2_MBUS_FMT_YUYV10_1X20:
+		if (field)
+			davinci_cfg_reg(DM365_VOUT_FIELD);
+		else
+			davinci_cfg_reg(DM365_VOUT_FIELD_G81);
+		davinci_cfg_reg(DM365_VOUT_COUTL_EN);
+		davinci_cfg_reg(DM365_VOUT_COUTH_EN);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+#define DM365_VPSS_VENCCLKEN_ENABLE		0x8
+#define DM365_VPSS_DACCLKEN_ENABLE		0x10
+#define DM365_VPSS_PLLC2SYSCLK5			0x20
+#define DM365_VPSS_CLK_CTRL_ADDR		0x44
+
+static int dm365_venc_setup_clock(enum vpbe_enc_timings_type type,
+				  unsigned int mode)
+{
+	void __iomem *vpss_clkctl_reg;
+	int ret = 0;
+
+	vpss_clkctl_reg = DAVINCI_SYSMOD_VIRT(DM365_VPSS_CLK_CTRL_ADDR);
+
+	switch (type) {
+	case VPBE_ENC_STD:
+		vpss_enable_clock(VPSS_VENC_CLOCK_SEL, 1);
+		vpss_enable_clock(VPSS_VPBE_CLOCK, 1);
+		__raw_writel(DM365_VPSS_VENCCLKEN_ENABLE +
+			DM365_VPSS_DACCLKEN_ENABLE, vpss_clkctl_reg);
+		break;
+	case VPBE_ENC_DV_PRESET:
+		switch ((unsigned int)mode) {
+		case V4L2_DV_720P60:
+		case V4L2_DV_1080I60:
+		case V4L2_DV_1080P30:
+		case V4L2_DV_1080I30:
+			/* set sysclk4 to output 74.25 MHz from pll1 */
+			__raw_writel(DM365_VPSS_PLLC2SYSCLK5 +
+				DM365_VPSS_DACCLKEN_ENABLE +
+				DM365_VPSS_VENCCLKEN_ENABLE, vpss_clkctl_reg);
+			break;
+
+		/* For LCD and EDTV cases */
+		case V4L2_DV_480P59_94:
+		case V4L2_DV_576P50:
+			vpss_enable_clock(VPSS_VENC_CLOCK_SEL, 1);
+			vpss_enable_clock(VPSS_VPBE_CLOCK, 1);
+			__raw_writel(DM365_VPSS_VENCCLKEN_ENABLE +
+				DM365_VPSS_DACCLKEN_ENABLE, vpss_clkctl_reg);
+			break;
+		default:
+			ret  = -EINVAL;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static struct platform_device dm365_vpbe_display = {
+	.name		= "vpbe-v4l2",
+	.id		= -1,
+	.num_resources  = ARRAY_SIZE(dm365_v4l2_disp_resources),
+	.resource	= dm365_v4l2_disp_resources,
+	.dev		= {
+		.dma_mask		= &dm365_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+struct venc_platform_data dm365_venc_pdata = {
+	.venc_type	= VPBE_VERSION_2,
+	.setup_pinmux	= dm365_vpbe_setup_pinmux,
+	.setup_clock	= dm365_venc_setup_clock,
+};
+
+static struct platform_device dm365_venc_dev = {
+	.name		= VPBE_VENC_SUBDEV_NAME,
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm365_venc_resources),
+	.resource	= dm365_venc_resources,
+	.dev		= {
+		.dma_mask		= &dm365_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= (void *)&dm365_venc_pdata,
+	},
+};
+
+static struct platform_device dm365_vpbe_dev = {
+	.name		= "vpbe_controller",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &dm365_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
+				struct vpbe_config *vpbe_cfg)
+{
+	if (vpfe_cfg || vpbe_cfg)
+		platform_device_register(&dm365_vpss_device);
+
+	if (vpfe_cfg) {
+		vpfe_capture_dev.dev.platform_data = vpfe_cfg;
+		platform_device_register(&dm365_isif_dev);
+		platform_device_register(&vpfe_capture_dev);
+		/* Add isif clock alias */
+		clk_add_alias("master", dm365_isif_dev.name, "vpss_master",
+					NULL);
+	}
+	if (vpbe_cfg) {
+		dm365_vpbe_dev.dev.platform_data = vpbe_cfg;
+		platform_device_register(&dm365_osd_dev);
+		platform_device_register(&dm365_venc_dev);
+		platform_device_register(&dm365_vpbe_dev);
+		platform_device_register(&dm365_vpbe_display);
+	}
+
+	return 0;
+}
+
 static int __init dm365_init_devices(void)
 {
 	if (!cpu_is_davinci_dm365())
@@ -1245,16 +1449,6 @@ static int __init dm365_init_devices(void)
 	clk_add_alias(NULL, dev_name(&dm365_mdio_device.dev),
 		      NULL, &dm365_emac_device.dev);
 
-	/* Add isif clock alias */
-	clk_add_alias("master", dm365_isif_dev.name, "vpss_master", NULL);
-	platform_device_register(&dm365_vpss_device);
-	platform_device_register(&dm365_isif_dev);
-	platform_device_register(&vpfe_capture_dev);
 	return 0;
 }
 postcore_initcall(dm365_init_devices);
-
-void dm365_set_vpfe_config(struct vpfe_config *cfg)
-{
-       vpfe_capture_dev.dev.platform_data = cfg;
-}
-- 
1.7.0.4

From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 30 Nov 2012 16:18:56 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20121130161856.985bdeb55e3a9be322e772ec@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-davinci/devices-da8xx.c between commit 3b43ad201dea
("da8xx-fb: cleanup LCDC configurations") from the omap_dss2 tree and
commit 8e0d72d2c7a6 ("ARM: davinci: da8xx: add DA850 PRUSS support") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-davinci/devices-da8xx.c
index fcb30d3,46c9a0c..0000000
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@@ -518,9 -520,98 +520,78 @@@ void __init da8xx_register_mcasp(int id
  	}
  }
  
+ static struct resource da8xx_pruss_resources[] = {
+ 	{
+ 		.start	= DA8XX_PRUSS_MEM_BASE,
+ 		.end	= DA8XX_PRUSS_MEM_BASE + 0xFFFF,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT0,
+ 		.end	= IRQ_DA8XX_EVTOUT0,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT1,
+ 		.end	= IRQ_DA8XX_EVTOUT1,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT2,
+ 		.end	= IRQ_DA8XX_EVTOUT2,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT3,
+ 		.end	= IRQ_DA8XX_EVTOUT3,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT4,
+ 		.end	= IRQ_DA8XX_EVTOUT4,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT5,
+ 		.end	= IRQ_DA8XX_EVTOUT5,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT6,
+ 		.end	= IRQ_DA8XX_EVTOUT6,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ 	{
+ 		.start	= IRQ_DA8XX_EVTOUT7,
+ 		.end	= IRQ_DA8XX_EVTOUT7,
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ };
+ 
+ static struct uio_pruss_pdata da8xx_uio_pruss_pdata = {
+ 	.pintc_base	= 0x4000,
+ };
+ 
+ static struct platform_device da8xx_uio_pruss_dev = {
+ 	.name		= "pruss_uio",
+ 	.id		= -1,
+ 	.num_resources	= ARRAY_SIZE(da8xx_pruss_resources),
+ 	.resource	= da8xx_pruss_resources,
+ 	.dev		= {
+ 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+ 		.platform_data		= &da8xx_uio_pruss_pdata,
+ 	}
+ };
+ 
+ int __init da8xx_register_uio_pruss(void)
+ {
+ 	da8xx_uio_pruss_pdata.sram_pool = sram_get_gen_pool();
+ 	return platform_device_register(&da8xx_uio_pruss_dev);
+ }
+ 
 -static const struct display_panel disp_panel = {
 -	QVGA,
 -	16,
 -	16,
 -	COLOR_ACTIVE,
 -};
 -
  static struct lcd_ctrl_config lcd_cfg = {
 -	&disp_panel,
 -	.ac_bias		= 255,
 -	.ac_bias_intrpt		= 0,
 -	.dma_burst_sz		= 16,
 +	.panel_shade		= COLOR_ACTIVE,
  	.bpp			= 16,
 -	.fdd			= 255,
 -	.tft_alt_mode		= 0,
 -	.stn_565_mode		= 0,
 -	.mono_8bit_mode		= 0,
 -	.invert_line_clock	= 1,
 -	.invert_frm_clock	= 1,
 -	.sync_edge		= 0,
 -	.sync_ctrl		= 1,
 -	.raster_order		= 0,
 -	.fifo_th		= 6,
  };
  
  struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121130/3b1da947/attachment-0001.sig>

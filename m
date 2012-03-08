From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Mar 2012 16:51:16 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120308165116.d400947f35e40a923e9c6ad0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap1/board-ams-delta.c between commit ddba6c7f7ec6
("OMAP1: pass LCD config with omapfb_set_lcd_config()") from the
omap_dss2 tree and commits 5ca6180fa6d7 ("ARM: OMAP1: ams-delta:
supersede custom led device by leds-gpio") and 2e3ee9f45b3c ("ARM: OMAP1:
Move most of plat/io.h into local iomap.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap1/board-ams-delta.c
index e0e8245,c847597..0000000
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@@ -20,7 -21,7 +21,8 @@@
  #include <linux/platform_device.h>
  #include <linux/serial_8250.h>
  #include <linux/export.h>
 +#include <linux/omapfb.h>
+ #include <linux/io.h>
  
  #include <media/soc_camera.h>
  
@@@ -170,6 -162,117 +163,113 @@@ static struct omap_usb_config ams_delta
  	.pins[0]	= 2,
  };
  
 -static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 -	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 -};
 -
+ #define LATCH1_GPIO_BASE	232
+ #define LATCH1_NGPIO		8
+ 
+ static struct resource latch1_resources[] __initconst = {
+ 	[0] = {
+ 		.name	= "dat",
+ 		.start	= LATCH1_PHYS,
+ 		.end	= LATCH1_PHYS + (LATCH1_NGPIO - 1) / 8,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ };
+ 
+ static struct bgpio_pdata latch1_pdata __initconst = {
+ 	.base	= LATCH1_GPIO_BASE,
+ 	.ngpio	= LATCH1_NGPIO,
+ };
+ 
+ static struct platform_device latch1_gpio_device = {
+ 	.name		= "basic-mmio-gpio",
+ 	.id		= 0,
+ 	.resource	= latch1_resources,
+ 	.num_resources	= ARRAY_SIZE(latch1_resources),
+ 	.dev		= {
+ 		.platform_data	= &latch1_pdata,
+ 	},
+ };
+ 
+ static struct resource latch2_resources[] __initconst = {
+ 	[0] = {
+ 		.name	= "dat",
+ 		.start	= LATCH2_PHYS,
+ 		.end	= LATCH2_PHYS + (AMS_DELTA_LATCH2_NGPIO - 1) / 8,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ };
+ 
+ static struct bgpio_pdata latch2_pdata __initconst = {
+ 	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
+ 	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
+ };
+ 
+ static struct platform_device latch2_gpio_device = {
+ 	.name		= "basic-mmio-gpio",
+ 	.id		= 1,
+ 	.resource	= latch2_resources,
+ 	.num_resources	= ARRAY_SIZE(latch2_resources),
+ 	.dev		= {
+ 		.platform_data	= &latch2_pdata,
+ 	},
+ };
+ 
+ static struct gpio latch_gpios[] __initconst = {
+ 	{
+ 		.gpio	= LATCH1_GPIO_BASE + 6,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "dockit1",
+ 	},
+ 	{
+ 		.gpio	= LATCH1_GPIO_BASE + 7,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "dockit2",
+ 	},
+ 	{
+ 		.gpio	= AMS_DELTA_GPIO_PIN_SCARD_RSTIN,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "scard_rstin",
+ 	},
+ 	{
+ 		.gpio	= AMS_DELTA_GPIO_PIN_SCARD_CMDVCC,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "scard_cmdvcc",
+ 	},
+ 	{
+ 		.gpio	= AMS_DELTA_GPIO_PIN_MODEM_NRESET,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "modem_nreset",
+ 	},
+ 	{
+ 		.gpio	= AMS_DELTA_GPIO_PIN_MODEM_CODEC,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "modem_codec",
+ 	},
+ 	{
+ 		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 14,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "hookflash1",
+ 	},
+ 	{
+ 		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 15,
+ 		.flags	= GPIOF_OUT_INIT_LOW,
+ 		.label	= "hookflash2",
+ 	},
+ };
+ 
+ void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value)
+ {
+ 	int bit = 0;
+ 	u16 bitpos = 1 << bit;
+ 
+ 	for (; bit < ngpio; bit++, bitpos = bitpos << 1) {
+ 		if (!(mask & bitpos))
+ 			continue;
+ 		gpio_set_value(base + bit, (value & bitpos) != 0);
+ 	}
+ }
+ EXPORT_SYMBOL(ams_delta_latch_write);
+ 
  static struct resource ams_delta_nand_resources[] = {
  	[0] = {
  		.start	= OMAP1_MPUIO_BASE,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/0dd7fc49/attachment.sig>

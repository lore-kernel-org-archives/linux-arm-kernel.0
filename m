From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2012 19:21:37 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120313192137.613a8bd8888c07597cba6307@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap1/board-ams-delta.c between commit ddba6c7f7ec6
("OMAP1: pass LCD config with omapfb_set_lcd_config()") from the
omap_dss2 tree and commits 2e3ee9f45b3c ("ARM: OMAP1: Move most of
plat/io.h into local iomap.h") and several others from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap1/board-ams-delta.c
index e0e8245,7dd3099..0000000
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@@ -18,9 -19,12 +19,13 @@@
  #include <linux/interrupt.h>
  #include <linux/leds.h>
  #include <linux/platform_device.h>
+ #include <linux/regulator/consumer.h>
+ #include <linux/regulator/fixed.h>
+ #include <linux/regulator/machine.h>
  #include <linux/serial_8250.h>
  #include <linux/export.h>
 +#include <linux/omapfb.h>
+ #include <linux/io.h>
  
  #include <media/soc_camera.h>
  
@@@ -170,6 -165,151 +166,147 @@@ static struct omap_usb_config ams_delta
  	.pins[0]	= 2,
  };
  
 -static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 -	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 -};
 -
+ #define LATCH1_GPIO_BASE	232
+ #define LATCH1_NGPIO		8
+ 
+ static struct resource latch1_resources[] = {
+ 	[0] = {
+ 		.name	= "dat",
+ 		.start	= LATCH1_PHYS,
+ 		.end	= LATCH1_PHYS + (LATCH1_NGPIO - 1) / 8,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ };
+ 
+ static struct bgpio_pdata latch1_pdata = {
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
+ static struct resource latch2_resources[] = {
+ 	[0] = {
+ 		.name	= "dat",
+ 		.start	= LATCH2_PHYS,
+ 		.end	= LATCH2_PHYS + (AMS_DELTA_LATCH2_NGPIO - 1) / 8,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ };
+ 
+ static struct bgpio_pdata latch2_pdata = {
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
+ static const struct gpio latch_gpios[] __initconst = {
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
+ static struct regulator_consumer_supply modem_nreset_consumers[] = {
+ 	REGULATOR_SUPPLY("RESET#", "serial8250.1"),
+ 	REGULATOR_SUPPLY("POR", "cx20442-codec"),
+ };
+ 
+ static struct regulator_init_data modem_nreset_data = {
+ 	.constraints		= {
+ 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+ 		.boot_on		= 1,
+ 	},
+ 	.num_consumer_supplies	= ARRAY_SIZE(modem_nreset_consumers),
+ 	.consumer_supplies	= modem_nreset_consumers,
+ };
+ 
+ static struct fixed_voltage_config modem_nreset_config = {
+ 	.supply_name		= "modem_nreset",
+ 	.microvolts		= 3300000,
+ 	.gpio			= AMS_DELTA_GPIO_PIN_MODEM_NRESET,
+ 	.startup_delay		= 25000,
+ 	.enable_high		= 1,
+ 	.enabled_at_boot	= 1,
+ 	.init_data		= &modem_nreset_data,
+ };
+ 
+ static struct platform_device modem_nreset_device = {
+ 	.name	= "reg-fixed-voltage",
+ 	.id	= -1,
+ 	.dev	= {
+ 		.platform_data	= &modem_nreset_config,
+ 	},
+ };
+ 
+ struct modem_private_data {
+ 	struct regulator *regulator;
+ };
+ 
+ static struct modem_private_data modem_priv;
+ 
+ void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value)
+ {
+ 	int bit = 0;
+ 	u16 bitpos = 1 << bit;
+ 
+ 	for (; bit < ngpio; bit++, bitpos = bitpos << 1) {
+ 		if (!(mask & bitpos))
+ 			continue;
+ 		else
+ 			gpio_set_value(base + bit, (value & bitpos) != 0);
+ 	}
+ }
+ EXPORT_SYMBOL(ams_delta_latch_write);
+ 
  static struct resource ams_delta_nand_resources[] = {
  	[0] = {
  		.start	= OMAP1_MPUIO_BASE,
@@@ -316,14 -496,28 +491,30 @@@ static void __init ams_delta_init(void
  	ams_delta_init_fiq();
  
  	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
 +
 +	omapfb_set_lcd_config(&ams_delta_lcd_config);
  }
  
+ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
+ {
+ 	struct modem_private_data *priv = port->private_data;
+ 
+ 	if (IS_ERR(priv->regulator))
+ 		return;
+ 
+ 	if (state == old)
+ 		return;
+ 
+ 	if (state == 0)
+ 		regulator_enable(priv->regulator);
+ 	else if (old == 0)
+ 		regulator_disable(priv->regulator);
+ }
+ 
  static struct plat_serial8250_port ams_delta_modem_ports[] = {
  	{
- 		.membase	= IOMEM(AMS_DELTA_MODEM_VIRT),
- 		.mapbase	= AMS_DELTA_MODEM_PHYS,
+ 		.membase	= IOMEM(MODEM_VIRT),
+ 		.mapbase	= MODEM_PHYS,
  		.irq		= -EINVAL, /* changed later */
  		.flags		= UPF_BOOT_AUTOCONF,
  		.irqflags	= IRQF_TRIGGER_RISING,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/b09b49c1/attachment.sig>

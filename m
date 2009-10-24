From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:23:29 +0400
Subject: [PATCH 15/20] SA1100: h3100/h3600: split h3600.c
In-Reply-To: <1256415643-22853-2-git-send-email-mad_soft@inbox.ru>
References: <1256415643-22853-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415813-22892-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split common h3600.c into three separate files: h3100.c, h3600.c and
h3xxx.c (the latter contains common code for h3100/h3600)
Copyright boilerplates and #includes are copied intact and will be
cleaned up later.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/Makefile             |    4 +-
 arch/arm/mach-sa1100/{h3600.c => h3100.c} |  368 -----------------------------
 arch/arm/mach-sa1100/h3600.c              |  333 --------------------------
 arch/arm/mach-sa1100/{h3600.c => h3xxx.c} |  201 +----------------
 arch/arm/mach-sa1100/include/mach/h3xxx.h |   14 +
 5 files changed, 19 insertions(+), 901 deletions(-)
 copy arch/arm/mach-sa1100/{h3600.c => h3100.c} (26%)
 copy arch/arm/mach-sa1100/{h3600.c => h3xxx.c} (56%)

diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index bb7b819..89349c1 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -25,8 +25,8 @@ led-$(CONFIG_SA1100_CERF)		+= leds-cerf.o
 
 obj-$(CONFIG_SA1100_COLLIE)		+= collie.o
 
-obj-$(CONFIG_SA1100_H3100)		+= h3600.o
-obj-$(CONFIG_SA1100_H3600)		+= h3600.o
+obj-$(CONFIG_SA1100_H3100)		+= h3100.o h3xxx.o
+obj-$(CONFIG_SA1100_H3600)		+= h3600.o h3xxx.o
 
 obj-$(CONFIG_SA1100_HACKKIT)		+= hackkit.o
 led-$(CONFIG_SA1100_HACKKIT)		+= leds-hackkit.o
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3100.c
similarity index 26%
copy from arch/arm/mach-sa1100/h3600.c
copy to arch/arm/mach-sa1100/h3100.c
index dd39f90..4c7778e 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -48,262 +48,6 @@
 
 #include "generic.h"
 
-struct gpio_default_state {
-	int gpio;
-	int mode;
-	const char *name;
-};
-
-#define GPIO_MODE_IN	-1
-#define GPIO_MODE_OUT0	0
-#define GPIO_MODE_OUT1	1
-
-static void h3xxx_init_gpio(struct gpio_default_state *s, size_t n)
-{
-	while (n--) {
-		const char *name = s->name;
-		int err;
-
-		if (!name)
-			name = "[init]";
-		err = gpio_request(s->gpio, name);
-		if (err) {
-			printk(KERN_ERR "gpio%u: unable to request: %d\n",
-				s->gpio, err);
-			continue;
-		}
-		if (s->mode >= 0) {
-			err = gpio_direction_output(s->gpio, s->mode);
-		} else {
-			err = gpio_direction_input(s->gpio);
-		}
-		if (err) {
-			printk(KERN_ERR "gpio%u: unable to set direction: %d\n",
-				s->gpio, err);
-			continue;
-		}
-		if (!s->name)
-			gpio_free(s->gpio);
-		s++;
-	}
-}
-
-
-/*
- * H3xxx flash support
- */
-static struct mtd_partition h3xxx_partitions[] = {
-	{
-		.name		= "H3XXX boot firmware",
-		.size		= 0x00040000,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
-	}, {
-		.name		= "H3XXX rootfs",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= 0x00040000,
-	}
-};
-
-static void h3xxx_set_vpp(int vpp)
-{
-	gpio_set_value(H3XXX_EGPIO_VPP_ON, vpp);
-}
-
-static int h3xxx_flash_init(void)
-{
-	int err = gpio_request(H3XXX_EGPIO_VPP_ON, "Flash Vpp");
-	if (err)
-		return err;
-
-	err = gpio_direction_output(H3XXX_EGPIO_VPP_ON, 0);
-	if (err)
-		gpio_free(H3XXX_EGPIO_VPP_ON);
-
-	return err;
-}
-
-static void h3xxx_flash_exit(void)
-{
-	gpio_free(H3XXX_EGPIO_VPP_ON);
-}
-
-static struct flash_platform_data h3xxx_flash_data = {
-	.map_name	= "cfi_probe",
-	.set_vpp	= h3xxx_set_vpp,
-	.init		= h3xxx_flash_init,
-	.exit		= h3xxx_flash_exit,
-	.parts		= h3xxx_partitions,
-	.nr_parts	= ARRAY_SIZE(h3xxx_partitions),
-};
-
-static struct resource h3xxx_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-
-/*
- * H3xxx uart support
- */
-static void h3xxx_uart_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser3UTCR0) {
-		gpio_set_value(H3XXX_GPIO_COM_RTS, !(mctrl & TIOCM_RTS));
-	}
-}
-
-static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
-{
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		/*
-		 * DCD and CTS bits are inverted in GPLR by RS232 transceiver
-		 */
-		if (gpio_get_value(H3XXX_GPIO_COM_DCD))
-			ret &= ~TIOCM_CD;
-		if (gpio_get_value(H3XXX_GPIO_COM_CTS))
-			ret &= ~TIOCM_CTS;
-	}
-
-	return ret;
-}
-
-static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
-{
-	if (port->mapbase == _Ser3UTCR0)
-		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
-			gpio_direction_output(H3XXX_EGPIO_RS232_ON, !state);
-			gpio_free(H3XXX_EGPIO_RS232_ON);
-		}
-}
-
-/*
- * Enable/Disable wake up events for this serial port.
- * Obviously, we only support this on the normal COM port.
- */
-static int h3xxx_uart_set_wake(struct uart_port *port, u_int enable)
-{
-	int err = -EINVAL;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		if (enable)
-			PWER |= PWER_GPIO23 | PWER_GPIO25; /* DCD and CTS */
-		else
-			PWER &= ~(PWER_GPIO23 | PWER_GPIO25); /* DCD and CTS */
-		err = 0;
-	}
-	return err;
-}
-
-static struct sa1100_port_fns h3xxx_port_fns __initdata = {
-	.set_mctrl	= h3xxx_uart_set_mctrl,
-	.get_mctrl	= h3xxx_uart_get_mctrl,
-	.pm		= h3xxx_uart_pm,
-	.set_wake	= h3xxx_uart_set_wake,
-};
-
-/*
- * EGPIO
- */
-
-static struct resource egpio_resources[] = {
-	[0] = {
-		.start	= H3600_EGPIO_PHYS,
-		.end	= H3600_EGPIO_PHYS + 0x4 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct htc_egpio_chip egpio_chips[] = {
-	[0] = {
-		.reg_start	= 0,
-		.gpio_base	= H3XXX_EGPIO_BASE,
-		.num_gpios	= 16,
-		.direction	= HTC_EGPIO_OUTPUT,
-		.initial_values	= 0x0080, /* H3XXX_EGPIO_RS232_ON */
-	},
-};
-
-static struct htc_egpio_platform_data egpio_info = {
-	.reg_width	= 16,
-	.bus_width	= 16,
-	.chip		= egpio_chips,
-	.num_chips	= ARRAY_SIZE(egpio_chips),
-};
-
-static struct platform_device h3xxx_egpio = {
-	.name		= "htc-egpio",
-	.id		= -1,
-	.resource	= egpio_resources,
-	.num_resources	= ARRAY_SIZE(egpio_resources),
-	.dev		= {
-		.platform_data = &egpio_info,
-	},
-};
-
-static struct platform_device *h3xxx_devices[] = {
-	&h3xxx_egpio,
-};
-
-static void __init h3xxx_mach_init(void)
-{
-	sa1100_register_uart_fns(&h3xxx_port_fns);
-	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
-	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
-}
-
-static struct map_desc h3600_io_desc[] __initdata = {
-  	{	/* static memory bank 2  CS#2 */
-		.virtual	=  H3600_BANK_2_VIRT,
-		.pfn		= __phys_to_pfn(SA1100_CS2_PHYS),
-		.length		= 0x02800000,
-		.type		= MT_DEVICE
-	}, {	/* static memory bank 4  CS#4 */
-		.virtual	=  H3600_BANK_4_VIRT,
-		.pfn		= __phys_to_pfn(SA1100_CS4_PHYS),
-		.length		= 0x00800000,
-		.type		= MT_DEVICE
-	}, {	/* EGPIO 0		CS#5 */
-		.virtual	=  H3600_EGPIO_VIRT,
-		.pfn		= __phys_to_pfn(H3600_EGPIO_PHYS),
-		.length		= 0x01000000,
-		.type		= MT_DEVICE
-	}
-};
-
-/*
- * Common map_io initialization
- */
-
-static void __init h3xxx_map_io(void)
-{
-	sa1100_map_io();
-	iotable_init(h3600_io_desc, ARRAY_SIZE(h3600_io_desc));
-
-	sa1100_register_uart(0, 3); /* Common serial port */
-//	sa1100_register_uart(1, 1); /* Microcontroller on 3100/3600 */
-
-	/* Ensure those pins are outputs and driving low  */
-	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
-	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
-
-	/* Configure suspend conditions */
-	PGSR = 0;
-	PWER = PWER_GPIO0;
-	PCFR = PCFR_OPDE;
-	PSDR = 0;
-
-	GPCR = 0x0fffffff;	/* All outputs are set low by default */
-	GPDR = 0;		/* Configure all GPIOs as input */
-}
-
-/************************* H3100 *************************/
-
-#ifdef CONFIG_SA1100_H3100
-
 /*
  * helper for sa1100fb
  */
@@ -373,115 +117,3 @@ MACHINE_START(H3100, "Compaq iPAQ H3100")
 	.init_machine	= h3100_mach_init,
 MACHINE_END
 
-#endif /* CONFIG_SA1100_H3100 */
-
-/************************* H3600 *************************/
-
-#ifdef CONFIG_SA1100_H3600
-
-/*
- * helper for sa1100fb
- */
-static void h3600_lcd_power(int enable)
-{
-	if (gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power"))
-		goto err1;
-	if (gpio_request(H3600_EGPIO_LCD_PCI, "LCD control"))
-		goto err2;
-	if (gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v"))
-		goto err3;
-	if (gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v"))
-		goto err4;
-
-	gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
-	gpio_direction_output(H3600_EGPIO_LCD_PCI, enable);
-	gpio_direction_output(H3600_EGPIO_LCD_5V_ON, enable);
-	gpio_direction_output(H3600_EGPIO_LVDD_ON, enable);
-
-	gpio_free(H3600_EGPIO_LVDD_ON);
-err4:	gpio_free(H3600_EGPIO_LCD_5V_ON);
-err3:	gpio_free(H3600_EGPIO_LCD_PCI);
-err2:	gpio_free(H3XXX_EGPIO_LCD_ON);
-err1:	return;
-}
-
-static void __init h3600_map_io(void)
-{
-	h3xxx_map_io();
-
-	sa1100fb_lcd_power = h3600_lcd_power;
-}
-
-/*
- * This turns the IRDA power on or off on the Compaq H3600
- */
-static int h3600_irda_set_power(struct device *dev, unsigned int state)
-{
-	gpio_set_value(H3600_EGPIO_IR_ON, state);
-	return 0;
-}
-
-static void h3600_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	gpio_set_value(H3600_EGPIO_IR_FSEL, !(speed < 4000000));
-}
-
-static int h3600_irda_startup(struct device *dev)
-{
-	int err = gpio_request(H3600_EGPIO_IR_ON, "IrDA power");
-	if (err)
-		goto err1;
-	err = gpio_direction_output(H3600_EGPIO_IR_ON, 0);
-	if (err)
-		goto err2;
-	err = gpio_request(H3600_EGPIO_IR_FSEL, "IrDA fsel");
-	if (err)
-		goto err2;
-	err = gpio_direction_output(H3600_EGPIO_IR_FSEL, 0);
-	if (err)
-		goto err3;
-	return 0;
-
-err3:	gpio_free(H3600_EGPIO_IR_FSEL);
-err2:	gpio_free(H3600_EGPIO_IR_ON);
-err1:	return err;
-}
-
-static void h3600_irda_shutdown(struct device *dev)
-{
-	gpio_free(H3600_EGPIO_IR_ON);
-	gpio_free(H3600_EGPIO_IR_FSEL);
-}
-
-static struct irda_platform_data h3600_irda_data = {
-	.set_power	= h3600_irda_set_power,
-	.set_speed	= h3600_irda_set_speed,
-	.startup	= h3600_irda_startup,
-	.shutdown	= h3600_irda_shutdown,
-};
-
-static struct gpio_default_state h3600_default_gpio[] = {
-	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-};
-
-static void __init h3600_mach_init(void)
-{
-	h3xxx_init_gpio(h3600_default_gpio, ARRAY_SIZE(h3600_default_gpio));
-	h3xxx_mach_init();
-	sa11x0_register_irda(&h3600_irda_data);
-}
-
-MACHINE_START(H3600, "Compaq iPAQ H3600")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
-	.boot_params	= 0xc0000100,
-	.map_io		= h3600_map_io,
-	.init_irq	= sa1100_init_irq,
-	.timer		= &sa1100_timer,
-	.init_machine	= h3600_mach_init,
-MACHINE_END
-
-#endif /* CONFIG_SA1100_H3600 */
-
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index dd39f90..65ab286 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -48,337 +48,6 @@
 
 #include "generic.h"
 
-struct gpio_default_state {
-	int gpio;
-	int mode;
-	const char *name;
-};
-
-#define GPIO_MODE_IN	-1
-#define GPIO_MODE_OUT0	0
-#define GPIO_MODE_OUT1	1
-
-static void h3xxx_init_gpio(struct gpio_default_state *s, size_t n)
-{
-	while (n--) {
-		const char *name = s->name;
-		int err;
-
-		if (!name)
-			name = "[init]";
-		err = gpio_request(s->gpio, name);
-		if (err) {
-			printk(KERN_ERR "gpio%u: unable to request: %d\n",
-				s->gpio, err);
-			continue;
-		}
-		if (s->mode >= 0) {
-			err = gpio_direction_output(s->gpio, s->mode);
-		} else {
-			err = gpio_direction_input(s->gpio);
-		}
-		if (err) {
-			printk(KERN_ERR "gpio%u: unable to set direction: %d\n",
-				s->gpio, err);
-			continue;
-		}
-		if (!s->name)
-			gpio_free(s->gpio);
-		s++;
-	}
-}
-
-
-/*
- * H3xxx flash support
- */
-static struct mtd_partition h3xxx_partitions[] = {
-	{
-		.name		= "H3XXX boot firmware",
-		.size		= 0x00040000,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
-	}, {
-		.name		= "H3XXX rootfs",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= 0x00040000,
-	}
-};
-
-static void h3xxx_set_vpp(int vpp)
-{
-	gpio_set_value(H3XXX_EGPIO_VPP_ON, vpp);
-}
-
-static int h3xxx_flash_init(void)
-{
-	int err = gpio_request(H3XXX_EGPIO_VPP_ON, "Flash Vpp");
-	if (err)
-		return err;
-
-	err = gpio_direction_output(H3XXX_EGPIO_VPP_ON, 0);
-	if (err)
-		gpio_free(H3XXX_EGPIO_VPP_ON);
-
-	return err;
-}
-
-static void h3xxx_flash_exit(void)
-{
-	gpio_free(H3XXX_EGPIO_VPP_ON);
-}
-
-static struct flash_platform_data h3xxx_flash_data = {
-	.map_name	= "cfi_probe",
-	.set_vpp	= h3xxx_set_vpp,
-	.init		= h3xxx_flash_init,
-	.exit		= h3xxx_flash_exit,
-	.parts		= h3xxx_partitions,
-	.nr_parts	= ARRAY_SIZE(h3xxx_partitions),
-};
-
-static struct resource h3xxx_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-
-/*
- * H3xxx uart support
- */
-static void h3xxx_uart_set_mctrl(struct uart_port *port, u_int mctrl)
-{
-	if (port->mapbase == _Ser3UTCR0) {
-		gpio_set_value(H3XXX_GPIO_COM_RTS, !(mctrl & TIOCM_RTS));
-	}
-}
-
-static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
-{
-	u_int ret = TIOCM_CD | TIOCM_CTS | TIOCM_DSR;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		/*
-		 * DCD and CTS bits are inverted in GPLR by RS232 transceiver
-		 */
-		if (gpio_get_value(H3XXX_GPIO_COM_DCD))
-			ret &= ~TIOCM_CD;
-		if (gpio_get_value(H3XXX_GPIO_COM_CTS))
-			ret &= ~TIOCM_CTS;
-	}
-
-	return ret;
-}
-
-static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
-{
-	if (port->mapbase == _Ser3UTCR0)
-		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
-			gpio_direction_output(H3XXX_EGPIO_RS232_ON, !state);
-			gpio_free(H3XXX_EGPIO_RS232_ON);
-		}
-}
-
-/*
- * Enable/Disable wake up events for this serial port.
- * Obviously, we only support this on the normal COM port.
- */
-static int h3xxx_uart_set_wake(struct uart_port *port, u_int enable)
-{
-	int err = -EINVAL;
-
-	if (port->mapbase == _Ser3UTCR0) {
-		if (enable)
-			PWER |= PWER_GPIO23 | PWER_GPIO25; /* DCD and CTS */
-		else
-			PWER &= ~(PWER_GPIO23 | PWER_GPIO25); /* DCD and CTS */
-		err = 0;
-	}
-	return err;
-}
-
-static struct sa1100_port_fns h3xxx_port_fns __initdata = {
-	.set_mctrl	= h3xxx_uart_set_mctrl,
-	.get_mctrl	= h3xxx_uart_get_mctrl,
-	.pm		= h3xxx_uart_pm,
-	.set_wake	= h3xxx_uart_set_wake,
-};
-
-/*
- * EGPIO
- */
-
-static struct resource egpio_resources[] = {
-	[0] = {
-		.start	= H3600_EGPIO_PHYS,
-		.end	= H3600_EGPIO_PHYS + 0x4 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct htc_egpio_chip egpio_chips[] = {
-	[0] = {
-		.reg_start	= 0,
-		.gpio_base	= H3XXX_EGPIO_BASE,
-		.num_gpios	= 16,
-		.direction	= HTC_EGPIO_OUTPUT,
-		.initial_values	= 0x0080, /* H3XXX_EGPIO_RS232_ON */
-	},
-};
-
-static struct htc_egpio_platform_data egpio_info = {
-	.reg_width	= 16,
-	.bus_width	= 16,
-	.chip		= egpio_chips,
-	.num_chips	= ARRAY_SIZE(egpio_chips),
-};
-
-static struct platform_device h3xxx_egpio = {
-	.name		= "htc-egpio",
-	.id		= -1,
-	.resource	= egpio_resources,
-	.num_resources	= ARRAY_SIZE(egpio_resources),
-	.dev		= {
-		.platform_data = &egpio_info,
-	},
-};
-
-static struct platform_device *h3xxx_devices[] = {
-	&h3xxx_egpio,
-};
-
-static void __init h3xxx_mach_init(void)
-{
-	sa1100_register_uart_fns(&h3xxx_port_fns);
-	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
-	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
-}
-
-static struct map_desc h3600_io_desc[] __initdata = {
-  	{	/* static memory bank 2  CS#2 */
-		.virtual	=  H3600_BANK_2_VIRT,
-		.pfn		= __phys_to_pfn(SA1100_CS2_PHYS),
-		.length		= 0x02800000,
-		.type		= MT_DEVICE
-	}, {	/* static memory bank 4  CS#4 */
-		.virtual	=  H3600_BANK_4_VIRT,
-		.pfn		= __phys_to_pfn(SA1100_CS4_PHYS),
-		.length		= 0x00800000,
-		.type		= MT_DEVICE
-	}, {	/* EGPIO 0		CS#5 */
-		.virtual	=  H3600_EGPIO_VIRT,
-		.pfn		= __phys_to_pfn(H3600_EGPIO_PHYS),
-		.length		= 0x01000000,
-		.type		= MT_DEVICE
-	}
-};
-
-/*
- * Common map_io initialization
- */
-
-static void __init h3xxx_map_io(void)
-{
-	sa1100_map_io();
-	iotable_init(h3600_io_desc, ARRAY_SIZE(h3600_io_desc));
-
-	sa1100_register_uart(0, 3); /* Common serial port */
-//	sa1100_register_uart(1, 1); /* Microcontroller on 3100/3600 */
-
-	/* Ensure those pins are outputs and driving low  */
-	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
-	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
-
-	/* Configure suspend conditions */
-	PGSR = 0;
-	PWER = PWER_GPIO0;
-	PCFR = PCFR_OPDE;
-	PSDR = 0;
-
-	GPCR = 0x0fffffff;	/* All outputs are set low by default */
-	GPDR = 0;		/* Configure all GPIOs as input */
-}
-
-/************************* H3100 *************************/
-
-#ifdef CONFIG_SA1100_H3100
-
-/*
- * helper for sa1100fb
- */
-static void h3100_lcd_power(int enable)
-{
-	if (!gpio_request(H3XXX_EGPIO_LCD_ON, "LCD ON")) {
-		gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
-		gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
-		gpio_free(H3XXX_EGPIO_LCD_ON);
-	}
-}
-
-
-static void __init h3100_map_io(void)
-{
-	h3xxx_map_io();
-
-	sa1100fb_lcd_power = h3100_lcd_power;
-
-	/* Older bootldrs put GPIO2-9 in alternate mode on the
-	   assumption that they are used for video */
-	GAFR &= ~0x000001fb;
-}
-
-/*
- * This turns the IRDA power on or off on the Compaq H3100
- */
-static int h3100_irda_set_power(struct device *dev, unsigned int state)
-{
-	gpio_set_value(H3100_GPIO_IR_ON, state);
-	return 0;
-}
-
-static void h3100_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	gpio_set_value(H3100_GPIO_IR_FSEL, !(speed < 4000000));
-}
-
-static struct irda_platform_data h3100_irda_data = {
-	.set_power	= h3100_irda_set_power,
-	.set_speed	= h3100_irda_set_speed,
-};
-
-static struct gpio_default_state h3100_default_gpio[] = {
-	{ H3100_GPIO_IR_ON,	GPIO_MODE_OUT0, "IrDA power" },
-	{ H3100_GPIO_IR_FSEL,	GPIO_MODE_OUT0, "IrDA fsel" },
-	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-	{ H3100_GPIO_LCD_3V_ON,	GPIO_MODE_OUT0,	"LCD 3v" },
-};
-
-static void __init h3100_mach_init(void)
-{
-	h3xxx_init_gpio(h3100_default_gpio, ARRAY_SIZE(h3100_default_gpio));
-	h3xxx_mach_init();
-	sa11x0_register_irda(&h3100_irda_data);
-}
-
-MACHINE_START(H3100, "Compaq iPAQ H3100")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
-	.boot_params	= 0xc0000100,
-	.map_io		= h3100_map_io,
-	.init_irq	= sa1100_init_irq,
-	.timer		= &sa1100_timer,
-	.init_machine	= h3100_mach_init,
-MACHINE_END
-
-#endif /* CONFIG_SA1100_H3100 */
-
-/************************* H3600 *************************/
-
-#ifdef CONFIG_SA1100_H3600
-
 /*
  * helper for sa1100fb
  */
@@ -483,5 +152,3 @@ MACHINE_START(H3600, "Compaq iPAQ H3600")
 	.init_machine	= h3600_mach_init,
 MACHINE_END
 
-#endif /* CONFIG_SA1100_H3600 */
-
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3xxx.c
similarity index 56%
copy from arch/arm/mach-sa1100/h3600.c
copy to arch/arm/mach-sa1100/h3xxx.c
index dd39f90..cf6563c 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -48,17 +48,7 @@
 
 #include "generic.h"
 
-struct gpio_default_state {
-	int gpio;
-	int mode;
-	const char *name;
-};
-
-#define GPIO_MODE_IN	-1
-#define GPIO_MODE_OUT0	0
-#define GPIO_MODE_OUT1	1
-
-static void h3xxx_init_gpio(struct gpio_default_state *s, size_t n)
+void h3xxx_init_gpio(struct gpio_default_state *s, size_t n)
 {
 	while (n--) {
 		const char *name = s->name;
@@ -248,7 +238,7 @@ static struct platform_device *h3xxx_devices[] = {
 	&h3xxx_egpio,
 };
 
-static void __init h3xxx_mach_init(void)
+void __init h3xxx_mach_init(void)
 {
 	sa1100_register_uart_fns(&h3xxx_port_fns);
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
@@ -278,7 +268,7 @@ static struct map_desc h3600_io_desc[] __initdata = {
  * Common map_io initialization
  */
 
-static void __init h3xxx_map_io(void)
+void __init h3xxx_map_io(void)
 {
 	sa1100_map_io();
 	iotable_init(h3600_io_desc, ARRAY_SIZE(h3600_io_desc));
@@ -300,188 +290,3 @@ static void __init h3xxx_map_io(void)
 	GPDR = 0;		/* Configure all GPIOs as input */
 }
 
-/************************* H3100 *************************/
-
-#ifdef CONFIG_SA1100_H3100
-
-/*
- * helper for sa1100fb
- */
-static void h3100_lcd_power(int enable)
-{
-	if (!gpio_request(H3XXX_EGPIO_LCD_ON, "LCD ON")) {
-		gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
-		gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
-		gpio_free(H3XXX_EGPIO_LCD_ON);
-	}
-}
-
-
-static void __init h3100_map_io(void)
-{
-	h3xxx_map_io();
-
-	sa1100fb_lcd_power = h3100_lcd_power;
-
-	/* Older bootldrs put GPIO2-9 in alternate mode on the
-	   assumption that they are used for video */
-	GAFR &= ~0x000001fb;
-}
-
-/*
- * This turns the IRDA power on or off on the Compaq H3100
- */
-static int h3100_irda_set_power(struct device *dev, unsigned int state)
-{
-	gpio_set_value(H3100_GPIO_IR_ON, state);
-	return 0;
-}
-
-static void h3100_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	gpio_set_value(H3100_GPIO_IR_FSEL, !(speed < 4000000));
-}
-
-static struct irda_platform_data h3100_irda_data = {
-	.set_power	= h3100_irda_set_power,
-	.set_speed	= h3100_irda_set_speed,
-};
-
-static struct gpio_default_state h3100_default_gpio[] = {
-	{ H3100_GPIO_IR_ON,	GPIO_MODE_OUT0, "IrDA power" },
-	{ H3100_GPIO_IR_FSEL,	GPIO_MODE_OUT0, "IrDA fsel" },
-	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-	{ H3100_GPIO_LCD_3V_ON,	GPIO_MODE_OUT0,	"LCD 3v" },
-};
-
-static void __init h3100_mach_init(void)
-{
-	h3xxx_init_gpio(h3100_default_gpio, ARRAY_SIZE(h3100_default_gpio));
-	h3xxx_mach_init();
-	sa11x0_register_irda(&h3100_irda_data);
-}
-
-MACHINE_START(H3100, "Compaq iPAQ H3100")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
-	.boot_params	= 0xc0000100,
-	.map_io		= h3100_map_io,
-	.init_irq	= sa1100_init_irq,
-	.timer		= &sa1100_timer,
-	.init_machine	= h3100_mach_init,
-MACHINE_END
-
-#endif /* CONFIG_SA1100_H3100 */
-
-/************************* H3600 *************************/
-
-#ifdef CONFIG_SA1100_H3600
-
-/*
- * helper for sa1100fb
- */
-static void h3600_lcd_power(int enable)
-{
-	if (gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power"))
-		goto err1;
-	if (gpio_request(H3600_EGPIO_LCD_PCI, "LCD control"))
-		goto err2;
-	if (gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v"))
-		goto err3;
-	if (gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v"))
-		goto err4;
-
-	gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
-	gpio_direction_output(H3600_EGPIO_LCD_PCI, enable);
-	gpio_direction_output(H3600_EGPIO_LCD_5V_ON, enable);
-	gpio_direction_output(H3600_EGPIO_LVDD_ON, enable);
-
-	gpio_free(H3600_EGPIO_LVDD_ON);
-err4:	gpio_free(H3600_EGPIO_LCD_5V_ON);
-err3:	gpio_free(H3600_EGPIO_LCD_PCI);
-err2:	gpio_free(H3XXX_EGPIO_LCD_ON);
-err1:	return;
-}
-
-static void __init h3600_map_io(void)
-{
-	h3xxx_map_io();
-
-	sa1100fb_lcd_power = h3600_lcd_power;
-}
-
-/*
- * This turns the IRDA power on or off on the Compaq H3600
- */
-static int h3600_irda_set_power(struct device *dev, unsigned int state)
-{
-	gpio_set_value(H3600_EGPIO_IR_ON, state);
-	return 0;
-}
-
-static void h3600_irda_set_speed(struct device *dev, unsigned int speed)
-{
-	gpio_set_value(H3600_EGPIO_IR_FSEL, !(speed < 4000000));
-}
-
-static int h3600_irda_startup(struct device *dev)
-{
-	int err = gpio_request(H3600_EGPIO_IR_ON, "IrDA power");
-	if (err)
-		goto err1;
-	err = gpio_direction_output(H3600_EGPIO_IR_ON, 0);
-	if (err)
-		goto err2;
-	err = gpio_request(H3600_EGPIO_IR_FSEL, "IrDA fsel");
-	if (err)
-		goto err2;
-	err = gpio_direction_output(H3600_EGPIO_IR_FSEL, 0);
-	if (err)
-		goto err3;
-	return 0;
-
-err3:	gpio_free(H3600_EGPIO_IR_FSEL);
-err2:	gpio_free(H3600_EGPIO_IR_ON);
-err1:	return err;
-}
-
-static void h3600_irda_shutdown(struct device *dev)
-{
-	gpio_free(H3600_EGPIO_IR_ON);
-	gpio_free(H3600_EGPIO_IR_FSEL);
-}
-
-static struct irda_platform_data h3600_irda_data = {
-	.set_power	= h3600_irda_set_power,
-	.set_speed	= h3600_irda_set_speed,
-	.startup	= h3600_irda_startup,
-	.shutdown	= h3600_irda_shutdown,
-};
-
-static struct gpio_default_state h3600_default_gpio[] = {
-	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
-	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
-	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-};
-
-static void __init h3600_mach_init(void)
-{
-	h3xxx_init_gpio(h3600_default_gpio, ARRAY_SIZE(h3600_default_gpio));
-	h3xxx_mach_init();
-	sa11x0_register_irda(&h3600_irda_data);
-}
-
-MACHINE_START(H3600, "Compaq iPAQ H3600")
-	.phys_io	= 0x80000000,
-	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
-	.boot_params	= 0xc0000100,
-	.map_io		= h3600_map_io,
-	.init_irq	= sa1100_init_irq,
-	.timer		= &sa1100_timer,
-	.init_machine	= h3600_mach_init,
-MACHINE_END
-
-#endif /* CONFIG_SA1100_H3600 */
-
diff --git a/arch/arm/mach-sa1100/include/mach/h3xxx.h b/arch/arm/mach-sa1100/include/mach/h3xxx.h
index 7f1e130..d8a6e7c 100644
--- a/arch/arm/mach-sa1100/include/mach/h3xxx.h
+++ b/arch/arm/mach-sa1100/include/mach/h3xxx.h
@@ -87,4 +87,18 @@
 #define H3600_EGPIO_LCD_5V_ON		(H3XXX_EGPIO_BASE + 14) /* enable 5V to LCD. active high. */
 #define H3600_EGPIO_LVDD_ON		(H3XXX_EGPIO_BASE + 15) /* enable 9V and -6.5V to LCD. */
 
+struct gpio_default_state {
+	int gpio;
+	int mode;
+	const char *name;
+};
+
+#define GPIO_MODE_IN	-1
+#define GPIO_MODE_OUT0	0
+#define GPIO_MODE_OUT1	1
+
+void h3xxx_init_gpio(struct gpio_default_state *s, size_t n);
+void __init h3xxx_map_io(void);
+void __init h3xxx_mach_init(void);
+
 #endif /* _INCLUDE_H3XXX_H_ */
-- 
1.6.5.1.63.ga9d7.dirty

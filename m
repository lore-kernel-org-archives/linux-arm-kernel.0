From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 21 Nov 2011 21:55:18 +0100
Subject: [PATCHv2] ARM: sa1100: refactor sa1100 serial driver
Message-ID: <1321908918-25262-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- move pin initialization into board files
- make use of resources in platform device
  rather than hardcoding them in the driver
- add DT support

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---

V2: fixed off-by-one error

 .../devicetree/bindings/tty/serial/sa1100-uart.txt |   20 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/include/asm/mach/serial_sa1100.h          |    5 +-
 arch/arm/mach-sa1100/badge4.c                      |    3 +
 arch/arm/mach-sa1100/cerf.c                        |    3 +
 arch/arm/mach-sa1100/collie.c                      |    2 +
 arch/arm/mach-sa1100/generic.c                     |   85 +++++++-
 arch/arm/mach-sa1100/generic.h                     |    2 +
 arch/arm/mach-sa1100/h3xxx.c                       |    3 +-
 arch/arm/mach-sa1100/hackkit.c                     |    3 +
 arch/arm/mach-sa1100/jornada720.c                  |    3 +
 arch/arm/mach-sa1100/lart.c                        |    3 +
 arch/arm/mach-sa1100/pleb.c                        |    3 +
 arch/arm/mach-sa1100/shannon.c                     |    3 +
 arch/arm/mach-sa1100/simpad.c                      |    5 +-
 drivers/tty/serial/sa1100.c                        |  240 +++++++++++---------
 16 files changed, 261 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/sa1100-uart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/sa1100-uart.txt b/Documentation/devicetree/bindings/tty/serial/sa1100-uart.txt
new file mode 100644
index 0000000..3dc76ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/sa1100-uart.txt
@@ -0,0 +1,20 @@
+* SA11x0 Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible: Should be "intel,<chip>-uart"
+  The compatible <chip> indicated will be the first SoC to support an
+  additional mode or an UART new feature.
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+
+<chip> compatible description:
+- sa1100: generic UART implementation for SA11x0 SoCs
+
+Example:
+
+	uart0: serial at 0x80010000 {
+		compatible = "intel,sa1100-uart";
+		reg = <0x80010000 0x24>;
+		interrupts = <15>;
+	};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index e855278..5b14518 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -19,6 +19,7 @@ gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 hp	Hewlett Packard
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
+intel	Intel
 intercontrol	Inter Control Group
 linux	Linux-specific binding
 marvell	Marvell Technology Group Ltd.
diff --git a/arch/arm/include/asm/mach/serial_sa1100.h b/arch/arm/include/asm/mach/serial_sa1100.h
index d09064b..8305ab5 100644
--- a/arch/arm/include/asm/mach/serial_sa1100.h
+++ b/arch/arm/include/asm/mach/serial_sa1100.h
@@ -9,7 +9,6 @@
  */
 
 struct uart_port;
-struct uart_info;
 
 /*
  * This is a temporary structure for registering these
@@ -22,10 +21,10 @@ struct sa1100_port_fns {
 	int	(*set_wake)(struct uart_port *, u_int);
 };
 
+struct platform_device *sa1100_get_uart(int id);
+
 #ifdef CONFIG_SERIAL_SA1100
 void sa1100_register_uart_fns(struct sa1100_port_fns *fns);
-void sa1100_register_uart(int idx, int port);
 #else
 #define sa1100_register_uart_fns(fns) do { } while (0)
-#define sa1100_register_uart(idx,port) do { } while (0)
 #endif
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index bda83e1..505645e 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -296,6 +296,9 @@ static void __init badge4_map_io(void)
 	sa1100_map_io();
 	iotable_init(badge4_io_desc, ARRAY_SIZE(badge4_io_desc));
 
+	PPDR |= PPC_TXD1 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD3;
+
 	sa1100_register_uart_fns(&badge4_port_fns);
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 1);
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 7f3da4b..a626790 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -113,6 +113,9 @@ static void __init cerf_map_io(void)
 	sa1100_map_io();
 	iotable_init(cerf_io_desc, ARRAY_SIZE(cerf_io_desc));
 
+	PPDR |= PPC_TXD1 | PPC_TXD2 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD2 | PPC_TXD3;
+
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 2); /* disable this and the uart2 device for sa1100_fir */
 	sa1100_register_uart(2, 1);
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 2965cc9..7a17703 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -330,6 +330,8 @@ static void __init collie_init(void)
 		PPC_LDD6 | PPC_LDD7 | PPC_L_PCLK | PPC_L_LCLK | PPC_L_FCLK | PPC_L_BIAS |
 		PPC_TXD1 | PPC_TXD2 | PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM;
 
+	PPSR |= PPC_TXD1 | PPC_TXD3;
+
 	PWER = _COLLIE_GPIO_AC_IN | _COLLIE_GPIO_CO | _COLLIE_GPIO_ON_KEY |
 		_COLLIE_GPIO_WAKEUP | _COLLIE_GPIO_nREMOCON_INT | PWER_RTC;
 
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 5fa5ae1..884ab63 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -166,7 +166,7 @@ static struct platform_device sa11x0udc_device = {
 static struct resource sa11x0uart1_resources[] = {
 	[0] = {
 		.start	= __PREG(Ser1UTCR0),
-		.end	= __PREG(Ser1UTCR0) + 0xffff,
+		.end	= __PREG(Ser1UTCR0) + 0x24 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -178,15 +178,35 @@ static struct resource sa11x0uart1_resources[] = {
 
 static struct platform_device sa11x0uart1_device = {
 	.name		= "sa11x0-uart",
-	.id		= 1,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(sa11x0uart1_resources),
 	.resource	= sa11x0uart1_resources,
 };
 
+static struct resource sa11x0uart2_resources[] = {
+	[0] = {
+		.start	= __PREG(Ser2UTCR0),
+		.end	= __PREG(Ser2UTCR0) + 0x24 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_Ser2ICP,
+		.end	= IRQ_Ser2ICP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sa11x0uart2_device = {
+	.name		= "sa11x0-uart",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(sa11x0uart2_resources),
+	.resource	= sa11x0uart2_resources,
+};
+
 static struct resource sa11x0uart3_resources[] = {
 	[0] = {
 		.start	= __PREG(Ser3UTCR0),
-		.end	= __PREG(Ser3UTCR0) + 0xffff,
+		.end	= __PREG(Ser3UTCR0) + 0x24 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -198,7 +218,7 @@ static struct resource sa11x0uart3_resources[] = {
 
 static struct platform_device sa11x0uart3_device = {
 	.name		= "sa11x0-uart",
-	.id		= 3,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(sa11x0uart3_resources),
 	.resource	= sa11x0uart3_resources,
 };
@@ -341,8 +361,6 @@ static struct platform_device sa11x0rtc_device = {
 
 static struct platform_device *sa11x0_devices[] __initdata = {
 	&sa11x0udc_device,
-	&sa11x0uart1_device,
-	&sa11x0uart3_device,
 	&sa11x0ssp_device,
 	&sa11x0pcmcia_device,
 	&sa11x0fb_device,
@@ -351,12 +369,65 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 
 static int __init sa1100_init(void)
 {
+	int ret = 0;
 	pm_power_off = sa1100_power_off;
-	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
+	if (sa11x0uart1_device.id >= 0)
+		ret = platform_device_register(&sa11x0uart1_device);
+	if (ret)
+		return ret;
+	if (sa11x0uart2_device.id >= 0)
+		ret = platform_device_register(&sa11x0uart2_device);
+	if (ret)
+		goto err_uart1;
+	if (sa11x0uart3_device.id >= 0)
+		ret = platform_device_register(&sa11x0uart3_device);
+	if (ret)
+		goto err_uart2;
+	ret = platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
+	if (ret)
+		goto err_uart3;
+	return 0;
+
+err_uart3:
+	platform_device_unregister(&sa11x0uart3_device);
+err_uart2:
+	platform_device_unregister(&sa11x0uart2_device);
+err_uart1:
+	platform_device_unregister(&sa11x0uart1_device);
+	return ret;
 }
 
 arch_initcall(sa1100_init);
 
+void __init sa1100_register_uart(int id, int hw)
+{
+	switch (hw) {
+	case 1:
+		sa11x0uart1_device.id = id;
+		break;
+
+	case 2:
+		sa11x0uart2_device.id = id;
+		break;
+
+	case 3:
+		sa11x0uart3_device.id = id;
+		break;
+	}
+}
+
+struct platform_device *sa1100_get_uart(int id)
+{
+	if (sa11x0uart1_device.id == id)
+		return &sa11x0uart1_device;
+	if (sa11x0uart2_device.id == id)
+		return &sa11x0uart2_device;
+	if (sa11x0uart3_device.id == id)
+		return &sa11x0uart3_device;
+	return NULL;
+}
+EXPORT_SYMBOL(sa1100_get_uart);
+
 void (*sa1100fb_backlight_power)(int on);
 void (*sa1100fb_lcd_power)(int on);
 
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index b7a9a60..d5a51d0 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -39,3 +39,5 @@ void sa11x0_register_irda(struct irda_platform_data *irda);
 
 struct mcp_plat_data;
 void sa11x0_register_mcp(struct mcp_plat_data *data);
+
+extern void sa1100_register_uart(int hw, int id);
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index b0784c9..f3c3ba9 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -299,7 +299,8 @@ void __init h3xxx_map_io(void)
 //	sa1100_register_uart(1, 1); /* Microcontroller on 3100/3600 */
 
 	/* Ensure those pins are outputs and driving low  */
-	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PPDR |= PPC_TXD3 | PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PPSR |= PPC_TXD3;
 	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
 
 	/* Configure suspend conditions */
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 30f4a55..e852a87 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -80,6 +80,9 @@ static void __init hackkit_map_io(void)
 	sa1100_map_io();
 	iotable_init(hackkit_io_desc, ARRAY_SIZE(hackkit_io_desc));
 
+	PPDR |= PPC_TXD1 | PPC_TXD2 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD2 | PPC_TXD3;
+
 	sa1100_register_uart_fns(&hackkit_port_fns);
 	sa1100_register_uart(0, 1);	/* com port */
 	sa1100_register_uart(1, 2);
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 77198fe..d99e00a 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -297,6 +297,9 @@ static void __init jornada720_map_io(void)
 	sa1100_map_io();
 	iotable_init(jornada720_io_desc, ARRAY_SIZE(jornada720_io_desc));
 
+	PPDR |= PPC_TXD1 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD3;
+
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 1);
 }
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 5bc59d0..a8fae5b 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -50,6 +50,9 @@ static void __init lart_map_io(void)
 	sa1100_map_io();
 	iotable_init(lart_io_desc, ARRAY_SIZE(lart_io_desc));
 
+	PPDR |= PPC_TXD1 | PPC_TXD2 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD2 | PPC_TXD3;
+
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 1);
 	sa1100_register_uart(2, 2);
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 65161f2..b8fced0 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -121,6 +121,9 @@ static void __init pleb_map_io(void)
 {
 	sa1100_map_io();
 
+	PPDR |= PPC_TXD1 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD3;
+
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 1);
 
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 1cccbf5..84f5b14 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -67,6 +67,9 @@ static void __init shannon_map_io(void)
 {
 	sa1100_map_io();
 
+	PPDR |= PPC_TXD1 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD3;
+
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 1);
 
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 4790f3f..d3c9d2b 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -206,7 +206,10 @@ static void __init simpad_map_io(void)
 		RS232_ON | ENABLE_5V | RESET_SIMCARD | DECT_POWER_ON);
 	__simpad_write_cs3(); /* Spinlocks not yet initialized */
 
-        sa1100_register_uart_fns(&simpad_port_fns);
+	PPDR |= PPC_TXD1 | PPC_TXD3;
+	PPSR |= PPC_TXD1 | PPC_TXD3;
+
+	sa1100_register_uart_fns(&simpad_port_fns);
 	sa1100_register_uart(0, 3);  /* serial interface */
 	sa1100_register_uart(1, 1);  /* DECT             */
 
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index ef7a21a..a084930 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -35,6 +35,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
@@ -43,6 +44,7 @@
 /* We've been assigned a range on the "Low-density serial ports" major */
 #define SERIAL_SA1100_MAJOR	204
 #define MINOR_START		5
+#define SA1100_DEVICENAME	"ttySA"
 
 #define NR_PORTS		3
 
@@ -71,11 +73,14 @@
 #define UART_PUT_UTSR0(sport,v)	__raw_writel((v),(sport)->port.membase + UTSR0)
 #define UART_PUT_UTSR1(sport,v)	__raw_writel((v),(sport)->port.membase + UTSR1)
 #define UART_PUT_CHAR(sport,v)	__raw_writel((v),(sport)->port.membase + UTDR)
+#if defined(CONFIG_OF)
+static const struct of_device_id sa1100_serial_dt_ids[] = {
+	{ .compatible = "intel,sa1100-uart" },
+	{ /* sentinel */ }
+};
 
-/*
- * This is the size of our serial port register set.
- */
-#define UART_PORT_SIZE	0x24
+MODULE_DEVICE_TABLE(of, sa1100_serial_dt_ids);
+#endif
 
 /*
  * This determines how often we check the modem status signals
@@ -89,6 +94,7 @@ struct sa1100_port {
 	struct uart_port	port;
 	struct timer_list	timer;
 	unsigned int		old_status;
+	unsigned int		size;
 };
 
 /*
@@ -521,7 +527,9 @@ static void sa1100_release_port(struct uart_port *port)
 {
 	struct sa1100_port *sport = (struct sa1100_port *)port;
 
-	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+	release_mem_region(port->mapbase, sport->size);
+	iounmap(port->membase);
+	port->membase = NULL;
 }
 
 /*
@@ -531,8 +539,20 @@ static int sa1100_request_port(struct uart_port *port)
 {
 	struct sa1100_port *sport = (struct sa1100_port *)port;
 
-	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
-			"sa11x0-uart") != NULL ? 0 : -EBUSY;
+	if (!request_mem_region(port->mapbase, sport->size,
+			"sa11x0-uart")) {
+		dev_err(port->dev, "Memory region busy\n");
+		return -EBUSY;
+	}
+
+	if (!port->membase)
+		port->membase = ioremap(port->mapbase, sport->size);
+	if (!port->membase) {
+		dev_err(port->dev, "Unable to map registers\n");
+		release_mem_region(port->mapbase, sport->size);
+		return -EBUSY;
+	}
+	return 0;
 }
 
 /*
@@ -555,24 +575,21 @@ static void sa1100_config_port(struct uart_port *port, int flags)
 static int
 sa1100_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct sa1100_port *sport = (struct sa1100_port *)port;
-	int ret = 0;
-
-	if (ser->type != PORT_UNKNOWN && ser->type != PORT_SA1100)
-		ret = -EINVAL;
-	if (sport->port.irq != ser->irq)
-		ret = -EINVAL;
+	if (ser->type != PORT_SA1100)
+		return -EINVAL;
+	if (port->irq != ser->irq)
+		return -EINVAL;
 	if (ser->io_type != SERIAL_IO_MEM)
-		ret = -EINVAL;
-	if (sport->port.uartclk / 16 != ser->baud_base)
-		ret = -EINVAL;
-	if ((void *)sport->port.mapbase != ser->iomem_base)
-		ret = -EINVAL;
-	if (sport->port.iobase != ser->port)
-		ret = -EINVAL;
+		return -EINVAL;
+	if (port->uartclk / 16 != ser->baud_base)
+		return -EINVAL;
+	if ((void *)port->mapbase != ser->iomem_base)
+		return -EINVAL;
+	if (port->iobase != ser->port)
+		return -EINVAL;
 	if (ser->hub6 != 0)
-		ret = -EINVAL;
-	return ret;
+		return -EINVAL;
+	return 0;
 }
 
 static struct uart_ops sa1100_pops = {
@@ -595,6 +612,7 @@ static struct uart_ops sa1100_pops = {
 };
 
 static struct sa1100_port sa1100_ports[NR_PORTS];
+static unsigned long sa1100_ports_in_use;
 
 /*
  * Setup the SA1100 serial ports.  Note that we don't include the IrDA
@@ -608,33 +626,6 @@ static struct sa1100_port sa1100_ports[NR_PORTS];
  * Note that NanoEngine UART3 becomes UART2, and UART2 is no longer
  * used here.
  */
-static void __init sa1100_init_ports(void)
-{
-	static int first = 1;
-	int i;
-
-	if (!first)
-		return;
-	first = 0;
-
-	for (i = 0; i < NR_PORTS; i++) {
-		sa1100_ports[i].port.uartclk   = 3686400;
-		sa1100_ports[i].port.ops       = &sa1100_pops;
-		sa1100_ports[i].port.fifosize  = 8;
-		sa1100_ports[i].port.line      = i;
-		sa1100_ports[i].port.iotype    = UPIO_MEM;
-		init_timer(&sa1100_ports[i].timer);
-		sa1100_ports[i].timer.function = sa1100_timeout;
-		sa1100_ports[i].timer.data     = (unsigned long)&sa1100_ports[i];
-	}
-
-	/*
-	 * make transmit lines outputs, so that when the port
-	 * is closed, the output is in the MARK state.
-	 */
-	PPDR |= PPC_TXD1 | PPC_TXD3;
-	PPSR |= PPC_TXD1 | PPC_TXD3;
-}
 
 void __devinit sa1100_register_uart_fns(struct sa1100_port_fns *fns)
 {
@@ -647,41 +638,6 @@ void __devinit sa1100_register_uart_fns(struct sa1100_port_fns *fns)
 	sa1100_pops.set_wake = fns->set_wake;
 }
 
-void __init sa1100_register_uart(int idx, int port)
-{
-	if (idx >= NR_PORTS) {
-		printk(KERN_ERR "%s: bad index number %d\n", __func__, idx);
-		return;
-	}
-
-	switch (port) {
-	case 1:
-		sa1100_ports[idx].port.membase = (void __iomem *)&Ser1UTCR0;
-		sa1100_ports[idx].port.mapbase = _Ser1UTCR0;
-		sa1100_ports[idx].port.irq     = IRQ_Ser1UART;
-		sa1100_ports[idx].port.flags   = UPF_BOOT_AUTOCONF;
-		break;
-
-	case 2:
-		sa1100_ports[idx].port.membase = (void __iomem *)&Ser2UTCR0;
-		sa1100_ports[idx].port.mapbase = _Ser2UTCR0;
-		sa1100_ports[idx].port.irq     = IRQ_Ser2ICP;
-		sa1100_ports[idx].port.flags   = UPF_BOOT_AUTOCONF;
-		break;
-
-	case 3:
-		sa1100_ports[idx].port.membase = (void __iomem *)&Ser3UTCR0;
-		sa1100_ports[idx].port.mapbase = _Ser3UTCR0;
-		sa1100_ports[idx].port.irq     = IRQ_Ser3UART;
-		sa1100_ports[idx].port.flags   = UPF_BOOT_AUTOCONF;
-		break;
-
-	default:
-		printk(KERN_ERR "%s: bad port number %d\n", __func__, port);
-	}
-}
-
-
 #ifdef CONFIG_SERIAL_SA1100_CONSOLE
 static void sa1100_console_putchar(struct uart_port *port, int ch)
 {
@@ -701,6 +657,9 @@ sa1100_console_write(struct console *co, const char *s, unsigned int count)
 	struct sa1100_port *sport = &sa1100_ports[co->index];
 	unsigned int old_utcr3, status;
 
+	if (co->index < 0 || co->index >= NR_PORTS)
+		return;
+
 	/*
 	 *	First, save UTCR3 and then disable interrupts
 	 */
@@ -764,6 +723,8 @@ sa1100_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	struct resource *res_mem, *res_irq;
+	struct platform_device *pdev;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
@@ -774,6 +735,30 @@ sa1100_console_setup(struct console *co, char *options)
 		co->index = 0;
 	sport = &sa1100_ports[co->index];
 
+	sport->port.uartclk   = get_clock_tick_rate();
+	sport->port.ops       = &sa1100_pops;
+	sport->port.fifosize  = 8;
+	sport->port.line      = co->index;
+	sport->port.iotype    = UPIO_MEM;
+
+	pdev = sa1100_get_uart(co->index);
+	if (!pdev)
+		return -ENODEV;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem)
+		return -ENODEV;
+
+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res_irq)
+		return -ENODEV;
+
+	sport->port.mapbase   = res_mem->start;
+	sport->port.irq       = res_irq->start;
+	sport->size           = res_mem->end - res_mem->start + 1;
+
+	sport->port.membase   = ioremap(sport->port.mapbase, sport->size);
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
@@ -784,7 +769,7 @@ sa1100_console_setup(struct console *co, char *options)
 
 static struct uart_driver sa1100_reg;
 static struct console sa1100_console = {
-	.name		= "ttySA",
+	.name		= SA1100_DEVICENAME,
 	.write		= sa1100_console_write,
 	.device		= uart_console_device,
 	.setup		= sa1100_console_setup,
@@ -795,7 +780,6 @@ static struct console sa1100_console = {
 
 static int __init sa1100_rs_console_init(void)
 {
-	sa1100_init_ports();
 	register_console(&sa1100_console);
 	return 0;
 }
@@ -808,8 +792,8 @@ console_initcall(sa1100_rs_console_init);
 
 static struct uart_driver sa1100_reg = {
 	.owner			= THIS_MODULE,
-	.driver_name		= "ttySA",
-	.dev_name		= "ttySA",
+	.driver_name		= "sa11x0-uart",
+	.dev_name		= SA1100_DEVICENAME,
 	.major			= SERIAL_SA1100_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
@@ -836,28 +820,62 @@ static int sa1100_serial_resume(struct platform_device *dev)
 	return 0;
 }
 
-static int sa1100_serial_probe(struct platform_device *dev)
+static int __devinit sa1100_serial_probe(struct platform_device *pdev)
 {
-	struct resource *res = dev->resource;
-	int i;
+	struct resource *res_mem, *res_irq;
+	struct device_node *np = pdev->dev.of_node;
+	struct sa1100_port *sport;
+	int ret, id;
 
-	for (i = 0; i < dev->num_resources; i++, res++)
-		if (res->flags & IORESOURCE_MEM)
-			break;
+	if (np)
+		id = of_alias_get_id(np, "serial");
+	else
+		id = pdev->id;
 
-	if (i < dev->num_resources) {
-		for (i = 0; i < NR_PORTS; i++) {
-			if (sa1100_ports[i].port.mapbase != res->start)
-				continue;
+	if (id < 0)
+		id = find_first_zero_bit(&sa1100_ports_in_use,
+			sizeof(sa1100_ports_in_use));
 
-			sa1100_ports[i].port.dev = &dev->dev;
-			uart_add_one_port(&sa1100_reg, &sa1100_ports[i].port);
-			platform_set_drvdata(dev, &sa1100_ports[i]);
-			break;
-		}
+	if (id < 0 || id >= NR_PORTS)
+		return -EINVAL;
+
+	if (test_and_set_bit(id, &sa1100_ports_in_use))
+		return -EBUSY;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem) {
+		clear_bit(id, &sa1100_ports_in_use);
+		printk(KERN_INFO "SA11x0 no mem for %d\n", id);
+		return -ENODEV;
+	}
+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res_irq) {
+		clear_bit(id, &sa1100_ports_in_use);
+		printk(KERN_INFO "SA11x0 no irq for %d\n", id);
+		return -ENODEV;
 	}
 
-	return 0;
+	sport = &sa1100_ports[id];
+
+	sport->port.uartclk   = get_clock_tick_rate();
+	sport->port.ops       = &sa1100_pops;
+	sport->port.fifosize  = 8;
+	sport->port.line      = id;
+	sport->port.iotype    = UPIO_MEM;
+	sport->port.mapbase   = res_mem->start;
+	sport->port.irq       = res_irq->start;
+	sport->port.flags     = UPF_BOOT_AUTOCONF;
+	sport->timer.function = sa1100_timeout;
+	sport->timer.data     = (unsigned long)sport;
+	sport->size           = res_mem->end - res_mem->start + 1;
+
+	init_timer(&sport->timer);
+	platform_set_drvdata(pdev, sport);
+	sport->port.dev = &pdev->dev;
+	ret = uart_add_one_port(&sa1100_reg, &sport->port);
+	if (ret)
+		clear_bit(id, &sa1100_ports_in_use);
+	return ret;
 }
 
 static int sa1100_serial_remove(struct platform_device *pdev)
@@ -866,20 +884,22 @@ static int sa1100_serial_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	if (sport)
+	if (sport) {
 		uart_remove_one_port(&sa1100_reg, &sport->port);
-
+		clear_bit(sport->port.line, &sa1100_ports_in_use);
+	}
 	return 0;
 }
 
 static struct platform_driver sa11x0_serial_driver = {
 	.probe		= sa1100_serial_probe,
-	.remove		= sa1100_serial_remove,
+	.remove		= __devexit_p(sa1100_serial_remove),
 	.suspend	= sa1100_serial_suspend,
 	.resume		= sa1100_serial_resume,
 	.driver		= {
 		.name	= "sa11x0-uart",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(sa1100_serial_dt_ids),
 	},
 };
 
@@ -889,8 +909,6 @@ static int __init sa1100_serial_init(void)
 
 	printk(KERN_INFO "Serial: SA11x0 driver\n");
 
-	sa1100_init_ports();
-
 	ret = uart_register_driver(&sa1100_reg);
 	if (ret == 0) {
 		ret = platform_driver_register(&sa11x0_serial_driver);
@@ -912,5 +930,5 @@ module_exit(sa1100_serial_exit);
 MODULE_AUTHOR("Deep Blue Solutions Ltd");
 MODULE_DESCRIPTION("SA1100 generic serial port driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV_MAJOR(SERIAL_SA1100_MAJOR);
+MODULE_ALIAS_CHARDEV(SERIAL_SA1100_MAJOR, MINOR_START);
 MODULE_ALIAS("platform:sa11x0-uart");
-- 
1.7.7.3

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jun 2012 13:55:26 +0200
Subject: [PATCH v2] RFC: spi/sa1100: rewrite the SA1100 SPI driver
Message-ID: <1339588526-31275-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This heavily rewrites the SA1100 SPI driver and moves it to the
SPI subsystem. I seriously doubt it will work (though you're
encouraged to give it a spin). It is meant as a starting
point for others who are able to pick up on it. I discussed
this with Kristoffer some time back.

The Jornada 720 seems to be the only in-kernel user of the SSP,
so the MCU driver (now called jornada720_ssp.c) is now an
SPI device on the SPI bus, and the jornada720_ssp is just
"some SPI device". Anything generic (like GPIO toggling to
sync to the other side) is now in the SPI driver. The
spinlock across transfers found in jornada720_ssp is probably
not going to play well with the SPI subsystem so this has
been replaced by a mutex.

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase to v3.5-rc1
- Move SA1100 SSP platform data to <linux/platform_data>
- Store bits per word (bpw) for the device in the state holder.
- Rewrite to use the new transfer queue.
- Delete reference to the FIFO data register from SA-1100.h since
  SA1100 now uses dmaengine and the device tells the engine what
  register to use.
- Use devm_* family for iomap, irq request etc.

Kristoffer, can you test this on the Jornada? I suspect you're
the only one who can actually take the SSP driver for a ride on
real hardware.
---
 arch/arm/include/asm/hardware/ssp.h         |   28 --
 arch/arm/mach-sa1100/Kconfig                |   10 +-
 arch/arm/mach-sa1100/Makefile               |    1 -
 arch/arm/mach-sa1100/include/mach/SA-1100.h |   83 +-----
 arch/arm/mach-sa1100/jornada720.c           |   52 +++-
 arch/arm/mach-sa1100/jornada720_ssp.c       |   79 ++---
 arch/arm/mach-sa1100/ssp.c                  |  243 --------------
 drivers/spi/Kconfig                         |    7 +
 drivers/spi/Makefile                        |    1 +
 drivers/spi/spi-sa1100.c                    |  470 +++++++++++++++++++++++++++
 include/linux/platform_data/sa1100-ssp.h    |   15 +
 11 files changed, 574 insertions(+), 415 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/ssp.h
 delete mode 100644 arch/arm/mach-sa1100/ssp.c
 create mode 100644 drivers/spi/spi-sa1100.c
 create mode 100644 include/linux/platform_data/sa1100-ssp.h

diff --git a/arch/arm/include/asm/hardware/ssp.h b/arch/arm/include/asm/hardware/ssp.h
deleted file mode 100644
index 3b42e18..0000000
--- a/arch/arm/include/asm/hardware/ssp.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  ssp.h
- *
- *  Copyright (C) 2003 Russell King, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef SSP_H
-#define SSP_H
-
-struct ssp_state {
-	unsigned int	cr0;
-	unsigned int	cr1;
-};
-
-int ssp_write_word(u16 data);
-int ssp_read_word(u16 *data);
-int ssp_flush(void);
-void ssp_enable(void);
-void ssp_disable(void);
-void ssp_save_state(struct ssp_state *ssp);
-void ssp_restore_state(struct ssp_state *ssp);
-int ssp_init(void);
-void ssp_exit(void);
-
-#endif
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 42625e4..cb1c115 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -95,7 +95,8 @@ config SA1100_JORNADA720
 
 config SA1100_JORNADA720_SSP
 	bool "HP Jornada 720 Extended SSP driver"
-	select SA1100_SSP
+	select SPI
+	select SPI_SA1100
 	depends on SA1100_JORNADA720
 	help
 	  Say Y here if you have a HP Jornada 7xx handheld computer and you
@@ -157,13 +158,6 @@ config SA1100_SIMPAD
 	  like CL4 in additional it has a PCMCIA-Slot. For more information
 	  visit <http://www.usa.siemens.com/> or <http://www.siemens.ch/>.
 
-config SA1100_SSP
-	tristate "Generic PIO SSP"
-	help
-	  Say Y here to enable support for the generic PIO SSP driver.
-	  This isn't for audio support, but for attached sensors and
-	  other devices, eg for BadgePAD 4 sensor support.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 60b97ec..b7f348e 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -51,5 +51,4 @@ obj-$(CONFIG_LEDS) += $(led-y)
 
 # Miscellaneous functions
 obj-$(CONFIG_PM)			+= pm.o sleep.o
-obj-$(CONFIG_SA1100_SSP)		+= ssp.o
 
diff --git a/arch/arm/mach-sa1100/include/mach/SA-1100.h b/arch/arm/mach-sa1100/include/mach/SA-1100.h
index 3f2d1b6..b6310b2 100644
--- a/arch/arm/mach-sa1100/include/mach/SA-1100.h
+++ b/arch/arm/mach-sa1100/include/mach/SA-1100.h
@@ -727,86 +727,8 @@
 #define MCCR1_F10MHz	(MCCR1_CFS*1)	/*  Freq. (fmc) = ~ 10 MHz         */
                 	        	/*  (9.585 MHz)                    */
 
-
-/*
- * Synchronous Serial Port (SSP) control registers
- *
- * Registers
- *    Ser4SSCR0 	Serial port 4 Synchronous Serial Port (SSP) Control
- *              	Register 0 (read/write).
- *    Ser4SSCR1 	Serial port 4 Synchronous Serial Port (SSP) Control
- *              	Register 1 (read/write).
- *              	[Bits SPO and SP are only implemented in versions 2.0
- *              	(rev. = 8) and higher of the StrongARM SA-1100.]
- *    Ser4SSDR  	Serial port 4 Synchronous Serial Port (SSP) Data
- *              	Register (read/write).
- *    Ser4SSSR  	Serial port 4 Synchronous Serial Port (SSP) Status
- *              	Register (read/write).
- *
- * Clocks
- *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
- *              	or 3.5795 MHz).
- *    fss, Tss  	Frequency, period of the SSP communication.
- */
-
-#define Ser4SSCR0	__REG(0x80070060)  /* Ser. port 4 SSP Control Reg. 0 */
-#define Ser4SSCR1	__REG(0x80070064)  /* Ser. port 4 SSP Control Reg. 1 */
-#define Ser4SSDR	__REG(0x8007006C)  /* Ser. port 4 SSP Data Reg. */
-#define Ser4SSSR	__REG(0x80070074)  /* Ser. port 4 SSP Status Reg. */
-
-#define SSCR0_DSS	Fld (4, 0)	/* Data Size - 1 Select [3..15]    */
-#define SSCR0_DataSize(Size)    	/*  Data Size Select [4..16]       */ \
-                	(((Size) - 1) << FShft (SSCR0_DSS))
-#define SSCR0_FRF	Fld (2, 4)	/* FRame Format                    */
-#define SSCR0_Motorola	        	/*  Motorola Serial Peripheral     */ \
-                	        	/*  Interface (SPI) format         */ \
-                	(0 << FShft (SSCR0_FRF))
-#define SSCR0_TI	        	/*  Texas Instruments Synchronous  */ \
-                	        	/*  Serial format                  */ \
-                	(1 << FShft (SSCR0_FRF))
-#define SSCR0_National	        	/*  National Microwire format      */ \
-                	(2 << FShft (SSCR0_FRF))
-#define SSCR0_SSE	0x00000080	/* SSP Enable                      */
-#define SSCR0_SCR	Fld (8, 8)	/* Serial Clock Rate divisor/2 - 1 */
-                	        	/* fss = fxtl/(2*(SCR + 1))        */
-                	        	/* Tss = 2*(SCR + 1)*Txtl          */
-#define SSCR0_SerClkDiv(Div)    	/*  Serial Clock Divisor [2..512]  */ \
-                	(((Div) - 2)/2 << FShft (SSCR0_SCR))
-                	        	/*  fss = fxtl/(2*Floor (Div/2))   */
-                	        	/*  Tss = 2*Floor (Div/2)*Txtl     */
-#define SSCR0_CeilSerClkDiv(Div)	/*  Ceil. of SerClkDiv [2..512]    */ \
-                	(((Div) - 1)/2 << FShft (SSCR0_SCR))
-                	        	/*  fss = fxtl/(2*Ceil (Div/2))    */
-                	        	/*  Tss = 2*Ceil (Div/2)*Txtl      */
-
-#define SSCR1_RIE	0x00000001	/* Receive FIFO 1/2-full or more   */
-                	        	/* Interrupt Enable                */
-#define SSCR1_TIE	0x00000002	/* Transmit FIFO 1/2-full or less  */
-                	        	/* Interrupt Enable                */
-#define SSCR1_LBM	0x00000004	/* Look-Back Mode                  */
-#define SSCR1_SPO	0x00000008	/* Sample clock (SCLK) POlarity    */
-#define SSCR1_SClkIactL	(SSCR1_SPO*0)	/*  Sample Clock Inactive Low      */
-#define SSCR1_SClkIactH	(SSCR1_SPO*1)	/*  Sample Clock Inactive High     */
-#define SSCR1_SP	0x00000010	/* Sample clock (SCLK) Phase       */
-#define SSCR1_SClk1P	(SSCR1_SP*0)	/*  Sample Clock active 1 Period   */
-                	        	/*  after frame (SFRM, 1st edge)   */
-#define SSCR1_SClk1_2P	(SSCR1_SP*1)	/*  Sample Clock active 1/2 Period */
-                	        	/*  after frame (SFRM, 1st edge)   */
-#define SSCR1_ECS	0x00000020	/* External Clock Select           */
-#define SSCR1_IntClk	(SSCR1_ECS*0)	/*  Internal Clock                 */
-#define SSCR1_ExtClk	(SSCR1_ECS*1)	/*  External Clock (GPIO [19])     */
-
-#define SSDR_DATA	Fld (16, 0)	/* receive/transmit DATA FIFOs     */
-
-#define SSSR_TNF	0x00000002	/* Transmit FIFO Not Full (read)   */
-#define SSSR_RNE	0x00000004	/* Receive FIFO Not Empty (read)   */
-#define SSSR_BSY	0x00000008	/* SSP BuSY (read)                 */
-#define SSSR_TFS	0x00000010	/* Transmit FIFO 1/2-full or less  */
-                	        	/* Service request (read)          */
-#define SSSR_RFS	0x00000020	/* Receive FIFO 1/2-full or more   */
-                	        	/* Service request (read)          */
-#define SSSR_ROR	0x00000040	/* Receive FIFO Over-Run           */
-
+/* The driver will contain the offsets for this peripheral */
+#define Ser4SSBase	0x80070000
 
 /*
  * Operating System (OS) timer control registers
@@ -1594,7 +1516,6 @@
 #define DMA_SIZE	(6 * 0x20)
 #define DMA_PHYS	0xb0000000
 
-
 /*
  * Liquid Crystal Display (LCD) control registers
  *
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index e3084f4..8abd1b6 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -21,6 +21,8 @@
 #include <linux/ioport.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_data/sa1100-ssp.h>
 #include <video/s1d13xxxfb.h>
 
 #include <asm/hardware/sa1111.h>
@@ -212,11 +214,6 @@ static struct platform_device sa1111_device = {
 	.resource	= sa1111_resources,
 };
 
-static struct platform_device jornada_ssp_device = {
-	.name           = "jornada_ssp",
-	.id             = -1,
-};
-
 static struct platform_device jornada_kbd_device = {
 	.name		= "jornada720_kbd",
 	.id		= -1,
@@ -227,7 +224,35 @@ static struct platform_device jornada_ts_device = {
 	.id		= -1,
 };
 
-static struct platform_device *devices[] __initdata = {
+static struct sa1100_ssp_plat_data jornada_ssp_plat = {
+	.en_gpio = GPIO_GPIO25,
+	.rdy_gpio = GPIO_GPIO10,
+};
+
+static struct resource jornada_ssp_resources[] = {
+	[0] = {
+		.start		= Ser4SSBase,
+		.end		= Ser4SSBase + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= IRQ_Ser4SSP,
+		.end		= IRQ_Ser4SSP,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device jornada_ssp_device = {
+	.name		= "sa1100-ssp",
+	.id		= 0,
+	.dev		= {
+		.platform_data = &jornada_ssp_plat,
+	},
+	.num_resources	= ARRAY_SIZE(jornada_ssp_resources),
+	.resource	= jornada_ssp_resources,
+};
+
+static struct platform_device *jornada_devices[] __initdata = {
 	&sa1111_device,
 	&jornada_ssp_device,
 	&s1d13xxxfb_device,
@@ -235,6 +260,15 @@ static struct platform_device *devices[] __initdata = {
 	&jornada_ts_device,
 };
 
+/* Todo, rename this device, it's driver and all symbols "jornada mcu" */
+static struct spi_board_info jornada_spi_devices[] = {
+	{
+		.modalias       = "jornada_ssp",
+		.bus_num        = 0,
+		.chip_select    = 0,
+	}
+};
+
 static int __init jornada720_init(void)
 {
 	int ret = -ENODEV;
@@ -250,7 +284,11 @@ static int __init jornada720_init(void)
 		GPSR = GPIO_GPIO20;	/* restart gpio20 */
 		udelay(20);		/* give it some time to restart */
 
-		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		/* Register SPI board data, then the platform devices */
+		spi_register_board_info(jornada_spi_devices,
+					ARRAY_SIZE(jornada_spi_devices));
+		ret = platform_add_devices(jornada_devices,
+					ARRAY_SIZE(jornada_devices));
 	}
 
 	return ret;
diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index b412fc0..499c14c 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -16,15 +16,14 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/sched.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <mach/jornada720.h>
-#include <asm/hardware/ssp.h>
 
-static DEFINE_SPINLOCK(jornada_ssp_lock);
-static unsigned long jornada_ssp_flags;
+static DEFINE_MUTEX(jornada_ssp_lock);
+static struct spi_device *spi;
 
 /**
  * jornada_ssp_reverse - reverses input byte
@@ -57,23 +56,25 @@ EXPORT_SYMBOL(jornada_ssp_reverse);
  */
 int jornada_ssp_byte(u8 byte)
 {
-	int timeout = 400000;
-	u16 ret;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	u16 txword;
+	u16 rxword;
+	int ret;
 
-	while ((GPLR & GPIO_GPIO10)) {
-		if (!--timeout) {
-			printk(KERN_WARNING "SSP: timeout while waiting for transmit\n");
-			return -ETIMEDOUT;
-		}
-		cpu_relax();
-	}
+	txword = jornada_ssp_reverse(byte) << 8;
 
-	ret = jornada_ssp_reverse(byte) << 8;
+	xfer.tx_buf = &txword;
+	xfer.rx_buf = &rxword;
+	xfer.len = sizeof(u16);
 
-	ssp_write_word(ret);
-	ssp_read_word(&ret);
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(spi, &msg);
+	if (ret < 0)
+		return ret;
 
-	return jornada_ssp_reverse(ret);
+	return jornada_ssp_reverse(rxword);
 };
 EXPORT_SYMBOL(jornada_ssp_byte);
 
@@ -110,8 +111,7 @@ EXPORT_SYMBOL(jornada_ssp_inout);
  */
 void jornada_ssp_start(void)
 {
-	spin_lock_irqsave(&jornada_ssp_lock, jornada_ssp_flags);
-	GPCR = GPIO_GPIO25;
+	mutex_lock(&jornada_ssp_lock);
 	udelay(50);
 	return;
 };
@@ -123,35 +123,22 @@ EXPORT_SYMBOL(jornada_ssp_start);
  */
 void jornada_ssp_end(void)
 {
-	GPSR = GPIO_GPIO25;
-	spin_unlock_irqrestore(&jornada_ssp_lock, jornada_ssp_flags);
+	mutex_unlock(&jornada_ssp_lock);
 	return;
 };
 EXPORT_SYMBOL(jornada_ssp_end);
 
-static int __devinit jornada_ssp_probe(struct platform_device *dev)
+static int __devinit jornada_ssp_probe(struct spi_device *spi)
 {
 	int ret;
 
-	GPSR = GPIO_GPIO25;
-
-	ret = ssp_init();
-
-	/* worked fine, lets not bother with anything else */
-	if (!ret) {
-		printk(KERN_INFO "SSP: device initialized with irq\n");
+	spi->bits_per_word = 16;
+	ret = spi_setup(spi);
+	if (ret < 0)
 		return ret;
-	}
-
-	printk(KERN_WARNING "SSP: initialization failed, trying non-irq solution \n");
 
 	/* init of Serial 4 port */
 	Ser4MCCR0 = 0;
-	Ser4SSCR0 = 0x0387;
-	Ser4SSCR1 = 0x18;
-
-	/* clear out any left over data */
-	ssp_flush();
 
 	/* enable MCU */
 	jornada_ssp_start();
@@ -167,36 +154,34 @@ static int __devinit jornada_ssp_probe(struct platform_device *dev)
 
 	/* failed, lets just kill everything */
 	if (ret == -ETIMEDOUT) {
-		printk(KERN_WARNING "SSP: attempts failed, bailing\n");
-		ssp_exit();
+		printk(KERN_WARNING "Jornada SSP: attempts failed, bailing\n");
 		return -ENODEV;
 	}
 
 	/* all fine */
-	printk(KERN_INFO "SSP: device initialized\n");
+	printk(KERN_INFO "Jornada SSP: device initialized\n");
 	return 0;
 };
 
-static int jornada_ssp_remove(struct platform_device *dev)
+static int jornada_ssp_remove(struct spi_device *spi)
 {
-	/* Note that this doesn't actually remove the driver, since theres nothing to remove
-	 * It just makes sure everything is turned off */
-	GPSR = GPIO_GPIO25;
-	ssp_exit();
 	return 0;
 };
 
-struct platform_driver jornadassp_driver = {
+struct spi_driver jornadassp_driver = {
 	.probe	= jornada_ssp_probe,
 	.remove	= jornada_ssp_remove,
 	.driver	= {
 		.name	= "jornada_ssp",
+		.owner	= THIS_MODULE,
+		.bus	= &spi_bus_type,
 	},
 };
 
 static int __init jornada_ssp_init(void)
 {
-	return platform_driver_register(&jornadassp_driver);
+	return spi_register_driver(&jornadassp_driver);
 }
 
 module_init(jornada_ssp_init);
+MODULE_ALIAS("spi:jornada_ssp");
diff --git a/arch/arm/mach-sa1100/ssp.c b/arch/arm/mach-sa1100/ssp.c
deleted file mode 100644
index e22fca9..0000000
--- a/arch/arm/mach-sa1100/ssp.c
+++ /dev/null
@@ -1,243 +0,0 @@
-/*
- *  linux/arch/arm/mach-sa1100/ssp.c
- *
- *  Copyright (C) 2003 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Generic SSP driver.  This provides the generic core for simple
- *  IO-based SSP applications.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <asm/hardware/ssp.h>
-
-#define TIMEOUT 100000
-
-static irqreturn_t ssp_interrupt(int irq, void *dev_id)
-{
-	unsigned int status = Ser4SSSR;
-
-	if (status & SSSR_ROR)
-		printk(KERN_WARNING "SSP: receiver overrun\n");
-
-	Ser4SSSR = SSSR_ROR;
-
-	return status ? IRQ_HANDLED : IRQ_NONE;
-}
-
-/**
- * ssp_write_word - write a word to the SSP port
- * @data: 16-bit, MSB justified data to write.
- *
- * Wait for a free entry in the SSP transmit FIFO, and write a data
- * word to the SSP port.  Wait for the SSP port to start sending
- * the data.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   0			success
- */
-int ssp_write_word(u16 data)
-{
-	int timeout = TIMEOUT;
-
-	while (!(Ser4SSSR & SSSR_TNF)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	Ser4SSDR = data;
-
-	timeout = TIMEOUT;
-	while (!(Ser4SSSR & SSSR_BSY)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	return 0;
-}
-
-/**
- * ssp_read_word - read a word from the SSP port
- *
- * Wait for a data word in the SSP receive FIFO, and return the
- * received data.  Data is LSB justified.
- *
- * Note: Currently, if data is not expected to be received, this
- * function will wait for ever.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   16-bit data	success
- */
-int ssp_read_word(u16 *data)
-{
-	int timeout = TIMEOUT;
-
-	while (!(Ser4SSSR & SSSR_RNE)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	*data = (u16)Ser4SSDR;
-
-	return 0;
-}
-
-/**
- * ssp_flush - flush the transmit and receive FIFOs
- *
- * Wait for the SSP to idle, and ensure that the receive FIFO
- * is empty.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   0			success
- */
-int ssp_flush(void)
-{
-	int timeout = TIMEOUT * 2;
-
-	do {
-		while (Ser4SSSR & SSSR_RNE) {
-		        if (!--timeout)
-		        	return -ETIMEDOUT;
-			(void) Ser4SSDR;
-		}
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-	} while (Ser4SSSR & SSSR_BSY);
-
-	return 0;
-}
-
-/**
- * ssp_enable - enable the SSP port
- *
- * Turn on the SSP port.
- */
-void ssp_enable(void)
-{
-	Ser4SSCR0 |= SSCR0_SSE;
-}
-
-/**
- * ssp_disable - shut down the SSP port
- *
- * Turn off the SSP port, optionally powering it down.
- */
-void ssp_disable(void)
-{
-	Ser4SSCR0 &= ~SSCR0_SSE;
-}
-
-/**
- * ssp_save_state - save the SSP configuration
- * @ssp: pointer to structure to save SSP configuration
- *
- * Save the configured SSP state for suspend.
- */
-void ssp_save_state(struct ssp_state *ssp)
-{
-	ssp->cr0 = Ser4SSCR0;
-	ssp->cr1 = Ser4SSCR1;
-
-	Ser4SSCR0 &= ~SSCR0_SSE;
-}
-
-/**
- * ssp_restore_state - restore a previously saved SSP configuration
- * @ssp: pointer to configuration saved by ssp_save_state
- *
- * Restore the SSP configuration saved previously by ssp_save_state.
- */
-void ssp_restore_state(struct ssp_state *ssp)
-{
-	Ser4SSSR = SSSR_ROR;
-
-	Ser4SSCR0 = ssp->cr0 & ~SSCR0_SSE;
-	Ser4SSCR1 = ssp->cr1;
-	Ser4SSCR0 = ssp->cr0;
-}
-
-/**
- * ssp_init - setup the SSP port
- *
- * initialise and claim resources for the SSP port.
- *
- * Returns:
- *   %-ENODEV	if the SSP port is unavailable
- *   %-EBUSY	if the resources are already in use
- *   %0		on success
- */
-int ssp_init(void)
-{
-	int ret;
-
-	if (!(PPAR & PPAR_SPR) && (Ser4MCCR0 & MCCR0_MCE))
-		return -ENODEV;
-
-	if (!request_mem_region(__PREG(Ser4SSCR0), 0x18, "SSP")) {
-		return -EBUSY;
-	}
-
-	Ser4SSSR = SSSR_ROR;
-
-	ret = request_irq(IRQ_Ser4SSP, ssp_interrupt, 0, "SSP", NULL);
-	if (ret)
-		goto out_region;
-
-	return 0;
-
- out_region:
-	release_mem_region(__PREG(Ser4SSCR0), 0x18);
-	return ret;
-}
-
-/**
- * ssp_exit - undo the effects of ssp_init
- *
- * release and free resources for the SSP port.
- */
-void ssp_exit(void)
-{
-	Ser4SSCR0 &= ~SSCR0_SSE;
-
-	free_irq(IRQ_Ser4SSP, NULL);
-	release_mem_region(__PREG(Ser4SSCR0), 0x18);
-}
-
-MODULE_AUTHOR("Russell King");
-MODULE_DESCRIPTION("SA11x0 SSP PIO driver");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(ssp_write_word);
-EXPORT_SYMBOL(ssp_read_word);
-EXPORT_SYMBOL(ssp_flush);
-EXPORT_SYMBOL(ssp_enable);
-EXPORT_SYMBOL(ssp_disable);
-EXPORT_SYMBOL(ssp_save_state);
-EXPORT_SYMBOL(ssp_restore_state);
-EXPORT_SYMBOL(ssp_init);
-EXPORT_SYMBOL(ssp_exit);
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd2fe35..9c9ae71 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -316,6 +316,13 @@ config SPI_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
+config SPI_SA1100
+	tristate "SA1100 PIO SSP"
+	help
+	  Say Y here to enable support for the SA1100 SSP/SPI driver.
+	  This isn't for audio support, but for attached sensors and
+	  other devices, eg for BadgePAD 4 sensor support.
+
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
 	depends on SUPERH && HAVE_CLK
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9d75d21..4109fcf 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
 spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
 obj-$(CONFIG_SPI_S3C64XX)		+= spi-s3c64xx.o
+obj-$(CONFIG_SPI_SA1100)		+= spi-sa1100.o
 obj-$(CONFIG_SPI_SH)			+= spi-sh.o
 obj-$(CONFIG_SPI_SH_HSPI)		+= spi-sh-hspi.o
 obj-$(CONFIG_SPI_SH_MSIOF)		+= spi-sh-msiof.o
diff --git a/drivers/spi/spi-sa1100.c b/drivers/spi/spi-sa1100.c
new file mode 100644
index 0000000..5626288
--- /dev/null
+++ b/drivers/spi/spi-sa1100.c
@@ -0,0 +1,470 @@
+/*
+ * Generic SA1100 and Jornada 720 derivate SSP/SPI driver
+ *
+ * Copyright (C) 2003 Russell King.
+ * Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
+ * Copyright (C) 2006 Filip Zyzniewski <filip.zyzniewski@tefnet.pl>
+ * Copyright (C) 2011 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Generic SSP driver. This provides the generic core for simple
+ * IO-based SSP applications. It also encompasses the SSP driver for the
+ * HP Jornada 710/720/72 which is currently the only user of it.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_data/sa1100-ssp.h>
+
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <mach/jornada720.h>
+
+/*
+ * TODO: tidy up this documentation (copied verbatim)
+ *
+ * Synchronous Serial Port (SSP) control registers
+ *
+ * Registers
+ *    SSCR0 		Serial port 4 Synchronous Serial Port (SSP) Control
+ *              	Register 0 (read/write).
+ *    SSCR1 		Serial port 4 Synchronous Serial Port (SSP) Control
+ *              	Register 1 (read/write).
+ *              	[Bits SPO and SP are only implemented in versions 2.0
+ *              	(rev. = 8) and higher of the StrongARM SA-1100.]
+ *    SSDR  		Serial port 4 Synchronous Serial Port (SSP) Data
+ *              	Register (read/write).
+ *    SSSR  		Serial port 4 Synchronous Serial Port (SSP) Status
+ *              	Register (read/write).
+ *
+ * Clocks
+ *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
+ *              	or 3.5795 MHz).
+ *    fss, Tss  	Frequency, period of the SSP communication.
+ */
+
+#define SSCR0		0x60	/* Ser. port 4 SSP Control Reg. 0 */
+#define SSCR1		0x64	/* Ser. port 4 SSP Control Reg. 1 */
+#define SSDR		0x6C	/* Ser. port 4 SSP Data Reg. */
+#define SSSR		0x74	/* Ser. port 4 SSP Status Reg. */
+
+#define SSCR0_DSS	Fld (4, 0)	/* Data Size - 1 Select [3..15]    */
+#define SSCR0_DataSize(Size)    	/*  Data Size Select [4..16]       */ \
+                	(((Size) - 1) << FShft (SSCR0_DSS))
+#define SSCR0_FRF	Fld (2, 4)	/* FRame Format                    */
+#define SSCR0_Motorola	        	/*  Motorola Serial Peripheral     */ \
+                	        	/*  Interface (SPI) format         */ \
+                	(0 << FShft (SSCR0_FRF))
+#define SSCR0_TI	        	/*  Texas Instruments Synchronous  */ \
+                	        	/*  Serial format                  */ \
+                	(1 << FShft (SSCR0_FRF))
+#define SSCR0_National	        	/*  National Microwire format      */ \
+                	(2 << FShft (SSCR0_FRF))
+#define SSCR0_SSE	0x00000080	/* SSP Enable                      */
+#define SSCR0_SCR	Fld (8, 8)	/* Serial Clock Rate divisor/2 - 1 */
+                	        	/* fss = fxtl/(2*(SCR + 1))        */
+                	        	/* Tss = 2*(SCR + 1)*Txtl          */
+#define SSCR0_SerClkDiv(Div)    	/*  Serial Clock Divisor [2..512]  */ \
+                	(((Div) - 2)/2 << FShft (SSCR0_SCR))
+                	        	/*  fss = fxtl/(2*Floor (Div/2))   */
+                	        	/*  Tss = 2*Floor (Div/2)*Txtl     */
+#define SSCR0_CeilSerClkDiv(Div)	/*  Ceil. of SerClkDiv [2..512]    */ \
+                	(((Div) - 1)/2 << FShft (SSCR0_SCR))
+                	        	/*  fss = fxtl/(2*Ceil (Div/2))    */
+                	        	/*  Tss = 2*Ceil (Div/2)*Txtl      */
+
+#define SSCR1_RIE	0x00000001	/* Receive FIFO 1/2-full or more   */
+                	        	/* Interrupt Enable                */
+#define SSCR1_TIE	0x00000002	/* Transmit FIFO 1/2-full or less  */
+                	        	/* Interrupt Enable                */
+#define SSCR1_LBM	0x00000004	/* Look-Back Mode                  */
+#define SSCR1_SPO	0x00000008	/* Sample clock (SCLK) POlarity    */
+#define SSCR1_SClkIactL	(SSCR1_SPO*0)	/*  Sample Clock Inactive Low      */
+#define SSCR1_SClkIactH	(SSCR1_SPO*1)	/*  Sample Clock Inactive High     */
+#define SSCR1_SP	0x00000010	/* Sample clock (SCLK) Phase       */
+#define SSCR1_SClk1P	(SSCR1_SP*0)	/*  Sample Clock active 1 Period   */
+                	        	/*  after frame (SFRM, 1st edge)   */
+#define SSCR1_SClk1_2P	(SSCR1_SP*1)	/*  Sample Clock active 1/2 Period */
+                	        	/*  after frame (SFRM, 1st edge)   */
+#define SSCR1_ECS	0x00000020	/* External Clock Select           */
+#define SSCR1_IntClk	(SSCR1_ECS*0)	/*  Internal Clock                 */
+#define SSCR1_ExtClk	(SSCR1_ECS*1)	/*  External Clock (GPIO [19])     */
+
+#define SSDR_DATA	Fld (16, 0)	/* receive/transmit DATA FIFOs     */
+
+#define SSSR_TNF	0x00000002	/* Transmit FIFO Not Full (read)   */
+#define SSSR_RNE	0x00000004	/* Receive FIFO Not Empty (read)   */
+#define SSSR_BSY	0x00000008	/* SSP BuSY (read)                 */
+#define SSSR_TFS	0x00000010	/* Transmit FIFO 1/2-full or less  */
+                	        	/* Service request (read)          */
+#define SSSR_RFS	0x00000020	/* Receive FIFO 1/2-full or more   */
+                	        	/* Service request (read)          */
+#define SSSR_ROR	0x00000040	/* Receive FIFO Over-Run           */
+
+#define DRV_NAME "sa1100-ssp"
+#define TIMEOUT 100000
+
+struct ssp_state {
+	struct spi_master *master;
+	struct device	*dev;
+	struct resource *memres;
+	void __iomem	*base;
+	int		irq;
+	unsigned int	en_gpio;
+	unsigned int	rdy_gpio;
+	unsigned int	cr0;
+	unsigned int	cr1;
+	int		bpw;
+};
+
+static inline bool sa1100_gpio_is_valid(unsigned int gpio)
+{
+	return gpio >= 0;
+}
+
+static irqreturn_t sa1100_ssp_interrupt(int irq, void *dev_id)
+{
+	struct ssp_state *ssp = dev_id;
+	u32 status = readl(ssp->base + SSSR);
+
+	if (status & SSSR_ROR)
+		dev_warn(ssp->dev, "receiver overrun\n");
+
+	writel(SSSR_ROR, ssp->base + SSSR);
+
+	return status ? IRQ_HANDLED : IRQ_NONE;
+}
+
+/**
+ * sa1100_ssp_write_word - write a word to the SSP port
+ * @data: 16-bit, MSB justified data to write.
+ *
+ * Wait for a free entry in the SSP transmit FIFO, and write a data
+ * word to the SSP port.  Wait for the SSP port to start sending
+ * the data.
+ *
+ * The caller is expected to perform the necessary locking.
+ *
+ * Returns:
+ *   %-ETIMEDOUT	timeout occurred
+ *   0			success
+ */
+static int sa1100_ssp_write_word(struct ssp_state *ssp, u16 data)
+{
+	int timeout = 400000; /* GPIO timeout */
+
+	/* If there is a GPIO ready pin to wait on */
+	if (sa1100_gpio_is_valid(ssp->rdy_gpio)) {
+		while ((GPLR & ssp->rdy_gpio)) {
+			if (!--timeout) {
+				dev_err(ssp->dev, "GPIO ready timeout\n");
+				return -ETIMEDOUT;
+			}
+			cpu_relax();
+		}
+	}
+
+	timeout = TIMEOUT;
+	while (!(readl(ssp->base + SSSR) & SSSR_TNF)) {
+	        if (!--timeout)
+			return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	writel(data, ssp->base + SSDR);
+
+	timeout = TIMEOUT;
+	while (!(readl(ssp->base + SSSR) & SSSR_BSY)) {
+	        if (!--timeout)
+			return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	return 0;
+}
+
+/**
+ * sa1100_ssp_read_word - read a word from the SSP port
+ *
+ * Wait for a data word in the SSP receive FIFO, and return the
+ * received data.  Data is LSB justified.
+ *
+ * Note: Currently, if data is not expected to be received, this
+ * function will wait for ever.
+ *
+ * The caller is expected to perform the necessary locking.
+ *
+ * Returns:
+ *   %-ETIMEDOUT	timeout occurred
+ *   16-bit data	success
+ */
+static int sa1100_ssp_read_word(struct ssp_state *ssp, u16 *data)
+{
+	int timeout = TIMEOUT;
+
+	while (!(readl(ssp->base + SSSR) & SSSR_RNE)) {
+	        if (!--timeout)
+			return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	*data = (u16) readl(ssp->base + SSDR);
+
+	return 0;
+}
+
+/**
+ * sa1100_ssp_flush - flush the transmit and receive FIFOs
+ *
+ * Wait for the SSP to idle, and ensure that the receive FIFO
+ * is empty.
+ *
+ * The caller is expected to perform the necessary locking.
+ *
+ * Returns:
+ *   %-ETIMEDOUT	timeout occurred
+ *   0			success
+ */
+static int sa1100_ssp_flush(struct ssp_state *ssp)
+{
+	int timeout = TIMEOUT * 2;
+
+	do {
+		while (readl(ssp->base + SSSR) & SSSR_RNE) {
+		        if (!--timeout)
+				return -ETIMEDOUT;
+			(void) readl(ssp->base + SSDR);
+		}
+	        if (!--timeout)
+			return -ETIMEDOUT;
+	} while (readl(ssp->base + SSSR) & SSSR_BSY);
+
+	return 0;
+}
+
+/**
+ * sa1100_ssp_enable - enable the SSP port
+ *
+ * Turn on the SSP port.
+ */
+static void sa1100_ssp_enable(struct ssp_state *ssp)
+{
+	/*
+	 * Enable SSP device on other end with GPIO (GPIO active low)
+	 */
+	if (sa1100_gpio_is_valid(ssp->en_gpio))
+		GPCR = ssp->en_gpio;
+	writel((readl(ssp->base + SSCR0) | SSCR0_SSE), ssp->base + SSCR0);
+}
+
+/**
+ * sa1100_ssp_disable - shut down the SSP port
+ *
+ * Turn off the SSP port, optionally powering it down.
+ */
+static void sa1100_ssp_disable(struct ssp_state *ssp)
+{
+	/* Disable SSP device on other end (GPIO active low) */
+	if (sa1100_gpio_is_valid(ssp->en_gpio))
+		GPSR = ssp->en_gpio;
+	writel((readl(ssp->base + SSCR0) & ~SSCR0_SSE), ssp->base + SSCR0);
+}
+
+static int sa1100_readwrite(struct ssp_state *ssp, struct spi_transfer *t)
+{
+	int bpw = ssp->bpw;
+	unsigned count;
+	const u16 *tx = t->tx_buf;
+	u16 *rx = t->rx_buf;
+	int ret;
+
+	/*
+	 * This SSP can do 16 bit transfers only
+	 */
+	if (t->bits_per_word)
+		bpw = t->bits_per_word;
+	if (bpw != 16)
+		return -EIO;
+
+	count = t->len;
+
+	do {
+		ret = sa1100_ssp_write_word(ssp, *tx);
+		if (ret < 0)
+			goto out;
+		ret = sa1100_ssp_read_word(ssp, rx);
+		if (ret < 0)
+			goto out;
+		tx++;
+		rx++;
+		count -= 2;
+	} while (count);
+out:
+	return t->len - count;
+}
+
+
+static int sa1100_setup(struct spi_device *spi)
+{
+	struct ssp_state *ssp = spi_master_get_devdata(spi->master);
+
+	ssp->bpw = spi->bits_per_word;
+	return 0;
+}
+
+static int sa1100_prepare_transfer_hardware(struct spi_master *master)
+{
+	struct ssp_state *ssp = spi_master_get_devdata(master);
+
+	sa1100_ssp_enable(ssp);
+	return 0;
+}
+
+static int sa1100_unprepare_transfer_hardware(struct spi_master *master)
+{
+	struct ssp_state *ssp = spi_master_get_devdata(master);
+
+	sa1100_ssp_disable(ssp);
+	return 0;
+}
+
+static int sa1100_transfer_one_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct ssp_state *ssp = spi_master_get_devdata(master);
+	struct spi_transfer *t = NULL;
+
+	/* Iterate over the transfers in this message */
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->len)
+			msg->actual_length += sa1100_readwrite(ssp, t);
+	}
+	msg->status = 0;
+	return 0;
+}
+
+static int __devinit sa1100_ssp_probe(struct platform_device *pdev)
+{
+	struct sa1100_ssp_plat_data *pdata = dev_get_platdata(&pdev->dev);
+	struct spi_master *master;
+	struct ssp_state *ssp;
+	int ret = -ENODEV;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*ssp));
+	if (!master)
+		return -ENOMEM;
+
+	/* setup the master state */
+	master->bus_num = pdev->id;
+	master->num_chipselect = 1;
+	master->mode_bits = SPI_CS_HIGH;
+	master->setup = sa1100_setup;
+	master->prepare_transfer_hardware = sa1100_prepare_transfer_hardware;
+	master->unprepare_transfer_hardware = sa1100_unprepare_transfer_hardware;
+	master->transfer_one_message = sa1100_transfer_one_message;
+
+	/* setup the driver state */
+	ssp = spi_master_get_devdata(master);
+	ssp->master = master;
+	ssp->dev = &pdev->dev;
+	ssp->en_gpio = pdata->en_gpio;
+	ssp->rdy_gpio = pdata->rdy_gpio;
+	platform_set_drvdata(pdev, ssp);
+
+	ssp->memres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!ssp->memres)
+		goto out;
+
+	if (devm_request_mem_region(&pdev->dev,
+				    ssp->memres->start,
+				    resource_size(ssp->memres),
+				    DRV_NAME) == NULL)
+		goto out;
+
+	ssp->base = devm_ioremap(&pdev->dev,
+				 ssp->memres->start,
+				 resource_size(ssp->memres));
+	if (ssp->base == NULL)
+		goto out;
+
+	/* This also lowers any GPIO signal */
+	sa1100_ssp_disable(ssp);
+	if (!(PPAR & PPAR_SPR) && (Ser4MCCR0 & MCCR0_MCE))
+		goto out;
+
+	writel(SSSR_ROR, ssp->base + SSSR);
+
+	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq >= 0) {
+		ret = devm_request_irq(&pdev->dev,
+				       ssp->irq, sa1100_ssp_interrupt,
+				       0, DRV_NAME, ssp);
+		if (!ret) {
+			/* With IRQ initialization we are done now */
+			dev_info(&pdev->dev, "irq initialized\n");
+			return ret;
+		}
+	}
+
+	/* Fall back to polling mode */
+	dev_warn(&pdev->dev,
+		"initialization failed, fallback to non-irq polling mode\n");
+
+	/* TODO: explain this magic, comes from the jornada */
+	writel(0x0387, ssp->base + SSCR0);
+	writel(0x18, ssp->base + SSCR1);
+
+	/* clear out any left over data */
+	sa1100_ssp_flush(ssp);
+
+	/* all fine */
+	dev_info(&pdev->dev, "device initialized\n");
+	return 0;
+
+out:
+	spi_master_put(master);
+	platform_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static int sa1100_ssp_remove(struct platform_device *pdev)
+{
+	struct ssp_state *ssp = platform_get_drvdata(pdev);
+
+	if (ssp) {
+		sa1100_ssp_disable(ssp);
+		spi_master_put(ssp->master);
+	}
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+struct platform_driver sa1100_ssp_driver = {
+	.probe	= sa1100_ssp_probe,
+	.remove	= sa1100_ssp_remove,
+	.driver	= {
+		.name	= DRV_NAME,
+	},
+};
+
+static int __init sa1100_ssp_module_init(void)
+{
+	return platform_driver_register(&sa1100_ssp_driver);
+}
+subsys_initcall(sa1100_ssp_module_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_DESCRIPTION("SA11x0 SSP PIO driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/sa1100-ssp.h b/include/linux/platform_data/sa1100-ssp.h
new file mode 100644
index 0000000..3d3df47
--- /dev/null
+++ b/include/linux/platform_data/sa1100-ssp.h
@@ -0,0 +1,15 @@
+/*
+ * Header file for the SA1100 SPI driver
+ */
+
+/**
+ * struct sa1100_ssp_plat_data - platform data for SA1100 SSP driver
+ * @en_gpio: GPIO pin to enable SSP device on the other end
+ * @rdy_gpio: GPIO pin to listen for ready flag for SSP device on other end -
+ *	when this is given this GPIO pin will be polled for retrieveing
+ *	words instead of using IRQ
+ */
+struct sa1100_ssp_plat_data {
+	unsigned int en_gpio;
+	unsigned int rdy_gpio;
+};
-- 
1.7.7.6

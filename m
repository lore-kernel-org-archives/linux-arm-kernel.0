From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Jul 2011 14:12:34 -0400 (EDT)
Subject: [PATCH] ARM: mach-s3c24a0: delete
In-Reply-To: <20110628212749.GJ21138@trinity.fluff.org>
References: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
	<20110628211712.GF21138@trinity.fluff.org>
	<201106282322.57631.arnd@arndb.de>
	<20110628212749.GJ21138@trinity.fluff.org>
Message-ID: <alpine.LFD.2.00.1107051357480.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jun 2011, Ben Dooks wrote:

> On Tue, Jun 28, 2011 at 11:22:57PM +0200, Arnd Bergmann wrote:
> 
> > On a related note, what about mach-s3c2400? It seems to be even more
> > incomplete.
> 
> Probably the same fate awaits that. It is so old that there's little
> incentive to do anything with it.

Here it is.  Please ACK.

commit 896ce6bc5bf1e0f963186ab0db4e692ecebeb14c
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Tue Jul 5 13:55:21 2011 -0400

    ARM: mach-s3c2400: delete
    
    On Tue, 28 Jun 2011, Ben Dooks wrote:
    
    > On Tue, Jun 28, 2011 at 11:22:57PM +0200, Arnd Bergmann wrote:
    >
    > > On a related note, what about mach-s3c2400? It seems to be even more
    > > incomplete.
    >
    > Probably the same fate awaits that. It is so old that there's little
    > incentive to do anything with it.
    
    So out it goes as well.
    
    Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                               |    1 -
 arch/arm/mach-s3c2400/Kconfig                  |    7 -
 arch/arm/mach-s3c2400/Makefile                 |   15 -
 arch/arm/mach-s3c2400/gpio.c                   |   42 ---
 arch/arm/mach-s3c2400/include/mach/map.h       |   66 -----
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h  |    6 -
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h |  241 ------------------
 arch/arm/mach-s3c2412/Kconfig                  |    2 +-
 arch/arm/plat-s3c24xx/cpu.c                    |   15 -
 arch/arm/plat-s3c24xx/include/plat/regs-iis.h  |    9 -
 arch/arm/plat-s3c24xx/include/plat/s3c2400.h   |   31 ---
 11 files changed, 1 insertions(+), 434 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ec1c799..feae354 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1016,7 +1016,6 @@ source "arch/arm/plat-spear/Kconfig"
 source "arch/arm/plat-tcc/Kconfig"
 
 if ARCH_S3C2410
-source "arch/arm/mach-s3c2400/Kconfig"
 source "arch/arm/mach-s3c2410/Kconfig"
 source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2416/Kconfig"
diff --git a/arch/arm/mach-s3c2400/Kconfig b/arch/arm/mach-s3c2400/Kconfig
deleted file mode 100644
index fdd8f5e..0000000
--- a/arch/arm/mach-s3c2400/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-menu "S3C2400 Machines"
-
-endmenu
diff --git a/arch/arm/mach-s3c2400/Makefile b/arch/arm/mach-s3c2400/Makefile
deleted file mode 100644
index 7e23f4e..0000000
--- a/arch/arm/mach-s3c2400/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-# arch/arm/mach-s3c2400/Makefile
-#
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-obj-$(CONFIG_CPU_S3C2400)	+= gpio.o
-
-# Machine support
-
diff --git a/arch/arm/mach-s3c2400/gpio.c b/arch/arm/mach-s3c2400/gpio.c
deleted file mode 100644
index 6c68e78..0000000
--- a/arch/arm/mach-s3c2400/gpio.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/* linux/arch/arm/mach-s3c2400/gpio.c
- *
- * Copyright (c) 2006 Lucas Correia Villa Real <lucasvr@gobolinux.org>
- *
- * S3C2400 GPIO support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <mach/regs-gpio.h>
-
-int s3c2400_gpio_getirq(unsigned int pin)
-{
-	if (pin < S3C2410_GPE(0) || pin > S3C2400_GPE(7))
-		return -EINVAL;  /* not valid interrupts */
-
-	return (pin - S3C2410_GPE(0)) + IRQ_EINT0;
-}
-
-EXPORT_SYMBOL(s3c2400_gpio_getirq);
diff --git a/arch/arm/mach-s3c2400/include/mach/map.h b/arch/arm/mach-s3c2400/include/mach/map.h
deleted file mode 100644
index 3fd8892..0000000
--- a/arch/arm/mach-s3c2400/include/mach/map.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* arch/arm/mach-s3c2400/include/mach/map.h
- *
- * Copyright 2003-2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Copyright 2003, Lucas Correia Villa Real
- *
- * S3C2400 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C2400_PA_MEMCTRL	(0x14000000)
-#define S3C2400_PA_USBHOST	(0x14200000)
-#define S3C2400_PA_IRQ		(0x14400000)
-#define S3C2400_PA_DMA		(0x14600000)
-#define S3C2400_PA_CLKPWR	(0x14800000)
-#define S3C2400_PA_LCD		(0x14A00000)
-#define S3C2400_PA_UART		(0x15000000)
-#define S3C2400_PA_TIMER	(0x15100000)
-#define S3C2400_PA_USBDEV	(0x15200140)
-#define S3C2400_PA_WATCHDOG	(0x15300000)
-#define S3C2400_PA_IIC		(0x15400000)
-#define S3C2400_PA_IIS		(0x15508000)
-#define S3C2400_PA_GPIO		(0x15600000)
-#define S3C2400_PA_RTC		(0x15700040)
-#define S3C2400_PA_ADC		(0x15800000)
-#define S3C2400_PA_SPI		(0x15900000)
-
-#define S3C2400_PA_MMC		(0x15A00000)
-#define S3C2400_SZ_MMC		SZ_1M
-
-/* physical addresses of all the chip-select areas */
-
-#define S3C2400_CS0	(0x00000000)
-#define S3C2400_CS1	(0x02000000)
-#define S3C2400_CS2	(0x04000000)
-#define S3C2400_CS3	(0x06000000)
-#define S3C2400_CS4	(0x08000000)
-#define S3C2400_CS5	(0x0A000000)
-#define S3C2400_CS6	(0x0C000000)
-#define S3C2400_CS7	(0x0E000000)
-
-#define S3C2400_SDRAM_PA    (S3C2400_CS6)
-
-/* Use a single interface for common resources between S3C24XX cpus */
-
-#define S3C24XX_PA_IRQ		S3C2400_PA_IRQ
-#define S3C24XX_PA_MEMCTRL	S3C2400_PA_MEMCTRL
-#define S3C24XX_PA_USBHOST	S3C2400_PA_USBHOST
-#define S3C24XX_PA_DMA		S3C2400_PA_DMA
-#define S3C24XX_PA_CLKPWR	S3C2400_PA_CLKPWR
-#define S3C24XX_PA_LCD		S3C2400_PA_LCD
-#define S3C24XX_PA_UART		S3C2400_PA_UART
-#define S3C24XX_PA_TIMER	S3C2400_PA_TIMER
-#define S3C24XX_PA_USBDEV	S3C2400_PA_USBDEV
-#define S3C24XX_PA_WATCHDOG	S3C2400_PA_WATCHDOG
-#define S3C24XX_PA_IIC		S3C2400_PA_IIC
-#define S3C24XX_PA_IIS		S3C2400_PA_IIS
-#define S3C24XX_PA_GPIO		S3C2400_PA_GPIO
-#define S3C24XX_PA_RTC		S3C2400_PA_RTC
-#define S3C24XX_PA_ADC		S3C2400_PA_ADC
-#define S3C24XX_PA_SPI		S3C2400_PA_SPI
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h b/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
index f453c4f..bab1392 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
@@ -52,12 +52,6 @@ extern unsigned int s3c2410_gpio_getcfg(unsigned int pin);
 
 extern int s3c2410_gpio_getirq(unsigned int pin);
 
-#ifdef CONFIG_CPU_S3C2400
-
-extern int s3c2400_gpio_getirq(unsigned int pin);
-
-#endif /* CONFIG_CPU_S3C2400 */
-
 /* s3c2410_gpio_irqfilter
  *
  * set the irq filtering on the given pin
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
index a0a89d4..cac1ad6 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
@@ -16,11 +16,7 @@
 
 #include <mach/gpio-nrs.h>
 
-#ifdef CONFIG_CPU_S3C2400
-#define S3C24XX_MISCCR		S3C2400_MISCCR
-#else
 #define S3C24XX_MISCCR		S3C24XX_GPIOREG2(0x80)
-#endif /* CONFIG_CPU_S3C2400 */
 
 /* general configuration options */
 
@@ -42,67 +38,33 @@
 /* configure GPIO ports A..G */
 
 /* port A - S3C2410: 22bits, zero in bit X makes pin X output
- *          S3C2400: 18bits, zero in bit X makes pin X output
  * 1 makes port special function, this is default
 */
 #define S3C2410_GPACON	   S3C2410_GPIOREG(0x00)
 #define S3C2410_GPADAT	   S3C2410_GPIOREG(0x04)
 
-#define S3C2400_GPACON	   S3C2410_GPIOREG(0x00)
-#define S3C2400_GPADAT	   S3C2410_GPIOREG(0x04)
-
 #define S3C2410_GPA0_ADDR0   (1<<0)
-
 #define S3C2410_GPA1_ADDR16  (1<<1)
-
 #define S3C2410_GPA2_ADDR17  (1<<2)
-
 #define S3C2410_GPA3_ADDR18  (1<<3)
-
 #define S3C2410_GPA4_ADDR19  (1<<4)
-
 #define S3C2410_GPA5_ADDR20  (1<<5)
-
 #define S3C2410_GPA6_ADDR21  (1<<6)
-
 #define S3C2410_GPA7_ADDR22  (1<<7)
-
 #define S3C2410_GPA8_ADDR23  (1<<8)
-
 #define S3C2410_GPA9_ADDR24  (1<<9)
-
 #define S3C2410_GPA10_ADDR25 (1<<10)
-#define S3C2400_GPA10_SCKE   (1<<10)
-
 #define S3C2410_GPA11_ADDR26 (1<<11)
-#define S3C2400_GPA11_nCAS0  (1<<11)
-
 #define S3C2410_GPA12_nGCS1  (1<<12)
-#define S3C2400_GPA12_nCAS1  (1<<12)
-
 #define S3C2410_GPA13_nGCS2  (1<<13)
-#define S3C2400_GPA13_nGCS1  (1<<13)
-
 #define S3C2410_GPA14_nGCS3  (1<<14)
-#define S3C2400_GPA14_nGCS2  (1<<14)
-
 #define S3C2410_GPA15_nGCS4  (1<<15)
-#define S3C2400_GPA15_nGCS3  (1<<15)
-
 #define S3C2410_GPA16_nGCS5  (1<<16)
-#define S3C2400_GPA16_nGCS4  (1<<16)
-
 #define S3C2410_GPA17_CLE    (1<<17)
-#define S3C2400_GPA17_nGCS5  (1<<17)
-
 #define S3C2410_GPA18_ALE    (1<<18)
-
 #define S3C2410_GPA19_nFWE   (1<<19)
-
 #define S3C2410_GPA20_nFRE   (1<<20)
-
 #define S3C2410_GPA21_nRSTOUT (1<<21)
-
 #define S3C2410_GPA22_nFCE   (1<<22)
 
 /* 0x08 and 0x0c are reserved on S3C2410 */
@@ -111,10 +73,6 @@
  * GPB is 10 IO pins, each configured by 2 bits each in GPBCON.
  *   00 = input, 01 = output, 10=special function, 11=reserved
 
- * S3C2400:
- * GPB is 16 IO pins, each configured by 2 bits each in GPBCON.
- *   00 = input, 01 = output, 10=data, 11=special function
-
  * bit 0,1 = pin 0, 2,3= pin 1...
  *
  * CPBUP = pull up resistor control, 1=disabled, 0=enabled
@@ -124,78 +82,35 @@
 #define S3C2410_GPBDAT	   S3C2410_GPIOREG(0x14)
 #define S3C2410_GPBUP	   S3C2410_GPIOREG(0x18)
 
-#define S3C2400_GPBCON	   S3C2410_GPIOREG(0x08)
-#define S3C2400_GPBDAT	   S3C2410_GPIOREG(0x0C)
-#define S3C2400_GPBUP	   S3C2410_GPIOREG(0x10)
-
 /* no i/o pin in port b can have value 3 (unless it is a s3c2443) ! */
 
 #define S3C2410_GPB0_TOUT0   (0x02 << 0)
-#define S3C2400_GPB0_DATA16  (0x02 << 0)
 
 #define S3C2410_GPB1_TOUT1   (0x02 << 2)
-#define S3C2400_GPB1_DATA17  (0x02 << 2)
 
 #define S3C2410_GPB2_TOUT2   (0x02 << 4)
-#define S3C2400_GPB2_DATA18  (0x02 << 4)
-#define S3C2400_GPB2_TCLK1   (0x03 << 4)
 
 #define S3C2410_GPB3_TOUT3   (0x02 << 6)
-#define S3C2400_GPB3_DATA19  (0x02 << 6)
-#define S3C2400_GPB3_TXD1    (0x03 << 6)
 
 #define S3C2410_GPB4_TCLK0   (0x02 << 8)
-#define S3C2400_GPB4_DATA20  (0x02 << 8)
 #define S3C2410_GPB4_MASK    (0x03 << 8)
-#define S3C2400_GPB4_RXD1    (0x03 << 8)
-#define S3C2400_GPB4_MASK    (0x03 << 8)
 
 #define S3C2410_GPB5_nXBACK  (0x02 << 10)
 #define S3C2443_GPB5_XBACK   (0x03 << 10)
-#define S3C2400_GPB5_DATA21  (0x02 << 10)
-#define S3C2400_GPB5_nCTS1   (0x03 << 10)
 
 #define S3C2410_GPB6_nXBREQ  (0x02 << 12)
 #define S3C2443_GPB6_XBREQ   (0x03 << 12)
-#define S3C2400_GPB6_DATA22  (0x02 << 12)
-#define S3C2400_GPB6_nRTS1   (0x03 << 12)
 
 #define S3C2410_GPB7_nXDACK1 (0x02 << 14)
 #define S3C2443_GPB7_XDACK1  (0x03 << 14)
-#define S3C2400_GPB7_DATA23  (0x02 << 14)
 
 #define S3C2410_GPB8_nXDREQ1 (0x02 << 16)
-#define S3C2400_GPB8_DATA24  (0x02 << 16)
 
 #define S3C2410_GPB9_nXDACK0 (0x02 << 18)
 #define S3C2443_GPB9_XDACK0  (0x03 << 18)
-#define S3C2400_GPB9_DATA25  (0x02 << 18)
-#define S3C2400_GPB9_I2SSDI  (0x03 << 18)
 
 #define S3C2410_GPB10_nXDRE0 (0x02 << 20)
 #define S3C2443_GPB10_XDREQ0 (0x03 << 20)
-#define S3C2400_GPB10_DATA26 (0x02 << 20)
-#define S3C2400_GPB10_nSS    (0x03 << 20)
-
-#define S3C2400_GPB11_INP    (0x00 << 22)
-#define S3C2400_GPB11_OUTP   (0x01 << 22)
-#define S3C2400_GPB11_DATA27 (0x02 << 22)
-
-#define S3C2400_GPB12_INP    (0x00 << 24)
-#define S3C2400_GPB12_OUTP   (0x01 << 24)
-#define S3C2400_GPB12_DATA28 (0x02 << 24)
-
-#define S3C2400_GPB13_INP    (0x00 << 26)
-#define S3C2400_GPB13_OUTP   (0x01 << 26)
-#define S3C2400_GPB13_DATA29 (0x02 << 26)
-
-#define S3C2400_GPB14_INP    (0x00 << 28)
-#define S3C2400_GPB14_OUTP   (0x01 << 28)
-#define S3C2400_GPB14_DATA30 (0x02 << 28)
-
-#define S3C2400_GPB15_INP    (0x00 << 30)
-#define S3C2400_GPB15_OUTP   (0x01 << 30)
-#define S3C2400_GPB15_DATA31 (0x02 << 30)
 
 #define S3C2410_GPB_PUPDIS(x)  (1<<(x))
 
@@ -208,59 +123,22 @@
 #define S3C2410_GPCCON	   S3C2410_GPIOREG(0x20)
 #define S3C2410_GPCDAT	   S3C2410_GPIOREG(0x24)
 #define S3C2410_GPCUP	   S3C2410_GPIOREG(0x28)
-
-#define S3C2400_GPCCON	   S3C2410_GPIOREG(0x14)
-#define S3C2400_GPCDAT	   S3C2410_GPIOREG(0x18)
-#define S3C2400_GPCUP	   S3C2410_GPIOREG(0x1C)
-
 #define S3C2410_GPC0_LEND	(0x02 << 0)
-#define S3C2400_GPC0_VD0 	(0x02 << 0)
-
 #define S3C2410_GPC1_VCLK	(0x02 << 2)
-#define S3C2400_GPC1_VD1 	(0x02 << 2)
-
 #define S3C2410_GPC2_VLINE	(0x02 << 4)
-#define S3C2400_GPC2_VD2  	(0x02 << 4)
-
 #define S3C2410_GPC3_VFRAME	(0x02 << 6)
-#define S3C2400_GPC3_VD3   	(0x02 << 6)
-
 #define S3C2410_GPC4_VM		(0x02 << 8)
-#define S3C2400_GPC4_VD4	(0x02 << 8)
-
 #define S3C2410_GPC5_LCDVF0	(0x02 << 10)
-#define S3C2400_GPC5_VD5   	(0x02 << 10)
-
 #define S3C2410_GPC6_LCDVF1	(0x02 << 12)
-#define S3C2400_GPC6_VD6   	(0x02 << 12)
-
 #define S3C2410_GPC7_LCDVF2	(0x02 << 14)
-#define S3C2400_GPC7_VD7   	(0x02 << 14)
-
 #define S3C2410_GPC8_VD0	(0x02 << 16)
-#define S3C2400_GPC8_VD8	(0x02 << 16)
-
 #define S3C2410_GPC9_VD1	(0x02 << 18)
-#define S3C2400_GPC9_VD9	(0x02 << 18)
-
 #define S3C2410_GPC10_VD2	(0x02 << 20)
-#define S3C2400_GPC10_VD10	(0x02 << 20)
-
 #define S3C2410_GPC11_VD3	(0x02 << 22)
-#define S3C2400_GPC11_VD11	(0x02 << 22)
-
 #define S3C2410_GPC12_VD4	(0x02 << 24)
-#define S3C2400_GPC12_VD12	(0x02 << 24)
-
 #define S3C2410_GPC13_VD5	(0x02 << 26)
-#define S3C2400_GPC13_VD13	(0x02 << 26)
-
 #define S3C2410_GPC14_VD6	(0x02 << 28)
-#define S3C2400_GPC14_VD14	(0x02 << 28)
-
 #define S3C2410_GPC15_VD7	(0x02 << 30)
-#define S3C2400_GPC15_VD15	(0x02 << 30)
-
 #define S3C2410_GPC_PUPDIS(x)  (1<<(x))
 
 /*
@@ -269,8 +147,6 @@
  * almost identical setup to port b, but the special functions are mostly
  * to do with the video system's data.
  *
- * S3C2400: Port D consists of 11 GPIO/Special function
- *
  * almost identical setup to port c
 */
 
@@ -278,46 +154,31 @@
 #define S3C2410_GPDDAT	   S3C2410_GPIOREG(0x34)
 #define S3C2410_GPDUP	   S3C2410_GPIOREG(0x38)
 
-#define S3C2400_GPDCON	   S3C2410_GPIOREG(0x20)
-#define S3C2400_GPDDAT	   S3C2410_GPIOREG(0x24)
-#define S3C2400_GPDUP	   S3C2410_GPIOREG(0x28)
-
 #define S3C2410_GPD0_VD8	(0x02 << 0)
-#define S3C2400_GPD0_VFRAME	(0x02 << 0)
 #define S3C2442_GPD0_nSPICS1	(0x03 << 0)
 
 #define S3C2410_GPD1_VD9	(0x02 << 2)
-#define S3C2400_GPD1_VM		(0x02 << 2)
 #define S3C2442_GPD1_SPICLK1	(0x03 << 2)
 
 #define S3C2410_GPD2_VD10	(0x02 << 4)
-#define S3C2400_GPD2_VLINE	(0x02 << 4)
 
 #define S3C2410_GPD3_VD11	(0x02 << 6)
-#define S3C2400_GPD3_VCLK	(0x02 << 6)
 
 #define S3C2410_GPD4_VD12	(0x02 << 8)
-#define S3C2400_GPD4_LEND	(0x02 << 8)
 
 #define S3C2410_GPD5_VD13	(0x02 << 10)
-#define S3C2400_GPD5_TOUT0	(0x02 << 10)
 
 #define S3C2410_GPD6_VD14	(0x02 << 12)
-#define S3C2400_GPD6_TOUT1	(0x02 << 12)
 
 #define S3C2410_GPD7_VD15	(0x02 << 14)
-#define S3C2400_GPD7_TOUT2	(0x02 << 14)
 
 #define S3C2410_GPD8_VD16	(0x02 << 16)
-#define S3C2400_GPD8_TOUT3	(0x02 << 16)
 #define S3C2440_GPD8_SPIMISO1	(0x03 << 16)
 
 #define S3C2410_GPD9_VD17	(0x02 << 18)
-#define S3C2400_GPD9_TCLK0	(0x02 << 18)
 #define S3C2440_GPD9_SPIMOSI1	(0x03 << 18)
 
 #define S3C2410_GPD10_VD18	(0x02 << 20)
-#define S3C2400_GPD10_nWAIT	(0x02 << 20)
 #define S3C2440_GPD10_SPICLK1	(0x03 << 20)
 
 #define S3C2410_GPD11_VD19	(0x02 << 22)
@@ -340,9 +201,6 @@
  * again, the same as port B, but dealing with I2S, SDI, and
  * more miscellaneous functions
  *
- * S3C2400:
- * Port E consists of 12 GPIO/Special function
- *
  * GPIO / interrupt inputs
 */
 
@@ -350,74 +208,51 @@
 #define S3C2410_GPEDAT	   S3C2410_GPIOREG(0x44)
 #define S3C2410_GPEUP	   S3C2410_GPIOREG(0x48)
 
-#define S3C2400_GPECON	   S3C2410_GPIOREG(0x2C)
-#define S3C2400_GPEDAT	   S3C2410_GPIOREG(0x30)
-#define S3C2400_GPEUP	   S3C2410_GPIOREG(0x34)
-
 #define S3C2410_GPE0_I2SLRCK   (0x02 << 0)
 #define S3C2443_GPE0_AC_nRESET (0x03 << 0)
-#define S3C2400_GPE0_EINT0     (0x02 << 0)
 #define S3C2410_GPE0_MASK      (0x03 << 0)
 
 #define S3C2410_GPE1_I2SSCLK   (0x02 << 2)
 #define S3C2443_GPE1_AC_SYNC   (0x03 << 2)
-#define S3C2400_GPE1_EINT1     (0x02 << 2)
-#define S3C2400_GPE1_nSS       (0x03 << 2)
 #define S3C2410_GPE1_MASK      (0x03 << 2)
 
 #define S3C2410_GPE2_CDCLK     (0x02 << 4)
 #define S3C2443_GPE2_AC_BITCLK (0x03 << 4)
-#define S3C2400_GPE2_EINT2     (0x02 << 4)
-#define S3C2400_GPE2_I2SSDI    (0x03 << 4)
 
 #define S3C2410_GPE3_I2SSDI    (0x02 << 6)
 #define S3C2443_GPE3_AC_SDI    (0x03 << 6)
-#define S3C2400_GPE3_EINT3     (0x02 << 6)
-#define S3C2400_GPE3_nCTS1     (0x03 << 6)
 #define S3C2410_GPE3_nSS0      (0x03 << 6)
 #define S3C2410_GPE3_MASK      (0x03 << 6)
 
 #define S3C2410_GPE4_I2SSDO    (0x02 << 8)
 #define S3C2443_GPE4_AC_SDO    (0x03 << 8)
-#define S3C2400_GPE4_EINT4     (0x02 << 8)
-#define S3C2400_GPE4_nRTS1     (0x03 << 8)
 #define S3C2410_GPE4_I2SSDI    (0x03 << 8)
 #define S3C2410_GPE4_MASK      (0x03 << 8)
 
 #define S3C2410_GPE5_SDCLK     (0x02 << 10)
 #define S3C2443_GPE5_SD1_CLK   (0x02 << 10)
-#define S3C2400_GPE5_EINT5     (0x02 << 10)
-#define S3C2400_GPE5_TCLK1     (0x03 << 10)
 #define S3C2443_GPE5_AC_BITCLK (0x03 << 10)
 
 #define S3C2410_GPE6_SDCMD     (0x02 << 12)
 #define S3C2443_GPE6_SD1_CMD   (0x02 << 12)
 #define S3C2443_GPE6_AC_SDI    (0x03 << 12)
-#define S3C2400_GPE6_EINT6     (0x02 << 12)
 
 #define S3C2410_GPE7_SDDAT0    (0x02 << 14)
 #define S3C2443_GPE5_SD1_DAT0  (0x02 << 14)
 #define S3C2443_GPE7_AC_SDO    (0x03 << 14)
-#define S3C2400_GPE7_EINT7     (0x02 << 14)
 
 #define S3C2410_GPE8_SDDAT1    (0x02 << 16)
 #define S3C2443_GPE8_SD1_DAT1  (0x02 << 16)
 #define S3C2443_GPE8_AC_SYNC   (0x03 << 16)
-#define S3C2400_GPE8_nXDACK0   (0x02 << 16)
 
 #define S3C2410_GPE9_SDDAT2    (0x02 << 18)
 #define S3C2443_GPE9_SD1_DAT2  (0x02 << 18)
 #define S3C2443_GPE9_AC_nRESET (0x03 << 18)
-#define S3C2400_GPE9_nXDACK1   (0x02 << 18)
-#define S3C2400_GPE9_nXBACK    (0x03 << 18)
 
 #define S3C2410_GPE10_SDDAT3   (0x02 << 20)
 #define S3C2443_GPE10_SD1_DAT3 (0x02 << 20)
-#define S3C2400_GPE10_nXDREQ0  (0x02 << 20)
 
 #define S3C2410_GPE11_SPIMISO0 (0x02 << 22)
-#define S3C2400_GPE11_nXDREQ1  (0x02 << 22)
-#define S3C2400_GPE11_nXBREQ   (0x03 << 22)
 
 #define S3C2410_GPE12_SPIMOSI0 (0x02 << 24)
 
@@ -447,9 +282,6 @@
  *
  * pull up works like all other ports.
  *
- * S3C2400:
- * Port F consists of 7 GPIO/Special function
- *
  * GPIO/serial/misc pins
 */
 
@@ -457,37 +289,14 @@
 #define S3C2410_GPFDAT	   S3C2410_GPIOREG(0x54)
 #define S3C2410_GPFUP	   S3C2410_GPIOREG(0x58)
 
-#define S3C2400_GPFCON	   S3C2410_GPIOREG(0x38)
-#define S3C2400_GPFDAT	   S3C2410_GPIOREG(0x3C)
-#define S3C2400_GPFUP	   S3C2410_GPIOREG(0x40)
-
 #define S3C2410_GPF0_EINT0  (0x02 << 0)
-#define S3C2400_GPF0_RXD0   (0x02 << 0)
-
 #define S3C2410_GPF1_EINT1  (0x02 << 2)
-#define S3C2400_GPF1_RXD1   (0x02 << 2)
-#define S3C2400_GPF1_IICSDA (0x03 << 2)
-
 #define S3C2410_GPF2_EINT2  (0x02 << 4)
-#define S3C2400_GPF2_TXD0   (0x02 << 4)
-
 #define S3C2410_GPF3_EINT3  (0x02 << 6)
-#define S3C2400_GPF3_TXD1   (0x02 << 6)
-#define S3C2400_GPF3_IICSCL (0x03 << 6)
-
 #define S3C2410_GPF4_EINT4  (0x02 << 8)
-#define S3C2400_GPF4_nRTS0  (0x02 << 8)
-#define S3C2400_GPF4_nXBACK (0x03 << 8)
-
 #define S3C2410_GPF5_EINT5  (0x02 << 10)
-#define S3C2400_GPF5_nCTS0  (0x02 << 10)
-#define S3C2400_GPF5_nXBREQ (0x03 << 10)
-
 #define S3C2410_GPF6_EINT6  (0x02 << 12)
-#define S3C2400_GPF6_CLKOUT (0x02 << 12)
-
 #define S3C2410_GPF7_EINT7  (0x02 << 14)
-
 #define S3C2410_GPF_PUPDIS(x)  (1<<(x))
 
 /* S3C2410:
@@ -497,62 +306,38 @@
  *   00 = 0 input, 1 output, 2 interrupt (EINT0..7), 3 special func
  *
  * pull up works like all other ports.
- *
- * S3C2400:
- * Port G consists of 10 GPIO/Special function
 */
 
 #define S3C2410_GPGCON	   S3C2410_GPIOREG(0x60)
 #define S3C2410_GPGDAT	   S3C2410_GPIOREG(0x64)
 #define S3C2410_GPGUP	   S3C2410_GPIOREG(0x68)
 
-#define S3C2400_GPGCON	   S3C2410_GPIOREG(0x44)
-#define S3C2400_GPGDAT	   S3C2410_GPIOREG(0x48)
-#define S3C2400_GPGUP	   S3C2410_GPIOREG(0x4C)
-
 #define S3C2410_GPG0_EINT8    (0x02 << 0)
-#define S3C2400_GPG0_I2SLRCK  (0x02 << 0)
 
 #define S3C2410_GPG1_EINT9    (0x02 << 2)
-#define S3C2400_GPG1_I2SSCLK  (0x02 << 2)
 
 #define S3C2410_GPG2_EINT10   (0x02 << 4)
 #define S3C2410_GPG2_nSS0     (0x03 << 4)
-#define S3C2400_GPG2_CDCLK    (0x02 << 4)
 
 #define S3C2410_GPG3_EINT11   (0x02 << 6)
 #define S3C2410_GPG3_nSS1     (0x03 << 6)
-#define S3C2400_GPG3_I2SSDO   (0x02 << 6)
-#define S3C2400_GPG3_I2SSDI   (0x03 << 6)
 
 #define S3C2410_GPG4_EINT12   (0x02 << 8)
-#define S3C2400_GPG4_MMCCLK   (0x02 << 8)
-#define S3C2400_GPG4_I2SSDI   (0x03 << 8)
 #define S3C2410_GPG4_LCDPWREN (0x03 << 8)
 #define S3C2443_GPG4_LCDPWRDN (0x03 << 8)
 
 #define S3C2410_GPG5_EINT13   (0x02 << 10)
-#define S3C2400_GPG5_MMCCMD   (0x02 << 10)
-#define S3C2400_GPG5_IICSDA   (0x03 << 10)
 #define S3C2410_GPG5_SPIMISO1 (0x03 << 10)	/* not s3c2443 */
 
 #define S3C2410_GPG6_EINT14   (0x02 << 12)
-#define S3C2400_GPG6_MMCDAT   (0x02 << 12)
-#define S3C2400_GPG6_IICSCL   (0x03 << 12)
 #define S3C2410_GPG6_SPIMOSI1 (0x03 << 12)
 
 #define S3C2410_GPG7_EINT15   (0x02 << 14)
 #define S3C2410_GPG7_SPICLK1  (0x03 << 14)
-#define S3C2400_GPG7_SPIMISO  (0x02 << 14)
-#define S3C2400_GPG7_IICSDA   (0x03 << 14)
 
 #define S3C2410_GPG8_EINT16   (0x02 << 16)
-#define S3C2400_GPG8_SPIMOSI  (0x02 << 16)
-#define S3C2400_GPG8_IICSCL   (0x03 << 16)
 
 #define S3C2410_GPG9_EINT17   (0x02 << 18)
-#define S3C2400_GPG9_SPICLK   (0x02 << 18)
-#define S3C2400_GPG9_MMCCLK   (0x03 << 18)
 
 #define S3C2410_GPG10_EINT18  (0x02 << 20)
 
@@ -660,7 +445,6 @@
 #define S3C2443_GPMUP	   S3C2410_GPIOREG(0x108)
 
 /* miscellaneous control */
-#define S3C2400_MISCCR	   S3C2410_GPIOREG(0x54)
 #define S3C2410_MISCCR	   S3C2410_GPIOREG(0x80)
 #define S3C2410_DCLKCON	   S3C2410_GPIOREG(0x84)
 
@@ -674,14 +458,6 @@
 #define S3C2410_MISCCR_SPUCR_LEN    (0<<1)
 #define S3C2410_MISCCR_SPUCR_LDIS   (1<<1)
 
-#define S3C2400_MISCCR_SPUCR_LEN    (0<<0)
-#define S3C2400_MISCCR_SPUCR_LDIS   (1<<0)
-#define S3C2400_MISCCR_SPUCR_HEN    (0<<1)
-#define S3C2400_MISCCR_SPUCR_HDIS   (1<<1)
-
-#define S3C2400_MISCCR_HZ_STOPEN    (0<<2)
-#define S3C2400_MISCCR_HZ_STOPPREV  (1<<2)
-
 #define S3C2410_MISCCR_USBDEV	    (0<<3)
 #define S3C2410_MISCCR_USBHOST	    (1<<3)
 
@@ -728,7 +504,6 @@
  *
  * Samsung datasheet p9-25
 */
-#define S3C2400_EXTINT0    S3C2410_GPIOREG(0x58)
 #define S3C2410_EXTINT0	   S3C2410_GPIOREG(0x88)
 #define S3C2410_EXTINT1	   S3C2410_GPIOREG(0x8C)
 #define S3C2410_EXTINT2	   S3C2410_GPIOREG(0x90)
@@ -796,22 +571,6 @@
 #define S3C2410_GSTATUS2_OFFRESET  (1<<1)
 #define S3C2410_GSTATUS2_PONRESET  (1<<0)
 
-/* open drain control register */
-#define S3C2400_OPENCR     S3C2410_GPIOREG(0x50)
-
-#define S3C2400_OPENCR_OPC_RXD1DIS  (0<<0)
-#define S3C2400_OPENCR_OPC_RXD1EN   (1<<0)
-#define S3C2400_OPENCR_OPC_TXD1DIS  (0<<1)
-#define S3C2400_OPENCR_OPC_TXD1EN   (1<<1)
-#define S3C2400_OPENCR_OPC_CMDDIS   (0<<2)
-#define S3C2400_OPENCR_OPC_CMDEN    (1<<2)
-#define S3C2400_OPENCR_OPC_DATDIS   (0<<3)
-#define S3C2400_OPENCR_OPC_DATEN    (1<<3)
-#define S3C2400_OPENCR_OPC_MISODIS  (0<<4)
-#define S3C2400_OPENCR_OPC_MISOEN   (1<<4)
-#define S3C2400_OPENCR_OPC_MOSIDIS  (0<<5)
-#define S3C2400_OPENCR_OPC_MOSIEN   (1<<5)
-
 /* 2412/2413 sleep configuration registers */
 
 #define S3C2412_GPBSLPCON	S3C2410_GPIOREG(0x1C)
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index e82ab4a..c2cf4e5 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -15,7 +15,7 @@ config CPU_S3C2412
 
 config CPU_S3C2412_ONLY
 	bool
-	depends on ARCH_S3C2410 && !CPU_S3C2400 && !CPU_S3C2410 && \
+	depends on ARCH_S3C2410 && !CPU_S3C2410 && \
 		   !CPU_S3C2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
 		   !CPU_S3C2443 && CPU_S3C2412
 	default y if CPU_S3C2412
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 4a10c0f..c1fc6c6 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -46,7 +46,6 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/s3c2400.h>
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
 #include <plat/s3c2416.h>
@@ -55,7 +54,6 @@
 
 /* table of supported CPUs */
 
-static const char name_s3c2400[]  = "S3C2400";
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2416[]  = "S3C2416/S3C2450";
@@ -157,15 +155,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s3c2443_init,
 		.name		= name_s3c2443,
 	},
-	{
-		.idcode		= 0x0,   /* S3C2400 doesn't have an idcode */
-		.idmask		= 0xffffffff,
-		.map_io		= s3c2400_map_io,
-		.init_clocks	= s3c2400_init_clocks,
-		.init_uarts	= s3c2400_init_uarts,
-		.init		= s3c2400_init,
-		.name		= name_s3c2400
-	},
 };
 
 /* minimal IO mapping */
@@ -200,11 +189,7 @@ static unsigned long s3c24xx_read_idcode_v5(void)
 
 static unsigned long s3c24xx_read_idcode_v4(void)
 {
-#ifndef CONFIG_CPU_S3C2400
 	return __raw_readl(S3C2410_GSTATUS1);
-#else
-	return 0UL;
-#endif
 }
 
 /* Hook for arm_pm_restart to ensure we execute the reset code
diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-iis.h b/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
index a6f1d5d..cc44e0e 100644
--- a/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
+++ b/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
@@ -64,14 +64,5 @@
 #define S3C2410_IISFCON_RXMASK	  (0x3f)
 #define S3C2410_IISFCON_RXSHIFT	  (0)
 
-#define S3C2400_IISFCON_TXDMA     (1<<11)
-#define S3C2400_IISFCON_RXDMA     (1<<10)
-#define S3C2400_IISFCON_TXENABLE  (1<<9)
-#define S3C2400_IISFCON_RXENABLE  (1<<8)
-#define S3C2400_IISFCON_TXMASK	  (0x07 << 4)
-#define S3C2400_IISFCON_TXSHIFT	  (4)
-#define S3C2400_IISFCON_RXMASK	  (0x07)
-#define S3C2400_IISFCON_RXSHIFT	  (0)
-
 #define S3C2410_IISFIFO  (0x10)
 #endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2400.h b/arch/arm/plat-s3c24xx/include/plat/s3c2400.h
deleted file mode 100644
index b3feaea..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2400.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2400.h
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for S3C2400 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Modifications:
- *     09-Fev-2006 LCVR  First version, based on s3c2410.h
-*/
-
-#ifdef CONFIG_CPU_S3C2400
-
-extern  int s3c2400_init(void);
-
-extern void s3c2400_map_io(void);
-
-extern void s3c2400_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2400_init_clocks(int xtal);
-
-#else
-#define s3c2400_init_clocks NULL
-#define s3c2400_init_uarts NULL
-#define s3c2400_map_io NULL
-#define s3c2400_init NULL
-#endif

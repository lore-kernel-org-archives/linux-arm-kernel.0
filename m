From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 29 Apr 2011 15:06:41 +0200
Subject: [PATCH 3/5] arm: mach-stmp37xx: remove mach
In-Reply-To: <1304082403-8897-1-git-send-email-w.sang@pengutronix.de>
References: <1304082403-8897-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1304082403-8897-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mach has not seen any updates since the initial inclusion besides
generic cleanup. Furthermore:

- It has a lot of reinvented interfaces, leaking all sorts of
  mach-related includes into the drivers. One example is the dmaengine
  which does not use the linux dmaengine-API but some privately exported
  symbols. So, drivers cannot be reused. mach-mxs is very similar and
  does it better.

- It can be doubted that this worked at all. Check the DMA routines in
  stmp37xx.c for copy/paste bugs. A lot of APBX-related stuff is 
  actually writing into registers for APBH.

- There is only one board defined (which I couldn't find any trace of
  despite being a development board). In this board, only two devices
  have resources, the debug uart and the application uart. Neither of
  those have the needed custom drivers merged (and never will). debug
  uart is amba-pl011 which has an in-kernel driver without the
  mach-specific-stuff. appuart has a driver which was introduced for
  mach-mxs, and this one is reusable for a properly done mach.

So, this single board registers only unsupported devices and the
generic code looks suspicious and has poor design. Delete this
stuff. If there is interest, it is wiser to restart using
mach-mxs.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/Makefile                                  |    1 -
 arch/arm/configs/stmp37xx_defconfig                |  108 --------
 arch/arm/mach-stmp37xx/Makefile                    |    2 -
 arch/arm/mach-stmp37xx/Makefile.boot               |    3 -
 arch/arm/mach-stmp37xx/include/mach/entry-macro.S  |   37 ---
 arch/arm/mach-stmp37xx/include/mach/irqs.h         |   99 -------
 arch/arm/mach-stmp37xx/include/mach/pins.h         |  147 -----------
 arch/arm/mach-stmp37xx/include/mach/regs-apbh.h    |   97 -------
 arch/arm/mach-stmp37xx/include/mach/regs-apbx.h    |  113 --------
 arch/arm/mach-stmp37xx/include/mach/regs-audioin.h |   61 -----
 .../arm/mach-stmp37xx/include/mach/regs-audioout.h |  111 --------
 arch/arm/mach-stmp37xx/include/mach/regs-clkctrl.h |   72 ------
 arch/arm/mach-stmp37xx/include/mach/regs-digctl.h  |   24 --
 arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h    |   37 ---
 arch/arm/mach-stmp37xx/include/mach/regs-gpmi.h    |   63 -----
 arch/arm/mach-stmp37xx/include/mach/regs-i2c.h     |   55 ----
 arch/arm/mach-stmp37xx/include/mach/regs-icoll.h   |   43 ---
 arch/arm/mach-stmp37xx/include/mach/regs-lcdif.h   |   89 -------
 arch/arm/mach-stmp37xx/include/mach/regs-lradc.h   |   97 -------
 arch/arm/mach-stmp37xx/include/mach/regs-pinctrl.h |   88 -------
 arch/arm/mach-stmp37xx/include/mach/regs-power.h   |   56 ----
 arch/arm/mach-stmp37xx/include/mach/regs-pwm.h     |   51 ----
 arch/arm/mach-stmp37xx/include/mach/regs-rtc.h     |   57 ----
 arch/arm/mach-stmp37xx/include/mach/regs-ssp.h     |  101 --------
 arch/arm/mach-stmp37xx/include/mach/regs-timrot.h  |   49 ----
 arch/arm/mach-stmp37xx/include/mach/regs-uartapp.h |   85 ------
 arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h |  268 --------------------
 arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h  |   22 --
 arch/arm/mach-stmp37xx/include/mach/regs-usbctrl.h |   22 --
 arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h  |   37 ---
 arch/arm/mach-stmp37xx/stmp37xx.c                  |  219 ----------------
 arch/arm/mach-stmp37xx/stmp37xx.h                  |   24 --
 arch/arm/mach-stmp37xx/stmp37xx_devb.c             |   99 -------
 arch/arm/plat-stmp3xxx/Kconfig                     |   10 -
 34 files changed, 0 insertions(+), 2447 deletions(-)
 delete mode 100644 arch/arm/configs/stmp37xx_defconfig
 delete mode 100644 arch/arm/mach-stmp37xx/Makefile
 delete mode 100644 arch/arm/mach-stmp37xx/Makefile.boot
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/pins.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-apbh.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-apbx.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-audioin.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-audioout.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-clkctrl.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-digctl.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-gpmi.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-i2c.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-icoll.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-lcdif.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-lradc.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-pinctrl.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-power.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-pwm.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-rtc.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-ssp.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-timrot.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-uartapp.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-usbctrl.h
 delete mode 100644 arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h
 delete mode 100644 arch/arm/mach-stmp37xx/stmp37xx.c
 delete mode 100644 arch/arm/mach-stmp37xx/stmp37xx.h
 delete mode 100644 arch/arm/mach-stmp37xx/stmp37xx_devb.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c7d321a..23ecbda 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -186,7 +186,6 @@ machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
-machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
 machine-$(CONFIG_ARCH_TCC8K)		:= tcc8k
 machine-$(CONFIG_ARCH_TEGRA)		:= tegra
 machine-$(CONFIG_ARCH_U300)		:= u300
diff --git a/arch/arm/configs/stmp37xx_defconfig b/arch/arm/configs/stmp37xx_defconfig
deleted file mode 100644
index 564a5cc..0000000
--- a/arch/arm/configs/stmp37xx_defconfig
+++ /dev/null
@@ -1,108 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_LOCALVERSION="-default"
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_STMP3XXX=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttySDBG0,115200 mem=32M lcd_panel=lms350 rdinit=/bin/sh ignore_loglevel"
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_NET_SCHED=y
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_STANDALONE is not set
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=4
-CONFIG_BLK_DEV_RAM_SIZE=6144
-# CONFIG_MISC_DEVICES is not set
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_SG=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_INPUT_POLLDEV=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
-CONFIG_INPUT_EVDEV=y
-# CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_INPUT_MISC=y
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_HW_RANDOM=y
-CONFIG_DEBUG_GPIO=y
-CONFIG_GPIO_SYSFS=y
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-CONFIG_LCD_CLASS_DEVICE=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_TMPFS=y
-CONFIG_CONFIGFS_FS=m
-# CONFIG_MISC_FILESYSTEMS is not set
-# CONFIG_NETWORK_FILESYSTEMS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_BOOT_TRACER=y
-CONFIG_STACK_TRACER=y
-CONFIG_BLK_DEV_IO_TRACE=y
-CONFIG_DEBUG_LL=y
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
-CONFIG_SECURITY=y
-CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_DES=y
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=y
diff --git a/arch/arm/mach-stmp37xx/Makefile b/arch/arm/mach-stmp37xx/Makefile
deleted file mode 100644
index 57deffd..0000000
--- a/arch/arm/mach-stmp37xx/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_ARCH_STMP37XX) += stmp37xx.o
-obj-$(CONFIG_MACH_STMP37XX) += stmp37xx_devb.o
diff --git a/arch/arm/mach-stmp37xx/Makefile.boot b/arch/arm/mach-stmp37xx/Makefile.boot
deleted file mode 100644
index 1568ad4..0000000
--- a/arch/arm/mach-stmp37xx/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	:= 0x40008000
-params_phys-y	:= 0x40000100
-initrd_phys-y	:= 0x40800000
diff --git a/arch/arm/mach-stmp37xx/include/mach/entry-macro.S b/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
deleted file mode 100644
index fed2787..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Low-level IRQ helper macros for Freescale STMP37XX
- *
- * Embedded Alley Solutions, Inc <source@embeddedalley.com>
- *
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-		.macro	disable_fiq
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	        mov	\base, #0xf0000000	@ vm address of IRQ controller
-		ldr	\irqnr, [\base, #0x30]	@ HW_ICOLL_STAT
-		cmp	\irqnr, #0x3f
-		movne	\irqstat, #0		@ Ack this IRQ
-		strne	\irqstat, [\base, #0x00]@ HW_ICOLL_VECTOR
-		moveqs	\irqnr, #0		@ Zero flag set for no IRQ
-
-		.endm
-
-                .macro  get_irqnr_preamble, base, tmp
-                .endm
-
-                .macro  arch_ret_to_user, tmp1, tmp2
-                .endm
diff --git a/arch/arm/mach-stmp37xx/include/mach/irqs.h b/arch/arm/mach-stmp37xx/include/mach/irqs.h
deleted file mode 100644
index 98f1293..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/irqs.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * Freescale STMP37XX interrupts
- *
- * Copyright (C) 2005 Sigmatel Inc
- *
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#ifndef _ASM_ARCH_IRQS_H
-#define _ASM_ARCH_IRQS_H
-
-#define IRQ_DEBUG_UART	         0
-#define IRQ_COMMS_RX	           1
-#define IRQ_COMMS_TX	           1
-#define IRQ_SSP2_ERROR	         2
-#define IRQ_VDD5V	              3
-#define IRQ_HEADPHONE_SHORT	    4
-#define IRQ_DAC_DMA	            5
-#define IRQ_DAC_ERROR	          6
-#define IRQ_ADC_DMA	            7
-#define IRQ_ADC_ERROR	          8
-#define IRQ_SPDIF_DMA	          9
-#define IRQ_SAIF2_DMA	          9
-#define IRQ_SPDIF_ERROR	        10
-#define IRQ_SAIF1_IRQ	          10
-#define IRQ_SAIF2_IRQ	          10
-#define IRQ_USB_CTRL	           11
-#define IRQ_USB_WAKEUP	         12
-#define IRQ_GPMI_DMA	           13
-#define IRQ_SSP1_DMA	           14
-#define IRQ_SSP_ERROR	          15
-#define IRQ_GPIO0	              16
-#define IRQ_GPIO1	              17
-#define IRQ_GPIO2	              18
-#define IRQ_SAIF1_DMA	          19
-#define IRQ_SSP2_DMA	           20
-#define IRQ_ECC8_IRQ	           21
-#define IRQ_RTC_ALARM	          22
-#define IRQ_UARTAPP_TX_DMA	     23
-#define IRQ_UARTAPP_INTERNAL	   24
-#define IRQ_UARTAPP_RX_DMA	     25
-#define IRQ_I2C_DMA	            26
-#define IRQ_I2C_ERROR	          27
-#define IRQ_TIMER0	             28
-#define IRQ_TIMER1	             29
-#define IRQ_TIMER2	             30
-#define IRQ_TIMER3	             31
-#define IRQ_BATT_BRNOUT	        32
-#define IRQ_VDDD_BRNOUT	        33
-#define IRQ_VDDIO_BRNOUT	       34
-#define IRQ_VDD18_BRNOUT	       35
-#define IRQ_TOUCH_DETECT	       36
-#define IRQ_LRADC_CH0	          37
-#define IRQ_LRADC_CH1	          38
-#define IRQ_LRADC_CH2	          39
-#define IRQ_LRADC_CH3	          40
-#define IRQ_LRADC_CH4	          41
-#define IRQ_LRADC_CH5	          42
-#define IRQ_LRADC_CH6	          43
-#define IRQ_LRADC_CH7	          44
-#define IRQ_LCDIF_DMA	          45
-#define IRQ_LCDIF_ERROR	        46
-#define IRQ_DIGCTL_DEBUG_TRAP	  47
-#define IRQ_RTC_1MSEC	          48
-#define IRQ_DRI_DMA	            49
-#define IRQ_DRI_ATTENTION	      50
-#define IRQ_GPMI_ATTENTION	     51
-#define IRQ_IR	                 52
-#define IRQ_DCP_VMI	            53
-#define IRQ_DCP	                54
-#define IRQ_RESERVED_55	        55
-#define IRQ_RESERVED_56	        56
-#define IRQ_RESERVED_57	        57
-#define IRQ_RESERVED_58	        58
-#define IRQ_RESERVED_59	        59
-#define SW_IRQ_60	              60
-#define SW_IRQ_61	              61
-#define SW_IRQ_62	              62
-#define SW_IRQ_63	              63
-
-#define NR_REAL_IRQS		64
-#define NR_IRQS			(NR_REAL_IRQS + 32 * 3)
-
-/* TIMER and BRNOUT are FIQ capable */
-#define FIQ_START			IRQ_TIMER0
-
-/* Hard disk IRQ is a GPMI attention IRQ */
-#define IRQ_HARDDISK		IRQ_GPMI_ATTENTION
-
-#endif /* _ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-stmp37xx/include/mach/pins.h b/arch/arm/mach-stmp37xx/include/mach/pins.h
deleted file mode 100644
index d56de0c..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/pins.h
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * Freescale STMP37XX SoC pin multiplexing
- *
- * Author: Vladislav Buzov <vbuzov@embeddedalley.com>
- *
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#ifndef __ASM_ARCH_PINS_H
-#define __ASM_ARCH_PINS_H
-
-/*
- * Define all STMP37XX pins, a pin name corresponds to a STMP37xx hardware
- * interface  this pin belongs to.
- */
-
-/* Bank 0 */
-#define PINID_GPMI_D00		STMP3XXX_PINID(0, 0)
-#define PINID_GPMI_D01		STMP3XXX_PINID(0, 1)
-#define PINID_GPMI_D02		STMP3XXX_PINID(0, 2)
-#define PINID_GPMI_D03		STMP3XXX_PINID(0, 3)
-#define PINID_GPMI_D04		STMP3XXX_PINID(0, 4)
-#define PINID_GPMI_D05		STMP3XXX_PINID(0, 5)
-#define PINID_GPMI_D06		STMP3XXX_PINID(0, 6)
-#define PINID_GPMI_D07		STMP3XXX_PINID(0, 7)
-#define PINID_GPMI_D08		STMP3XXX_PINID(0, 8)
-#define PINID_GPMI_D09		STMP3XXX_PINID(0, 9)
-#define PINID_GPMI_D10		STMP3XXX_PINID(0, 10)
-#define PINID_GPMI_D11		STMP3XXX_PINID(0, 11)
-#define PINID_GPMI_D12		STMP3XXX_PINID(0, 12)
-#define PINID_GPMI_D13		STMP3XXX_PINID(0, 13)
-#define PINID_GPMI_D14		STMP3XXX_PINID(0, 14)
-#define PINID_GPMI_D15		STMP3XXX_PINID(0, 15)
-#define PINID_GPMI_A0		STMP3XXX_PINID(0, 16)
-#define PINID_GPMI_A1		STMP3XXX_PINID(0, 17)
-#define PINID_GPMI_A2		STMP3XXX_PINID(0, 18)
-#define PINID_GPMI_RDY0		STMP3XXX_PINID(0, 19)
-#define PINID_GPMI_RDY2		STMP3XXX_PINID(0, 20)
-#define PINID_GPMI_RDY3		STMP3XXX_PINID(0, 21)
-#define PINID_GPMI_RESETN	STMP3XXX_PINID(0, 22)
-#define PINID_GPMI_IRQ		STMP3XXX_PINID(0, 23)
-#define PINID_GPMI_WRN		STMP3XXX_PINID(0, 24)
-#define PINID_GPMI_RDN		STMP3XXX_PINID(0, 25)
-#define PINID_UART2_CTS		STMP3XXX_PINID(0, 26)
-#define PINID_UART2_RTS		STMP3XXX_PINID(0, 27)
-#define PINID_UART2_RX		STMP3XXX_PINID(0, 28)
-#define PINID_UART2_TX		STMP3XXX_PINID(0, 29)
-
-/* Bank 1 */
-#define PINID_LCD_D00		STMP3XXX_PINID(1, 0)
-#define PINID_LCD_D01		STMP3XXX_PINID(1, 1)
-#define PINID_LCD_D02		STMP3XXX_PINID(1, 2)
-#define PINID_LCD_D03		STMP3XXX_PINID(1, 3)
-#define PINID_LCD_D04		STMP3XXX_PINID(1, 4)
-#define PINID_LCD_D05		STMP3XXX_PINID(1, 5)
-#define PINID_LCD_D06		STMP3XXX_PINID(1, 6)
-#define PINID_LCD_D07		STMP3XXX_PINID(1, 7)
-#define PINID_LCD_D08		STMP3XXX_PINID(1, 8)
-#define PINID_LCD_D09		STMP3XXX_PINID(1, 9)
-#define PINID_LCD_D10		STMP3XXX_PINID(1, 10)
-#define PINID_LCD_D11		STMP3XXX_PINID(1, 11)
-#define PINID_LCD_D12		STMP3XXX_PINID(1, 12)
-#define PINID_LCD_D13		STMP3XXX_PINID(1, 13)
-#define PINID_LCD_D14		STMP3XXX_PINID(1, 14)
-#define PINID_LCD_D15		STMP3XXX_PINID(1, 15)
-#define PINID_LCD_RESET 	STMP3XXX_PINID(1, 16)
-#define PINID_LCD_RS		STMP3XXX_PINID(1, 17)
-#define PINID_LCD_WR_RWN	STMP3XXX_PINID(1, 18)
-#define PINID_LCD_RD_E		STMP3XXX_PINID(1, 19)
-#define PINID_LCD_CS		STMP3XXX_PINID(1, 20)
-#define PINID_LCD_BUSY		STMP3XXX_PINID(1, 21)
-#define PINID_SSP1_CMD		STMP3XXX_PINID(1, 22)
-#define PINID_SSP1_SCK		STMP3XXX_PINID(1, 23)
-#define PINID_SSP1_DATA0	STMP3XXX_PINID(1, 24)
-#define PINID_SSP1_DATA1	STMP3XXX_PINID(1, 25)
-#define PINID_SSP1_DATA2	STMP3XXX_PINID(1, 26)
-#define PINID_SSP1_DATA3	STMP3XXX_PINID(1, 27)
-#define PINID_SSP1_DETECT	STMP3XXX_PINID(1, 28)
-
-/* Bank 2 */
-#define PINID_PWM0		STMP3XXX_PINID(2, 0)
-#define PINID_PWM1		STMP3XXX_PINID(2, 1)
-#define PINID_PWM2		STMP3XXX_PINID(2, 2)
-#define PINID_PWM3		STMP3XXX_PINID(2, 3)
-#define PINID_PWM4		STMP3XXX_PINID(2, 4)
-#define PINID_I2C_SCL		STMP3XXX_PINID(2, 5)
-#define PINID_I2C_SDA		STMP3XXX_PINID(2, 6)
-#define PINID_ROTTARYA		STMP3XXX_PINID(2, 7)
-#define PINID_ROTTARYB		STMP3XXX_PINID(2, 8)
-#define PINID_EMI_CKE		STMP3XXX_PINID(2, 9)
-#define PINID_EMI_RASN		STMP3XXX_PINID(2, 10)
-#define PINID_EMI_CASN		STMP3XXX_PINID(2, 11)
-#define PINID_EMI_CE0N		STMP3XXX_PINID(2, 12)
-#define PINID_EMI_CE1N		STMP3XXX_PINID(2, 13)
-#define PINID_EMI_CE2N		STMP3XXX_PINID(2, 14)
-#define PINID_EMI_CE3N		STMP3XXX_PINID(2, 15)
-#define PINID_EMI_A00		STMP3XXX_PINID(2, 16)
-#define PINID_EMI_A01		STMP3XXX_PINID(2, 17)
-#define PINID_EMI_A02		STMP3XXX_PINID(2, 18)
-#define PINID_EMI_A03		STMP3XXX_PINID(2, 19)
-#define PINID_EMI_A04		STMP3XXX_PINID(2, 20)
-#define PINID_EMI_A05		STMP3XXX_PINID(2, 21)
-#define PINID_EMI_A06		STMP3XXX_PINID(2, 22)
-#define PINID_EMI_A07		STMP3XXX_PINID(2, 23)
-#define PINID_EMI_A08		STMP3XXX_PINID(2, 24)
-#define PINID_EMI_A09		STMP3XXX_PINID(2, 25)
-#define PINID_EMI_A10		STMP3XXX_PINID(2, 26)
-#define PINID_EMI_A11		STMP3XXX_PINID(2, 27)
-#define PINID_EMI_A12		STMP3XXX_PINID(2, 28)
-#define PINID_EMI_A13		STMP3XXX_PINID(2, 29)
-#define PINID_EMI_A14		STMP3XXX_PINID(2, 30)
-#define PINID_EMI_WEN		STMP3XXX_PINID(2, 31)
-
-/* Bank 3 */
-#define PINID_EMI_D00		STMP3XXX_PINID(3, 0)
-#define PINID_EMI_D01		STMP3XXX_PINID(3, 1)
-#define PINID_EMI_D02		STMP3XXX_PINID(3, 2)
-#define PINID_EMI_D03		STMP3XXX_PINID(3, 3)
-#define PINID_EMI_D04		STMP3XXX_PINID(3, 4)
-#define PINID_EMI_D05		STMP3XXX_PINID(3, 5)
-#define PINID_EMI_D06		STMP3XXX_PINID(3, 6)
-#define PINID_EMI_D07		STMP3XXX_PINID(3, 7)
-#define PINID_EMI_D08		STMP3XXX_PINID(3, 8)
-#define PINID_EMI_D09		STMP3XXX_PINID(3, 9)
-#define PINID_EMI_D10		STMP3XXX_PINID(3, 10)
-#define PINID_EMI_D11		STMP3XXX_PINID(3, 11)
-#define PINID_EMI_D12		STMP3XXX_PINID(3, 12)
-#define PINID_EMI_D13		STMP3XXX_PINID(3, 13)
-#define PINID_EMI_D14		STMP3XXX_PINID(3, 14)
-#define PINID_EMI_D15		STMP3XXX_PINID(3, 15)
-#define PINID_EMI_DQS0		STMP3XXX_PINID(3, 16)
-#define PINID_EMI_DQS1		STMP3XXX_PINID(3, 17)
-#define PINID_EMI_DQM0		STMP3XXX_PINID(3, 18)
-#define PINID_EMI_DQM1		STMP3XXX_PINID(3, 19)
-#define PINID_EMI_CLK		STMP3XXX_PINID(3, 20)
-#define PINID_EMI_CLKN		STMP3XXX_PINID(3, 21)
-
-#endif /* __ASM_ARCH_PINS_H */
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-apbh.h b/arch/arm/mach-stmp37xx/include/mach/regs-apbh.h
deleted file mode 100644
index a323aa9..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-apbh.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * stmp37xx: APBH register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_APBH
-#define _MACH_REGS_APBH
-
-#define REGS_APBH_BASE	(STMP3XXX_REGS_BASE + 0x4000)
-
-#define HW_APBH_CTRL0		0x0
-#define BM_APBH_CTRL0_RESET_CHANNEL	0x00FF0000
-#define BP_APBH_CTRL0_RESET_CHANNEL	16
-#define BM_APBH_CTRL0_CLKGATE	0x40000000
-#define BM_APBH_CTRL0_SFTRST	0x80000000
-
-#define HW_APBH_CTRL1		0x10
-#define BM_APBH_CTRL1_CH0_CMDCMPLT_IRQ	0x00000001
-#define BP_APBH_CTRL1_CH0_CMDCMPLT_IRQ	0
-
-#define HW_APBH_DEVSEL		0x20
-
-#define HW_APBH_CH0_NXTCMDAR	(0x50 + 0 * 0x70)
-#define HW_APBH_CH1_NXTCMDAR	(0x50 + 1 * 0x70)
-#define HW_APBH_CH2_NXTCMDAR	(0x50 + 2 * 0x70)
-#define HW_APBH_CH3_NXTCMDAR	(0x50 + 3 * 0x70)
-#define HW_APBH_CH4_NXTCMDAR	(0x50 + 4 * 0x70)
-#define HW_APBH_CH5_NXTCMDAR	(0x50 + 5 * 0x70)
-#define HW_APBH_CH6_NXTCMDAR	(0x50 + 6 * 0x70)
-#define HW_APBH_CH7_NXTCMDAR	(0x50 + 7 * 0x70)
-#define HW_APBH_CH8_NXTCMDAR	(0x50 + 8 * 0x70)
-#define HW_APBH_CH9_NXTCMDAR	(0x50 + 9 * 0x70)
-#define HW_APBH_CH10_NXTCMDAR	(0x50 + 10 * 0x70)
-#define HW_APBH_CH11_NXTCMDAR	(0x50 + 11 * 0x70)
-#define HW_APBH_CH12_NXTCMDAR	(0x50 + 12 * 0x70)
-#define HW_APBH_CH13_NXTCMDAR	(0x50 + 13 * 0x70)
-#define HW_APBH_CH14_NXTCMDAR	(0x50 + 14 * 0x70)
-#define HW_APBH_CH15_NXTCMDAR	(0x50 + 15 * 0x70)
-
-#define HW_APBH_CHn_NXTCMDAR	0x50
-
-#define BM_APBH_CHn_CMD_MODE		0x00000003
-#define BP_APBH_CHn_CMD_MODE		0x00000001
-#define BV_APBH_CHn_CMD_MODE_NOOP		 0
-#define BV_APBH_CHn_CMD_MODE_WRITE		 1
-#define BV_APBH_CHn_CMD_MODE_READ		 2
-#define BV_APBH_CHn_CMD_MODE_SENSE		 3
-#define BM_APBH_CHn_CMD_CHAIN		0x00000004
-#define BM_APBH_CHn_CMD_IRQONCMPLT	0x00000008
-#define BM_APBH_CHn_CMD_NANDLOCK	0x00000010
-#define BM_APBH_CHn_CMD_NANDWAIT4READY	0x00000020
-#define BM_APBH_CHn_CMD_SEMAPHORE	0x00000040
-#define BM_APBH_CHn_CMD_WAIT4ENDCMD	0x00000080
-#define BM_APBH_CHn_CMD_CMDWORDS	0x0000F000
-#define BP_APBH_CHn_CMD_CMDWORDS	12
-#define BM_APBH_CHn_CMD_XFER_COUNT	0xFFFF0000
-#define BP_APBH_CHn_CMD_XFER_COUNT	16
-
-#define HW_APBH_CH0_SEMA	(0x80 + 0 * 0x70)
-#define HW_APBH_CH1_SEMA	(0x80 + 1 * 0x70)
-#define HW_APBH_CH2_SEMA	(0x80 + 2 * 0x70)
-#define HW_APBH_CH3_SEMA	(0x80 + 3 * 0x70)
-#define HW_APBH_CH4_SEMA	(0x80 + 4 * 0x70)
-#define HW_APBH_CH5_SEMA	(0x80 + 5 * 0x70)
-#define HW_APBH_CH6_SEMA	(0x80 + 6 * 0x70)
-#define HW_APBH_CH7_SEMA	(0x80 + 7 * 0x70)
-#define HW_APBH_CH8_SEMA	(0x80 + 8 * 0x70)
-#define HW_APBH_CH9_SEMA	(0x80 + 9 * 0x70)
-#define HW_APBH_CH10_SEMA	(0x80 + 10 * 0x70)
-#define HW_APBH_CH11_SEMA	(0x80 + 11 * 0x70)
-#define HW_APBH_CH12_SEMA	(0x80 + 12 * 0x70)
-#define HW_APBH_CH13_SEMA	(0x80 + 13 * 0x70)
-#define HW_APBH_CH14_SEMA	(0x80 + 14 * 0x70)
-#define HW_APBH_CH15_SEMA	(0x80 + 15 * 0x70)
-
-#define HW_APBH_CHn_SEMA	0x80
-#define BM_APBH_CHn_SEMA_INCREMENT_SEMA	0x000000FF
-#define BP_APBH_CHn_SEMA_INCREMENT_SEMA	0
-#define BM_APBH_CHn_SEMA_PHORE	0x00FF0000
-#define BP_APBH_CHn_SEMA_PHORE	16
-
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-apbx.h b/arch/arm/mach-stmp37xx/include/mach/regs-apbx.h
deleted file mode 100644
index 6d080cd..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-apbx.h
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * stmp37xx: APBX register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_APBX
-#define _MACH_REGS_APBX
-
-#define REGS_APBX_BASE	(STMP3XXX_REGS_BASE + 0x24000)
-
-#define HW_APBX_CTRL0		0x0
-#define BM_APBX_CTRL0_RESET_CHANNEL	0x00FF0000
-#define BP_APBX_CTRL0_RESET_CHANNEL	16
-#define BM_APBX_CTRL0_CLKGATE	0x40000000
-#define BM_APBX_CTRL0_SFTRST	0x80000000
-
-#define HW_APBX_CTRL1		0x10
-
-#define HW_APBX_DEVSEL		0x20
-
-#define HW_APBX_CH0_NXTCMDAR	(0x50 + 0 * 0x70)
-#define HW_APBX_CH1_NXTCMDAR	(0x50 + 1 * 0x70)
-#define HW_APBX_CH2_NXTCMDAR	(0x50 + 2 * 0x70)
-#define HW_APBX_CH3_NXTCMDAR	(0x50 + 3 * 0x70)
-#define HW_APBX_CH4_NXTCMDAR	(0x50 + 4 * 0x70)
-#define HW_APBX_CH5_NXTCMDAR	(0x50 + 5 * 0x70)
-#define HW_APBX_CH6_NXTCMDAR	(0x50 + 6 * 0x70)
-#define HW_APBX_CH7_NXTCMDAR	(0x50 + 7 * 0x70)
-#define HW_APBX_CH8_NXTCMDAR	(0x50 + 8 * 0x70)
-#define HW_APBX_CH9_NXTCMDAR	(0x50 + 9 * 0x70)
-#define HW_APBX_CH10_NXTCMDAR	(0x50 + 10 * 0x70)
-#define HW_APBX_CH11_NXTCMDAR	(0x50 + 11 * 0x70)
-#define HW_APBX_CH12_NXTCMDAR	(0x50 + 12 * 0x70)
-#define HW_APBX_CH13_NXTCMDAR	(0x50 + 13 * 0x70)
-#define HW_APBX_CH14_NXTCMDAR	(0x50 + 14 * 0x70)
-#define HW_APBX_CH15_NXTCMDAR	(0x50 + 15 * 0x70)
-
-#define HW_APBX_CHn_NXTCMDAR	0x50
-#define BM_APBX_CHn_CMD_MODE		0x00000003
-#define BP_APBX_CHn_CMD_MODE		0x00000001
-#define BV_APBX_CHn_CMD_MODE_NOOP		 0
-#define BV_APBX_CHn_CMD_MODE_WRITE		 1
-#define BV_APBX_CHn_CMD_MODE_READ		 2
-#define BV_APBX_CHn_CMD_MODE_SENSE		 3
-#define BM_APBX_CHn_CMD_COMMAND	0x00000003
-#define BP_APBX_CHn_CMD_COMMAND	0
-#define BM_APBX_CHn_CMD_CHAIN	0x00000004
-#define BM_APBX_CHn_CMD_IRQONCMPLT	0x00000008
-#define BM_APBX_CHn_CMD_SEMAPHORE	0x00000040
-#define BM_APBX_CHn_CMD_WAIT4ENDCMD	0x00000080
-#define BM_APBX_CHn_CMD_CMDWORDS	0x0000F000
-#define BP_APBX_CHn_CMD_CMDWORDS	12
-#define BM_APBX_CHn_CMD_XFER_COUNT	0xFFFF0000
-#define BP_APBX_CHn_CMD_XFER_COUNT	16
-
-#define HW_APBX_CH0_BAR		(0x70 + 0 * 0x70)
-#define HW_APBX_CH1_BAR		(0x70 + 1 * 0x70)
-#define HW_APBX_CH2_BAR		(0x70 + 2 * 0x70)
-#define HW_APBX_CH3_BAR		(0x70 + 3 * 0x70)
-#define HW_APBX_CH4_BAR		(0x70 + 4 * 0x70)
-#define HW_APBX_CH5_BAR		(0x70 + 5 * 0x70)
-#define HW_APBX_CH6_BAR		(0x70 + 6 * 0x70)
-#define HW_APBX_CH7_BAR		(0x70 + 7 * 0x70)
-#define HW_APBX_CH8_BAR		(0x70 + 8 * 0x70)
-#define HW_APBX_CH9_BAR		(0x70 + 9 * 0x70)
-#define HW_APBX_CH10_BAR		(0x70 + 10 * 0x70)
-#define HW_APBX_CH11_BAR		(0x70 + 11 * 0x70)
-#define HW_APBX_CH12_BAR		(0x70 + 12 * 0x70)
-#define HW_APBX_CH13_BAR		(0x70 + 13 * 0x70)
-#define HW_APBX_CH14_BAR		(0x70 + 14 * 0x70)
-#define HW_APBX_CH15_BAR		(0x70 + 15 * 0x70)
-
-#define HW_APBX_CHn_BAR		0x70
-
-#define HW_APBX_CH0_SEMA	(0x80 + 0 * 0x70)
-#define HW_APBX_CH1_SEMA	(0x80 + 1 * 0x70)
-#define HW_APBX_CH2_SEMA	(0x80 + 2 * 0x70)
-#define HW_APBX_CH3_SEMA	(0x80 + 3 * 0x70)
-#define HW_APBX_CH4_SEMA	(0x80 + 4 * 0x70)
-#define HW_APBX_CH5_SEMA	(0x80 + 5 * 0x70)
-#define HW_APBX_CH6_SEMA	(0x80 + 6 * 0x70)
-#define HW_APBX_CH7_SEMA	(0x80 + 7 * 0x70)
-#define HW_APBX_CH8_SEMA	(0x80 + 8 * 0x70)
-#define HW_APBX_CH9_SEMA	(0x80 + 9 * 0x70)
-#define HW_APBX_CH10_SEMA	(0x80 + 10 * 0x70)
-#define HW_APBX_CH11_SEMA	(0x80 + 11 * 0x70)
-#define HW_APBX_CH12_SEMA	(0x80 + 12 * 0x70)
-#define HW_APBX_CH13_SEMA	(0x80 + 13 * 0x70)
-#define HW_APBX_CH14_SEMA	(0x80 + 14 * 0x70)
-#define HW_APBX_CH15_SEMA	(0x80 + 15 * 0x70)
-
-#define HW_APBX_CHn_SEMA	0x80
-#define BM_APBX_CHn_SEMA_INCREMENT_SEMA	0x000000FF
-#define BP_APBX_CHn_SEMA_INCREMENT_SEMA	0
-#define BM_APBX_CHn_SEMA_PHORE	0x00FF0000
-#define BP_APBX_CHn_SEMA_PHORE	16
-
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-audioin.h b/arch/arm/mach-stmp37xx/include/mach/regs-audioin.h
deleted file mode 100644
index 3b511f9..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-audioin.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * stmp37xx: AUDIOIN register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_AUDIOIN_BASE	(STMP3XXX_REGS_BASE + 0x4C000)
-
-#define HW_AUDIOIN_CTRL		0x0
-#define BM_AUDIOIN_CTRL_RUN	0x00000001
-#define BP_AUDIOIN_CTRL_RUN	0
-#define BM_AUDIOIN_CTRL_FIFO_ERROR_IRQ_EN	0x00000002
-#define BM_AUDIOIN_CTRL_FIFO_OVERFLOW_IRQ	0x00000004
-#define BM_AUDIOIN_CTRL_FIFO_UNDERFLOW_IRQ	0x00000008
-#define BM_AUDIOIN_CTRL_WORD_LENGTH	0x00000020
-#define BM_AUDIOIN_CTRL_CLKGATE	0x40000000
-#define BM_AUDIOIN_CTRL_SFTRST	0x80000000
-
-#define HW_AUDIOIN_STAT		0x10
-
-#define HW_AUDIOIN_ADCSRR	0x20
-
-#define HW_AUDIOIN_ADCVOLUME	0x30
-#define BM_AUDIOIN_ADCVOLUME_VOLUME_RIGHT	0x000000FF
-#define BP_AUDIOIN_ADCVOLUME_VOLUME_RIGHT	0
-#define BM_AUDIOIN_ADCVOLUME_VOLUME_LEFT	0x00FF0000
-#define BP_AUDIOIN_ADCVOLUME_VOLUME_LEFT	16
-
-#define HW_AUDIOIN_ADCDEBUG	0x40
-
-#define HW_AUDIOIN_ADCVOL	0x50
-#define BM_AUDIOIN_ADCVOL_GAIN_RIGHT	0x0000000F
-#define BP_AUDIOIN_ADCVOL_GAIN_RIGHT	0
-#define BM_AUDIOIN_ADCVOL_SELECT_RIGHT	0x00000030
-#define BP_AUDIOIN_ADCVOL_SELECT_RIGHT	4
-#define BM_AUDIOIN_ADCVOL_GAIN_LEFT	0x00000F00
-#define BP_AUDIOIN_ADCVOL_GAIN_LEFT	8
-#define BM_AUDIOIN_ADCVOL_SELECT_LEFT	0x00003000
-#define BP_AUDIOIN_ADCVOL_SELECT_LEFT	12
-#define BM_AUDIOIN_ADCVOL_MUTE	0x01000000
-
-#define HW_AUDIOIN_MICLINE	0x60
-
-#define HW_AUDIOIN_ANACLKCTRL	0x70
-#define BM_AUDIOIN_ANACLKCTRL_CLKGATE	0x80000000
-
-#define HW_AUDIOIN_DATA		0x80
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-audioout.h b/arch/arm/mach-stmp37xx/include/mach/regs-audioout.h
deleted file mode 100644
index ca1942b..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-audioout.h
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * stmp37xx: AUDIOOUT register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_AUDIOOUT_BASE	(STMP3XXX_REGS_BASE + 0x48000)
-
-#define HW_AUDIOOUT_CTRL	0x0
-#define BM_AUDIOOUT_CTRL_RUN	0x00000001
-#define BP_AUDIOOUT_CTRL_RUN	0
-#define BM_AUDIOOUT_CTRL_FIFO_ERROR_IRQ_EN	0x00000002
-#define BM_AUDIOOUT_CTRL_FIFO_OVERFLOW_IRQ	0x00000004
-#define BM_AUDIOOUT_CTRL_FIFO_UNDERFLOW_IRQ	0x00000008
-#define BM_AUDIOOUT_CTRL_WORD_LENGTH	0x00000040
-#define BM_AUDIOOUT_CTRL_CLKGATE	0x40000000
-#define BM_AUDIOOUT_CTRL_SFTRST	0x80000000
-
-#define HW_AUDIOOUT_STAT	0x10
-
-#define HW_AUDIOOUT_DACSRR	0x20
-#define BM_AUDIOOUT_DACSRR_SRC_FRAC	0x00001FFF
-#define BP_AUDIOOUT_DACSRR_SRC_FRAC	0
-#define BM_AUDIOOUT_DACSRR_SRC_INT	0x001F0000
-#define BP_AUDIOOUT_DACSRR_SRC_INT	16
-#define BM_AUDIOOUT_DACSRR_SRC_HOLD	0x07000000
-#define BP_AUDIOOUT_DACSRR_SRC_HOLD	24
-#define BM_AUDIOOUT_DACSRR_BASEMULT	0x70000000
-#define BP_AUDIOOUT_DACSRR_BASEMULT	28
-
-#define HW_AUDIOOUT_DACVOLUME	0x30
-#define BM_AUDIOOUT_DACVOLUME_MUTE_RIGHT	0x00000100
-#define BM_AUDIOOUT_DACVOLUME_MUTE_LEFT	0x01000000
-#define BM_AUDIOOUT_DACVOLUME_EN_ZCD	0x02000000
-
-#define HW_AUDIOOUT_DACDEBUG	0x40
-
-#define HW_AUDIOOUT_HPVOL	0x50
-#define BM_AUDIOOUT_HPVOL_MUTE	0x01000000
-#define BM_AUDIOOUT_HPVOL_EN_MSTR_ZCD	0x02000000
-
-#define HW_AUDIOOUT_PWRDN	0x70
-#define BM_AUDIOOUT_PWRDN_HEADPHONE	0x00000001
-#define BP_AUDIOOUT_PWRDN_HEADPHONE	0
-#define BM_AUDIOOUT_PWRDN_CAPLESS	0x00000010
-#define BM_AUDIOOUT_PWRDN_ADC	0x00000100
-#define BM_AUDIOOUT_PWRDN_DAC	0x00001000
-#define BM_AUDIOOUT_PWRDN_RIGHT_ADC	0x00010000
-#define BM_AUDIOOUT_PWRDN_LINEOUT	0x01000000
-
-#define HW_AUDIOOUT_REFCTRL	0x80
-#define BM_AUDIOOUT_REFCTRL_VAG_VAL	0x000000F0
-#define BP_AUDIOOUT_REFCTRL_VAG_VAL	4
-#define BM_AUDIOOUT_REFCTRL_ADC_REFVAL	0x00000F00
-#define BP_AUDIOOUT_REFCTRL_ADC_REFVAL	8
-#define BM_AUDIOOUT_REFCTRL_ADJ_VAG	0x00001000
-#define BM_AUDIOOUT_REFCTRL_ADJ_ADC	0x00002000
-#define BM_AUDIOOUT_REFCTRL_BIAS_CTRL	0x00030000
-#define BP_AUDIOOUT_REFCTRL_BIAS_CTRL	16
-#define BM_AUDIOOUT_REFCTRL_LOW_PWR	0x00080000
-#define BM_AUDIOOUT_REFCTRL_VBG_ADJ	0x00700000
-#define BP_AUDIOOUT_REFCTRL_VBG_ADJ	20
-#define BM_AUDIOOUT_REFCTRL_XTAL_BGR_BIAS	0x01000000
-#define BM_AUDIOOUT_REFCTRL_RAISE_REF	0x02000000
-
-#define HW_AUDIOOUT_ANACTRL	0x90
-#define BM_AUDIOOUT_ANACTRL_HP_CLASSAB	0x00000010
-#define BM_AUDIOOUT_ANACTRL_HP_HOLD_GND	0x00000020
-
-#define HW_AUDIOOUT_TEST	0xA0
-#define BM_AUDIOOUT_TEST_HP_I1_ADJ	0x00C00000
-#define BP_AUDIOOUT_TEST_HP_I1_ADJ	22
-
-#define HW_AUDIOOUT_BISTCTRL	0xB0
-
-#define HW_AUDIOOUT_BISTSTAT0	0xC0
-
-#define HW_AUDIOOUT_BISTSTAT1	0xD0
-
-#define HW_AUDIOOUT_ANACLKCTRL	0xE0
-#define BM_AUDIOOUT_ANACLKCTRL_CLKGATE	0x80000000
-
-#define HW_AUDIOOUT_DATA	0xF0
-
-#define HW_AUDIOOUT_LINEOUTCTRL	0x100
-#define BM_AUDIOOUT_LINEOUTCTRL_VOL_RIGHT	0x0000001F
-#define BP_AUDIOOUT_LINEOUTCTRL_VOL_RIGHT	0
-#define BM_AUDIOOUT_LINEOUTCTRL_VOL_LEFT	0x00001F00
-#define BP_AUDIOOUT_LINEOUTCTRL_VOL_LEFT	8
-#define BM_AUDIOOUT_LINEOUTCTRL_CHARGE_CAP	0x00007000
-#define BP_AUDIOOUT_LINEOUTCTRL_CHARGE_CAP	12
-#define BM_AUDIOOUT_LINEOUTCTRL_VAG_CTRL	0x00F00000
-#define BP_AUDIOOUT_LINEOUTCTRL_VAG_CTRL	20
-#define BM_AUDIOOUT_LINEOUTCTRL_MUTE	0x01000000
-#define BM_AUDIOOUT_LINEOUTCTRL_EN_ZCD	0x02000000
-
-#define HW_AUDIOOUT_VERSION	0x200
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-clkctrl.h b/arch/arm/mach-stmp37xx/include/mach/regs-clkctrl.h
deleted file mode 100644
index 47f5c92..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-clkctrl.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * stmp37xx: CLKCTRL register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_CLKCTRL
-#define _MACH_REGS_CLKCTRL
-
-#define REGS_CLKCTRL_BASE	(STMP3XXX_REGS_BASE + 0x40000)
-
-#define HW_CLKCTRL_PLLCTRL0	0x0
-#define BM_CLKCTRL_PLLCTRL0_EN_USB_CLKS	0x00040000
-
-#define HW_CLKCTRL_CPU		0x20
-#define BM_CLKCTRL_CPU_DIV_CPU	0x0000003F
-#define BP_CLKCTRL_CPU_DIV_CPU	0
-
-#define HW_CLKCTRL_HBUS		0x30
-#define BM_CLKCTRL_HBUS_DIV	0x0000001F
-#define BP_CLKCTRL_HBUS_DIV	0
-
-#define HW_CLKCTRL_XBUS		0x40
-
-#define HW_CLKCTRL_XTAL		0x50
-
-#define HW_CLKCTRL_PIX		0x60
-#define BM_CLKCTRL_PIX_DIV	0x00007FFF
-#define BP_CLKCTRL_PIX_DIV	0
-#define BM_CLKCTRL_PIX_CLKGATE	0x80000000
-
-#define HW_CLKCTRL_SSP		0x70
-
-#define HW_CLKCTRL_GPMI		0x80
-
-#define HW_CLKCTRL_SPDIF	0x90
-
-#define HW_CLKCTRL_EMI		0xA0
-
-#define HW_CLKCTRL_IR		0xB0
-
-#define HW_CLKCTRL_SAIF		0xC0
-
-#define HW_CLKCTRL_FRAC		0xD0
-#define BM_CLKCTRL_FRAC_EMIFRAC	0x00003F00
-#define BP_CLKCTRL_FRAC_EMIFRAC	8
-#define BM_CLKCTRL_FRAC_PIXFRAC	0x003F0000
-#define BP_CLKCTRL_FRAC_PIXFRAC	16
-#define BM_CLKCTRL_FRAC_CLKGATEPIX	0x00800000
-
-#define HW_CLKCTRL_CLKSEQ	0xE0
-#define BM_CLKCTRL_CLKSEQ_BYPASS_PIX	0x00000002
-
-#define HW_CLKCTRL_RESET	0xF0
-#define BM_CLKCTRL_RESET_DIG	0x00000001
-#define BP_CLKCTRL_RESET_DIG	0
-
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-digctl.h b/arch/arm/mach-stmp37xx/include/mach/regs-digctl.h
deleted file mode 100644
index ba1bbe2..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-digctl.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * stmp37xx: DIGCTL register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_DIGCTL_BASE	(STMP3XXX_REGS_BASE + 0x1C000)
-
-#define HW_DIGCTL_CTRL		0x0
-#define BM_DIGCTL_CTRL_USB_CLKGATE	0x00000004
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h b/arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h
deleted file mode 100644
index 3b6d990..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * stmp37xx: ECC8 register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_ECC8_BASE	(STMP3XXX_REGS_BASE + 0x8000)
-
-#define HW_ECC8_CTRL		0x0
-#define BM_ECC8_CTRL_COMPLETE_IRQ	0x00000001
-#define BP_ECC8_CTRL_COMPLETE_IRQ	0
-#define BM_ECC8_CTRL_COMPLETE_IRQ_EN	0x00000100
-#define BM_ECC8_CTRL_AHBM_SFTRST	0x20000000
-
-#define HW_ECC8_STATUS0		0x10
-#define BM_ECC8_STATUS0_UNCORRECTABLE	0x00000004
-#define BM_ECC8_STATUS0_CORRECTED	0x00000008
-#define BM_ECC8_STATUS0_STATUS_AUX	0x00000F00
-#define BP_ECC8_STATUS0_STATUS_AUX	8
-#define BM_ECC8_STATUS0_COMPLETED_CE	0x000F0000
-#define BP_ECC8_STATUS0_COMPLETED_CE	16
-
-#define HW_ECC8_STATUS1		0x20
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-gpmi.h b/arch/arm/mach-stmp37xx/include/mach/regs-gpmi.h
deleted file mode 100644
index f2b304f..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-gpmi.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * stmp37xx: GPMI register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_GPMI_BASE	(STMP3XXX_REGS_BASE + 0xC000)
-#define REGS_GPMI_PHYS	0x8000C000
-#define REGS_GPMI_SIZE	0x2000
-
-#define HW_GPMI_CTRL0		0x0
-#define BM_GPMI_CTRL0_XFER_COUNT	0x0000FFFF
-#define BP_GPMI_CTRL0_XFER_COUNT	0
-#define BM_GPMI_CTRL0_CS	0x00300000
-#define BP_GPMI_CTRL0_CS	20
-#define BM_GPMI_CTRL0_LOCK_CS	0x00400000
-#define BM_GPMI_CTRL0_WORD_LENGTH	0x00800000
-#define BM_GPMI_CTRL0_COMMAND_MODE	0x03000000
-#define BP_GPMI_CTRL0_COMMAND_MODE	24
-#define BV_GPMI_CTRL0_COMMAND_MODE__WRITE	    0x0
-#define BV_GPMI_CTRL0_COMMAND_MODE__READ	     0x1
-#define BV_GPMI_CTRL0_COMMAND_MODE__READ_AND_COMPARE 0x2
-#define BV_GPMI_CTRL0_COMMAND_MODE__WAIT_FOR_READY   0x3
-#define BM_GPMI_CTRL0_RUN	0x20000000
-#define BM_GPMI_CTRL0_CLKGATE	0x40000000
-#define BM_GPMI_CTRL0_SFTRST	0x80000000
-#define BM_GPMI_ECCCTRL_ENABLE_ECC	0x00001000
-#define BM_GPMI_ECCCTRL_ECC_CMD	0x00006000
-#define BP_GPMI_ECCCTRL_ECC_CMD	13
-
-#define HW_GPMI_CTRL1		0x60
-#define BM_GPMI_CTRL1_GPMI_MODE	0x00000003
-#define BP_GPMI_CTRL1_GPMI_MODE	0
-#define BM_GPMI_CTRL1_ATA_IRQRDY_POLARITY	0x00000004
-#define BM_GPMI_CTRL1_DEV_RESET	0x00000008
-#define BM_GPMI_CTRL1_TIMEOUT_IRQ	0x00000200
-#define BM_GPMI_CTRL1_DEV_IRQ	0x00000400
-#define BM_GPMI_CTRL1_DSAMPLE_TIME	0x00007000
-#define BP_GPMI_CTRL1_DSAMPLE_TIME	12
-
-#define HW_GPMI_TIMING0		0x70
-#define BM_GPMI_TIMING0_DATA_SETUP	0x000000FF
-#define BP_GPMI_TIMING0_DATA_SETUP	0
-#define BM_GPMI_TIMING0_DATA_HOLD	0x0000FF00
-#define BP_GPMI_TIMING0_DATA_HOLD	8
-
-#define HW_GPMI_TIMING1		0x80
-#define BM_GPMI_TIMING1_DEVICE_BUSY_TIMEOUT	0xFFFF0000
-#define BP_GPMI_TIMING1_DEVICE_BUSY_TIMEOUT	16
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-i2c.h b/arch/arm/mach-stmp37xx/include/mach/regs-i2c.h
deleted file mode 100644
index 35882a9..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-i2c.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * stmp37xx: I2C register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_I2C_BASE	(STMP3XXX_REGS_BASE + 0x58000)
-#define REGS_I2C_PHYS	0x80058000
-#define REGS_I2C_SIZE	0x2000
-
-#define HW_I2C_CTRL0		0x0
-#define BM_I2C_CTRL0_XFER_COUNT	0x0000FFFF
-#define BP_I2C_CTRL0_XFER_COUNT	0
-#define BM_I2C_CTRL0_DIRECTION	0x00010000
-#define BM_I2C_CTRL0_MASTER_MODE	0x00020000
-#define BM_I2C_CTRL0_PRE_SEND_START	0x00080000
-#define BM_I2C_CTRL0_POST_SEND_STOP	0x00100000
-#define BM_I2C_CTRL0_RETAIN_CLOCK	0x00200000
-#define BM_I2C_CTRL0_SEND_NAK_ON_LAST	0x02000000
-#define BM_I2C_CTRL0_CLKGATE	0x40000000
-#define BM_I2C_CTRL0_SFTRST	0x80000000
-
-#define HW_I2C_TIMING0		0x10
-
-#define HW_I2C_TIMING1		0x20
-
-#define HW_I2C_TIMING2		0x30
-
-#define HW_I2C_CTRL1		0x40
-#define BM_I2C_CTRL1_SLAVE_IRQ	0x00000001
-#define BP_I2C_CTRL1_SLAVE_IRQ	0
-#define BM_I2C_CTRL1_SLAVE_STOP_IRQ	0x00000002
-#define BM_I2C_CTRL1_MASTER_LOSS_IRQ	0x00000004
-#define BM_I2C_CTRL1_EARLY_TERM_IRQ	0x00000008
-#define BM_I2C_CTRL1_OVERSIZE_XFER_TERM_IRQ	0x00000010
-#define BM_I2C_CTRL1_NO_SLAVE_ACK_IRQ	0x00000020
-#define BM_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ	0x00000040
-#define BM_I2C_CTRL1_BUS_FREE_IRQ	0x00000080
-#define BM_I2C_CTRL1_CLR_GOT_A_NAK	0x10000000
-
-#define HW_I2C_VERSION		0x90
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-icoll.h b/arch/arm/mach-stmp37xx/include/mach/regs-icoll.h
deleted file mode 100644
index 3b7c922..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-icoll.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * stmp37xx: ICOLL register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_ICOLL
-#define _MACH_REGS_ICOLL
-
-#define REGS_ICOLL_BASE	(STMP3XXX_REGS_BASE + 0x0)
-
-#define HW_ICOLL_VECTOR		0x0
-
-#define HW_ICOLL_LEVELACK	0x10
-
-#define HW_ICOLL_CTRL		0x20
-#define BM_ICOLL_CTRL_CLKGATE	0x40000000
-#define BM_ICOLL_CTRL_SFTRST	0x80000000
-
-#define HW_ICOLL_STAT		0x30
-
-#define HW_ICOLL_PRIORITY0	(0x60 + 0 * 0x10)
-#define HW_ICOLL_PRIORITY1	(0x60 + 1 * 0x10)
-#define HW_ICOLL_PRIORITY2	(0x60 + 2 * 0x10)
-#define HW_ICOLL_PRIORITY3	(0x60 + 3 * 0x10)
-
-#define HW_ICOLL_PRIORITYn	0x60
-
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-lcdif.h b/arch/arm/mach-stmp37xx/include/mach/regs-lcdif.h
deleted file mode 100644
index 72514e8..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-lcdif.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * stmp37xx: LCDIF register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_LCDIF_BASE	(STMP3XXX_REGS_BASE + 0x30000)
-#define REGS_LCDIF_PHYS	0x80030000
-#define REGS_LCDIF_SIZE	0x2000
-
-#define HW_LCDIF_CTRL		0x0
-#define BM_LCDIF_CTRL_COUNT	0x0000FFFF
-#define BP_LCDIF_CTRL_COUNT	0
-#define BM_LCDIF_CTRL_RUN	0x00010000
-#define BM_LCDIF_CTRL_WORD_LENGTH	0x00020000
-#define BM_LCDIF_CTRL_DATA_SELECT	0x00040000
-#define BM_LCDIF_CTRL_DOTCLK_MODE	0x00080000
-#define BM_LCDIF_CTRL_VSYNC_MODE	0x00100000
-#define BM_LCDIF_CTRL_DATA_SWIZZLE	0x00600000
-#define BP_LCDIF_CTRL_DATA_SWIZZLE	21
-#define BM_LCDIF_CTRL_BYPASS_COUNT	0x00800000
-#define BM_LCDIF_CTRL_SHIFT_NUM_BITS	0x06000000
-#define BP_LCDIF_CTRL_SHIFT_NUM_BITS	25
-#define BM_LCDIF_CTRL_DATA_SHIFT_DIR	0x08000000
-#define BM_LCDIF_CTRL_WAIT_FOR_VSYNC_EDGE	0x10000000
-#define BM_LCDIF_CTRL_CLKGATE	0x40000000
-#define BM_LCDIF_CTRL_SFTRST	0x80000000
-
-#define HW_LCDIF_CTRL1		0x10
-#define BM_LCDIF_CTRL1_RESET	0x00000001
-#define BP_LCDIF_CTRL1_RESET	0
-#define BM_LCDIF_CTRL1_MODE86	0x00000002
-#define BM_LCDIF_CTRL1_BUSY_ENABLE	0x00000004
-#define BM_LCDIF_CTRL1_VSYNC_EDGE_IRQ	0x00000100
-#define BM_LCDIF_CTRL1_CUR_FRAME_DONE_IRQ	0x00000200
-#define BM_LCDIF_CTRL1_UNDERFLOW_IRQ	0x00000400
-#define BM_LCDIF_CTRL1_OVERFLOW_IRQ	0x00000800
-#define BM_LCDIF_CTRL1_VSYNC_EDGE_IRQ_EN	0x00001000
-#define BM_LCDIF_CTRL1_BYTE_PACKING_FORMAT	0x000F0000
-#define BP_LCDIF_CTRL1_BYTE_PACKING_FORMAT	16
-
-#define HW_LCDIF_TIMING		0x20
-
-#define HW_LCDIF_VDCTRL0	0x30
-#define BM_LCDIF_VDCTRL0_VALID_DATA_CNT	0x000003FF
-#define BP_LCDIF_VDCTRL0_VALID_DATA_CNT	0
-#define BM_LCDIF_VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	0x00100000
-#define BM_LCDIF_VDCTRL0_VSYNC_PERIOD_UNIT	0x00200000
-#define BM_LCDIF_VDCTRL0_ENABLE_POL	0x01000000
-#define BM_LCDIF_VDCTRL0_DOTCLK_POL	0x02000000
-#define BM_LCDIF_VDCTRL0_HSYNC_POL	0x04000000
-#define BM_LCDIF_VDCTRL0_VSYNC_POL	0x08000000
-#define BM_LCDIF_VDCTRL0_ENABLE_PRESENT	0x10000000
-#define BM_LCDIF_VDCTRL0_VSYNC_OEB	0x20000000
-
-#define HW_LCDIF_VDCTRL1	0x40
-#define BM_LCDIF_VDCTRL1_VSYNC_PERIOD	0x000FFFFF
-#define BP_LCDIF_VDCTRL1_VSYNC_PERIOD	0
-#define BM_LCDIF_VDCTRL1_VSYNC_PULSE_WIDTH	0xFFF00000
-#define BP_LCDIF_VDCTRL1_VSYNC_PULSE_WIDTH	20
-
-#define HW_LCDIF_VDCTRL2	0x50
-#define BM_LCDIF_VDCTRL2_VALID_DATA_CNT	0x000007FF
-#define BP_LCDIF_VDCTRL2_VALID_DATA_CNT	0
-#define BM_LCDIF_VDCTRL2_HSYNC_PERIOD	0x007FF800
-#define BP_LCDIF_VDCTRL2_HSYNC_PERIOD	11
-#define BM_LCDIF_VDCTRL2_HSYNC_PULSE_WIDTH	0xFF800000
-#define BP_LCDIF_VDCTRL2_HSYNC_PULSE_WIDTH	23
-
-#define HW_LCDIF_VDCTRL3	0x60
-#define BM_LCDIF_VDCTRL3_VERTICAL_WAIT_CNT	0x000001FF
-#define BP_LCDIF_VDCTRL3_VERTICAL_WAIT_CNT	0
-#define BM_LCDIF_VDCTRL3_HORIZONTAL_WAIT_CNT	0x00FFF000
-#define BP_LCDIF_VDCTRL3_HORIZONTAL_WAIT_CNT	12
-#define BM_LCDIF_VDCTRL3_SYNC_SIGNALS_ON	0x01000000
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-lradc.h b/arch/arm/mach-stmp37xx/include/mach/regs-lradc.h
deleted file mode 100644
index cc7b470..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-lradc.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * stmp37xx: LRADC register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_LRADC_BASE	(STMP3XXX_REGS_BASE + 0x50000)
-
-#define HW_LRADC_CTRL0		0x0
-#define BM_LRADC_CTRL0_SCHEDULE	0x000000FF
-#define BP_LRADC_CTRL0_SCHEDULE	0
-#define BM_LRADC_CTRL0_XPLUS_ENABLE	0x00010000
-#define BM_LRADC_CTRL0_YPLUS_ENABLE	0x00020000
-#define BM_LRADC_CTRL0_XMINUS_ENABLE	0x00040000
-#define BM_LRADC_CTRL0_YMINUS_ENABLE	0x00080000
-#define BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE	0x00100000
-#define BM_LRADC_CTRL0_ONCHIP_GROUNDREF	0x00200000
-#define BM_LRADC_CTRL0_CLKGATE	0x40000000
-#define BM_LRADC_CTRL0_SFTRST	0x80000000
-
-#define HW_LRADC_CTRL1		0x10
-#define BM_LRADC_CTRL1_LRADC0_IRQ	0x00000001
-#define BP_LRADC_CTRL1_LRADC0_IRQ	0
-#define BM_LRADC_CTRL1_LRADC5_IRQ	0x00000020
-#define BM_LRADC_CTRL1_LRADC6_IRQ	0x00000040
-#define BM_LRADC_CTRL1_TOUCH_DETECT_IRQ	0x00000100
-#define BM_LRADC_CTRL1_LRADC0_IRQ_EN	0x00010000
-#define BM_LRADC_CTRL1_LRADC5_IRQ_EN	0x00200000
-#define BM_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN	0x01000000
-
-#define HW_LRADC_CTRL2		0x20
-#define BM_LRADC_CTRL2_BL_BRIGHTNESS	0x001F0000
-#define BP_LRADC_CTRL2_BL_BRIGHTNESS	16
-#define BM_LRADC_CTRL2_BL_MUX_SELECT	0x00200000
-#define BM_LRADC_CTRL2_BL_ENABLE	0x00400000
-#define BM_LRADC_CTRL2_DIVIDE_BY_TWO	0xFF000000
-#define BP_LRADC_CTRL2_DIVIDE_BY_TWO	24
-
-#define HW_LRADC_CTRL3		0x30
-#define BM_LRADC_CTRL3_CYCLE_TIME	0x00000300
-#define BP_LRADC_CTRL3_CYCLE_TIME	8
-
-#define HW_LRADC_STATUS		0x40
-#define BM_LRADC_STATUS_TOUCH_DETECT_RAW	0x00000001
-#define BP_LRADC_STATUS_TOUCH_DETECT_RAW	0
-
-#define HW_LRADC_CH0		(0x50 + 0 * 0x10)
-#define HW_LRADC_CH1		(0x50 + 1 * 0x10)
-#define HW_LRADC_CH2		(0x50 + 2 * 0x10)
-#define HW_LRADC_CH3		(0x50 + 3 * 0x10)
-#define HW_LRADC_CH4		(0x50 + 4 * 0x10)
-#define HW_LRADC_CH5		(0x50 + 5 * 0x10)
-#define HW_LRADC_CH6		(0x50 + 6 * 0x10)
-#define HW_LRADC_CH7		(0x50 + 7 * 0x10)
-
-#define HW_LRADC_CHn		0x50
-#define BM_LRADC_CHn_VALUE	0x0003FFFF
-#define BP_LRADC_CHn_VALUE	0
-#define BM_LRADC_CHn_NUM_SAMPLES	0x1F000000
-#define BP_LRADC_CHn_NUM_SAMPLES	24
-#define BM_LRADC_CHn_ACCUMULATE	0x20000000
-
-#define HW_LRADC_DELAY0		(0xD0 + 0 * 0x10)
-#define HW_LRADC_DELAY1		(0xD0 + 1 * 0x10)
-#define HW_LRADC_DELAY2		(0xD0 + 2 * 0x10)
-#define HW_LRADC_DELAY3		(0xD0 + 3 * 0x10)
-
-#define HW_LRADC_DELAYn		0xD0
-#define BM_LRADC_DELAYn_DELAY	0x000007FF
-#define BP_LRADC_DELAYn_DELAY	0
-#define BM_LRADC_DELAYn_LOOP_COUNT	0x0000F800
-#define BP_LRADC_DELAYn_LOOP_COUNT	11
-#define BM_LRADC_DELAYn_TRIGGER_DELAYS	0x000F0000
-#define BP_LRADC_DELAYn_TRIGGER_DELAYS	16
-#define BM_LRADC_DELAYn_KICK	0x00100000
-#define BM_LRADC_DELAYn_TRIGGER_LRADCS	0xFF000000
-#define BP_LRADC_DELAYn_TRIGGER_LRADCS	24
-
-#define HW_LRADC_CTRL4		0x140
-#define BM_LRADC_CTRL4_LRADC6SELECT	0x0F000000
-#define BP_LRADC_CTRL4_LRADC6SELECT	24
-#define BM_LRADC_CTRL4_LRADC7SELECT	0xF0000000
-#define BP_LRADC_CTRL4_LRADC7SELECT	28
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-pinctrl.h b/arch/arm/mach-stmp37xx/include/mach/regs-pinctrl.h
deleted file mode 100644
index d5efce2..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-pinctrl.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * stmp37xx: PINCTRL register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_PINCTRL
-#define _MACH_REGS_PINCTRL
-
-#define REGS_PINCTRL_BASE	(STMP3XXX_REGS_BASE + 0x18000)
-
-#define HW_PINCTRL_MUXSEL0	0x100
-#define HW_PINCTRL_MUXSEL1	0x110
-#define HW_PINCTRL_MUXSEL2	0x120
-#define HW_PINCTRL_MUXSEL3	0x130
-#define HW_PINCTRL_MUXSEL4	0x140
-#define HW_PINCTRL_MUXSEL5	0x150
-#define HW_PINCTRL_MUXSEL6	0x160
-#define HW_PINCTRL_MUXSEL7	0x170
-
-#define HW_PINCTRL_DRIVE0	0x200
-#define HW_PINCTRL_DRIVE1	0x210
-#define HW_PINCTRL_DRIVE2	0x220
-#define HW_PINCTRL_DRIVE3	0x230
-#define HW_PINCTRL_DRIVE4	0x240
-#define HW_PINCTRL_DRIVE5	0x250
-#define HW_PINCTRL_DRIVE6	0x260
-#define HW_PINCTRL_DRIVE7	0x270
-#define HW_PINCTRL_DRIVE8	0x280
-#define HW_PINCTRL_DRIVE9	0x290
-#define HW_PINCTRL_DRIVE10	0x2A0
-#define HW_PINCTRL_DRIVE11	0x2B0
-#define HW_PINCTRL_DRIVE12	0x2C0
-#define HW_PINCTRL_DRIVE13	0x2D0
-#define HW_PINCTRL_DRIVE14	0x2E0
-
-#define HW_PINCTRL_PULL0	0x300
-#define HW_PINCTRL_PULL1	0x310
-#define HW_PINCTRL_PULL2	0x320
-#define HW_PINCTRL_PULL3	0x330
-
-#define HW_PINCTRL_DOUT0	0x400
-#define HW_PINCTRL_DOUT1	0x410
-#define HW_PINCTRL_DOUT2	0x420
-
-#define HW_PINCTRL_DIN0		0x500
-#define HW_PINCTRL_DIN1		0x510
-#define HW_PINCTRL_DIN2		0x520
-
-#define HW_PINCTRL_DOE0		0x600
-#define HW_PINCTRL_DOE1		0x610
-#define HW_PINCTRL_DOE2		0x620
-
-#define HW_PINCTRL_PIN2IRQ0	0x700
-#define HW_PINCTRL_PIN2IRQ1	0x710
-#define HW_PINCTRL_PIN2IRQ2	0x720
-
-#define HW_PINCTRL_IRQEN0	0x800
-#define HW_PINCTRL_IRQEN1	0x810
-#define HW_PINCTRL_IRQEN2	0x820
-
-#define HW_PINCTRL_IRQLEVEL0	0x900
-#define HW_PINCTRL_IRQLEVEL1	0x910
-#define HW_PINCTRL_IRQLEVEL2	0x920
-
-#define HW_PINCTRL_IRQPOL0	0xA00
-#define HW_PINCTRL_IRQPOL1	0xA10
-#define HW_PINCTRL_IRQPOL2	0xA20
-
-#define HW_PINCTRL_IRQSTAT0	0xB00
-#define HW_PINCTRL_IRQSTAT1	0xB10
-#define HW_PINCTRL_IRQSTAT2	0xB20
-
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-power.h b/arch/arm/mach-stmp37xx/include/mach/regs-power.h
deleted file mode 100644
index 0e733d7..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-power.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * stmp37xx: POWER register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_POWER
-#define _MACH_REGS_POWER
-
-#define REGS_POWER_BASE	(STMP3XXX_REGS_BASE + 0x44000)
-
-#define HW_POWER_CTRL		0x0
-#define BM_POWER_CTRL_CLKGATE	0x40000000
-
-#define HW_POWER_5VCTRL		0x10
-
-#define HW_POWER_MINPWR		0x20
-
-#define HW_POWER_CHARGE		0x30
-
-#define HW_POWER_VDDDCTRL	0x40
-
-#define HW_POWER_VDDACTRL	0x50
-
-#define HW_POWER_VDDIOCTRL	0x60
-#define BM_POWER_VDDIOCTRL_TRG	0x0000001F
-#define BP_POWER_VDDIOCTRL_TRG	0
-
-#define HW_POWER_STS		0xB0
-#define BM_POWER_STS_VBUSVALID	0x00000002
-#define BM_POWER_STS_BVALID	0x00000004
-#define BM_POWER_STS_AVALID	0x00000008
-#define BM_POWER_STS_DC_OK	0x00000100
-
-#define HW_POWER_RESET		0xE0
-
-#define HW_POWER_DEBUG		0xF0
-#define BM_POWER_DEBUG_BVALIDPIOLOCK	0x00000002
-#define BM_POWER_DEBUG_AVALIDPIOLOCK	0x00000004
-#define BM_POWER_DEBUG_VBUSVALIDPIOLOCK	0x00000008
-
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-pwm.h b/arch/arm/mach-stmp37xx/include/mach/regs-pwm.h
deleted file mode 100644
index 15966a1..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-pwm.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * stmp37xx: PWM register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_PWM_BASE	(STMP3XXX_REGS_BASE + 0x64000)
-
-#define HW_PWM_CTRL		0x0
-#define BM_PWM_CTRL_PWM2_ENABLE	0x00000004
-#define BM_PWM_CTRL_PWM2_ANA_CTRL_ENABLE	0x00000020
-
-#define HW_PWM_ACTIVE0		(0x10 + 0 * 0x20)
-#define HW_PWM_ACTIVE1		(0x10 + 1 * 0x20)
-#define HW_PWM_ACTIVE2		(0x10 + 2 * 0x20)
-#define HW_PWM_ACTIVE3		(0x10 + 3 * 0x20)
-
-#define HW_PWM_ACTIVEn		0x10
-#define BM_PWM_ACTIVEn_ACTIVE	0x0000FFFF
-#define BP_PWM_ACTIVEn_ACTIVE	0
-#define BM_PWM_ACTIVEn_INACTIVE	0xFFFF0000
-#define BP_PWM_ACTIVEn_INACTIVE	16
-
-#define HW_PWM_PERIOD0		(0x20 + 0 * 0x20)
-#define HW_PWM_PERIOD1		(0x20 + 1 * 0x20)
-#define HW_PWM_PERIOD2		(0x20 + 2 * 0x20)
-#define HW_PWM_PERIOD3		(0x20 + 3 * 0x20)
-
-#define HW_PWM_PERIODn		0x20
-#define BM_PWM_PERIODn_PERIOD	0x0000FFFF
-#define BP_PWM_PERIODn_PERIOD	0
-#define BM_PWM_PERIODn_ACTIVE_STATE	0x00030000
-#define BP_PWM_PERIODn_ACTIVE_STATE	16
-#define BM_PWM_PERIODn_INACTIVE_STATE	0x000C0000
-#define BP_PWM_PERIODn_INACTIVE_STATE	18
-#define BM_PWM_PERIODn_CDIV	0x00700000
-#define BP_PWM_PERIODn_CDIV	20
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-rtc.h b/arch/arm/mach-stmp37xx/include/mach/regs-rtc.h
deleted file mode 100644
index fac40ed..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-rtc.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * stmp37xx: RTC register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_RTC_BASE	(STMP3XXX_REGS_BASE + 0x5C000)
-#define REGS_RTC_PHYS   0x8005C000
-#define REGS_RTC_SIZE   0x2000
-
-#define HW_RTC_CTRL		0x0
-#define BM_RTC_CTRL_ALARM_IRQ_EN	0x00000001
-#define BP_RTC_CTRL_ALARM_IRQ_EN	0
-#define BM_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
-#define BM_RTC_CTRL_ALARM_IRQ	0x00000004
-#define BM_RTC_CTRL_ONEMSEC_IRQ	0x00000008
-#define BM_RTC_CTRL_WATCHDOGEN	0x00000010
-
-#define HW_RTC_STAT		0x10
-#define BM_RTC_STAT_NEW_REGS	0x0000FF00
-#define BP_RTC_STAT_NEW_REGS	8
-#define BM_RTC_STAT_STALE_REGS	0x00FF0000
-#define BP_RTC_STAT_STALE_REGS	16
-#define BM_RTC_STAT_RTC_PRESENT	0x80000000
-
-#define HW_RTC_SECONDS		0x30
-
-#define HW_RTC_ALARM		0x40
-
-#define HW_RTC_WATCHDOG		0x50
-
-#define HW_RTC_PERSISTENT0	0x60
-#define BM_RTC_PERSISTENT0_ALARM_WAKE_EN	0x00000002
-#define BM_RTC_PERSISTENT0_ALARM_EN	0x00000004
-#define BM_RTC_PERSISTENT0_XTAL24MHZ_PWRUP	0x00000010
-#define BM_RTC_PERSISTENT0_XTAL32KHZ_PWRUP	0x00000020
-#define BM_RTC_PERSISTENT0_ALARM_WAKE	0x00000080
-#define BM_RTC_PERSISTENT0_SPARE_ANALOG	0xFFFC0000
-#define BP_RTC_PERSISTENT0_SPARE_ANALOG	18
-
-#define HW_RTC_PERSISTENT1	0x70
-
-#define HW_RTC_VERSION		0xD0
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-ssp.h b/arch/arm/mach-stmp37xx/include/mach/regs-ssp.h
deleted file mode 100644
index cbde891..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-ssp.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * stmp37xx: SSP register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_SSP_BASE	(STMP3XXX_REGS_BASE + 0x10000)
-#define REGS_SSP1_PHYS	0x80010000
-#define REGS_SSP2_PHYS	0x80034000
-#define REGS_SSP_SIZE	0x2000
-
-#define HW_SSP_CTRL0		0x0
-#define BM_SSP_CTRL0_XFER_COUNT	0x0000FFFF
-#define BP_SSP_CTRL0_XFER_COUNT	0
-#define BM_SSP_CTRL0_ENABLE	0x00010000
-#define BM_SSP_CTRL0_GET_RESP	0x00020000
-#define BM_SSP_CTRL0_LONG_RESP	0x00080000
-#define BM_SSP_CTRL0_WAIT_FOR_CMD	0x00100000
-#define BM_SSP_CTRL0_WAIT_FOR_IRQ	0x00200000
-#define BM_SSP_CTRL0_BUS_WIDTH	0x00C00000
-#define BP_SSP_CTRL0_BUS_WIDTH	22
-#define BM_SSP_CTRL0_DATA_XFER	0x01000000
-#define BM_SSP_CTRL0_READ	0x02000000
-#define BM_SSP_CTRL0_IGNORE_CRC	0x04000000
-#define BM_SSP_CTRL0_LOCK_CS	0x08000000
-#define BM_SSP_CTRL0_RUN	0x20000000
-#define BM_SSP_CTRL0_CLKGATE	0x40000000
-#define BM_SSP_CTRL0_SFTRST	0x80000000
-
-#define HW_SSP_CMD0		0x10
-#define BM_SSP_CMD0_CMD		0x000000FF
-#define BP_SSP_CMD0_CMD		0
-#define BM_SSP_CMD0_BLOCK_COUNT	0x0000FF00
-#define BP_SSP_CMD0_BLOCK_COUNT	8
-#define BM_SSP_CMD0_BLOCK_SIZE	0x000F0000
-#define BP_SSP_CMD0_BLOCK_SIZE	16
-#define BM_SSP_CMD0_APPEND_8CYC	0x00100000
-#define BM_SSP_CMD1_CMD_ARG	0xFFFFFFFF
-#define BP_SSP_CMD1_CMD_ARG	0
-
-#define HW_SSP_TIMING		0x50
-#define BM_SSP_TIMING_CLOCK_RATE	0x000000FF
-#define BP_SSP_TIMING_CLOCK_RATE	0
-#define BM_SSP_TIMING_CLOCK_DIVIDE	0x0000FF00
-#define BP_SSP_TIMING_CLOCK_DIVIDE	8
-#define BM_SSP_TIMING_TIMEOUT	0xFFFF0000
-#define BP_SSP_TIMING_TIMEOUT	16
-
-#define HW_SSP_CTRL1		0x60
-#define BM_SSP_CTRL1_SSP_MODE	0x0000000F
-#define BP_SSP_CTRL1_SSP_MODE	0
-#define BM_SSP_CTRL1_WORD_LENGTH	0x000000F0
-#define BP_SSP_CTRL1_WORD_LENGTH	4
-#define BM_SSP_CTRL1_POLARITY	0x00000200
-#define BM_SSP_CTRL1_PHASE	0x00000400
-#define BM_SSP_CTRL1_DMA_ENABLE	0x00002000
-#define BM_SSP_CTRL1_FIFO_OVERRUN_IRQ	0x00008000
-#define BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN	0x00010000
-#define BM_SSP_CTRL1_RECV_TIMEOUT_IRQ	0x00020000
-#define BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ	0x00200000
-#define BM_SSP_CTRL1_DATA_CRC_IRQ_EN	0x00400000
-#define BM_SSP_CTRL1_DATA_CRC_IRQ	0x00800000
-#define BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN	0x01000000
-#define BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	0x02000000
-#define BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN	0x04000000
-#define BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	0x08000000
-#define BM_SSP_CTRL1_RESP_ERR_IRQ_EN	0x10000000
-#define BM_SSP_CTRL1_RESP_ERR_IRQ	0x20000000
-#define BM_SSP_CTRL1_SDIO_IRQ	0x80000000
-
-#define HW_SSP_DATA		0x70
-
-#define HW_SSP_SDRESP0		0x80
-
-#define HW_SSP_SDRESP1		0x90
-
-#define HW_SSP_SDRESP2		0xA0
-
-#define HW_SSP_SDRESP3		0xB0
-
-#define HW_SSP_STATUS		0xC0
-#define BM_SSP_STATUS_FIFO_EMPTY	0x00000020
-#define BM_SSP_STATUS_TIMEOUT	0x00001000
-#define BM_SSP_STATUS_RESP_TIMEOUT	0x00004000
-#define BM_SSP_STATUS_RESP_ERR	0x00008000
-#define BM_SSP_STATUS_RESP_CRC_ERR	0x00010000
-#define BM_SSP_STATUS_CARD_DETECT	0x10000000
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-timrot.h b/arch/arm/mach-stmp37xx/include/mach/regs-timrot.h
deleted file mode 100644
index 4af0f6e..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-timrot.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * stmp37xx: TIMROT register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _MACH_REGS_TIMROT
-#define _MACH_REGS_TIMROT
-
-#define REGS_TIMROT_BASE	(STMP3XXX_REGS_BASE + 0x68000)
-
-#define HW_TIMROT_ROTCTRL	0x0
-#define BM_TIMROT_ROTCTRL_CLKGATE	0x40000000
-#define BM_TIMROT_ROTCTRL_SFTRST	0x80000000
-
-#define HW_TIMROT_TIMCTRL0	(0x20 + 0 * 0x20)
-#define HW_TIMROT_TIMCTRL1	(0x20 + 1 * 0x20)
-#define HW_TIMROT_TIMCTRL2	(0x20 + 2 * 0x20)
-
-#define HW_TIMROT_TIMCTRLn	0x20
-#define BM_TIMROT_TIMCTRLn_SELECT	0x0000000F
-#define BP_TIMROT_TIMCTRLn_SELECT	0
-#define BM_TIMROT_TIMCTRLn_PRESCALE	0x00000030
-#define BP_TIMROT_TIMCTRLn_PRESCALE	4
-#define BM_TIMROT_TIMCTRLn_RELOAD	0x00000040
-#define BM_TIMROT_TIMCTRLn_UPDATE	0x00000080
-#define BM_TIMROT_TIMCTRLn_IRQ_EN	0x00004000
-#define BM_TIMROT_TIMCTRLn_IRQ	0x00008000
-
-#define HW_TIMROT_TIMCOUNT0	(0x30 + 0 * 0x20)
-#define HW_TIMROT_TIMCOUNT1	(0x30 + 1 * 0x20)
-#define HW_TIMROT_TIMCOUNT2	(0x30 + 2 * 0x20)
-
-#define HW_TIMROT_TIMCOUNTn	0x30
-#endif
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-uartapp.h b/arch/arm/mach-stmp37xx/include/mach/regs-uartapp.h
deleted file mode 100644
index 0594275..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-uartapp.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * stmp37xx: UARTAPP register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_UARTAPP_BASE	(STMP3XXX_REGS_BASE + 0x6C000)
-#define REGS_UARTAPP1_PHYS	0x8006C000
-#define REGS_UARTAPP_SIZE	0x2000
-
-#define HW_UARTAPP_CTRL0	0x0
-#define BM_UARTAPP_CTRL0_XFER_COUNT	0x0000FFFF
-#define BP_UARTAPP_CTRL0_XFER_COUNT	0
-#define BM_UARTAPP_CTRL0_RXTIMEOUT	0x07FF0000
-#define BP_UARTAPP_CTRL0_RXTIMEOUT	16
-#define BM_UARTAPP_CTRL0_RXTO_ENABLE	0x08000000
-#define BM_UARTAPP_CTRL0_RUN	0x20000000
-#define BM_UARTAPP_CTRL0_SFTRST	0x80000000
-#define BM_UARTAPP_CTRL1_XFER_COUNT	0x0000FFFF
-#define BP_UARTAPP_CTRL1_XFER_COUNT	0
-#define BM_UARTAPP_CTRL1_RUN	0x10000000
-
-#define HW_UARTAPP_CTRL2	0x20
-#define BM_UARTAPP_CTRL2_UARTEN	0x00000001
-#define BP_UARTAPP_CTRL2_UARTEN	0
-#define BM_UARTAPP_CTRL2_TXE	0x00000100
-#define BM_UARTAPP_CTRL2_RXE	0x00000200
-#define BM_UARTAPP_CTRL2_RTS	0x00000800
-#define BM_UARTAPP_CTRL2_RTSEN	0x00004000
-#define BM_UARTAPP_CTRL2_CTSEN	0x00008000
-#define BM_UARTAPP_CTRL2_RXDMAE	0x01000000
-#define BM_UARTAPP_CTRL2_TXDMAE	0x02000000
-#define BM_UARTAPP_CTRL2_DMAONERR	0x04000000
-
-#define HW_UARTAPP_LINECTRL	0x30
-#define BM_UARTAPP_LINECTRL_BRK	0x00000001
-#define BP_UARTAPP_LINECTRL_BRK	0
-#define BM_UARTAPP_LINECTRL_PEN	0x00000002
-#define BM_UARTAPP_LINECTRL_EPS	0x00000004
-#define BM_UARTAPP_LINECTRL_STP2	0x00000008
-#define BM_UARTAPP_LINECTRL_FEN	0x00000010
-#define BM_UARTAPP_LINECTRL_WLEN	0x00000060
-#define BP_UARTAPP_LINECTRL_WLEN	5
-#define BM_UARTAPP_LINECTRL_SPS	0x00000080
-#define BM_UARTAPP_LINECTRL_BAUD_DIVFRAC	0x00003F00
-#define BP_UARTAPP_LINECTRL_BAUD_DIVFRAC	8
-#define BM_UARTAPP_LINECTRL_BAUD_DIVINT	0xFFFF0000
-#define BP_UARTAPP_LINECTRL_BAUD_DIVINT	16
-
-#define HW_UARTAPP_INTR		0x50
-#define BM_UARTAPP_INTR_CTSMIS	0x00000002
-#define BM_UARTAPP_INTR_RTIS	0x00000040
-#define BM_UARTAPP_INTR_CTSMIEN	0x00020000
-#define BM_UARTAPP_INTR_RXIEN	0x00100000
-#define BM_UARTAPP_INTR_RTIEN	0x00400000
-
-#define HW_UARTAPP_DATA		0x60
-
-#define HW_UARTAPP_STAT		0x70
-#define BM_UARTAPP_STAT_RXCOUNT	0x0000FFFF
-#define BP_UARTAPP_STAT_RXCOUNT	0
-#define BM_UARTAPP_STAT_FERR	0x00010000
-#define BM_UARTAPP_STAT_PERR	0x00020000
-#define BM_UARTAPP_STAT_BERR	0x00040000
-#define BM_UARTAPP_STAT_OERR	0x00080000
-#define BM_UARTAPP_STAT_RXFE	0x01000000
-#define BM_UARTAPP_STAT_TXFF	0x02000000
-#define BM_UARTAPP_STAT_TXFE	0x08000000
-#define BM_UARTAPP_STAT_CTS	0x10000000
-
-#define HW_UARTAPP_VERSION	0x90
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h b/arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h
deleted file mode 100644
index b810deb..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- * stmp378x: UARTDBG register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_UARTDBG_BASE	(STMP3XXX_REGS_BASE + 0x70000)
-#define REGS_UARTDBG_PHYS	0x80070000
-#define REGS_UARTDBG_SIZE	0x2000
-
-#define HW_UARTDBGDR 0x00000000
-#define BP_UARTDBGDR_UNAVAILABLE      16
-#define BM_UARTDBGDR_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGDR_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGDR_UNAVAILABLE)
-#define BP_UARTDBGDR_RESERVED      12
-#define BM_UARTDBGDR_RESERVED 0x0000F000
-#define BF_UARTDBGDR_RESERVED(v)  \
-	(((v) << 12) & BM_UARTDBGDR_RESERVED)
-#define BM_UARTDBGDR_OE 0x00000800
-#define BM_UARTDBGDR_BE 0x00000400
-#define BM_UARTDBGDR_PE 0x00000200
-#define BM_UARTDBGDR_FE 0x00000100
-#define BP_UARTDBGDR_DATA      0
-#define BM_UARTDBGDR_DATA 0x000000FF
-#define BF_UARTDBGDR_DATA(v)  \
-	(((v) << 0) & BM_UARTDBGDR_DATA)
-#define HW_UARTDBGRSR_ECR 0x00000004
-#define BP_UARTDBGRSR_ECR_UNAVAILABLE      8
-#define BM_UARTDBGRSR_ECR_UNAVAILABLE 0xFFFFFF00
-#define BF_UARTDBGRSR_ECR_UNAVAILABLE(v) \
-	(((v) << 8) & BM_UARTDBGRSR_ECR_UNAVAILABLE)
-#define BP_UARTDBGRSR_ECR_EC      4
-#define BM_UARTDBGRSR_ECR_EC 0x000000F0
-#define BF_UARTDBGRSR_ECR_EC(v)  \
-	(((v) << 4) & BM_UARTDBGRSR_ECR_EC)
-#define BM_UARTDBGRSR_ECR_OE 0x00000008
-#define BM_UARTDBGRSR_ECR_BE 0x00000004
-#define BM_UARTDBGRSR_ECR_PE 0x00000002
-#define BM_UARTDBGRSR_ECR_FE 0x00000001
-#define HW_UARTDBGFR 0x00000018
-#define BP_UARTDBGFR_UNAVAILABLE      16
-#define BM_UARTDBGFR_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGFR_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGFR_UNAVAILABLE)
-#define BP_UARTDBGFR_RESERVED      9
-#define BM_UARTDBGFR_RESERVED 0x0000FE00
-#define BF_UARTDBGFR_RESERVED(v)  \
-	(((v) << 9) & BM_UARTDBGFR_RESERVED)
-#define BM_UARTDBGFR_RI 0x00000100
-#define BM_UARTDBGFR_TXFE 0x00000080
-#define BM_UARTDBGFR_RXFF 0x00000040
-#define BM_UARTDBGFR_TXFF 0x00000020
-#define BM_UARTDBGFR_RXFE 0x00000010
-#define BM_UARTDBGFR_BUSY 0x00000008
-#define BM_UARTDBGFR_DCD 0x00000004
-#define BM_UARTDBGFR_DSR 0x00000002
-#define BM_UARTDBGFR_CTS 0x00000001
-#define HW_UARTDBGILPR 0x00000020
-#define BP_UARTDBGILPR_UNAVAILABLE      8
-#define BM_UARTDBGILPR_UNAVAILABLE 0xFFFFFF00
-#define BF_UARTDBGILPR_UNAVAILABLE(v) \
-	(((v) << 8) & BM_UARTDBGILPR_UNAVAILABLE)
-#define BP_UARTDBGILPR_ILPDVSR      0
-#define BM_UARTDBGILPR_ILPDVSR 0x000000FF
-#define BF_UARTDBGILPR_ILPDVSR(v)  \
-	(((v) << 0) & BM_UARTDBGILPR_ILPDVSR)
-#define HW_UARTDBGIBRD 0x00000024
-#define BP_UARTDBGIBRD_UNAVAILABLE      16
-#define BM_UARTDBGIBRD_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGIBRD_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGIBRD_UNAVAILABLE)
-#define BP_UARTDBGIBRD_BAUD_DIVINT      0
-#define BM_UARTDBGIBRD_BAUD_DIVINT 0x0000FFFF
-#define BF_UARTDBGIBRD_BAUD_DIVINT(v)  \
-	(((v) << 0) & BM_UARTDBGIBRD_BAUD_DIVINT)
-#define HW_UARTDBGFBRD 0x00000028
-#define BP_UARTDBGFBRD_UNAVAILABLE      8
-#define BM_UARTDBGFBRD_UNAVAILABLE 0xFFFFFF00
-#define BF_UARTDBGFBRD_UNAVAILABLE(v) \
-	(((v) << 8) & BM_UARTDBGFBRD_UNAVAILABLE)
-#define BP_UARTDBGFBRD_RESERVED      6
-#define BM_UARTDBGFBRD_RESERVED 0x000000C0
-#define BF_UARTDBGFBRD_RESERVED(v)  \
-	(((v) << 6) & BM_UARTDBGFBRD_RESERVED)
-#define BP_UARTDBGFBRD_BAUD_DIVFRAC      0
-#define BM_UARTDBGFBRD_BAUD_DIVFRAC 0x0000003F
-#define BF_UARTDBGFBRD_BAUD_DIVFRAC(v)  \
-	(((v) << 0) & BM_UARTDBGFBRD_BAUD_DIVFRAC)
-#define HW_UARTDBGLCR_H 0x0000002c
-#define BP_UARTDBGLCR_H_UNAVAILABLE      16
-#define BM_UARTDBGLCR_H_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGLCR_H_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGLCR_H_UNAVAILABLE)
-#define BP_UARTDBGLCR_H_RESERVED      8
-#define BM_UARTDBGLCR_H_RESERVED 0x0000FF00
-#define BF_UARTDBGLCR_H_RESERVED(v)  \
-	(((v) << 8) & BM_UARTDBGLCR_H_RESERVED)
-#define BM_UARTDBGLCR_H_SPS 0x00000080
-#define BP_UARTDBGLCR_H_WLEN      5
-#define BM_UARTDBGLCR_H_WLEN 0x00000060
-#define BF_UARTDBGLCR_H_WLEN(v)  \
-	(((v) << 5) & BM_UARTDBGLCR_H_WLEN)
-#define BM_UARTDBGLCR_H_FEN 0x00000010
-#define BM_UARTDBGLCR_H_STP2 0x00000008
-#define BM_UARTDBGLCR_H_EPS 0x00000004
-#define BM_UARTDBGLCR_H_PEN 0x00000002
-#define BM_UARTDBGLCR_H_BRK 0x00000001
-#define HW_UARTDBGCR 0x00000030
-#define BP_UARTDBGCR_UNAVAILABLE      16
-#define BM_UARTDBGCR_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGCR_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGCR_UNAVAILABLE)
-#define BM_UARTDBGCR_CTSEN 0x00008000
-#define BM_UARTDBGCR_RTSEN 0x00004000
-#define BM_UARTDBGCR_OUT2 0x00002000
-#define BM_UARTDBGCR_OUT1 0x00001000
-#define BM_UARTDBGCR_RTS 0x00000800
-#define BM_UARTDBGCR_DTR 0x00000400
-#define BM_UARTDBGCR_RXE 0x00000200
-#define BM_UARTDBGCR_TXE 0x00000100
-#define BM_UARTDBGCR_LBE 0x00000080
-#define BP_UARTDBGCR_RESERVED      3
-#define BM_UARTDBGCR_RESERVED 0x00000078
-#define BF_UARTDBGCR_RESERVED(v)  \
-	(((v) << 3) & BM_UARTDBGCR_RESERVED)
-#define BM_UARTDBGCR_SIRLP 0x00000004
-#define BM_UARTDBGCR_SIREN 0x00000002
-#define BM_UARTDBGCR_UARTEN 0x00000001
-#define HW_UARTDBGIFLS 0x00000034
-#define BP_UARTDBGIFLS_UNAVAILABLE      16
-#define BM_UARTDBGIFLS_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGIFLS_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGIFLS_UNAVAILABLE)
-#define BP_UARTDBGIFLS_RESERVED      6
-#define BM_UARTDBGIFLS_RESERVED 0x0000FFC0
-#define BF_UARTDBGIFLS_RESERVED(v)  \
-	(((v) << 6) & BM_UARTDBGIFLS_RESERVED)
-#define BP_UARTDBGIFLS_RXIFLSEL      3
-#define BM_UARTDBGIFLS_RXIFLSEL 0x00000038
-#define BF_UARTDBGIFLS_RXIFLSEL(v)  \
-	(((v) << 3) & BM_UARTDBGIFLS_RXIFLSEL)
-#define BV_UARTDBGIFLS_RXIFLSEL__NOT_EMPTY      0x0
-#define BV_UARTDBGIFLS_RXIFLSEL__ONE_QUARTER    0x1
-#define BV_UARTDBGIFLS_RXIFLSEL__ONE_HALF       0x2
-#define BV_UARTDBGIFLS_RXIFLSEL__THREE_QUARTERS 0x3
-#define BV_UARTDBGIFLS_RXIFLSEL__SEVEN_EIGHTHS  0x4
-#define BV_UARTDBGIFLS_RXIFLSEL__INVALID5       0x5
-#define BV_UARTDBGIFLS_RXIFLSEL__INVALID6       0x6
-#define BV_UARTDBGIFLS_RXIFLSEL__INVALID7       0x7
-#define BP_UARTDBGIFLS_TXIFLSEL      0
-#define BM_UARTDBGIFLS_TXIFLSEL 0x00000007
-#define BF_UARTDBGIFLS_TXIFLSEL(v)  \
-	(((v) << 0) & BM_UARTDBGIFLS_TXIFLSEL)
-#define BV_UARTDBGIFLS_TXIFLSEL__EMPTY	  0x0
-#define BV_UARTDBGIFLS_TXIFLSEL__ONE_QUARTER    0x1
-#define BV_UARTDBGIFLS_TXIFLSEL__ONE_HALF       0x2
-#define BV_UARTDBGIFLS_TXIFLSEL__THREE_QUARTERS 0x3
-#define BV_UARTDBGIFLS_TXIFLSEL__SEVEN_EIGHTHS  0x4
-#define BV_UARTDBGIFLS_TXIFLSEL__INVALID5       0x5
-#define BV_UARTDBGIFLS_TXIFLSEL__INVALID6       0x6
-#define BV_UARTDBGIFLS_TXIFLSEL__INVALID7       0x7
-#define HW_UARTDBGIMSC 0x00000038
-#define BP_UARTDBGIMSC_UNAVAILABLE      16
-#define BM_UARTDBGIMSC_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGIMSC_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGIMSC_UNAVAILABLE)
-#define BP_UARTDBGIMSC_RESERVED      11
-#define BM_UARTDBGIMSC_RESERVED 0x0000F800
-#define BF_UARTDBGIMSC_RESERVED(v)  \
-	(((v) << 11) & BM_UARTDBGIMSC_RESERVED)
-#define BM_UARTDBGIMSC_OEIM 0x00000400
-#define BM_UARTDBGIMSC_BEIM 0x00000200
-#define BM_UARTDBGIMSC_PEIM 0x00000100
-#define BM_UARTDBGIMSC_FEIM 0x00000080
-#define BM_UARTDBGIMSC_RTIM 0x00000040
-#define BM_UARTDBGIMSC_TXIM 0x00000020
-#define BM_UARTDBGIMSC_RXIM 0x00000010
-#define BM_UARTDBGIMSC_DSRMIM 0x00000008
-#define BM_UARTDBGIMSC_DCDMIM 0x00000004
-#define BM_UARTDBGIMSC_CTSMIM 0x00000002
-#define BM_UARTDBGIMSC_RIMIM 0x00000001
-#define HW_UARTDBGRIS 0x0000003c
-#define BP_UARTDBGRIS_UNAVAILABLE      16
-#define BM_UARTDBGRIS_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGRIS_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGRIS_UNAVAILABLE)
-#define BP_UARTDBGRIS_RESERVED      11
-#define BM_UARTDBGRIS_RESERVED 0x0000F800
-#define BF_UARTDBGRIS_RESERVED(v)  \
-	(((v) << 11) & BM_UARTDBGRIS_RESERVED)
-#define BM_UARTDBGRIS_OERIS 0x00000400
-#define BM_UARTDBGRIS_BERIS 0x00000200
-#define BM_UARTDBGRIS_PERIS 0x00000100
-#define BM_UARTDBGRIS_FERIS 0x00000080
-#define BM_UARTDBGRIS_RTRIS 0x00000040
-#define BM_UARTDBGRIS_TXRIS 0x00000020
-#define BM_UARTDBGRIS_RXRIS 0x00000010
-#define BM_UARTDBGRIS_DSRRMIS 0x00000008
-#define BM_UARTDBGRIS_DCDRMIS 0x00000004
-#define BM_UARTDBGRIS_CTSRMIS 0x00000002
-#define BM_UARTDBGRIS_RIRMIS 0x00000001
-#define HW_UARTDBGMIS 0x00000040
-#define BP_UARTDBGMIS_UNAVAILABLE      16
-#define BM_UARTDBGMIS_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGMIS_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGMIS_UNAVAILABLE)
-#define BP_UARTDBGMIS_RESERVED      11
-#define BM_UARTDBGMIS_RESERVED 0x0000F800
-#define BF_UARTDBGMIS_RESERVED(v)  \
-	(((v) << 11) & BM_UARTDBGMIS_RESERVED)
-#define BM_UARTDBGMIS_OEMIS 0x00000400
-#define BM_UARTDBGMIS_BEMIS 0x00000200
-#define BM_UARTDBGMIS_PEMIS 0x00000100
-#define BM_UARTDBGMIS_FEMIS 0x00000080
-#define BM_UARTDBGMIS_RTMIS 0x00000040
-#define BM_UARTDBGMIS_TXMIS 0x00000020
-#define BM_UARTDBGMIS_RXMIS 0x00000010
-#define BM_UARTDBGMIS_DSRMMIS 0x00000008
-#define BM_UARTDBGMIS_DCDMMIS 0x00000004
-#define BM_UARTDBGMIS_CTSMMIS 0x00000002
-#define BM_UARTDBGMIS_RIMMIS 0x00000001
-#define HW_UARTDBGICR 0x00000044
-#define BP_UARTDBGICR_UNAVAILABLE      16
-#define BM_UARTDBGICR_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGICR_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGICR_UNAVAILABLE)
-#define BP_UARTDBGICR_RESERVED      11
-#define BM_UARTDBGICR_RESERVED 0x0000F800
-#define BF_UARTDBGICR_RESERVED(v)  \
-	(((v) << 11) & BM_UARTDBGICR_RESERVED)
-#define BM_UARTDBGICR_OEIC 0x00000400
-#define BM_UARTDBGICR_BEIC 0x00000200
-#define BM_UARTDBGICR_PEIC 0x00000100
-#define BM_UARTDBGICR_FEIC 0x00000080
-#define BM_UARTDBGICR_RTIC 0x00000040
-#define BM_UARTDBGICR_TXIC 0x00000020
-#define BM_UARTDBGICR_RXIC 0x00000010
-#define BM_UARTDBGICR_DSRMIC 0x00000008
-#define BM_UARTDBGICR_DCDMIC 0x00000004
-#define BM_UARTDBGICR_CTSMIC 0x00000002
-#define BM_UARTDBGICR_RIMIC 0x00000001
-#define HW_UARTDBGDMACR 0x00000048
-#define BP_UARTDBGDMACR_UNAVAILABLE      16
-#define BM_UARTDBGDMACR_UNAVAILABLE 0xFFFF0000
-#define BF_UARTDBGDMACR_UNAVAILABLE(v) \
-	(((v) << 16) & BM_UARTDBGDMACR_UNAVAILABLE)
-#define BP_UARTDBGDMACR_RESERVED      3
-#define BM_UARTDBGDMACR_RESERVED 0x0000FFF8
-#define BF_UARTDBGDMACR_RESERVED(v)  \
-	(((v) << 3) & BM_UARTDBGDMACR_RESERVED)
-#define BM_UARTDBGDMACR_DMAONERR 0x00000004
-#define BM_UARTDBGDMACR_TXDMAE 0x00000002
-#define BM_UARTDBGDMACR_RXDMAE 0x00000001
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h b/arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h
deleted file mode 100644
index 9145e22..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * stmp37xx: USBCTL register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_USBCTL_BASE	(STMP3XXX_REGS_BASE + 0x80000)
-#define REGS_USBCTL_PHYS	0x80000
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-usbctrl.h b/arch/arm/mach-stmp37xx/include/mach/regs-usbctrl.h
deleted file mode 100644
index 1a2ae9c..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-usbctrl.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * stmp37xx: USBCTRL register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_USBCTRL_BASE	(STMP3XXX_REGS_BASE + 0x80000)
-#define REGS_USBCTRL_PHYS	0x80080000
diff --git a/arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h b/arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h
deleted file mode 100644
index b7fce0f..0000000
--- a/arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * stmp37xx: USBPHY register definitions
- *
- * Copyright (c) 2008 Freescale Semiconductor
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#define REGS_USBPHY_BASE	(STMP3XXX_REGS_BASE + 0x7C000)
-
-#define HW_USBPHY_PWD		0x0
-
-#define HW_USBPHY_CTRL		0x30
-#define BM_USBPHY_CTRL_ENHSPRECHARGEXMIT	0x00000001
-#define BP_USBPHY_CTRL_ENHSPRECHARGEXMIT	0
-#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	0x00000002
-#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT	0x00000010
-#define BM_USBPHY_CTRL_ENOTGIDDETECT	0x00000080
-#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN	0x00000800
-#define BM_USBPHY_CTRL_CLKGATE	0x40000000
-#define BM_USBPHY_CTRL_SFTRST	0x80000000
-
-#define HW_USBPHY_STATUS	0x40
-#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS	0x00000040
-#define BM_USBPHY_STATUS_OTGID_STATUS	0x00000100
diff --git a/arch/arm/mach-stmp37xx/stmp37xx.c b/arch/arm/mach-stmp37xx/stmp37xx.c
deleted file mode 100644
index a9aed06..0000000
--- a/arch/arm/mach-stmp37xx/stmp37xx.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * Freescale STMP37XX platform support
- *
- * Embedded Alley Solutions, Inc <source@embeddedalley.com>
- *
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
-#include <asm/mach/map.h>
-#include <asm/mach/time.h>
-
-#include <mach/stmp3xxx.h>
-#include <mach/dma.h>
-
-#include <mach/platform.h>
-#include <mach/regs-icoll.h>
-#include <mach/regs-apbh.h>
-#include <mach/regs-apbx.h>
-#include "stmp37xx.h"
-
-/*
- * IRQ handling
- */
-static void stmp37xx_ack_irq(struct irq_data *d)
-{
-	/* Disable IRQ */
-	stmp3xxx_clearl(0x04 << ((d->irq % 4) * 8),
-		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + d->irq / 4 * 0x10);
-
-	/* ACK current interrupt */
-	__raw_writel(1, REGS_ICOLL_BASE + HW_ICOLL_LEVELACK);
-
-	/* Barrier */
-	(void)__raw_readl(REGS_ICOLL_BASE + HW_ICOLL_STAT);
-}
-
-static void stmp37xx_mask_irq(struct irq_data *d)
-{
-	/* IRQ disable */
-	stmp3xxx_clearl(0x04 << ((d->irq % 4) * 8),
-		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + d->irq / 4 * 0x10);
-}
-
-static void stmp37xx_unmask_irq(struct irq_data *d)
-{
-	/* IRQ enable */
-	stmp3xxx_setl(0x04 << ((d->irq % 4) * 8),
-		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + d->irq / 4 * 0x10);
-}
-
-static struct irq_chip stmp37xx_chip = {
-	.irq_ack	= stmp37xx_ack_irq,
-	.irq_mask	= stmp37xx_mask_irq,
-	.irq_unmask	= stmp37xx_unmask_irq,
-};
-
-void __init stmp37xx_init_irq(void)
-{
-	stmp3xxx_init_irq(&stmp37xx_chip);
-}
-
-/*
- * DMA interrupt handling
- */
-void stmp3xxx_arch_dma_enable_interrupt(int channel)
-{
-	switch (STMP3XXX_DMA_BUS(channel)) {
-	case STMP3XXX_BUS_APBH:
-		stmp3xxx_setl(1 << (8 + STMP3XXX_DMA_CHANNEL(channel)),
-			REGS_APBH_BASE + HW_APBH_CTRL1);
-		break;
-
-	case STMP3XXX_BUS_APBX:
-		stmp3xxx_setl(1 << (8 + STMP3XXX_DMA_CHANNEL(channel)),
-			REGS_APBX_BASE + HW_APBX_CTRL1);
-		break;
-	}
-}
-EXPORT_SYMBOL(stmp3xxx_arch_dma_enable_interrupt);
-
-void stmp3xxx_arch_dma_clear_interrupt(int channel)
-{
-	switch (STMP3XXX_DMA_BUS(channel)) {
-	case STMP3XXX_BUS_APBH:
-		stmp3xxx_clearl(1 << STMP3XXX_DMA_CHANNEL(channel),
-				REGS_APBH_BASE + HW_APBH_CTRL1);
-		break;
-
-	case STMP3XXX_BUS_APBX:
-		stmp3xxx_clearl(1 << STMP3XXX_DMA_CHANNEL(channel),
-				REGS_APBX_BASE + HW_APBX_CTRL1);
-		break;
-	}
-}
-EXPORT_SYMBOL(stmp3xxx_arch_dma_clear_interrupt);
-
-int stmp3xxx_arch_dma_is_interrupt(int channel)
-{
-	int r = 0;
-
-	switch (STMP3XXX_DMA_BUS(channel)) {
-	case STMP3XXX_BUS_APBH:
-		r = __raw_readl(REGS_APBH_BASE + HW_APBH_CTRL1) &
-			(1 << STMP3XXX_DMA_CHANNEL(channel));
-		break;
-
-	case STMP3XXX_BUS_APBX:
-		r = __raw_readl(REGS_APBH_BASE + HW_APBH_CTRL1) &
-			(1 << STMP3XXX_DMA_CHANNEL(channel));
-		break;
-	}
-	return r;
-}
-EXPORT_SYMBOL(stmp3xxx_arch_dma_is_interrupt);
-
-void stmp3xxx_arch_dma_reset_channel(int channel)
-{
-	unsigned chbit = 1 << STMP3XXX_DMA_CHANNEL(channel);
-
-	switch (STMP3XXX_DMA_BUS(channel)) {
-	case STMP3XXX_BUS_APBH:
-		/* Reset channel and wait for it to complete */
-		stmp3xxx_setl(chbit << BP_APBH_CTRL0_RESET_CHANNEL,
-			REGS_APBH_BASE + HW_APBH_CTRL0);
-		while (__raw_readl(REGS_APBH_BASE + HW_APBH_CTRL0) &
-		       (chbit << BP_APBH_CTRL0_RESET_CHANNEL))
-				cpu_relax();
-		break;
-
-	case STMP3XXX_BUS_APBX:
-		stmp3xxx_setl(chbit << BP_APBX_CTRL0_RESET_CHANNEL,
-			REGS_APBX_BASE + HW_APBX_CTRL0);
-		while (__raw_readl(REGS_APBX_BASE + HW_APBX_CTRL0) &
-		       (chbit << BP_APBX_CTRL0_RESET_CHANNEL))
-				cpu_relax();
-		break;
-	}
-}
-EXPORT_SYMBOL(stmp3xxx_arch_dma_reset_channel);
-
-void stmp3xxx_arch_dma_freeze(int channel)
-{
-	unsigned chbit = 1 << STMP3XXX_DMA_CHANNEL(channel);
-
-	switch (STMP3XXX_DMA_BUS(channel)) {
-	case STMP3XXX_BUS_APBH:
-		stmp3xxx_setl(1 << chbit, REGS_APBH_BASE + HW_APBH_CTRL0);
-		break;
-	case STMP3XXX_BUS_APBX:
-		stmp3xxx_setl(1 << chbit, REGS_APBH_BASE + HW_APBH_CTRL0);
-		break;
-	}
-}
-EXPORT_SYMBOL(stmp3xxx_arch_dma_freeze);
-
-void stmp3xxx_arch_dma_unfreeze(int channel)
-{
-	unsigned chbit = 1 << STMP3XXX_DMA_CHANNEL(channel);
-
-	switch (STMP3XXX_DMA_BUS(channel)) {
-	case STMP3XXX_BUS_APBH:
-		stmp3xxx_clearl(1 << chbit, REGS_APBH_BASE + HW_APBH_CTRL0);
-		break;
-	case STMP3XXX_BUS_APBX:
-		stmp3xxx_clearl(1 << chbit, REGS_APBH_BASE + HW_APBH_CTRL0);
-		break;
-	}
-}
-EXPORT_SYMBOL(stmp3xxx_arch_dma_unfreeze);
-
-/*
- * The registers are all very closely mapped, so we might as well map them all
- * with a single mapping
- *
- * Logical      Physical
- * f0000000	80000000	On-chip registers
- * f1000000	00000000	32k on-chip SRAM
- */
-static struct map_desc stmp37xx_io_desc[] __initdata = {
-	{
-		.virtual	= (u32)STMP3XXX_REGS_BASE,
-		.pfn		= __phys_to_pfn(STMP3XXX_REGS_PHBASE),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE
-	},
-	{
-		.virtual	= (u32)STMP3XXX_OCRAM_BASE,
-		.pfn		= __phys_to_pfn(STMP3XXX_OCRAM_PHBASE),
-		.length		= STMP3XXX_OCRAM_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
-void __init stmp37xx_map_io(void)
-{
-	iotable_init(stmp37xx_io_desc, ARRAY_SIZE(stmp37xx_io_desc));
-}
diff --git a/arch/arm/mach-stmp37xx/stmp37xx.h b/arch/arm/mach-stmp37xx/stmp37xx.h
deleted file mode 100644
index 0b75fb7..0000000
--- a/arch/arm/mach-stmp37xx/stmp37xx.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Freescale STMP37XX/STMP378X internal functions and data declarations
- *
- * Embedded Alley Solutions, Inc <source@embeddedalley.com>
- *
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#ifndef __MACH_STMP37XX_H
-#define __MACH_STMP37XX_H
-
-void stmp37xx_map_io(void);
-void stmp37xx_init_irq(void);
-
-#endif /* __MACH_STMP37XX_H */
diff --git a/arch/arm/mach-stmp37xx/stmp37xx_devb.c b/arch/arm/mach-stmp37xx/stmp37xx_devb.c
deleted file mode 100644
index 311d855..0000000
--- a/arch/arm/mach-stmp37xx/stmp37xx_devb.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * Freescale STMP37XX development board support
- *
- * Embedded Alley Solutions, Inc <source@embeddedalley.com>
- *
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
- */
-
-/*
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include <mach/stmp3xxx.h>
-#include <mach/pins.h>
-#include <mach/pinmux.h>
-#include "stmp37xx.h"
-
-/*
- * List of STMP37xx development board specific devices
- */
-static struct platform_device *stmp37xx_devb_devices[] = {
-	&stmp3xxx_dbguart,
-	&stmp3xxx_appuart,
-};
-
-static struct pin_desc dbguart_pins_0[] = {
-	{ PINID_PWM0, PIN_FUN3, },
-	{ PINID_PWM1, PIN_FUN3, },
-};
-
-struct pin_desc appuart_pins_0[] = {
-	{ PINID_UART2_CTS, PIN_FUN1, PIN_4MA, PIN_1_8V, 0, },
-	{ PINID_UART2_RTS, PIN_FUN1, PIN_4MA, PIN_1_8V, 0, },
-	{ PINID_UART2_RX, PIN_FUN1, PIN_4MA, PIN_1_8V, 0, },
-	{ PINID_UART2_TX, PIN_FUN1, PIN_4MA, PIN_1_8V, 0, },
-};
-
-static struct pin_group appuart_pins[] = {
-	[0] = {
-		.pins		= appuart_pins_0,
-		.nr_pins	= ARRAY_SIZE(appuart_pins_0),
-	},
-	/* 37xx has the only app uart */
-};
-
-static struct pin_group dbguart_pins[] = {
-	[0] = {
-		.pins		= dbguart_pins_0,
-		.nr_pins	= ARRAY_SIZE(dbguart_pins_0),
-	},
-};
-
-static int dbguart_pins_control(int id, int request)
-{
-	int r = 0;
-
-	if (request)
-		r = stmp3xxx_request_pin_group(&dbguart_pins[id], "debug uart");
-	else
-		stmp3xxx_release_pin_group(&dbguart_pins[id], "debug uart");
-	return r;
-}
-
-
-static void __init stmp37xx_devb_init(void)
-{
-	stmp3xxx_pinmux_init(NR_REAL_IRQS);
-
-	/* Init STMP3xxx platform */
-	stmp3xxx_init();
-
-	stmp3xxx_dbguart.dev.platform_data = dbguart_pins_control;
-	stmp3xxx_appuart.dev.platform_data = appuart_pins;
-
-	/* Add STMP37xx development board devices */
-	platform_add_devices(stmp37xx_devb_devices,
-			ARRAY_SIZE(stmp37xx_devb_devices));
-}
-
-MACHINE_START(STMP37XX, "STMP37XX")
-	.boot_params	= 0x40000100,
-	.map_io		= stmp37xx_map_io,
-	.init_irq	= stmp37xx_init_irq,
-	.timer		= &stmp3xxx_timer,
-	.init_machine	= stmp37xx_devb_init,
-MACHINE_END
diff --git a/arch/arm/plat-stmp3xxx/Kconfig b/arch/arm/plat-stmp3xxx/Kconfig
index 2cf37c3..dcdbe32 100644
--- a/arch/arm/plat-stmp3xxx/Kconfig
+++ b/arch/arm/plat-stmp3xxx/Kconfig
@@ -5,12 +5,6 @@ menu "Freescale STMP3xxx implementations"
 choice
 	prompt "Select STMP3xxx chip family"
 
-config ARCH_STMP37XX
-	bool "Freescale SMTP37xx"
-	select CPU_ARM926T
-	---help---
-	 STMP37xx refers to 3700 through 3769 chips
-
 config ARCH_STMP378X
 	bool "Freescale STMP378x"
 	select CPU_ARM926T
@@ -22,10 +16,6 @@ endchoice
 choice
 	prompt "Select STMP3xxx board type"
 
-config MACH_STMP37XX
-	depends on ARCH_STMP37XX
-	bool "Freescale STMP37xx development board"
-
 config MACH_STMP378X
 	depends on ARCH_STMP378X
 	bool "Freescale STMP378x development board"
-- 
1.7.2.5

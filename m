From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 26 Jan 2012 14:07:09 +0100
Subject: [PATCH] ARM: at91: removal of CAP9 SoC family
Message-ID: <1327583229-20942-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel CAP9 family is not maintained well and products may be
difficult to find now. It will allow to save workforce and
remove LOC during current cleanup process.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/feature-removal-schedule.txt        |   14 -
 arch/arm/Kconfig                                  |    2 +-
 arch/arm/Kconfig.debug                            |    2 +-
 arch/arm/configs/at91cap9_defconfig               |  108 --
 arch/arm/mach-at91/Kconfig                        |   26 +-
 arch/arm/mach-at91/Makefile                       |    4 -
 arch/arm/mach-at91/Makefile.boot                  |    6 +-
 arch/arm/mach-at91/at91cap9.c                     |  396 -------
 arch/arm/mach-at91/at91cap9_devices.c             | 1273 ---------------------
 arch/arm/mach-at91/board-cap9adk.c                |  396 -------
 arch/arm/mach-at91/clock.c                        |    5 +-
 arch/arm/mach-at91/generic.h                      |    1 -
 arch/arm/mach-at91/include/mach/at91_pmc.h        |   16 +-
 arch/arm/mach-at91/include/mach/at91cap9.h        |  122 --
 arch/arm/mach-at91/include/mach/at91cap9_matrix.h |  137 ---
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |   10 -
 arch/arm/mach-at91/include/mach/cpu.h             |   21 -
 arch/arm/mach-at91/include/mach/hardware.h        |    4 +-
 arch/arm/mach-at91/pm.c                           |    5 -
 arch/arm/mach-at91/pm.h                           |   18 -
 arch/arm/mach-at91/pm_slowclock.S                 |   12 +-
 arch/arm/mach-at91/setup.c                        |   17 -
 arch/arm/mach-at91/soc.h                          |    5 -
 arch/avr32/mach-at32ap/include/mach/cpu.h         |    3 -
 drivers/mmc/host/at91_mci.c                       |    1 -
 drivers/usb/gadget/Kconfig                        |    4 +-
 26 files changed, 18 insertions(+), 2590 deletions(-)
 delete mode 100644 arch/arm/configs/at91cap9_defconfig
 delete mode 100644 arch/arm/mach-at91/at91cap9.c
 delete mode 100644 arch/arm/mach-at91/at91cap9_devices.c
 delete mode 100644 arch/arm/mach-at91/board-cap9adk.c
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91cap9_matrix.h

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index a0ffac0..1bea46a 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -510,17 +510,3 @@ Why:	The pci_scan_bus_parented() interface creates a new root bus.  The
 	convert to using pci_scan_root_bus() so they can supply a list of
 	bus resources when the bus is created.
 Who:	Bjorn Helgaas <bhelgaas@google.com>
-
-----------------------------
-
-What:	The CAP9 SoC family will be removed
-When:	3.4
-Files:	arch/arm/mach-at91/at91cap9.c
-	arch/arm/mach-at91/at91cap9_devices.c
-	arch/arm/mach-at91/include/mach/at91cap9.h
-	arch/arm/mach-at91/include/mach/at91cap9_matrix.h
-	arch/arm/mach-at91/include/mach/at91cap9_ddrsdr.h
-	arch/arm/mach-at91/board-cap9adk.c
-Why:	The code is not actively maintained and platforms are now hard to find.
-Who:	Nicolas Ferre <nicolas.ferre@atmel.com>
-	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b0d8c6a..c0a13aa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -325,7 +325,7 @@ config ARCH_AT91
 	select IRQ_DOMAIN
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
-	  AT91SAM9 and AT91CAP9 processors.
+	  AT91SAM9 processors.
 
 config ARCH_BCMRING
 	bool "Broadcom BCMRING"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0d236d..d0a9118 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -105,7 +105,7 @@ choice
 		depends on HAVE_AT91_DBGU0
 
 	config AT91_DEBUG_LL_DBGU1
-		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
+		bool "Kernel low-level debugging on 9263 and 9g45"
 		depends on HAVE_AT91_DBGU1
 
 	config DEBUG_FOOTBRIDGE_COM1
diff --git a/arch/arm/configs/at91cap9_defconfig b/arch/arm/configs/at91cap9_defconfig
deleted file mode 100644
index 8826eb2..0000000
--- a/arch/arm/configs/at91cap9_defconfig
+++ /dev/null
@@ -1,108 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-# CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
-CONFIG_ARCH_AT91CAP9=y
-CONFIG_MACH_AT91CAP9ADK=y
-CONFIG_MTD_AT91_DATAFLASH_CARD=y
-CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_AEABI=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/ram0 rw"
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_ATMEL=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
-CONFIG_NETDEVICES=y
-CONFIG_MII=y
-CONFIG_MACB=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_TOUCHSCREEN_ADS7846=y
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_ATMEL=y
-CONFIG_SERIAL_ATMEL_CONSOLE=y
-CONFIG_HW_RANDOM=y
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_SPI=y
-CONFIG_SPI_ATMEL=y
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_NOWAYOUT=y
-CONFIG_FB=y
-CONFIG_FB_ATMEL=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_CLUT224 is not set
-# CONFIG_USB_HID is not set
-CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_MON=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_ETH=m
-CONFIG_USB_FILE_STORAGE=m
-CONFIG_MMC=y
-CONFIG_MMC_AT91=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_AT91SAM9=y
-CONFIG_EXT2_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index f7fdd17..aca2d69 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -111,15 +111,6 @@ config ARCH_AT91SAM9X5
 	select HAVE_AT91_DBGU0
 	select AT91_SAM9G45_RESET
 
-config ARCH_AT91CAP9
-	bool "AT91CAP9"
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select HAVE_FB_ATMEL
-	select HAVE_NET_MACB
-	select HAVE_AT91_DBGU1
-	select AT91_SAM9G45_RESET
-
 config ARCH_AT91X40
 	bool "AT91x40"
 	select ARCH_USES_GETTIMEOFFSET
@@ -456,21 +447,6 @@ endif
 
 # ----------------------------------------------------------
 
-if ARCH_AT91CAP9
-
-comment "AT91CAP9 Board Type"
-
-config MACH_AT91CAP9ADK
-	bool "Atmel AT91CAP9A-DK Evaluation Kit"
-	select HAVE_AT91_DATAFLASH_CARD
-	help
-	  Select this if you are using Atmel's AT91CAP9A-DK Evaluation Kit.
-	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4138>
-
-endif
-
-# ----------------------------------------------------------
-
 if ARCH_AT91X40
 
 comment "AT91X40 Board Type"
@@ -553,7 +529,7 @@ config AT91_EARLY_DBGU0
 	depends on HAVE_AT91_DBGU0
 
 config AT91_EARLY_DBGU1
-	bool "DBGU on 9263, 9g45 and cap9"
+	bool "DBGU on 9263 and 9g45"
 	depends on HAVE_AT91_DBGU1
 
 config AT91_EARLY_USART0
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 7b7ab6e..1b65185 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devi
 obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91SAM9X5)	+= at91sam9x5.o at91sam926x_time.o
-obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
 obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 
 # AT91RM9200 board-specific support
@@ -82,9 +81,6 @@ obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 # AT91SAM board with device-tree
 obj-$(CONFIG_MACH_AT91SAM_DT) += board-dt.o
 
-# AT91CAP9 board-specific support
-obj-$(CONFIG_MACH_AT91CAP9ADK)	+= board-cap9adk.o
-
 # AT91X40 board-specific support
 obj-$(CONFIG_MACH_AT91EB01)	+= board-eb01.o
 
diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 8ddafad..2fd051e 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -3,11 +3,7 @@
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
 
-ifeq ($(CONFIG_ARCH_AT91CAP9),y)
-   zreladdr-y	+= 0x70008000
-params_phys-y	:= 0x70000100
-initrd_phys-y	:= 0x70410000
-else ifeq ($(CONFIG_ARCH_AT91SAM9G45),y)
+ifeq ($(CONFIG_ARCH_AT91SAM9G45),y)
    zreladdr-y	+= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70410000
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
deleted file mode 100644
index a42edc2..0000000
--- a/arch/arm/mach-at91/at91cap9.c
+++ /dev/null
@@ -1,396 +0,0 @@
-/*
- * arch/arm/mach-at91/at91cap9.c
- *
- *  Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
- *  Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
- *  Copyright (C) 2007 Atmel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#include <linux/module.h>
-
-#include <asm/irq.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/cpu.h>
-#include <mach/at91cap9.h>
-#include <mach/at91_pmc.h>
-
-#include "soc.h"
-#include "generic.h"
-#include "clock.h"
-#include "sam9_smc.h"
-
-/* --------------------------------------------------------------------
- *  Clocks
- * -------------------------------------------------------------------- */
-
-/*
- * The peripheral clocks.
- */
-static struct clk pioABCD_clk = {
-	.name		= "pioABCD_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_PIOABCD,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mpb0_clk = {
-	.name		= "mpb0_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MPB0,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mpb1_clk = {
-	.name		= "mpb1_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MPB1,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mpb2_clk = {
-	.name		= "mpb2_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MPB2,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mpb3_clk = {
-	.name		= "mpb3_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MPB3,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mpb4_clk = {
-	.name		= "mpb4_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MPB4,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk usart0_clk = {
-	.name		= "usart0_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_US0,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk usart1_clk = {
-	.name		= "usart1_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_US1,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk usart2_clk = {
-	.name		= "usart2_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_US2,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mmc0_clk = {
-	.name		= "mci0_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MCI0,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk mmc1_clk = {
-	.name		= "mci1_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_MCI1,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk can_clk = {
-	.name		= "can_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_CAN,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk twi_clk = {
-	.name		= "twi_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_TWI,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk spi0_clk = {
-	.name		= "spi0_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_SPI0,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk spi1_clk = {
-	.name		= "spi1_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_SPI1,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk ssc0_clk = {
-	.name		= "ssc0_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_SSC0,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk ssc1_clk = {
-	.name		= "ssc1_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_SSC1,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk ac97_clk = {
-	.name		= "ac97_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_AC97C,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk tcb_clk = {
-	.name		= "tcb_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_TCB,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk pwm_clk = {
-	.name		= "pwm_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_PWMC,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk macb_clk = {
-	.name		= "pclk",
-	.pmc_mask	= 1 << AT91CAP9_ID_EMAC,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk aestdes_clk = {
-	.name		= "aestdes_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_AESTDES,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk adc_clk = {
-	.name		= "adc_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_ADC,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk isi_clk = {
-	.name		= "isi_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_ISI,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk lcdc_clk = {
-	.name		= "lcdc_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_LCDC,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk dma_clk = {
-	.name		= "dma_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_DMA,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk udphs_clk = {
-	.name		= "udphs_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_UDPHS,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-static struct clk ohci_clk = {
-	.name		= "ohci_clk",
-	.pmc_mask	= 1 << AT91CAP9_ID_UHP,
-	.type		= CLK_TYPE_PERIPHERAL,
-};
-
-static struct clk *periph_clocks[] __initdata = {
-	&pioABCD_clk,
-	&mpb0_clk,
-	&mpb1_clk,
-	&mpb2_clk,
-	&mpb3_clk,
-	&mpb4_clk,
-	&usart0_clk,
-	&usart1_clk,
-	&usart2_clk,
-	&mmc0_clk,
-	&mmc1_clk,
-	&can_clk,
-	&twi_clk,
-	&spi0_clk,
-	&spi1_clk,
-	&ssc0_clk,
-	&ssc1_clk,
-	&ac97_clk,
-	&tcb_clk,
-	&pwm_clk,
-	&macb_clk,
-	&aestdes_clk,
-	&adc_clk,
-	&isi_clk,
-	&lcdc_clk,
-	&dma_clk,
-	&udphs_clk,
-	&ohci_clk,
-	// irq0 .. irq1
-};
-
-static struct clk_lookup periph_clocks_lookups[] = {
-	/* One additional fake clock for macb_hclk */
-	CLKDEV_CON_ID("hclk", &macb_clk),
-	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc", &utmi_clk),
-	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc", &udphs_clk),
-	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
-	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
-	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
-	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
-	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
-	/* fake hclk clock */
-	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
-	CLKDEV_CON_ID("pioA", &pioABCD_clk),
-	CLKDEV_CON_ID("pioB", &pioABCD_clk),
-	CLKDEV_CON_ID("pioC", &pioABCD_clk),
-	CLKDEV_CON_ID("pioD", &pioABCD_clk),
-};
-
-static struct clk_lookup usart_clocks_lookups[] = {
-	CLKDEV_CON_DEV_ID("usart", "atmel_usart.0", &mck),
-	CLKDEV_CON_DEV_ID("usart", "atmel_usart.1", &usart0_clk),
-	CLKDEV_CON_DEV_ID("usart", "atmel_usart.2", &usart1_clk),
-	CLKDEV_CON_DEV_ID("usart", "atmel_usart.3", &usart2_clk),
-};
-
-/*
- * The four programmable clocks.
- * You must configure pin multiplexing to bring these signals out.
- */
-static struct clk pck0 = {
-	.name		= "pck0",
-	.pmc_mask	= AT91_PMC_PCK0,
-	.type		= CLK_TYPE_PROGRAMMABLE,
-	.id		= 0,
-};
-static struct clk pck1 = {
-	.name		= "pck1",
-	.pmc_mask	= AT91_PMC_PCK1,
-	.type		= CLK_TYPE_PROGRAMMABLE,
-	.id		= 1,
-};
-static struct clk pck2 = {
-	.name		= "pck2",
-	.pmc_mask	= AT91_PMC_PCK2,
-	.type		= CLK_TYPE_PROGRAMMABLE,
-	.id		= 2,
-};
-static struct clk pck3 = {
-	.name		= "pck3",
-	.pmc_mask	= AT91_PMC_PCK3,
-	.type		= CLK_TYPE_PROGRAMMABLE,
-	.id		= 3,
-};
-
-static void __init at91cap9_register_clocks(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
-		clk_register(periph_clocks[i]);
-
-	clkdev_add_table(periph_clocks_lookups,
-			 ARRAY_SIZE(periph_clocks_lookups));
-	clkdev_add_table(usart_clocks_lookups,
-			 ARRAY_SIZE(usart_clocks_lookups));
-
-	clk_register(&pck0);
-	clk_register(&pck1);
-	clk_register(&pck2);
-	clk_register(&pck3);
-}
-
-static struct clk_lookup console_clock_lookup;
-
-void __init at91cap9_set_console_clock(int id)
-{
-	if (id >= ARRAY_SIZE(usart_clocks_lookups))
-		return;
-
-	console_clock_lookup.con_id = "usart";
-	console_clock_lookup.clk = usart_clocks_lookups[id].clk;
-	clkdev_add(&console_clock_lookup);
-}
-
-/* --------------------------------------------------------------------
- *  GPIO
- * -------------------------------------------------------------------- */
-
-static struct at91_gpio_bank at91cap9_gpio[] __initdata = {
-	{
-		.id		= AT91CAP9_ID_PIOABCD,
-		.regbase	= AT91CAP9_BASE_PIOA,
-	}, {
-		.id		= AT91CAP9_ID_PIOABCD,
-		.regbase	= AT91CAP9_BASE_PIOB,
-	}, {
-		.id		= AT91CAP9_ID_PIOABCD,
-		.regbase	= AT91CAP9_BASE_PIOC,
-	}, {
-		.id		= AT91CAP9_ID_PIOABCD,
-		.regbase	= AT91CAP9_BASE_PIOD,
-	}
-};
-
-/* --------------------------------------------------------------------
- *  AT91CAP9 processor initialization
- * -------------------------------------------------------------------- */
-
-static void __init at91cap9_map_io(void)
-{
-	at91_init_sram(0, AT91CAP9_SRAM_BASE, AT91CAP9_SRAM_SIZE);
-}
-
-static void __init at91cap9_ioremap_registers(void)
-{
-	at91_ioremap_shdwc(AT91CAP9_BASE_SHDWC);
-	at91_ioremap_rstc(AT91CAP9_BASE_RSTC);
-	at91sam926x_ioremap_pit(AT91CAP9_BASE_PIT);
-	at91sam9_ioremap_smc(0, AT91CAP9_BASE_SMC);
-}
-
-static void __init at91cap9_initialize(void)
-{
-	arm_pm_restart = at91sam9g45_restart;
-	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
-
-	/* Register GPIO subsystem */
-	at91_gpio_init(at91cap9_gpio, 4);
-
-	/* Remember the silicon revision */
-	if (cpu_is_at91cap9_revB())
-		system_rev = 0xB;
-	else if (cpu_is_at91cap9_revC())
-		system_rev = 0xC;
-}
-
-/* --------------------------------------------------------------------
- *  Interrupt initialization
- * -------------------------------------------------------------------- */
-
-/*
- * The default interrupt priority levels (0 = lowest, 7 = highest).
- */
-static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
-	7,	/* Advanced Interrupt Controller (FIQ) */
-	7,	/* System Peripherals */
-	1,	/* Parallel IO Controller A, B, C and D */
-	0,	/* MP Block Peripheral 0 */
-	0,	/* MP Block Peripheral 1 */
-	0,	/* MP Block Peripheral 2 */
-	0,	/* MP Block Peripheral 3 */
-	0,	/* MP Block Peripheral 4 */
-	5,	/* USART 0 */
-	5,	/* USART 1 */
-	5,	/* USART 2 */
-	0,	/* Multimedia Card Interface 0 */
-	0,	/* Multimedia Card Interface 1 */
-	3,	/* CAN */
-	6,	/* Two-Wire Interface */
-	5,	/* Serial Peripheral Interface 0 */
-	5,	/* Serial Peripheral Interface 1 */
-	4,	/* Serial Synchronous Controller 0 */
-	4,	/* Serial Synchronous Controller 1 */
-	5,	/* AC97 Controller */
-	0,	/* Timer Counter 0, 1 and 2 */
-	0,	/* Pulse Width Modulation Controller */
-	3,	/* Ethernet */
-	0,	/* Advanced Encryption Standard, Triple DES*/
-	0,	/* Analog-to-Digital Converter */
-	0,	/* Image Sensor Interface */
-	3,	/* LCD Controller */
-	0,	/* DMA Controller */
-	2,	/* USB Device Port */
-	2,	/* USB Host port */
-	0,	/* Advanced Interrupt Controller (IRQ0) */
-	0,	/* Advanced Interrupt Controller (IRQ1) */
-};
-
-struct at91_init_soc __initdata at91cap9_soc = {
-	.map_io = at91cap9_map_io,
-	.default_irq_priority = at91cap9_default_irq_priority,
-	.ioremap_registers = at91cap9_ioremap_registers,
-	.register_clocks = at91cap9_register_clocks,
-	.init = at91cap9_initialize,
-};
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
deleted file mode 100644
index d298fb7..0000000
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ /dev/null
@@ -1,1273 +0,0 @@
-/*
- * arch/arm/mach-at91/at91cap9_devices.c
- *
- *  Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
- *  Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
- *  Copyright (C) 2007 Atmel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/i2c-gpio.h>
-
-#include <video/atmel_lcdc.h>
-
-#include <mach/board.h>
-#include <mach/cpu.h>
-#include <mach/at91cap9.h>
-#include <mach/at91cap9_matrix.h>
-#include <mach/at91sam9_smc.h>
-
-#include "generic.h"
-
-
-/* --------------------------------------------------------------------
- *  USB Host
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-static struct at91_usbh_data usbh_data;
-
-static struct resource usbh_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_UHP_BASE,
-		.end	= AT91CAP9_UHP_BASE + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_UHP,
-		.end	= AT91CAP9_ID_UHP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_usbh_device = {
-	.name		= "at91_ohci",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &ohci_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &usbh_data,
-	},
-	.resource	= usbh_resources,
-	.num_resources	= ARRAY_SIZE(usbh_resources),
-};
-
-void __init at91_add_device_usbh(struct at91_usbh_data *data)
-{
-	int i;
-
-	if (!data)
-		return;
-
-	if (cpu_is_at91cap9_revB())
-		irq_set_irq_type(AT91CAP9_ID_UHP, IRQ_TYPE_LEVEL_HIGH);
-
-	/* Enable VBus control for UHP ports */
-	for (i = 0; i < data->ports; i++) {
-		if (gpio_is_valid(data->vbus_pin[i]))
-			at91_set_gpio_output(data->vbus_pin[i], 0);
-	}
-
-	/* Enable overcurrent notification */
-	for (i = 0; i < data->ports; i++) {
-		if (data->overcurrent_pin[i])
-			at91_set_gpio_input(data->overcurrent_pin[i], 1);
-	}
-
-	usbh_data = *data;
-	platform_device_register(&at91_usbh_device);
-}
-#else
-void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  USB HS Device (Gadget)
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_USB_ATMEL_USBA) || defined(CONFIG_USB_ATMEL_USBA_MODULE)
-
-static struct resource usba_udc_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_UDPHS_FIFO,
-		.end	= AT91CAP9_UDPHS_FIFO + SZ_512K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_BASE_UDPHS,
-		.end	= AT91CAP9_BASE_UDPHS + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= AT91CAP9_ID_UDPHS,
-		.end	= AT91CAP9_ID_UDPHS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-#define EP(nam, idx, maxpkt, maxbk, dma, isoc)			\
-	[idx] = {						\
-		.name		= nam,				\
-		.index		= idx,				\
-		.fifo_size	= maxpkt,			\
-		.nr_banks	= maxbk,			\
-		.can_dma	= dma,				\
-		.can_isoc	= isoc,				\
-	}
-
-static struct usba_ep_data usba_udc_ep[] = {
-	EP("ep0", 0,   64, 1, 0, 0),
-	EP("ep1", 1, 1024, 3, 1, 1),
-	EP("ep2", 2, 1024, 3, 1, 1),
-	EP("ep3", 3, 1024, 2, 1, 1),
-	EP("ep4", 4, 1024, 2, 1, 1),
-	EP("ep5", 5, 1024, 2, 1, 0),
-	EP("ep6", 6, 1024, 2, 1, 0),
-	EP("ep7", 7, 1024, 2, 0, 0),
-};
-
-#undef EP
-
-/*
- * pdata doesn't have room for any endpoints, so we need to
- * append room for the ones we need right after it.
- */
-static struct {
-	struct usba_platform_data pdata;
-	struct usba_ep_data ep[8];
-} usba_udc_data;
-
-static struct platform_device at91_usba_udc_device = {
-	.name		= "atmel_usba_udc",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &usba_udc_data.pdata,
-	},
-	.resource	= usba_udc_resources,
-	.num_resources	= ARRAY_SIZE(usba_udc_resources),
-};
-
-void __init at91_add_device_usba(struct usba_platform_data *data)
-{
-	if (cpu_is_at91cap9_revB()) {
-		irq_set_irq_type(AT91CAP9_ID_UDPHS, IRQ_TYPE_LEVEL_HIGH);
-		at91_sys_write(AT91_MATRIX_UDPHS, AT91_MATRIX_SELECT_UDPHS |
-						  AT91_MATRIX_UDPHS_BYPASS_LOCK);
-	}
-	else
-		at91_sys_write(AT91_MATRIX_UDPHS, AT91_MATRIX_SELECT_UDPHS);
-
-	/*
-	 * Invalid pins are 0 on AT91, but the usba driver is shared
-	 * with AVR32, which use negative values instead. Once/if
-	 * gpio_is_valid() is ported to AT91, revisit this code.
-	 */
-	usba_udc_data.pdata.vbus_pin = -EINVAL;
-	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
-
-	if (data && gpio_is_valid(data->vbus_pin)) {
-		at91_set_gpio_input(data->vbus_pin, 0);
-		at91_set_deglitch(data->vbus_pin, 1);
-		usba_udc_data.pdata.vbus_pin = data->vbus_pin;
-	}
-
-	/* Pullup pin is handled internally by USB device peripheral */
-
-	platform_device_register(&at91_usba_udc_device);
-}
-#else
-void __init at91_add_device_usba(struct usba_platform_data *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  Ethernet
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
-static u64 eth_dmamask = DMA_BIT_MASK(32);
-static struct macb_platform_data eth_data;
-
-static struct resource eth_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_EMAC,
-		.end	= AT91CAP9_BASE_EMAC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_EMAC,
-		.end	= AT91CAP9_ID_EMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_eth_device = {
-	.name		= "macb",
-	.id		= -1,
-	.dev		= {
-				.dma_mask		= &eth_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &eth_data,
-	},
-	.resource	= eth_resources,
-	.num_resources	= ARRAY_SIZE(eth_resources),
-};
-
-void __init at91_add_device_eth(struct macb_platform_data *data)
-{
-	if (!data)
-		return;
-
-	if (gpio_is_valid(data->phy_irq_pin)) {
-		at91_set_gpio_input(data->phy_irq_pin, 0);
-		at91_set_deglitch(data->phy_irq_pin, 1);
-	}
-
-	/* Pins used for MII and RMII */
-	at91_set_A_periph(AT91_PIN_PB21, 0);	/* ETXCK_EREFCK */
-	at91_set_A_periph(AT91_PIN_PB22, 0);	/* ERXDV */
-	at91_set_A_periph(AT91_PIN_PB25, 0);	/* ERX0 */
-	at91_set_A_periph(AT91_PIN_PB26, 0);	/* ERX1 */
-	at91_set_A_periph(AT91_PIN_PB27, 0);	/* ERXER */
-	at91_set_A_periph(AT91_PIN_PB28, 0);	/* ETXEN */
-	at91_set_A_periph(AT91_PIN_PB23, 0);	/* ETX0 */
-	at91_set_A_periph(AT91_PIN_PB24, 0);	/* ETX1 */
-	at91_set_A_periph(AT91_PIN_PB30, 0);	/* EMDIO */
-	at91_set_A_periph(AT91_PIN_PB29, 0);	/* EMDC */
-
-	if (!data->is_rmii) {
-		at91_set_B_periph(AT91_PIN_PC25, 0);	/* ECRS */
-		at91_set_B_periph(AT91_PIN_PC26, 0);	/* ECOL */
-		at91_set_B_periph(AT91_PIN_PC22, 0);	/* ERX2 */
-		at91_set_B_periph(AT91_PIN_PC23, 0);	/* ERX3 */
-		at91_set_B_periph(AT91_PIN_PC27, 0);	/* ERXCK */
-		at91_set_B_periph(AT91_PIN_PC20, 0);	/* ETX2 */
-		at91_set_B_periph(AT91_PIN_PC21, 0);	/* ETX3 */
-		at91_set_B_periph(AT91_PIN_PC24, 0);	/* ETXER */
-	}
-
-	eth_data = *data;
-	platform_device_register(&at91cap9_eth_device);
-}
-#else
-void __init at91_add_device_eth(struct macb_platform_data *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  MMC / SD
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
-static u64 mmc_dmamask = DMA_BIT_MASK(32);
-static struct at91_mmc_data mmc0_data, mmc1_data;
-
-static struct resource mmc0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_MCI0,
-		.end	= AT91CAP9_BASE_MCI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_MCI0,
-		.end	= AT91CAP9_ID_MCI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_mmc0_device = {
-	.name		= "at91_mci",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc0_data,
-	},
-	.resource	= mmc0_resources,
-	.num_resources	= ARRAY_SIZE(mmc0_resources),
-};
-
-static struct resource mmc1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_MCI1,
-		.end	= AT91CAP9_BASE_MCI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_MCI1,
-		.end	= AT91CAP9_ID_MCI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_mmc1_device = {
-	.name		= "at91_mci",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &mmc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &mmc1_data,
-	},
-	.resource	= mmc1_resources,
-	.num_resources	= ARRAY_SIZE(mmc1_resources),
-};
-
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
-{
-	if (!data)
-		return;
-
-	/* input/irq */
-	if (gpio_is_valid(data->det_pin)) {
-		at91_set_gpio_input(data->det_pin, 1);
-		at91_set_deglitch(data->det_pin, 1);
-	}
-	if (gpio_is_valid(data->wp_pin))
-		at91_set_gpio_input(data->wp_pin, 1);
-	if (gpio_is_valid(data->vcc_pin))
-		at91_set_gpio_output(data->vcc_pin, 0);
-
-	if (mmc_id == 0) {		/* MCI0 */
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA2, 0);
-
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA1, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_A_periph(AT91_PIN_PA0, 1);
-		if (data->wire4) {
-			at91_set_A_periph(AT91_PIN_PA3, 1);
-			at91_set_A_periph(AT91_PIN_PA4, 1);
-			at91_set_A_periph(AT91_PIN_PA5, 1);
-		}
-
-		mmc0_data = *data;
-		platform_device_register(&at91cap9_mmc0_device);
-	} else {			/* MCI1 */
-		/* CLK */
-		at91_set_A_periph(AT91_PIN_PA16, 0);
-
-		/* CMD */
-		at91_set_A_periph(AT91_PIN_PA17, 1);
-
-		/* DAT0, maybe DAT1..DAT3 */
-		at91_set_A_periph(AT91_PIN_PA18, 1);
-		if (data->wire4) {
-			at91_set_A_periph(AT91_PIN_PA19, 1);
-			at91_set_A_periph(AT91_PIN_PA20, 1);
-			at91_set_A_periph(AT91_PIN_PA21, 1);
-		}
-
-		mmc1_data = *data;
-		platform_device_register(&at91cap9_mmc1_device);
-	}
-}
-#else
-void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  NAND / SmartMedia
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_MTD_NAND_ATMEL) || defined(CONFIG_MTD_NAND_ATMEL_MODULE)
-static struct atmel_nand_data nand_data;
-
-#define NAND_BASE	AT91_CHIPSELECT_3
-
-static struct resource nand_resources[] = {
-	[0] = {
-		.start	= NAND_BASE,
-		.end	= NAND_BASE + SZ_256M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_BASE_ECC,
-		.end	= AT91CAP9_BASE_ECC + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91cap9_nand_device = {
-	.name		= "atmel_nand",
-	.id		= -1,
-	.dev		= {
-				.platform_data	= &nand_data,
-	},
-	.resource	= nand_resources,
-	.num_resources	= ARRAY_SIZE(nand_resources),
-};
-
-void __init at91_add_device_nand(struct atmel_nand_data *data)
-{
-	unsigned long csa;
-
-	if (!data)
-		return;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA);
-
-	/* enable pin */
-	if (gpio_is_valid(data->enable_pin))
-		at91_set_gpio_output(data->enable_pin, 1);
-
-	/* ready/busy pin */
-	if (gpio_is_valid(data->rdy_pin))
-		at91_set_gpio_input(data->rdy_pin, 1);
-
-	/* card detect pin */
-	if (gpio_is_valid(data->det_pin))
-		at91_set_gpio_input(data->det_pin, 1);
-
-	nand_data = *data;
-	platform_device_register(&at91cap9_nand_device);
-}
-#else
-void __init at91_add_device_nand(struct atmel_nand_data *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  TWI (i2c)
- * -------------------------------------------------------------------- */
-
-/*
- * Prefer the GPIO code since the TWI controller isn't robust
- * (gets overruns and underruns under load) and can only issue
- * repeated STARTs in one scenario (the driver doesn't yet handle them).
- */
-#if defined(CONFIG_I2C_GPIO) || defined(CONFIG_I2C_GPIO_MODULE)
-
-static struct i2c_gpio_platform_data pdata = {
-	.sda_pin		= AT91_PIN_PB4,
-	.sda_is_open_drain	= 1,
-	.scl_pin		= AT91_PIN_PB5,
-	.scl_is_open_drain	= 1,
-	.udelay			= 2,		/* ~100 kHz */
-};
-
-static struct platform_device at91cap9_twi_device = {
-	.name			= "i2c-gpio",
-	.id			= -1,
-	.dev.platform_data	= &pdata,
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	at91_set_GPIO_periph(AT91_PIN_PB4, 1);		/* TWD (SDA) */
-	at91_set_multi_drive(AT91_PIN_PB4, 1);
-
-	at91_set_GPIO_periph(AT91_PIN_PB5, 1);		/* TWCK (SCL) */
-	at91_set_multi_drive(AT91_PIN_PB5, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91cap9_twi_device);
-}
-
-#elif defined(CONFIG_I2C_AT91) || defined(CONFIG_I2C_AT91_MODULE)
-
-static struct resource twi_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_TWI,
-		.end	= AT91CAP9_BASE_TWI + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_TWI,
-		.end	= AT91CAP9_ID_TWI,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_twi_device = {
-	.name		= "at91_i2c",
-	.id		= -1,
-	.resource	= twi_resources,
-	.num_resources	= ARRAY_SIZE(twi_resources),
-};
-
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices)
-{
-	/* pins used for TWI interface */
-	at91_set_B_periph(AT91_PIN_PB4, 0);		/* TWD */
-	at91_set_multi_drive(AT91_PIN_PB4, 1);
-
-	at91_set_B_periph(AT91_PIN_PB5, 0);		/* TWCK */
-	at91_set_multi_drive(AT91_PIN_PB5, 1);
-
-	i2c_register_board_info(0, devices, nr_devices);
-	platform_device_register(&at91cap9_twi_device);
-}
-#else
-void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices) {}
-#endif
-
-/* --------------------------------------------------------------------
- *  SPI
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct resource spi0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SPI0,
-		.end	= AT91CAP9_BASE_SPI0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SPI0,
-		.end	= AT91CAP9_ID_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_spi0_device = {
-	.name		= "atmel_spi",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi0_resources,
-	.num_resources	= ARRAY_SIZE(spi0_resources),
-};
-
-static const unsigned spi0_standard_cs[4] = { AT91_PIN_PA5, AT91_PIN_PA3, AT91_PIN_PD0, AT91_PIN_PD1 };
-
-static struct resource spi1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SPI1,
-		.end	= AT91CAP9_BASE_SPI1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SPI1,
-		.end	= AT91CAP9_ID_SPI1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_spi1_device = {
-	.name		= "atmel_spi",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &spi_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= spi1_resources,
-	.num_resources	= ARRAY_SIZE(spi1_resources),
-};
-
-static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB15, AT91_PIN_PB16, AT91_PIN_PB17, AT91_PIN_PB18 };
-
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
-{
-	int i;
-	unsigned long cs_pin;
-	short enable_spi0 = 0;
-	short enable_spi1 = 0;
-
-	/* Choose SPI chip-selects */
-	for (i = 0; i < nr_devices; i++) {
-		if (devices[i].controller_data)
-			cs_pin = (unsigned long) devices[i].controller_data;
-		else if (devices[i].bus_num == 0)
-			cs_pin = spi0_standard_cs[devices[i].chip_select];
-		else
-			cs_pin = spi1_standard_cs[devices[i].chip_select];
-
-		if (devices[i].bus_num == 0)
-			enable_spi0 = 1;
-		else
-			enable_spi1 = 1;
-
-		/* enable chip-select pin */
-		at91_set_gpio_output(cs_pin, 1);
-
-		/* pass chip-select pin to driver */
-		devices[i].controller_data = (void *) cs_pin;
-	}
-
-	spi_register_board_info(devices, nr_devices);
-
-	/* Configure SPI bus(es) */
-	if (enable_spi0) {
-		at91_set_B_periph(AT91_PIN_PA0, 0);	/* SPI0_MISO */
-		at91_set_B_periph(AT91_PIN_PA1, 0);	/* SPI0_MOSI */
-		at91_set_B_periph(AT91_PIN_PA2, 0);	/* SPI0_SPCK */
-
-		platform_device_register(&at91cap9_spi0_device);
-	}
-	if (enable_spi1) {
-		at91_set_A_periph(AT91_PIN_PB12, 0);	/* SPI1_MISO */
-		at91_set_A_periph(AT91_PIN_PB13, 0);	/* SPI1_MOSI */
-		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_SPCK */
-
-		platform_device_register(&at91cap9_spi1_device);
-	}
-}
-#else
-void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  Timer/Counter block
- * -------------------------------------------------------------------- */
-
-#ifdef CONFIG_ATMEL_TCLIB
-
-static struct resource tcb_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_TCB0,
-		.end	= AT91CAP9_BASE_TCB0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_TCB,
-		.end	= AT91CAP9_ID_TCB,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_tcb_device = {
-	.name		= "atmel_tcb",
-	.id		= 0,
-	.resource	= tcb_resources,
-	.num_resources	= ARRAY_SIZE(tcb_resources),
-};
-
-static void __init at91_add_device_tc(void)
-{
-	platform_device_register(&at91cap9_tcb_device);
-}
-#else
-static void __init at91_add_device_tc(void) { }
-#endif
-
-
-/* --------------------------------------------------------------------
- *  RTT
- * -------------------------------------------------------------------- */
-
-static struct resource rtt_resources[] = {
-	{
-		.start	= AT91CAP9_BASE_RTT,
-		.end	= AT91CAP9_BASE_RTT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91cap9_rtt_device = {
-	.name		= "at91_rtt",
-	.id		= 0,
-	.resource	= rtt_resources,
-	.num_resources	= ARRAY_SIZE(rtt_resources),
-};
-
-static void __init at91_add_device_rtt(void)
-{
-	platform_device_register(&at91cap9_rtt_device);
-}
-
-
-/* --------------------------------------------------------------------
- *  Watchdog
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
-static struct resource wdt_resources[] = {
-	{
-		.start	= AT91CAP9_BASE_WDT,
-		.end	= AT91CAP9_BASE_WDT + SZ_16 - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device at91cap9_wdt_device = {
-	.name		= "at91_wdt",
-	.id		= -1,
-	.resource	= wdt_resources,
-	.num_resources	= ARRAY_SIZE(wdt_resources),
-};
-
-static void __init at91_add_device_watchdog(void)
-{
-	platform_device_register(&at91cap9_wdt_device);
-}
-#else
-static void __init at91_add_device_watchdog(void) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  PWM
- * --------------------------------------------------------------------*/
-
-#if defined(CONFIG_ATMEL_PWM)
-static u32 pwm_mask;
-
-static struct resource pwm_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_PWMC,
-		.end	= AT91CAP9_BASE_PWMC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_PWMC,
-		.end	= AT91CAP9_ID_PWMC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_pwm0_device = {
-	.name	= "atmel_pwm",
-	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
-	.resource	= pwm_resources,
-	.num_resources	= ARRAY_SIZE(pwm_resources),
-};
-
-void __init at91_add_device_pwm(u32 mask)
-{
-	if (mask & (1 << AT91_PWM0))
-		at91_set_A_periph(AT91_PIN_PB19, 1);	/* enable PWM0 */
-
-	if (mask & (1 << AT91_PWM1))
-		at91_set_B_periph(AT91_PIN_PB8, 1);	/* enable PWM1 */
-
-	if (mask & (1 << AT91_PWM2))
-		at91_set_B_periph(AT91_PIN_PC29, 1);	/* enable PWM2 */
-
-	if (mask & (1 << AT91_PWM3))
-		at91_set_B_periph(AT91_PIN_PA11, 1);	/* enable PWM3 */
-
-	pwm_mask = mask;
-
-	platform_device_register(&at91cap9_pwm0_device);
-}
-#else
-void __init at91_add_device_pwm(u32 mask) {}
-#endif
-
-
-
-/* --------------------------------------------------------------------
- *  AC97
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
-static u64 ac97_dmamask = DMA_BIT_MASK(32);
-static struct ac97c_platform_data ac97_data;
-
-static struct resource ac97_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_AC97C,
-		.end	= AT91CAP9_BASE_AC97C + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_AC97C,
-		.end	= AT91CAP9_ID_AC97C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_ac97_device = {
-	.name		= "atmel_ac97c",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &ac97_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &ac97_data,
-	},
-	.resource	= ac97_resources,
-	.num_resources	= ARRAY_SIZE(ac97_resources),
-};
-
-void __init at91_add_device_ac97(struct ac97c_platform_data *data)
-{
-	if (!data)
-		return;
-
-	at91_set_A_periph(AT91_PIN_PA6, 0);	/* AC97FS */
-	at91_set_A_periph(AT91_PIN_PA7, 0);	/* AC97CK */
-	at91_set_A_periph(AT91_PIN_PA8, 0);	/* AC97TX */
-	at91_set_A_periph(AT91_PIN_PA9, 0);	/* AC97RX */
-
-	/* reset */
-	if (gpio_is_valid(data->reset_pin))
-		at91_set_gpio_output(data->reset_pin, 0);
-
-	ac97_data = *data;
-	platform_device_register(&at91cap9_ac97_device);
-}
-#else
-void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  LCD Controller
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_LCDC_BASE,
-		.end	= AT91CAP9_LCDC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_LCDC,
-		.end	= AT91CAP9_ID_LCDC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91_lcdc_device = {
-	.name		= "atmel_lcdfb",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &lcdc_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &lcdc_data,
-	},
-	.resource	= lcdc_resources,
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
-};
-
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
-{
-	if (!data)
-		return;
-
-	if (cpu_is_at91cap9_revB())
-		irq_set_irq_type(AT91CAP9_ID_LCDC, IRQ_TYPE_LEVEL_HIGH);
-
-	at91_set_A_periph(AT91_PIN_PC1, 0);	/* LCDHSYNC */
-	at91_set_A_periph(AT91_PIN_PC2, 0);	/* LCDDOTCK */
-	at91_set_A_periph(AT91_PIN_PC3, 0);	/* LCDDEN */
-	at91_set_B_periph(AT91_PIN_PB9, 0);	/* LCDCC */
-	at91_set_A_periph(AT91_PIN_PC6, 0);	/* LCDD2 */
-	at91_set_A_periph(AT91_PIN_PC7, 0);	/* LCDD3 */
-	at91_set_A_periph(AT91_PIN_PC8, 0);	/* LCDD4 */
-	at91_set_A_periph(AT91_PIN_PC9, 0);	/* LCDD5 */
-	at91_set_A_periph(AT91_PIN_PC10, 0);	/* LCDD6 */
-	at91_set_A_periph(AT91_PIN_PC11, 0);	/* LCDD7 */
-	at91_set_A_periph(AT91_PIN_PC14, 0);	/* LCDD10 */
-	at91_set_A_periph(AT91_PIN_PC15, 0);	/* LCDD11 */
-	at91_set_A_periph(AT91_PIN_PC16, 0);	/* LCDD12 */
-	at91_set_A_periph(AT91_PIN_PC17, 0);	/* LCDD13 */
-	at91_set_A_periph(AT91_PIN_PC18, 0);	/* LCDD14 */
-	at91_set_A_periph(AT91_PIN_PC19, 0);	/* LCDD15 */
-	at91_set_A_periph(AT91_PIN_PC22, 0);	/* LCDD18 */
-	at91_set_A_periph(AT91_PIN_PC23, 0);	/* LCDD19 */
-	at91_set_A_periph(AT91_PIN_PC24, 0);	/* LCDD20 */
-	at91_set_A_periph(AT91_PIN_PC25, 0);	/* LCDD21 */
-	at91_set_A_periph(AT91_PIN_PC26, 0);	/* LCDD22 */
-	at91_set_A_periph(AT91_PIN_PC27, 0);	/* LCDD23 */
-
-	lcdc_data = *data;
-	platform_device_register(&at91_lcdc_device);
-}
-#else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  SSC -- Synchronous Serial Controller
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
-static u64 ssc0_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SSC0,
-		.end	= AT91CAP9_BASE_SSC0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SSC0,
-		.end	= AT91CAP9_ID_SSC0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_ssc0_device = {
-	.name	= "ssc",
-	.id	= 0,
-	.dev	= {
-		.dma_mask		= &ssc0_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc0_resources,
-	.num_resources	= ARRAY_SIZE(ssc0_resources),
-};
-
-static inline void configure_ssc0_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB0, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB1, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB2, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB3, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB4, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB5, 1);
-}
-
-static u64 ssc1_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ssc1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_SSC1,
-		.end	= AT91CAP9_BASE_SSC1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_SSC1,
-		.end	= AT91CAP9_ID_SSC1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device at91cap9_ssc1_device = {
-	.name	= "ssc",
-	.id	= 1,
-	.dev	= {
-		.dma_mask		= &ssc1_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= ssc1_resources,
-	.num_resources	= ARRAY_SIZE(ssc1_resources),
-};
-
-static inline void configure_ssc1_pins(unsigned pins)
-{
-	if (pins & ATMEL_SSC_TF)
-		at91_set_A_periph(AT91_PIN_PB6, 1);
-	if (pins & ATMEL_SSC_TK)
-		at91_set_A_periph(AT91_PIN_PB7, 1);
-	if (pins & ATMEL_SSC_TD)
-		at91_set_A_periph(AT91_PIN_PB8, 1);
-	if (pins & ATMEL_SSC_RD)
-		at91_set_A_periph(AT91_PIN_PB9, 1);
-	if (pins & ATMEL_SSC_RK)
-		at91_set_A_periph(AT91_PIN_PB10, 1);
-	if (pins & ATMEL_SSC_RF)
-		at91_set_A_periph(AT91_PIN_PB11, 1);
-}
-
-/*
- * SSC controllers are accessed through library code, instead of any
- * kind of all-singing/all-dancing driver.  For example one could be
- * used by a particular I2S audio codec's driver, while another one
- * on the same system might be used by a custom data capture driver.
- */
-void __init at91_add_device_ssc(unsigned id, unsigned pins)
-{
-	struct platform_device *pdev;
-
-	/*
-	 * NOTE: caller is responsible for passing information matching
-	 * "pins" to whatever will be using each particular controller.
-	 */
-	switch (id) {
-	case AT91CAP9_ID_SSC0:
-		pdev = &at91cap9_ssc0_device;
-		configure_ssc0_pins(pins);
-		break;
-	case AT91CAP9_ID_SSC1:
-		pdev = &at91cap9_ssc1_device;
-		configure_ssc1_pins(pins);
-		break;
-	default:
-		return;
-	}
-
-	platform_device_register(pdev);
-}
-
-#else
-void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
-#endif
-
-
-/* --------------------------------------------------------------------
- *  UART
- * -------------------------------------------------------------------- */
-
-#if defined(CONFIG_SERIAL_ATMEL)
-static struct resource dbgu_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_DBGU,
-		.end	= AT91CAP9_BASE_DBGU + SZ_512 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91_ID_SYS,
-		.end	= AT91_ID_SYS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data dbgu_data = {
-	.use_dma_tx	= 0,
-	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-};
-
-static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_dbgu_device = {
-	.name		= "atmel_usart",
-	.id		= 0,
-	.dev		= {
-				.dma_mask		= &dbgu_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &dbgu_data,
-	},
-	.resource	= dbgu_resources,
-	.num_resources	= ARRAY_SIZE(dbgu_resources),
-};
-
-static inline void configure_dbgu_pins(void)
-{
-	at91_set_A_periph(AT91_PIN_PC30, 0);		/* DRXD */
-	at91_set_A_periph(AT91_PIN_PC31, 1);		/* DTXD */
-}
-
-static struct resource uart0_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_US0,
-		.end	= AT91CAP9_BASE_US0 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_US0,
-		.end	= AT91CAP9_ID_US0,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart0_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart0_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_uart0_device = {
-	.name		= "atmel_usart",
-	.id		= 1,
-	.dev		= {
-				.dma_mask		= &uart0_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart0_data,
-	},
-	.resource	= uart0_resources,
-	.num_resources	= ARRAY_SIZE(uart0_resources),
-};
-
-static inline void configure_usart0_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PA22, 1);		/* TXD0 */
-	at91_set_A_periph(AT91_PIN_PA23, 0);		/* RXD0 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_A_periph(AT91_PIN_PA24, 0);	/* RTS0 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_A_periph(AT91_PIN_PA25, 0);	/* CTS0 */
-}
-
-static struct resource uart1_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_US1,
-		.end	= AT91CAP9_BASE_US1 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_US1,
-		.end	= AT91CAP9_ID_US1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart1_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart1_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_uart1_device = {
-	.name		= "atmel_usart",
-	.id		= 2,
-	.dev		= {
-				.dma_mask		= &uart1_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart1_data,
-	},
-	.resource	= uart1_resources,
-	.num_resources	= ARRAY_SIZE(uart1_resources),
-};
-
-static inline void configure_usart1_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PD0, 1);		/* TXD1 */
-	at91_set_A_periph(AT91_PIN_PD1, 0);		/* RXD1 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD7, 0);	/* RTS1 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD8, 0);	/* CTS1 */
-}
-
-static struct resource uart2_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_US2,
-		.end	= AT91CAP9_BASE_US2 + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_US2,
-		.end	= AT91CAP9_ID_US2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct atmel_uart_data uart2_data = {
-	.use_dma_tx	= 1,
-	.use_dma_rx	= 1,
-};
-
-static u64 uart2_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device at91cap9_uart2_device = {
-	.name		= "atmel_usart",
-	.id		= 3,
-	.dev		= {
-				.dma_mask		= &uart2_dmamask,
-				.coherent_dma_mask	= DMA_BIT_MASK(32),
-				.platform_data		= &uart2_data,
-	},
-	.resource	= uart2_resources,
-	.num_resources	= ARRAY_SIZE(uart2_resources),
-};
-
-static inline void configure_usart2_pins(unsigned pins)
-{
-	at91_set_A_periph(AT91_PIN_PD2, 1);		/* TXD2 */
-	at91_set_A_periph(AT91_PIN_PD3, 0);		/* RXD2 */
-
-	if (pins & ATMEL_UART_RTS)
-		at91_set_B_periph(AT91_PIN_PD5, 0);	/* RTS2 */
-	if (pins & ATMEL_UART_CTS)
-		at91_set_B_periph(AT91_PIN_PD6, 0);	/* CTS2 */
-}
-
-static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
-struct platform_device *atmel_default_console_device;	/* the serial console device */
-
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
-{
-	struct platform_device *pdev;
-	struct atmel_uart_data *pdata;
-
-	switch (id) {
-		case 0:		/* DBGU */
-			pdev = &at91cap9_dbgu_device;
-			configure_dbgu_pins();
-			break;
-		case AT91CAP9_ID_US0:
-			pdev = &at91cap9_uart0_device;
-			configure_usart0_pins(pins);
-			break;
-		case AT91CAP9_ID_US1:
-			pdev = &at91cap9_uart1_device;
-			configure_usart1_pins(pins);
-			break;
-		case AT91CAP9_ID_US2:
-			pdev = &at91cap9_uart2_device;
-			configure_usart2_pins(pins);
-			break;
-		default:
-			return;
-	}
-	pdata = pdev->dev.platform_data;
-	pdata->num = portnr;		/* update to mapped ID */
-
-	if (portnr < ATMEL_MAX_UART)
-		at91_uarts[portnr] = pdev;
-}
-
-void __init at91_set_serial_console(unsigned portnr)
-{
-	if (portnr < ATMEL_MAX_UART) {
-		atmel_default_console_device = at91_uarts[portnr];
-		at91cap9_set_console_clock(at91_uarts[portnr]->id);
-	}
-}
-
-void __init at91_add_device_serial(void)
-{
-	int i;
-
-	for (i = 0; i < ATMEL_MAX_UART; i++) {
-		if (at91_uarts[i])
-			platform_device_register(at91_uarts[i]);
-	}
-
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-#else
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-void __init at91_add_device_serial(void) {}
-#endif
-
-
-/* -------------------------------------------------------------------- */
-/*
- * These devices are always present and don't need any board-specific
- * setup.
- */
-static int __init at91_add_standard_devices(void)
-{
-	at91_add_device_rtt();
-	at91_add_device_watchdog();
-	at91_add_device_tc();
-	return 0;
-}
-
-arch_initcall(at91_add_standard_devices);
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
deleted file mode 100644
index ac3de4f..0000000
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ /dev/null
@@ -1,396 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/board-cap9adk.c
- *
- *  Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
- *  Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
- *  Copyright (C) 2005 SAN People
- *  Copyright (C) 2007 Atmel Corporation.
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
- */
-
-#include <linux/types.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
-#include <linux/fb.h>
-#include <linux/mtd/physmap.h>
-
-#include <video/atmel_lcdc.h>
-
-#include <mach/hardware.h>
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/board.h>
-#include <mach/at91cap9_matrix.h>
-#include <mach/at91sam9_smc.h>
-#include <mach/system_rev.h>
-
-#include "sam9_smc.h"
-#include "generic.h"
-
-
-static void __init cap9adk_init_early(void)
-{
-	/* Initialize processor: 12 MHz crystal */
-	at91_initialize(12000000);
-
-	/* Setup the LEDs: USER1 and USER2 LED for cpu/timer... */
-	at91_init_leds(AT91_PIN_PA10, AT91_PIN_PA11);
-	/* ... POWER LED always on */
-	at91_set_gpio_output(AT91_PIN_PC29, 1);
-
-	/* Setup the serial ports and console */
-	at91_register_uart(0, 0, 0);		/* DBGU = ttyS0 */
-	at91_set_serial_console(0);
-}
-
-/*
- * USB Host port
- */
-static struct at91_usbh_data __initdata cap9adk_usbh_data = {
-	.ports		= 2,
-	.vbus_pin	= {-EINVAL, -EINVAL},
-	.overcurrent_pin= {-EINVAL, -EINVAL},
-};
-
-/*
- * USB HS Device port
- */
-static struct usba_platform_data __initdata cap9adk_usba_udc_data = {
-	.vbus_pin	= AT91_PIN_PB31,
-};
-
-/*
- * ADS7846 Touchscreen
- */
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) || defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-static int ads7843_pendown_state(void)
-{
-	return !at91_get_gpio_value(AT91_PIN_PC4);	/* Touchscreen PENIRQ */
-}
-
-static struct ads7846_platform_data ads_info = {
-	.model			= 7843,
-	.x_min			= 150,
-	.x_max			= 3830,
-	.y_min			= 190,
-	.y_max			= 3830,
-	.vref_delay_usecs	= 100,
-	.x_plate_ohms		= 450,
-	.y_plate_ohms		= 250,
-	.pressure_max		= 15000,
-	.debounce_max		= 1,
-	.debounce_rep		= 0,
-	.debounce_tol		= (~0),
-	.get_pendown_state	= ads7843_pendown_state,
-};
-
-static void __init cap9adk_add_device_ts(void)
-{
-	at91_set_gpio_input(AT91_PIN_PC4, 1);	/* Touchscreen PENIRQ */
-	at91_set_gpio_input(AT91_PIN_PC5, 1);	/* Touchscreen BUSY */
-}
-#else
-static void __init cap9adk_add_device_ts(void) {}
-#endif
-
-
-/*
- * SPI devices.
- */
-static struct spi_board_info cap9adk_spi_devices[] = {
-#if defined(CONFIG_MTD_AT91_DATAFLASH_CARD)
-	{	/* DataFlash card */
-		.modalias	= "mtd_dataflash",
-		.chip_select	= 0,
-		.max_speed_hz	= 15 * 1000 * 1000,
-		.bus_num	= 0,
-	},
-#endif
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) || defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-	{
-		.modalias	= "ads7846",
-		.chip_select	= 3,		/* can be 2 or 3, depending on J2 jumper */
-		.max_speed_hz	= 125000 * 26,	/* (max sample rate @ 3V) * (cmd + data + overhead) */
-		.bus_num	= 0,
-		.platform_data	= &ads_info,
-		.irq		= AT91_PIN_PC4,
-	},
-#endif
-};
-
-
-/*
- * MCI (SD/MMC)
- */
-static struct at91_mmc_data __initdata cap9adk_mmc_data = {
-	.wire4		= 1,
-	.det_pin	= -EINVAL,
-	.wp_pin		= -EINVAL,
-	.vcc_pin	= -EINVAL,
-};
-
-
-/*
- * MACB Ethernet device
- */
-static struct macb_platform_data __initdata cap9adk_macb_data = {
-	.phy_irq_pin	= -EINVAL,
-	.is_rmii	= 1,
-};
-
-
-/*
- * NAND flash
- */
-static struct mtd_partition __initdata cap9adk_nand_partitions[] = {
-	{
-		.name	= "NAND partition",
-		.offset	= 0,
-		.size	= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct atmel_nand_data __initdata cap9adk_nand_data = {
-	.ale		= 21,
-	.cle		= 22,
-	.det_pin	= -EINVAL,
-	.rdy_pin	= -EINVAL,
-	.enable_pin	= AT91_PIN_PD15,
-	.parts		= cap9adk_nand_partitions,
-	.num_parts	= ARRAY_SIZE(cap9adk_nand_partitions),
-};
-
-static struct sam9_smc_config __initdata cap9adk_nand_smc_config = {
-	.ncs_read_setup		= 1,
-	.nrd_setup		= 2,
-	.ncs_write_setup	= 1,
-	.nwe_setup		= 2,
-
-	.ncs_read_pulse		= 6,
-	.nrd_pulse		= 4,
-	.ncs_write_pulse	= 6,
-	.nwe_pulse		= 4,
-
-	.read_cycle		= 8,
-	.write_cycle		= 8,
-
-	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE,
-	.tdf_cycles		= 1,
-};
-
-static void __init cap9adk_add_device_nand(void)
-{
-	unsigned long csa;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_VDDIOMSEL_3_3V);
-
-	cap9adk_nand_data.bus_width_16 = board_have_nand_16bit();
-	/* setup bus-width (8 or 16) */
-	if (cap9adk_nand_data.bus_width_16)
-		cap9adk_nand_smc_config.mode |= AT91_SMC_DBW_16;
-	else
-		cap9adk_nand_smc_config.mode |= AT91_SMC_DBW_8;
-
-	/* configure chip-select 3 (NAND) */
-	sam9_smc_configure(0, 3, &cap9adk_nand_smc_config);
-
-	at91_add_device_nand(&cap9adk_nand_data);
-}
-
-
-/*
- * NOR flash
- */
-static struct mtd_partition cap9adk_nor_partitions[] = {
-	{
-		.name		= "NOR partition",
-		.offset		= 0,
-		.size		= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct physmap_flash_data cap9adk_nor_data = {
-	.width		= 2,
-	.parts		= cap9adk_nor_partitions,
-	.nr_parts	= ARRAY_SIZE(cap9adk_nor_partitions),
-};
-
-#define NOR_BASE	AT91_CHIPSELECT_0
-#define NOR_SIZE	SZ_8M
-
-static struct resource nor_flash_resources[] = {
-	{
-		.start	= NOR_BASE,
-		.end	= NOR_BASE + NOR_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device cap9adk_nor_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-				.platform_data	= &cap9adk_nor_data,
-	},
-	.resource	= nor_flash_resources,
-	.num_resources	= ARRAY_SIZE(nor_flash_resources),
-};
-
-static struct sam9_smc_config __initdata cap9adk_nor_smc_config = {
-	.ncs_read_setup		= 2,
-	.nrd_setup		= 4,
-	.ncs_write_setup	= 2,
-	.nwe_setup		= 4,
-
-	.ncs_read_pulse		= 10,
-	.nrd_pulse		= 8,
-	.ncs_write_pulse	= 10,
-	.nwe_pulse		= 8,
-
-	.read_cycle		= 16,
-	.write_cycle		= 16,
-
-	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_BAT_WRITE | AT91_SMC_DBW_16,
-	.tdf_cycles		= 1,
-};
-
-static __init void cap9adk_add_device_nor(void)
-{
-	unsigned long csa;
-
-	csa = at91_sys_read(AT91_MATRIX_EBICSA);
-	at91_sys_write(AT91_MATRIX_EBICSA, csa | AT91_MATRIX_EBI_VDDIOMSEL_3_3V);
-
-	/* configure chip-select 0 (NOR) */
-	sam9_smc_configure(0, 0, &cap9adk_nor_smc_config);
-
-	platform_device_register(&cap9adk_nor_flash);
-}
-
-
-/*
- * LCD Controller
- */
-#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
-static struct fb_videomode at91_tft_vga_modes[] = {
-	{
-	        .name           = "TX09D50VM1CCA @ 60",
-		.refresh	= 60,
-		.xres		= 240,		.yres		= 320,
-		.pixclock	= KHZ2PICOS(4965),
-
-		.left_margin	= 1,		.right_margin	= 33,
-		.upper_margin	= 1,		.lower_margin	= 0,
-		.hsync_len	= 5,		.vsync_len	= 1,
-
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-};
-
-static struct fb_monspecs at91fb_default_monspecs = {
-	.manufacturer	= "HIT",
-	.monitor        = "TX09D70VM1CCA",
-
-	.modedb		= at91_tft_vga_modes,
-	.modedb_len	= ARRAY_SIZE(at91_tft_vga_modes),
-	.hfmin		= 15000,
-	.hfmax		= 64000,
-	.vfmin		= 50,
-	.vfmax		= 150,
-};
-
-#define AT91CAP9_DEFAULT_LCDCON2 	(ATMEL_LCDC_MEMOR_LITTLE \
-					| ATMEL_LCDC_DISTYPE_TFT    \
-					| ATMEL_LCDC_CLKMOD_ALWAYSACTIVE)
-
-static void at91_lcdc_power_control(int on)
-{
-	if (on)
-		at91_set_gpio_value(AT91_PIN_PC0, 0);	/* power up */
-	else
-		at91_set_gpio_value(AT91_PIN_PC0, 1);	/* power down */
-}
-
-/* Driver datas */
-static struct atmel_lcdfb_info __initdata cap9adk_lcdc_data = {
-	.default_bpp			= 16,
-	.default_dmacon			= ATMEL_LCDC_DMAEN,
-	.default_lcdcon2		= AT91CAP9_DEFAULT_LCDCON2,
-	.default_monspecs		= &at91fb_default_monspecs,
-	.atmel_lcdfb_power_control	= at91_lcdc_power_control,
-	.guard_time			= 1,
-};
-
-#else
-static struct atmel_lcdfb_info __initdata cap9adk_lcdc_data;
-#endif
-
-
-/*
- * AC97
- */
-static struct ac97c_platform_data cap9adk_ac97_data = {
-	.reset_pin	= -EINVAL,
-};
-
-
-static void __init cap9adk_board_init(void)
-{
-	/* Serial */
-	at91_add_device_serial();
-	/* USB Host */
-	at91_add_device_usbh(&cap9adk_usbh_data);
-	/* USB HS */
-	at91_add_device_usba(&cap9adk_usba_udc_data);
-	/* SPI */
-	at91_add_device_spi(cap9adk_spi_devices, ARRAY_SIZE(cap9adk_spi_devices));
-	/* Touchscreen */
-	cap9adk_add_device_ts();
-	/* MMC */
-	at91_add_device_mmc(1, &cap9adk_mmc_data);
-	/* Ethernet */
-	at91_add_device_eth(&cap9adk_macb_data);
-	/* NAND */
-	cap9adk_add_device_nand();
-	/* NOR Flash */
-	cap9adk_add_device_nor();
-	/* I2C */
-	at91_add_device_i2c(NULL, 0);
-	/* LCD Controller */
-	at91_add_device_lcdc(&cap9adk_lcdc_data);
-	/* AC97 */
-	at91_add_device_ac97(&cap9adk_ac97_data);
-}
-
-MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
-	/* Maintainer: Stelian Pop <stelian.pop@leadtechdesign.com> */
-	.timer		= &at91sam926x_timer,
-	.map_io		= at91_map_io,
-	.init_early	= cap9adk_init_early,
-	.init_irq	= at91_init_irq_default,
-	.init_machine	= cap9adk_board_init,
-MACHINE_END
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index ca76b5a..a5291e0 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -47,8 +47,7 @@
 /*
  * Chips have some kind of clocks : group them by functionality
  */
-#define cpu_has_utmi()		(  cpu_is_at91cap9() \
-				|| cpu_is_at91sam9rl() \
+#define cpu_has_utmi()		(  cpu_is_at91sam9rl() \
 				|| cpu_is_at91sam9g45() \
 				|| cpu_is_at91sam9x5())
 
@@ -637,8 +636,6 @@ static void __init at91_pllb_usbfs_clock_init(unsigned long main_clock)
 		   cpu_is_at91sam9g10()) {
 		uhpck.pmc_mask = AT91SAM926x_PMC_UHP;
 		udpck.pmc_mask = AT91SAM926x_PMC_UDP;
-	} else if (cpu_is_at91cap9()) {
-		uhpck.pmc_mask = AT91CAP9_PMC_UHP;
 	}
 	at91_sys_write(AT91_CKGR_PLLBR, 0);
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 07f5505..78cd605 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -46,7 +46,6 @@ extern void __init at91sam9261_set_console_clock(int id);
 extern void __init at91sam9263_set_console_clock(int id);
 extern void __init at91sam9rl_set_console_clock(int id);
 extern void __init at91sam9g45_set_console_clock(int id);
-extern void __init at91cap9_set_console_clock(int id);
 #ifdef CONFIG_AT91_PMC_UNIT
 extern int __init at91_clock_init(unsigned long main_clock);
 #else
diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/arch/arm/mach-at91/include/mach/at91_pmc.h
index 1782178..4675789 100644
--- a/arch/arm/mach-at91/include/mach/at91_pmc.h
+++ b/arch/arm/mach-at91/include/mach/at91_pmc.h
@@ -23,10 +23,8 @@
 #define		AT91_PMC_PCK		(1 <<  0)		/* Processor Clock */
 #define		AT91RM9200_PMC_UDP	(1 <<  1)		/* USB Devcice Port Clock [AT91RM9200 only] */
 #define		AT91RM9200_PMC_MCKUDP	(1 <<  2)		/* USB Device Port Master Clock Automatic Disable on Suspend [AT91RM9200 only] */
-#define		AT91CAP9_PMC_DDR	(1 <<  2)		/* DDR Clock [CAP9 revC & some SAM9 only] */
 #define		AT91RM9200_PMC_UHP	(1 <<  4)		/* USB Host Port Clock [AT91RM9200 only] */
 #define		AT91SAM926x_PMC_UHP	(1 <<  6)		/* USB Host Port Clock [AT91SAM926x only] */
-#define		AT91CAP9_PMC_UHP	(1 <<  6)		/* USB Host Port Clock [AT91CAP9 only] */
 #define		AT91SAM926x_PMC_UDP	(1 <<  7)		/* USB Devcice Port Clock [AT91SAM926x only] */
 #define		AT91_PMC_PCK0		(1 <<  8)		/* Programmable Clock 0 */
 #define		AT91_PMC_PCK1		(1 <<  9)		/* Programmable Clock 1 */
@@ -40,7 +38,7 @@
 #define	AT91_PMC_PCDR		(AT91_PMC + 0x14)	/* Peripheral Clock Disable Register */
 #define	AT91_PMC_PCSR		(AT91_PMC + 0x18)	/* Peripheral Clock Status Register */
 
-#define	AT91_CKGR_UCKR		(AT91_PMC + 0x1C)	/* UTMI Clock Register [some SAM9, CAP9] */
+#define	AT91_CKGR_UCKR		(AT91_PMC + 0x1C)	/* UTMI Clock Register [some SAM9] */
 #define		AT91_PMC_UPLLEN		(1   << 16)		/* UTMI PLL Enable */
 #define		AT91_PMC_UPLLCOUNT	(0xf << 20)		/* UTMI PLL Start-up Time */
 #define		AT91_PMC_BIASEN		(1   << 24)		/* UTMI BIAS Enable */
@@ -48,7 +46,7 @@
 
 #define	AT91_CKGR_MOR		(AT91_PMC + 0x20)	/* Main Oscillator Register [not on SAM9RL] */
 #define		AT91_PMC_MOSCEN		(1    <<  0)		/* Main Oscillator Enable */
-#define		AT91_PMC_OSCBYPASS	(1    <<  1)		/* Oscillator Bypass [SAM9x, CAP9] */
+#define		AT91_PMC_OSCBYPASS	(1    <<  1)		/* Oscillator Bypass [SAM9x] */
 #define		AT91_PMC_MOSCRCEN	(1    <<  3)		/* Main On-Chip RC Oscillator Enable [some SAM9] */
 #define		AT91_PMC_OSCOUNT	(0xff <<  8)		/* Main Oscillator Start-up Time */
 #define		AT91_PMC_KEY		(0x37 << 16)		/* MOR Writing Key */
@@ -101,7 +99,7 @@
 #define			AT91RM9200_PMC_MDIV_2		(1 << 8)
 #define			AT91RM9200_PMC_MDIV_3		(2 << 8)
 #define			AT91RM9200_PMC_MDIV_4		(3 << 8)
-#define			AT91SAM9_PMC_MDIV_1		(0 << 8)	/* [SAM9,CAP9 only] */
+#define			AT91SAM9_PMC_MDIV_1		(0 << 8)	/* [SAM9 only] */
 #define			AT91SAM9_PMC_MDIV_2		(1 << 8)
 #define			AT91SAM9_PMC_MDIV_4		(2 << 8)
 #define			AT91SAM9_PMC_MDIV_6		(3 << 8)	/* [some SAM9 only] */
@@ -126,7 +124,7 @@
 
 #define	AT91_PMC_PCKR(n)	(AT91_PMC + 0x40 + ((n) * 4))	/* Programmable Clock 0-N Registers */
 #define		AT91_PMC_ALT_PCKR_CSS	(0x7 <<  0)		/* Programmable Clock Source Selection [alternate length] */
-#define			AT91_PMC_CSS_MASTER		(4 << 0)	/* [some SAM9 only] */
+#define			AT91_PMC_CSS_MASTER		(4 << 0)	/* [some SAM9] */
 #define		AT91_PMC_CSSMCK		(0x1 <<  8)		/* CSS or Master Clock Selection */
 #define			AT91_PMC_CSSMCK_CSS		(0 << 8)
 #define			AT91_PMC_CSSMCK_MCK		(1 << 8)
@@ -138,8 +136,7 @@
 #define		AT91_PMC_LOCKA		(1 <<  1)		/* PLLA Lock */
 #define		AT91_PMC_LOCKB		(1 <<  2)		/* PLLB Lock */
 #define		AT91_PMC_MCKRDY		(1 <<  3)		/* Master Clock */
-#define		AT91_PMC_LOCKU		(1 <<  6)		/* UPLL Lock [some SAM9, AT91CAP9 only] */
-#define		AT91_PMC_OSCSEL		(1 <<  7)		/* Slow Clock Oscillator [AT91CAP9 revC only] */
+#define		AT91_PMC_LOCKU		(1 <<  6)		/* UPLL Lock [some SAM9] */
 #define		AT91_PMC_PCK0RDY	(1 <<  8)		/* Programmable Clock 0 */
 #define		AT91_PMC_PCK1RDY	(1 <<  9)		/* Programmable Clock 1 */
 #define		AT91_PMC_PCK2RDY	(1 << 10)		/* Programmable Clock 2 */
@@ -149,7 +146,7 @@
 #define		AT91_PMC_CFDEV		(1 << 18)		/* Clock Failure Detector Event [some SAM9] */
 #define	AT91_PMC_IMR		(AT91_PMC + 0x6c)	/* Interrupt Mask Register */
 
-#define AT91_PMC_PROT		(AT91_PMC + 0xe4)	/* Write Protect Mode Register [some SAM9, AT91CAP9 revC only] */
+#define AT91_PMC_PROT		(AT91_PMC + 0xe4)	/* Write Protect Mode Register [some SAM9] */
 #define		AT91_PMC_WPEN		(0x1  <<  0)		/* Write Protect Enable */
 #define		AT91_PMC_WPKEY		(0xffffff << 8)		/* Write Protect Key */
 #define		AT91_PMC_PROTKEY	(0x504d43 << 8)		/* Activation Code */
@@ -158,7 +155,6 @@
 #define		AT91_PMC_WPVS		(0x1  <<  0)		/* Write Protect Violation Status */
 #define		AT91_PMC_WPVSRC		(0xffff  <<  8)		/* Write Protect Violation Source */
 
-#define AT91_PMC_VER		(AT91_PMC + 0xfc)	/* PMC Module Version [AT91CAP9 only] */
 
 #define AT91_PMC_PCR		(AT91_PMC + 0x10c)	/* Peripheral Control Register [some SAM9] */
 #define		AT91_PMC_PCR_PID	(0x3f  <<  0)		/* Peripheral ID */
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
deleted file mode 100644
index 61d9529..0000000
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91cap9.h
- *
- *  Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
- *  Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
- *  Copyright (C) 2007 Atmel Corporation.
- *
- * Common definitions.
- * Based on AT91CAP9 datasheet revision B (Preliminary).
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91CAP9_H
-#define AT91CAP9_H
-
-/*
- * Peripheral identifiers/interrupts.
- */
-#define AT91CAP9_ID_PIOABCD	2	/* Parallel IO Controller A, B, C and D */
-#define AT91CAP9_ID_MPB0	3	/* MP Block Peripheral 0 */
-#define AT91CAP9_ID_MPB1	4	/* MP Block Peripheral 1 */
-#define AT91CAP9_ID_MPB2	5	/* MP Block Peripheral 2 */
-#define AT91CAP9_ID_MPB3	6	/* MP Block Peripheral 3 */
-#define AT91CAP9_ID_MPB4	7	/* MP Block Peripheral 4 */
-#define AT91CAP9_ID_US0		8	/* USART 0 */
-#define AT91CAP9_ID_US1		9	/* USART 1 */
-#define AT91CAP9_ID_US2		10	/* USART 2 */
-#define AT91CAP9_ID_MCI0	11	/* Multimedia Card Interface 0 */
-#define AT91CAP9_ID_MCI1	12	/* Multimedia Card Interface 1 */
-#define AT91CAP9_ID_CAN		13	/* CAN */
-#define AT91CAP9_ID_TWI		14	/* Two-Wire Interface */
-#define AT91CAP9_ID_SPI0	15	/* Serial Peripheral Interface 0 */
-#define AT91CAP9_ID_SPI1	16	/* Serial Peripheral Interface 0 */
-#define AT91CAP9_ID_SSC0	17	/* Serial Synchronous Controller 0 */
-#define AT91CAP9_ID_SSC1	18	/* Serial Synchronous Controller 1 */
-#define AT91CAP9_ID_AC97C	19	/* AC97 Controller */
-#define AT91CAP9_ID_TCB		20	/* Timer Counter 0, 1 and 2 */
-#define AT91CAP9_ID_PWMC	21	/* Pulse Width Modulation Controller */
-#define AT91CAP9_ID_EMAC	22	/* Ethernet */
-#define AT91CAP9_ID_AESTDES	23	/* Advanced Encryption Standard, Triple DES */
-#define AT91CAP9_ID_ADC		24	/* Analog-to-Digital Converter */
-#define AT91CAP9_ID_ISI		25	/* Image Sensor Interface */
-#define AT91CAP9_ID_LCDC	26	/* LCD Controller */
-#define AT91CAP9_ID_DMA		27	/* DMA Controller */
-#define AT91CAP9_ID_UDPHS	28	/* USB High Speed Device Port */
-#define AT91CAP9_ID_UHP		29	/* USB Host Port */
-#define AT91CAP9_ID_IRQ0	30	/* Advanced Interrupt Controller (IRQ0) */
-#define AT91CAP9_ID_IRQ1	31	/* Advanced Interrupt Controller (IRQ1) */
-
-/*
- * User Peripheral physical base addresses.
- */
-#define AT91CAP9_BASE_UDPHS		0xfff78000
-#define AT91CAP9_BASE_TCB0		0xfff7c000
-#define AT91CAP9_BASE_TC0		0xfff7c000
-#define AT91CAP9_BASE_TC1		0xfff7c040
-#define AT91CAP9_BASE_TC2		0xfff7c080
-#define AT91CAP9_BASE_MCI0		0xfff80000
-#define AT91CAP9_BASE_MCI1		0xfff84000
-#define AT91CAP9_BASE_TWI		0xfff88000
-#define AT91CAP9_BASE_US0		0xfff8c000
-#define AT91CAP9_BASE_US1		0xfff90000
-#define AT91CAP9_BASE_US2		0xfff94000
-#define AT91CAP9_BASE_SSC0		0xfff98000
-#define AT91CAP9_BASE_SSC1		0xfff9c000
-#define AT91CAP9_BASE_AC97C		0xfffa0000
-#define AT91CAP9_BASE_SPI0		0xfffa4000
-#define AT91CAP9_BASE_SPI1		0xfffa8000
-#define AT91CAP9_BASE_CAN		0xfffac000
-#define AT91CAP9_BASE_PWMC		0xfffb8000
-#define AT91CAP9_BASE_EMAC		0xfffbc000
-#define AT91CAP9_BASE_ADC		0xfffc0000
-#define AT91CAP9_BASE_ISI		0xfffc4000
-
-/*
- * System Peripherals (offset from AT91_BASE_SYS)
- */
-#define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
-#define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
-#define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-#define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
-			(0xfffffd50 - AT91_BASE_SYS) :	\
-			(0xfffffd60 - AT91_BASE_SYS))
-
-#define AT91CAP9_BASE_ECC	0xffffe200
-#define AT91CAP9_BASE_DMA	0xffffec00
-#define AT91CAP9_BASE_SMC	0xffffe800
-#define AT91CAP9_BASE_DBGU	AT91_BASE_DBGU1
-#define AT91CAP9_BASE_PIOA	0xfffff200
-#define AT91CAP9_BASE_PIOB	0xfffff400
-#define AT91CAP9_BASE_PIOC	0xfffff600
-#define AT91CAP9_BASE_PIOD	0xfffff800
-#define AT91CAP9_BASE_RSTC	0xfffffd00
-#define AT91CAP9_BASE_SHDWC	0xfffffd10
-#define AT91CAP9_BASE_RTT	0xfffffd20
-#define AT91CAP9_BASE_PIT	0xfffffd30
-#define AT91CAP9_BASE_WDT	0xfffffd40
-
-#define AT91_USART0	AT91CAP9_BASE_US0
-#define AT91_USART1	AT91CAP9_BASE_US1
-#define AT91_USART2	AT91CAP9_BASE_US2
-
-
-/*
- * Internal Memory.
- */
-#define AT91CAP9_SRAM_BASE	0x00100000	/* Internal SRAM base address */
-#define AT91CAP9_SRAM_SIZE	(32 * SZ_1K)	/* Internal SRAM size (32Kb) */
-
-#define AT91CAP9_ROM_BASE	0x00400000	/* Internal ROM base address */
-#define AT91CAP9_ROM_SIZE	(32 * SZ_1K)	/* Internal ROM size (32Kb) */
-
-#define AT91CAP9_LCDC_BASE	0x00500000	/* LCD Controller */
-#define AT91CAP9_UDPHS_FIFO	0x00600000	/* USB High Speed Device Port */
-#define AT91CAP9_UHP_BASE	0x00700000	/* USB Host controller */
-
-#endif
diff --git a/arch/arm/mach-at91/include/mach/at91cap9_matrix.h b/arch/arm/mach-at91/include/mach/at91cap9_matrix.h
deleted file mode 100644
index 4b9d4af..0000000
--- a/arch/arm/mach-at91/include/mach/at91cap9_matrix.h
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91cap9_matrix.h
- *
- *  Copyright (C) 2007 Stelian Pop <stelian.pop@leadtechdesign.com>
- *  Copyright (C) 2007 Lead Tech Design <www.leadtechdesign.com>
- *  Copyright (C) 2006 Atmel Corporation.
- *
- * Memory Controllers (MATRIX, EBI) - System peripherals registers.
- * Based on AT91CAP9 datasheet revision B (Preliminary).
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91CAP9_MATRIX_H
-#define AT91CAP9_MATRIX_H
-
-#define AT91_MATRIX_MCFG0	(AT91_MATRIX + 0x00)	/* Master Configuration Register 0 */
-#define AT91_MATRIX_MCFG1	(AT91_MATRIX + 0x04)	/* Master Configuration Register 1 */
-#define AT91_MATRIX_MCFG2	(AT91_MATRIX + 0x08)	/* Master Configuration Register 2 */
-#define AT91_MATRIX_MCFG3	(AT91_MATRIX + 0x0C)	/* Master Configuration Register 3 */
-#define AT91_MATRIX_MCFG4	(AT91_MATRIX + 0x10)	/* Master Configuration Register 4 */
-#define AT91_MATRIX_MCFG5	(AT91_MATRIX + 0x14)	/* Master Configuration Register 5 */
-#define AT91_MATRIX_MCFG6	(AT91_MATRIX + 0x18)	/* Master Configuration Register 6 */
-#define AT91_MATRIX_MCFG7	(AT91_MATRIX + 0x1C)	/* Master Configuration Register 7 */
-#define AT91_MATRIX_MCFG8	(AT91_MATRIX + 0x20)	/* Master Configuration Register 8 */
-#define AT91_MATRIX_MCFG9	(AT91_MATRIX + 0x24)	/* Master Configuration Register 9 */
-#define AT91_MATRIX_MCFG10	(AT91_MATRIX + 0x28)	/* Master Configuration Register 10 */
-#define AT91_MATRIX_MCFG11	(AT91_MATRIX + 0x2C)	/* Master Configuration Register 11 */
-#define		AT91_MATRIX_ULBT	(7 << 0)	/* Undefined Length Burst Type */
-#define			AT91_MATRIX_ULBT_INFINITE	(0 << 0)
-#define			AT91_MATRIX_ULBT_SINGLE		(1 << 0)
-#define			AT91_MATRIX_ULBT_FOUR		(2 << 0)
-#define			AT91_MATRIX_ULBT_EIGHT		(3 << 0)
-#define			AT91_MATRIX_ULBT_SIXTEEN	(4 << 0)
-
-#define AT91_MATRIX_SCFG0	(AT91_MATRIX + 0x40)	/* Slave Configuration Register 0 */
-#define AT91_MATRIX_SCFG1	(AT91_MATRIX + 0x44)	/* Slave Configuration Register 1 */
-#define AT91_MATRIX_SCFG2	(AT91_MATRIX + 0x48)	/* Slave Configuration Register 2 */
-#define AT91_MATRIX_SCFG3	(AT91_MATRIX + 0x4C)	/* Slave Configuration Register 3 */
-#define AT91_MATRIX_SCFG4	(AT91_MATRIX + 0x50)	/* Slave Configuration Register 4 */
-#define AT91_MATRIX_SCFG5	(AT91_MATRIX + 0x54)	/* Slave Configuration Register 5 */
-#define AT91_MATRIX_SCFG6	(AT91_MATRIX + 0x58)	/* Slave Configuration Register 6 */
-#define AT91_MATRIX_SCFG7	(AT91_MATRIX + 0x5C)	/* Slave Configuration Register 7 */
-#define AT91_MATRIX_SCFG8	(AT91_MATRIX + 0x60)	/* Slave Configuration Register 8 */
-#define AT91_MATRIX_SCFG9	(AT91_MATRIX + 0x64)	/* Slave Configuration Register 9 */
-#define		AT91_MATRIX_SLOT_CYCLE		(0xff << 0)	/* Maximum Number of Allowed Cycles for a Burst */
-#define		AT91_MATRIX_DEFMSTR_TYPE	(3    << 16)	/* Default Master Type */
-#define			AT91_MATRIX_DEFMSTR_TYPE_NONE	(0 << 16)
-#define			AT91_MATRIX_DEFMSTR_TYPE_LAST	(1 << 16)
-#define			AT91_MATRIX_DEFMSTR_TYPE_FIXED	(2 << 16)
-#define		AT91_MATRIX_FIXED_DEFMSTR	(0xf  << 18)	/* Fixed Index of Default Master */
-#define		AT91_MATRIX_ARBT		(3    << 24)	/* Arbitration Type */
-#define			AT91_MATRIX_ARBT_ROUND_ROBIN	(0 << 24)
-#define			AT91_MATRIX_ARBT_FIXED_PRIORITY	(1 << 24)
-
-#define AT91_MATRIX_PRAS0	(AT91_MATRIX + 0x80)	/* Priority Register A for Slave 0 */
-#define AT91_MATRIX_PRBS0	(AT91_MATRIX + 0x84)	/* Priority Register B for Slave 0 */
-#define AT91_MATRIX_PRAS1	(AT91_MATRIX + 0x88)	/* Priority Register A for Slave 1 */
-#define AT91_MATRIX_PRBS1	(AT91_MATRIX + 0x8C)	/* Priority Register B for Slave 1 */
-#define AT91_MATRIX_PRAS2	(AT91_MATRIX + 0x90)	/* Priority Register A for Slave 2 */
-#define AT91_MATRIX_PRBS2	(AT91_MATRIX + 0x94)	/* Priority Register B for Slave 2 */
-#define AT91_MATRIX_PRAS3	(AT91_MATRIX + 0x98)	/* Priority Register A for Slave 3 */
-#define AT91_MATRIX_PRBS3	(AT91_MATRIX + 0x9C)	/* Priority Register B for Slave 3 */
-#define AT91_MATRIX_PRAS4	(AT91_MATRIX + 0xA0)	/* Priority Register A for Slave 4 */
-#define AT91_MATRIX_PRBS4	(AT91_MATRIX + 0xA4)	/* Priority Register B for Slave 4 */
-#define AT91_MATRIX_PRAS5	(AT91_MATRIX + 0xA8)	/* Priority Register A for Slave 5 */
-#define AT91_MATRIX_PRBS5	(AT91_MATRIX + 0xAC)	/* Priority Register B for Slave 5 */
-#define AT91_MATRIX_PRAS6	(AT91_MATRIX + 0xB0)	/* Priority Register A for Slave 6 */
-#define AT91_MATRIX_PRBS6	(AT91_MATRIX + 0xB4)	/* Priority Register B for Slave 6 */
-#define AT91_MATRIX_PRAS7	(AT91_MATRIX + 0xB8)	/* Priority Register A for Slave 7 */
-#define AT91_MATRIX_PRBS7	(AT91_MATRIX + 0xBC)	/* Priority Register B for Slave 7 */
-#define AT91_MATRIX_PRAS8	(AT91_MATRIX + 0xC0)	/* Priority Register A for Slave 8 */
-#define AT91_MATRIX_PRBS8	(AT91_MATRIX + 0xC4)	/* Priority Register B for Slave 8 */
-#define AT91_MATRIX_PRAS9	(AT91_MATRIX + 0xC8)	/* Priority Register A for Slave 9 */
-#define AT91_MATRIX_PRBS9	(AT91_MATRIX + 0xCC)	/* Priority Register B for Slave 9 */
-#define		AT91_MATRIX_M0PR		(3 << 0)	/* Master 0 Priority */
-#define		AT91_MATRIX_M1PR		(3 << 4)	/* Master 1 Priority */
-#define		AT91_MATRIX_M2PR		(3 << 8)	/* Master 2 Priority */
-#define		AT91_MATRIX_M3PR		(3 << 12)	/* Master 3 Priority */
-#define		AT91_MATRIX_M4PR		(3 << 16)	/* Master 4 Priority */
-#define		AT91_MATRIX_M5PR		(3 << 20)	/* Master 5 Priority */
-#define		AT91_MATRIX_M6PR		(3 << 24)	/* Master 6 Priority */
-#define		AT91_MATRIX_M7PR		(3 << 28)	/* Master 7 Priority */
-#define		AT91_MATRIX_M8PR		(3 << 0)	/* Master 8 Priority (in Register B) */
-#define		AT91_MATRIX_M9PR		(3 << 4)	/* Master 9 Priority (in Register B) */
-#define		AT91_MATRIX_M10PR		(3 << 8)	/* Master 10 Priority (in Register B) */
-#define		AT91_MATRIX_M11PR		(3 << 12)	/* Master 11 Priority (in Register B) */
-
-#define AT91_MATRIX_MRCR	(AT91_MATRIX + 0x100)	/* Master Remap Control Register */
-#define		AT91_MATRIX_RCB0		(1 << 0)	/* Remap Command for AHB Master 0 (ARM926EJ-S Instruction Master) */
-#define		AT91_MATRIX_RCB1		(1 << 1)	/* Remap Command for AHB Master 1 (ARM926EJ-S Data Master) */
-#define		AT91_MATRIX_RCB2		(1 << 2)
-#define		AT91_MATRIX_RCB3		(1 << 3)
-#define		AT91_MATRIX_RCB4		(1 << 4)
-#define		AT91_MATRIX_RCB5		(1 << 5)
-#define		AT91_MATRIX_RCB6		(1 << 6)
-#define		AT91_MATRIX_RCB7		(1 << 7)
-#define		AT91_MATRIX_RCB8		(1 << 8)
-#define		AT91_MATRIX_RCB9		(1 << 9)
-#define		AT91_MATRIX_RCB10		(1 << 10)
-#define		AT91_MATRIX_RCB11		(1 << 11)
-
-#define AT91_MPBS0_SFR		(AT91_MATRIX + 0x114)	/* MPBlock Slave 0 Special Function Register */
-#define AT91_MPBS1_SFR		(AT91_MATRIX + 0x11C)	/* MPBlock Slave 1 Special Function Register */
-
-#define AT91_MATRIX_UDPHS	(AT91_MATRIX + 0x118)	/* USBHS Special Function Register [AT91CAP9 only] */
-#define		AT91_MATRIX_SELECT_UDPHS	(0 << 31)	/* select High Speed UDP */
-#define		AT91_MATRIX_SELECT_UDP		(1 << 31)	/* select standard UDP */
-#define		AT91_MATRIX_UDPHS_BYPASS_LOCK	(1 << 30)	/* bypass lock bit */
-
-#define AT91_MATRIX_EBICSA	(AT91_MATRIX + 0x120)	/* EBI Chip Select Assignment Register */
-#define		AT91_MATRIX_EBI_CS1A		(1 << 1)	/* Chip Select 1 Assignment */
-#define			AT91_MATRIX_EBI_CS1A_SMC		(0 << 1)
-#define			AT91_MATRIX_EBI_CS1A_BCRAMC		(1 << 1)
-#define		AT91_MATRIX_EBI_CS3A		(1 << 3)	/* Chip Select 3 Assignment */
-#define			AT91_MATRIX_EBI_CS3A_SMC		(0 << 3)
-#define			AT91_MATRIX_EBI_CS3A_SMC_SMARTMEDIA	(1 << 3)
-#define		AT91_MATRIX_EBI_CS4A		(1 << 4)	/* Chip Select 4 Assignment */
-#define			AT91_MATRIX_EBI_CS4A_SMC		(0 << 4)
-#define			AT91_MATRIX_EBI_CS4A_SMC_CF1		(1 << 4)
-#define		AT91_MATRIX_EBI_CS5A		(1 << 5)	/* Chip Select 5 Assignment */
-#define			AT91_MATRIX_EBI_CS5A_SMC		(0 << 5)
-#define			AT91_MATRIX_EBI_CS5A_SMC_CF2		(1 << 5)
-#define		AT91_MATRIX_EBI_DBPUC		(1 << 8)	/* Data Bus Pull-up Configuration */
-#define		AT91_MATRIX_EBI_DQSPDC		(1 << 9)	/* Data Qualifier Strobe Pull-Down Configuration */
-#define		AT91_MATRIX_EBI_VDDIOMSEL	(1 << 16)	/* Memory voltage selection */
-#define			AT91_MATRIX_EBI_VDDIOMSEL_1_8V		(0 << 16)
-#define			AT91_MATRIX_EBI_VDDIOMSEL_3_3V		(1 << 16)
-
-#define AT91_MPBS2_SFR		(AT91_MATRIX + 0x12C)	/* MPBlock Slave 2 Special Function Register */
-#define AT91_MPBS3_SFR		(AT91_MATRIX + 0x130)	/* MPBlock Slave 3 Special Function Register */
-#define AT91_APB_SFR		(AT91_MATRIX + 0x134)	/* APB Bridge Special Function Register */
-
-#endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
index e2f8da8..5d4a9f8 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
@@ -59,7 +59,6 @@
 #define		AT91_DDRSDRC_TRP	(0xf << 16)		/* Row precharge delay */
 #define		AT91_DDRSDRC_TRRD	(0xf << 20)		/* Active BankA to BankB */
 #define		AT91_DDRSDRC_TWTR	(0x7 << 24)		/* Internal Write to Read delay */
-#define		AT91CAP9_DDRSDRC_TWTR	(1   << 24)		/* Internal Write to Read delay */
 #define		AT91_DDRSDRC_RED_WRRD	(0x1 << 27)		/* Reduce Write to Read Delay [SAM9 Only] */
 #define		AT91_DDRSDRC_TMRD	(0xf << 28)		/* Load mode to active/refresh delay */
 
@@ -76,7 +75,6 @@
 #define		AT91_DDRSDRC_TRTP	(0x7  << 12)		/* Read to Precharge delay */
 
 #define AT91_DDRSDRC_LPR	0x1C	/* Low Power Register */
-#define AT91CAP9_DDRSDRC_LPR	0x18	/* Low Power Register */
 #define		AT91_DDRSDRC_LPCB	(3 << 0)		/* Low-power Configurations */
 #define			AT91_DDRSDRC_LPCB_DISABLE		0
 #define			AT91_DDRSDRC_LPCB_SELF_REFRESH		1
@@ -94,11 +92,9 @@
 #define		AT91_DDRSDRC_UPD_MR	(3 << 20)	 /* Update load mode register and extended mode register */
 
 #define AT91_DDRSDRC_MDR	0x20	/* Memory Device Register */
-#define AT91CAP9_DDRSDRC_MDR	0x1C	/* Memory Device Register */
 #define		AT91_DDRSDRC_MD		(3 << 0)		/* Memory Device Type */
 #define			AT91_DDRSDRC_MD_SDR		0
 #define			AT91_DDRSDRC_MD_LOW_POWER_SDR	1
-#define			AT91CAP9_DDRSDRC_MD_DDR		2
 #define			AT91_DDRSDRC_MD_LOW_POWER_DDR	3
 #define			AT91_DDRSDRC_MD_DDR2		6	/* [SAM9 Only] */
 #define		AT91_DDRSDRC_DBW	(1 << 4)		/* Data Bus Width */
@@ -106,16 +102,10 @@
 #define			AT91_DDRSDRC_DBW_16BITS		(1 <<  4)
 
 #define AT91_DDRSDRC_DLL	0x24	/* DLL Information Register */
-#define AT91CAP9_DDRSDRC_DLL	0x20	/* DLL Information Register */
 #define		AT91_DDRSDRC_MDINC	(1 << 0)		/* Master Delay increment */
 #define		AT91_DDRSDRC_MDDEC	(1 << 1)		/* Master Delay decrement */
 #define		AT91_DDRSDRC_MDOVF	(1 << 2)		/* Master Delay Overflow */
-#define		AT91CAP9_DDRSDRC_SDCOVF	(1 << 3)		/* Slave Delay Correction Overflow */
-#define		AT91CAP9_DDRSDRC_SDCUDF	(1 << 4)		/* Slave Delay Correction Underflow */
-#define		AT91CAP9_DDRSDRC_SDERF	(1 << 5)		/* Slave Delay Correction error */
 #define		AT91_DDRSDRC_MDVAL	(0xff <<  8)		/* Master Delay value */
-#define		AT91CAP9_DDRSDRC_SDVAL	(0xff << 16)		/* Slave Delay value */
-#define		AT91CAP9_DDRSDRC_SDCVAL	(0xff << 24)		/* Slave Delay Correction value */
 
 #define AT91_DDRSDRC_HS		0x2C	/* High Speed Register [SAM9 Only] */
 #define		AT91_DDRSDRC_DIS_ATCP_RD	(1 << 2)	/* Anticip read access is disabled */
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index f6ce936..0118c33 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -25,7 +25,6 @@
 #define ARCH_ID_AT91SAM9G45MRL	0x819b05a2	/* aka 9G45-ES2 & non ES lots */
 #define ARCH_ID_AT91SAM9G45ES	0x819b05a1	/* 9G45-ES (Engineering Sample) */
 #define ARCH_ID_AT91SAM9X5	0x819a05a0
-#define ARCH_ID_AT91CAP9	0x039A03A0
 
 #define ARCH_ID_AT91SAM9XE128	0x329973a0
 #define ARCH_ID_AT91SAM9XE256	0x329a93a0
@@ -51,10 +50,6 @@
 #define ARCH_FAMILY_AT91SAM9	0x01900000
 #define ARCH_FAMILY_AT91SAM9XE	0x02900000
 
-/* PMC revision */
-#define ARCH_REVISION_CAP9_B	0x399
-#define ARCH_REVISION_CAP9_C	0x601
-
 /* RM9200 type */
 #define ARCH_REVISON_9200_BGA	(0 << 0)
 #define ARCH_REVISON_9200_PQFP	(1 << 0)
@@ -63,9 +58,6 @@ enum at91_soc_type {
 	/* 920T */
 	AT91_SOC_RM9200,
 
-	/* CAP */
-	AT91_SOC_CAP9,
-
 	/* SAM92xx */
 	AT91_SOC_SAM9260, AT91_SOC_SAM9261, AT91_SOC_SAM9263,
 
@@ -86,9 +78,6 @@ enum at91_soc_subtype {
 	/* RM9200 */
 	AT91_SOC_RM9200_BGA, AT91_SOC_RM9200_PQFP,
 
-	/* CAP9 */
-	AT91_SOC_CAP9_REV_B, AT91_SOC_CAP9_REV_C,
-
 	/* SAM9260 */
 	AT91_SOC_SAM9XE,
 
@@ -195,16 +184,6 @@ static inline int at91_soc_is_detected(void)
 #define cpu_is_at91sam9x25()	(0)
 #endif
 
-#ifdef CONFIG_ARCH_AT91CAP9
-#define cpu_is_at91cap9()	(at91_soc_initdata.type == AT91_SOC_CAP9)
-#define cpu_is_at91cap9_revB()	(at91_soc_initdata.subtype == AT91_SOC_CAP9_REV_B)
-#define cpu_is_at91cap9_revC()	(at91_soc_initdata.subtype == AT91_SOC_CAP9_REV_C)
-#else
-#define cpu_is_at91cap9()	(0)
-#define cpu_is_at91cap9_revB()	(0)
-#define cpu_is_at91cap9_revC()	(0)
-#endif
-
 /*
  * Since this is ARM, we will never run on any AVR32 CPU. But these
  * definitions may reduce clutter in common drivers.
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 12ad180..fd7dce4 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -19,7 +19,7 @@
 /* DBGU base */
 /* rm9200, 9260/9g20, 9261/9g10, 9rl */
 #define AT91_BASE_DBGU0	0xfffff200
-/* 9263, 9g45, cap9 */
+/* 9263, 9g45 */
 #define AT91_BASE_DBGU1	0xffffee00
 
 #if defined(CONFIG_ARCH_AT91RM9200)
@@ -36,8 +36,6 @@
 #include <mach/at91sam9g45.h>
 #elif defined(CONFIG_ARCH_AT91SAM9X5)
 #include <mach/at91sam9x5.h>
-#elif defined(CONFIG_ARCH_AT91CAP9)
-#include <mach/at91cap9.h>
 #elif defined(CONFIG_ARCH_AT91X40)
 #include <mach/at91x40.h>
 #else
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1606379..87be5aa 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -150,11 +150,6 @@ static int at91_pm_verify_clocks(void)
 			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
 			return 0;
 		}
-	} else if (cpu_is_at91cap9()) {
-		if ((scsr & AT91CAP9_PMC_UHP) != 0) {
-			pr_err("AT91: PM - Suspend-to-RAM with USB still active\n");
-			return 0;
-		}
 	}
 
 #ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 7eb40d2..218d816 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -24,24 +24,6 @@ static inline u32 sdram_selfrefresh_enable(void)
 #define wait_for_interrupt_enable()		asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
 								: : "r" (0))
 
-#elif defined(CONFIG_ARCH_AT91CAP9)
-#include <mach/at91sam9_ddrsdr.h>
-
-
-static inline u32 sdram_selfrefresh_enable(void)
-{
-	u32 saved_lpr, lpr;
-
-	saved_lpr = at91_ramc_read(0, AT91CAP9_DDRSDRC_LPR);
-
-	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
-	at91_ramc_write(0, AT91CAP9_DDRSDRC_LPR, lpr | AT91_DDRSDRC_LPCB_SELF_REFRESH);
-	return saved_lpr;
-}
-
-#define sdram_selfrefresh_disable(saved_lpr)	at91_ramc_write(0, AT91CAP9_DDRSDRC_LPR, saved_lpr)
-#define wait_for_interrupt_enable()		cpu_do_idle()
-
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
 #include <mach/at91sam9_ddrsdr.h>
 
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 92dfb84..f8539a8 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -18,8 +18,7 @@
 
 #if defined(CONFIG_ARCH_AT91RM9200)
 #include <mach/at91rm9200_mc.h>
-#elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
 #include <mach/at91sam9_ddrsdr.h>
 #else
 #include <mach/at91sam9_sdramc.h>
@@ -130,8 +129,7 @@ ENTRY(at91_slow_clock)
 	/* Put SDRAM in self-refresh mode */
 	mov	r3, #1
 	str	r3, [r2, #AT91_SDRAMC_SRR]
-#elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
 
 	/* prepare for DDRAM self-refresh mode */
 	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
@@ -263,8 +261,7 @@ ENTRY(at91_slow_clock)
 
 #ifdef CONFIG_ARCH_AT91RM9200
 	/* Do nothing - self-refresh is automatically disabled. */
-#elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
 	/* Restore LPR on AT91 with DDRAM */
 	ldr	r3, .saved_sam9_lpr
 	str	r3, [r2, #AT91_DDRSDRC_LPR]
@@ -305,8 +302,7 @@ ENTRY(at91_slow_clock)
 #ifdef CONFIG_ARCH_AT91RM9200
 .at91_va_base_sdramc:
 	.word AT91_VA_BASE_SYS
-#elif defined(CONFIG_ARCH_AT91CAP9) \
-	|| defined(CONFIG_ARCH_AT91SAM9G45)
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
 .at91_va_base_sdramc:
 	.word AT91_VA_BASE_SYS + AT91_DDRSDRC0
 #else
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 69d3fc4..620c67e 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -86,20 +86,6 @@ static void __init soc_detect(u32 dbgu_base)
 	socid = cidr & ~AT91_CIDR_VERSION;
 
 	switch (socid) {
-	case ARCH_ID_AT91CAP9: {
-#ifdef CONFIG_AT91_PMC_UNIT
-		u32 pmc_ver = at91_sys_read(AT91_PMC_VER);
-
-		if (pmc_ver == ARCH_REVISION_CAP9_B)
-			at91_soc_initdata.subtype = AT91_SOC_CAP9_REV_B;
-		else if (pmc_ver == ARCH_REVISION_CAP9_C)
-			at91_soc_initdata.subtype = AT91_SOC_CAP9_REV_C;
-#endif
-		at91_soc_initdata.type = AT91_SOC_CAP9;
-		at91_boot_soc = at91cap9_soc;
-		break;
-	}
-
 	case ARCH_ID_AT91RM9200:
 		at91_soc_initdata.type = AT91_SOC_RM9200;
 		at91_boot_soc = at91rm9200_soc;
@@ -200,7 +186,6 @@ static void __init soc_detect(u32 dbgu_base)
 
 static const char *soc_name[] = {
 	[AT91_SOC_RM9200]	= "at91rm9200",
-	[AT91_SOC_CAP9]		= "at91cap9",
 	[AT91_SOC_SAM9260]	= "at91sam9260",
 	[AT91_SOC_SAM9261]	= "at91sam9261",
 	[AT91_SOC_SAM9263]	= "at91sam9263",
@@ -221,8 +206,6 @@ EXPORT_SYMBOL(at91_get_soc_type);
 static const char *soc_subtype_name[] = {
 	[AT91_SOC_RM9200_BGA]	= "at91rm9200 BGA",
 	[AT91_SOC_RM9200_PQFP]	= "at91rm9200 PQFP",
-	[AT91_SOC_CAP9_REV_B]	= "at91cap9 revB",
-	[AT91_SOC_CAP9_REV_C]	= "at91cap9 revC",
 	[AT91_SOC_SAM9XE]	= "at91sam9xe",
 	[AT91_SOC_SAM9G45ES]	= "at91sam9g45es",
 	[AT91_SOC_SAM9M10]	= "at91sam9m10",
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 4588ae6..5db4aa4 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -13,7 +13,6 @@ struct at91_init_soc {
 };
 
 extern struct at91_init_soc at91_boot_soc;
-extern struct at91_init_soc at91cap9_soc;
 extern struct at91_init_soc at91rm9200_soc;
 extern struct at91_init_soc at91sam9260_soc;
 extern struct at91_init_soc at91sam9261_soc;
@@ -27,10 +26,6 @@ static inline int at91_soc_is_enabled(void)
 	return at91_boot_soc.init != NULL;
 }
 
-#if !defined(CONFIG_ARCH_AT91CAP9)
-#define at91cap9_soc	at91_boot_soc
-#endif
-
 #if !defined(CONFIG_ARCH_AT91RM9200)
 #define at91rm9200_soc	at91_boot_soc
 #endif
diff --git a/arch/avr32/mach-at32ap/include/mach/cpu.h b/arch/avr32/mach-at32ap/include/mach/cpu.h
index 8181293..16a24b1 100644
--- a/arch/avr32/mach-at32ap/include/mach/cpu.h
+++ b/arch/avr32/mach-at32ap/include/mach/cpu.h
@@ -30,9 +30,6 @@
 #define cpu_is_at91sam9261()	(0)
 #define cpu_is_at91sam9263()	(0)
 #define cpu_is_at91sam9rl()	(0)
-#define cpu_is_at91cap9()	(0)
-#define cpu_is_at91cap9_revB()	(0)
-#define cpu_is_at91cap9_revC()	(0)
 #define cpu_is_at91sam9g10()	(0)
 #define cpu_is_at91sam9g20()	(0)
 #define cpu_is_at91sam9g45()	(0)
diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 947faa5..efdb81d 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -86,7 +86,6 @@ static inline int at91mci_is_mci1rev2xx(void)
 {
 	return (   cpu_is_at91sam9260()
 		|| cpu_is_at91sam9263()
-		|| cpu_is_at91cap9()
 		|| cpu_is_at91sam9rl()
 		|| cpu_is_at91sam9g10()
 		|| cpu_is_at91sam9g20()
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7ecb68a..85ae4b4 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -137,7 +137,7 @@ choice
 
 config USB_AT91
 	tristate "Atmel AT91 USB Device Port"
-	depends on ARCH_AT91 && !ARCH_AT91SAM9RL && !ARCH_AT91CAP9 && !ARCH_AT91SAM9G45
+	depends on ARCH_AT91 && !ARCH_AT91SAM9RL && !ARCH_AT91SAM9G45
 	help
 	   Many Atmel AT91 processors (such as the AT91RM2000) have a
 	   full speed USB Device Port with support for five configurable
@@ -150,7 +150,7 @@ config USB_AT91
 config USB_ATMEL_USBA
 	tristate "Atmel USBA"
 	select USB_GADGET_DUALSPEED
-	depends on AVR32 || ARCH_AT91CAP9 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
+	depends on AVR32 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
 	help
 	  USBA is the integrated high-speed USB Device controller on
 	  the AT32AP700x, some AT91SAM9 and AT91CAP9 processors from Atmel.
-- 
1.7.7

From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:55 +0100
Subject: [PATCH v1 10/24] zynq: Minor config cleanup
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <8a592564a41599f3435a672dbfc5d6aa2709bec3.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Cleanups mostly on:
- Add comments
- Re-order configs
- Remove #define CONFIG_ZYNQ_SDHCI

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 75 ++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 8be52df..44ae5ed 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -7,33 +7,51 @@
 #ifndef __CONFIG_ZYNQ_H
 #define __CONFIG_ZYNQ_H

-#define CONFIG_ARMV7 /* This is an ARM V7 CPU core */
+/* High Level configuration Options */
+#define CONFIG_ARMV7
 #define CONFIG_ZYNQ

 /* CPU clock */
-#define CONFIG_CPU_FREQ_HZ	800000000
+#ifndef CONFIG_CPU_FREQ_HZ
+# define CONFIG_CPU_FREQ_HZ	800000000
+#endif

+/* Serial drivers */
+#define CONFIG_BAUDRATE		115200
 /* The following table includes the supported baudrates */
 #define CONFIG_SYS_BAUDRATE_TABLE  \
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400}

-#define CONFIG_BAUDRATE		115200
-
-/* XPSS Serial driver */
+/* Zynq Serial driver */
 #define CONFIG_ZYNQ_SERIAL
 #define CONFIG_ZYNQ_SERIAL_BASEADDR0	0xE0001000
 #define CONFIG_ZYNQ_SERIAL_BAUDRATE0	CONFIG_BAUDRATE
 #define CONFIG_ZYNQ_SERIAL_CLOCK0	50000000

+/* DCC driver */
+#if defined(CONFIG_ZYNQ_DCC)
+# define CONFIG_ARM_DCC
+# define CONFIG_CPU_V6 /* Required by CONFIG_ARM_DCC */
+#endif
+
 /* Ethernet driver */
 #define CONFIG_NET_MULTI
 #define CONFIG_ZYNQ_GEM
 #define CONFIG_ZYNQ_GEM0
 #define CONFIG_ZYNQ_GEM_PHY_ADDR0	7

-#define CONFIG_ZYNQ_SDHCI
-#define CONFIG_ZYNQ_SDHCI0
+#define CONFIG_ZYNQ_SPI
+/* SPI */
+#ifdef CONFIG_ZYNQ_SPI
+# define CONFIG_SPI_FLASH
+# define CONFIG_SPI_FLASH_SST
+# define CONFIG_CMD_SF
+#endif
+
+/* NOR */
+#define CONFIG_SYS_NO_FLASH

+#define CONFIG_ZYNQ_SDHCI0
 /* MMC */
 #if defined(CONFIG_ZYNQ_SDHCI0) || defined(CONFIG_ZYNQ_SDHCI1)
 # define CONFIG_MMC
@@ -58,26 +76,6 @@
 # define CONFIG_SYS_I2C_ZYNQ_SLAVE		1
 #endif

-#if defined(CONFIG_ZYNQ_DCC)
-# define CONFIG_ARM_DCC
-# define CONFIG_CPU_V6 /* Required by CONFIG_ARM_DCC */
-#endif
-
-#define CONFIG_ZYNQ_SPI
-
-/* SPI */
-#ifdef CONFIG_ZYNQ_SPI
-# define CONFIG_SPI_FLASH
-# define CONFIG_SPI_FLASH_SST
-# define CONFIG_CMD_SF
-#endif
-
-/* Enable the PL to be downloaded */
-#define CONFIG_FPGA
-#define CONFIG_FPGA_XILINX
-#define CONFIG_FPGA_ZYNQPL
-#define CONFIG_CMD_FPGA
-
 #define CONFIG_BOOTP_SERVERIP
 #define CONFIG_BOOTP_BOOTPATH
 #define CONFIG_BOOTP_GATEWAY
@@ -91,12 +89,9 @@
 #define CONFIG_PHY_MARVELL

 /* Environment */
+#define CONFIG_ENV_SIZE		0x10000 /* Env. sector size */
 #define CONFIG_ENV_IS_NOWHERE
-#define CONFIG_ENV_SIZE 0x10000
-
-#define CONFIG_SYS_NO_FLASH
-
-#define CONFIG_SYS_MALLOC_LEN		0x400000
+#define CONFIG_SYS_LOAD_ADDR	0

 /* Miscellaneous configurable options */
 #define CONFIG_SYS_PROMPT		"zynq-uboot> "
@@ -110,8 +105,6 @@
 #define CONFIG_SYS_PBSIZE		(CONFIG_SYS_CBSIZE + \
 					sizeof(CONFIG_SYS_PROMPT) + 16)

-#define CONFIG_SYS_LOAD_ADDR	0
-
 /* Physical Memory map */
 #define CONFIG_SYS_TEXT_BASE		0

@@ -122,15 +115,25 @@
 #define CONFIG_SYS_MEMTEST_START	CONFIG_SYS_SDRAM_BASE
 #define CONFIG_SYS_MEMTEST_END		(CONFIG_SYS_SDRAM_BASE + 0x1000)

+#define CONFIG_SYS_MALLOC_LEN		0x400000
 #define CONFIG_SYS_INIT_RAM_ADDR	CONFIG_SYS_SDRAM_BASE
 #define CONFIG_SYS_INIT_RAM_SIZE	CONFIG_SYS_MALLOC_LEN
 #define CONFIG_SYS_INIT_SP_ADDR		(CONFIG_SYS_INIT_RAM_ADDR + \
 					CONFIG_SYS_INIT_RAM_SIZE - \
 					GENERATED_GBL_DATA_SIZE)
-/* OF */
+
+/* Enable the PL to be downloaded */
+#define CONFIG_FPGA
+#define CONFIG_FPGA_XILINX
+#define CONFIG_FPGA_ZYNQPL
+#define CONFIG_CMD_FPGA
+
+/* Open Firmware flat tree */
+#define CONFIG_OF_LIBFDT
+
+/* FIT support */
 #define CONFIG_FIT
 #define CONFIG_FIT_VERBOSE	1 /* enable fit_format_{error,warning}() */
-#define CONFIG_OF_LIBFDT

 /* Boot FreeBSD/vxWorks from an ELF image */
 #if defined(CONFIG_ZYNQ_BOOT_FREEBSD)
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/5021a04e/attachment.sig>

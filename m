From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 20 Jan 2010 03:48:52 +0000
Subject: [PATCH] ARM: SAMSUNG: Move pm-check.c to plat-samsung
In-Reply-To: <1263959332-6264-1-git-send-email-ben-linux@fluff.org>
References: <1263959332-6264-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263959332-6264-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pm-check.c file to plat-samsung for all Samsung SoC users, and
update Kconfig names to make them SAMSUNG_ instead of S3C2410_

Sed expresions used to make the change:

    s/S3C2410_PM_DEBUG/SAMSUNG_PM_DEBUG/g
    s/S3C2410_PM_CHECK/SAMSUNG_PM_CHECK/g

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/configs/mini2440_defconfig            |    4 +-
 arch/arm/configs/s3c2410_defconfig             |    4 +-
 arch/arm/plat-s3c/Kconfig                      |   44 -----------------------
 arch/arm/plat-s3c/Makefile                     |    1 -
 arch/arm/plat-s3c/include/plat/pm.h            |    4 +-
 arch/arm/plat-s3c/pm.c                         |    6 ++--
 arch/arm/plat-samsung/Kconfig                  |   45 ++++++++++++++++++++++++
 arch/arm/plat-samsung/Makefile                 |    1 +
 arch/arm/{plat-s3c => plat-samsung}/pm-check.c |    8 ++--
 9 files changed, 59 insertions(+), 58 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/pm-check.c (95%)

diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 4c46644..ff44bd1 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -199,8 +199,8 @@ CONFIG_S3C_BOOT_UART_FORCE_FIFO=y
 #
 # Power management
 #
-# CONFIG_S3C2410_PM_DEBUG is not set
-# CONFIG_S3C2410_PM_CHECK is not set
+# CONFIG_SAMSUNG_PM_DEBUG is not set
+# CONFIG_SAMSUNG_PM_CHECK is not set
 CONFIG_S3C_LOWLEVEL_UART_PORT=0
 CONFIG_S3C_GPIO_SPACE=0
 
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 9697e97..8e94c3c 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -203,8 +203,8 @@ CONFIG_S3C_BOOT_UART_FORCE_FIFO=y
 #
 # Power management
 #
-# CONFIG_S3C2410_PM_DEBUG is not set
-# CONFIG_S3C2410_PM_CHECK is not set
+# CONFIG_SAMSUNG_PM_DEBUG is not set
+# CONFIG_SAMSUNG_PM_CHECK is not set
 CONFIG_S3C_LOWLEVEL_UART_PORT=0
 CONFIG_S3C_GPIO_SPACE=0
 CONFIG_S3C_DEV_HSMMC=y
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 454cc39..2367908 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -59,50 +59,6 @@ config S3C_BOOT_UART_FORCE_FIFO
          Say Y here to force the UART FIFOs on during the kernel
 	 uncompressor
 
-comment "Power management"
-
-config S3C2410_PM_DEBUG
-	bool "S3C2410 PM Suspend debug"
-	depends on PM
-	help
-	  Say Y here if you want verbose debugging from the PM Suspend and
-	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
-	  for more information.
-
-config S3C_PM_DEBUG_LED_SMDK
-       bool "SMDK LED suspend/resume debugging"
-       depends on PM && (MACH_SMDK6410)
-       help
-         Say Y here to enable the use of the SMDK LEDs on the baseboard
-	 for debugging of the state of the suspend and resume process.
-
-	 Note, this currently only works for S3C64XX based SMDK boards.
-
-config S3C2410_PM_CHECK
-	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM && CRC32
-	help
- 	  Enable the PM code's memory area checksum over sleep. This option
-	  will generate CRCs of all blocks of memory, and store them before
-	  going to sleep. The blocks are then checked on resume for any
-	  errors.
-
-	  Note, this can take several seconds depending on memory size
-	  and CPU speed.
-
-	  See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
-
-config S3C2410_PM_CHECK_CHUNKSIZE
-	int "S3C2410 PM Suspend CRC Chunksize (KiB)"
-	depends on PM && S3C2410_PM_CHECK
-	default 64
-	help
-	  Set the chunksize in Kilobytes of the CRC for checking memory
-	  corruption over suspend and resume. A smaller value will mean that
-	  the CRC data block will take more memory, but wil identify any
-	  faults with better precision.
-
-	  See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
 
 config S3C_LOWLEVEL_UART_PORT
 	int "S3C UART to use for low-level messages"
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 095bc97..89dbdb0 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -21,4 +21,3 @@ obj-$(CONFIG_S3C_DMA)		+= dma.o
 # PM support
 
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_S3C2410_PM_CHECK)	+= pm-check.o
diff --git a/arch/arm/plat-s3c/include/plat/pm.h b/arch/arm/plat-s3c/include/plat/pm.h
index 7a79719..2543bd2 100644
--- a/arch/arm/plat-s3c/include/plat/pm.h
+++ b/arch/arm/plat-s3c/include/plat/pm.h
@@ -111,7 +111,7 @@ extern int s3c24xx_irq_resume(struct sys_device *dev);
 
 /* PM debug functions */
 
-#ifdef CONFIG_S3C2410_PM_DEBUG
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
 /**
  * s3c_pm_dbg() - low level debug function for use in suspend/resume.
  * @msg: The message to print.
@@ -141,7 +141,7 @@ static inline void s3c_pm_debug_smdkled(u32 set, u32 clear) { }
 
 /* suspend memory checking */
 
-#ifdef CONFIG_S3C2410_PM_CHECK
+#ifdef CONFIG_SAMSUNG_PM_CHECK
 extern void s3c_pm_check_prepare(void);
 extern void s3c_pm_check_restore(void);
 extern void s3c_pm_check_cleanup(void);
diff --git a/arch/arm/plat-s3c/pm.c b/arch/arm/plat-s3c/pm.c
index 7674706..e5eef12 100644
--- a/arch/arm/plat-s3c/pm.c
+++ b/arch/arm/plat-s3c/pm.c
@@ -41,7 +41,7 @@ unsigned long s3c_pm_flags;
  * resume before the console layer is available.
 */
 
-#ifdef CONFIG_S3C2410_PM_DEBUG
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
 extern void printascii(const char *);
 
 void s3c_pm_dbg(const char *fmt, ...)
@@ -65,13 +65,13 @@ static inline void s3c_pm_debug_init(void)
 #else
 #define s3c_pm_debug_init() do { } while(0)
 
-#endif /* CONFIG_S3C2410_PM_DEBUG */
+#endif /* CONFIG_SAMSUNG_PM_DEBUG */
 
 /* Save the UART configurations if we are configured for debug. */
 
 unsigned char pm_uart_udivslot;
 
-#ifdef CONFIG_S3C2410_PM_DEBUG
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
 
 struct pm_uart_save uart_save[CONFIG_SERIAL_SAMSUNG_UARTS];
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 6484b5b..1c2fe91 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -132,4 +132,49 @@ config S3C_DEV_NAND
 	help
 	  Compile in platform device definition for NAND controller
 
+comment "Power management"
+
+config SAMSUNG_PM_DEBUG
+	bool "S3C2410 PM Suspend debug"
+	depends on PM
+	help
+	  Say Y here if you want verbose debugging from the PM Suspend and
+	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
+	  for more information.
+
+config S3C_PM_DEBUG_LED_SMDK
+       bool "SMDK LED suspend/resume debugging"
+       depends on PM && (MACH_SMDK6410)
+       help
+         Say Y here to enable the use of the SMDK LEDs on the baseboard
+	 for debugging of the state of the suspend and resume process.
+
+	 Note, this currently only works for S3C64XX based SMDK boards.
+
+config SAMSUNG_PM_CHECK
+	bool "S3C2410 PM Suspend Memory CRC"
+	depends on PM && CRC32
+	help
+	  Enable the PM code's memory area checksum over sleep. This option
+	  will generate CRCs of all blocks of memory, and store them before
+	  going to sleep. The blocks are then checked on resume for any
+	  errors.
+
+	  Note, this can take several seconds depending on memory size
+	  and CPU speed.
+
+	  See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
+
+config SAMSUNG_PM_CHECK_CHUNKSIZE
+	int "S3C2410 PM Suspend CRC Chunksize (KiB)"
+	depends on PM && SAMSUNG_PM_CHECK
+	default 64
+	help
+	  Set the chunksize in Kilobytes of the CRC for checking memory
+	  corruption over suspend and resume. A smaller value will mean that
+	  the CRC data block will take more memory, but wil identify any
+	  faults with better precision.
+
+	  See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
+
 endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index f31e64f..c8c8cae 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 # PM support
 
 obj-$(CONFIG_PM)		+= pm-gpio.o
+obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 # PWM support
 
diff --git a/arch/arm/plat-s3c/pm-check.c b/arch/arm/plat-samsung/pm-check.c
similarity index 95%
rename from arch/arm/plat-s3c/pm-check.c
rename to arch/arm/plat-samsung/pm-check.c
index 8eb1f43..0b5bb77 100644
--- a/arch/arm/plat-s3c/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -20,8 +20,8 @@
 
 #include <plat/pm.h>
 
-#if CONFIG_S3C2410_PM_CHECK_CHUNKSIZE < 1
-#error CONFIG_S3C2410_PM_CHECK_CHUNKSIZE must be a positive non-zero value
+#if CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE < 1
+#error CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE must be a positive non-zero value
 #endif
 
 /* suspend checking code...
@@ -29,12 +29,12 @@
  * this next area does a set of crc checks over all the installed
  * memory, so the system can verify if the resume was ok.
  *
- * CONFIG_S3C2410_PM_CHECK_CHUNKSIZE defines the block-size for the CRC,
+ * CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE defines the block-size for the CRC,
  * increasing it will mean that the area corrupted will be less easy to spot,
  * and reducing the size will cause the CRC save area to grow
 */
 
-#define CHECK_CHUNKSIZE (CONFIG_S3C2410_PM_CHECK_CHUNKSIZE * 1024)
+#define CHECK_CHUNKSIZE (CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE * 1024)
 
 static u32 crc_size;	/* size needed for the crc block */
 static u32 *crcs;	/* allocated over suspend/resume */
-- 
1.6.0.4

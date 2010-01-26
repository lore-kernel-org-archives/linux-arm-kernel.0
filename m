From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:03:00 +0000
Subject: [PATCH] ARM: S3C64XX: Move cpu,
	clock and gpiolib and PM support to mach-s3c64xx
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the core S3C64XX support to mach-s3c64xx as it is unlikely to be used
outside of this directory. Also move the SoC header files in with it.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/{plat-s3c64xx => mach-s3c6410}/pm.c       |    0
 arch/arm/mach-s3c64xx/Makefile                     |    7 +++++++
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/clock.c    |    2 ++
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpu.c      |    4 ++--
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/gpiolib.c  |    0
 .../plat => mach-s3c64xx/include/mach}/pll.h       |    0
 .../plat => mach-s3c64xx/include/mach}/s3c6400.h   |    3 +--
 .../plat => mach-s3c64xx/include/mach}/s3c6410.h   |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s3c64xx/s3c6400.c                    |    2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |    4 ++--
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/sleep.S    |    0
 arch/arm/plat-s3c64xx/Makefile                     |   10 ----------
 arch/arm/plat-s3c64xx/s3c6400-init.c               |    4 ++--
 18 files changed, 23 insertions(+), 25 deletions(-)
 rename arch/arm/{plat-s3c64xx => mach-s3c6410}/pm.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/clock.c (99%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpu.c (98%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/gpiolib.c (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/pll.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/s3c6400.h (95%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/s3c6410.h (93%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/sleep.S (100%)

diff --git a/arch/arm/plat-s3c64xx/pm.c b/arch/arm/mach-s3c6410/pm.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/pm.c
rename to arch/arm/mach-s3c6410/pm.c
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 49b71d5..ef8bec8 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -10,6 +10,11 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
+# Core files
+obj-y				+= cpu.o
+obj-y				+= clock.o
+obj-y				+= gpiolib.o
+
 # Core support for S3C6400 system
 
 obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
@@ -28,6 +33,8 @@ obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 
 # PM
 
+obj-$(CONFIG_PM)		+= pm.o
+obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_PM)		+= irq-pm.o
 
 # Machine support
diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
similarity index 99%
rename from arch/arm/plat-s3c64xx/clock.c
rename to arch/arm/mach-s3c64xx/clock.c
index 64439de..229bb3b 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -23,6 +23,8 @@
 
 #include <mach/regs-sys.h>
 #include <mach/regs-clock.h>
+#include <mach/pll.h>
+
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
diff --git a/arch/arm/plat-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
similarity index 98%
rename from arch/arm/plat-s3c64xx/cpu.c
rename to arch/arm/mach-s3c64xx/cpu.c
index bc7ca18..410d688 100644
--- a/arch/arm/plat-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -33,8 +33,8 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 
-#include <plat/s3c6400.h>
-#include <plat/s3c6410.h>
+#include <mach/s3c6400.h>
+#include <mach/s3c6410.h>
 
 /* table of supported CPUs */
 
diff --git a/arch/arm/plat-s3c64xx/gpiolib.c b/arch/arm/mach-s3c64xx/gpiolib.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/gpiolib.c
rename to arch/arm/mach-s3c64xx/gpiolib.c
diff --git a/arch/arm/plat-s3c64xx/include/plat/pll.h b/arch/arm/mach-s3c64xx/include/mach/pll.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/pll.h
rename to arch/arm/mach-s3c64xx/include/mach/pll.h
diff --git a/arch/arm/plat-s3c64xx/include/plat/s3c6400.h b/arch/arm/mach-s3c64xx/include/mach/s3c6400.h
similarity index 95%
rename from arch/arm/plat-s3c64xx/include/plat/s3c6400.h
rename to arch/arm/mach-s3c64xx/include/mach/s3c6400.h
index 11f2e1e..2bc7c07 100644
--- a/arch/arm/plat-s3c64xx/include/plat/s3c6400.h
+++ b/arch/arm/mach-s3c64xx/include/mach/s3c6400.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c64xx/include/plat/s3c6400.h
+/* arch/arm/mach-s3c64xx/include/macht/s3c6400.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
@@ -33,4 +33,3 @@ extern void s3c6400_init_clocks(int xtal);
 #define s3c6400_map_io NULL
 #define s3c6400_init NULL
 #endif
-
diff --git a/arch/arm/plat-s3c64xx/include/plat/s3c6410.h b/arch/arm/mach-s3c64xx/include/mach/s3c6410.h
similarity index 93%
rename from arch/arm/plat-s3c64xx/include/plat/s3c6410.h
rename to arch/arm/mach-s3c64xx/include/mach/s3c6410.h
index 50dcdd6..24f1141 100644
--- a/arch/arm/plat-s3c64xx/include/plat/s3c6410.h
+++ b/arch/arm/mach-s3c64xx/include/mach/s3c6410.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c64xx/include/plat/s3c6410.h
+/* arch/arm/mach-s3c64xx/include/mach/s3c6410.h
  *
  * Copyright 2008 Openmoko,  Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 06d8fe5..4a0bb24 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -45,7 +45,7 @@
 #include <plat/iic.h>
 #include <plat/fb.h>
 
-#include <plat/s3c6410.h>
+#include <mach/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 284886c..a6d91c3 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -38,7 +38,7 @@
 #include <plat/fb.h>
 #include <plat/nand.h>
 
-#include <plat/s3c6410.h>
+#include <mach/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 9be92dd..bf65747 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -40,7 +40,7 @@
 #include <plat/iic.h>
 #include <plat/fb.h>
 
-#include <plat/s3c6410.h>
+#include <mach/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index ba8a052..f7b1898 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -31,7 +31,7 @@
 
 #include <plat/regs-serial.h>
 
-#include <plat/s3c6400.h>
+#include <mach/s3c6400.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 021670e..fdf8f75 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -54,7 +54,7 @@
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
-#include <plat/s3c6410.h>
+#include <mach/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 2fba1b2..720d0d1 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -37,7 +37,7 @@
 #include <plat/clock.h>
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
-#include <plat/s3c6400.h>
+#include <mach/s3c6400.h>
 
 void __init s3c6400_map_io(void)
 {
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index b881d6a..fd457cc 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -38,8 +38,8 @@
 #include <plat/clock.h>
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
-#include <plat/s3c6400.h>
-#include <plat/s3c6410.h>
+#include <mach/s3c6400.h>
+#include <mach/s3c6410.h>
 
 void __init s3c6410_map_io(void)
 {
diff --git a/arch/arm/plat-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
similarity index 100%
rename from arch/arm/plat-s3c64xx/sleep.S
rename to arch/arm/mach-s3c64xx/sleep.S
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index 187b779..60d7990 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -10,22 +10,12 @@ obj-m				:=
 obj-n				:= dummy.o
 obj-				:=
 
-# Core files
-obj-y				+= cpu.o
-obj-y				+= clock.o
-obj-y				+= gpiolib.o
-
 # CPU support
 
 obj-$(CONFIG_CPU_S3C6400_INIT)	+= s3c6400-init.o
 obj-$(CONFIG_CPU_S3C6400_CLOCK)	+= s3c6400-clock.o
 obj-$(CONFIG_CPU_FREQ_S3C64XX)  += cpufreq.o
 
-# PM support
-
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= sleep.o
-
 # DMA support
 
 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
diff --git a/arch/arm/plat-s3c64xx/s3c6400-init.c b/arch/arm/plat-s3c64xx/s3c6400-init.c
index 6c28f39..e64caa4 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-init.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-init.c
@@ -18,8 +18,8 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/s3c6400.h>
-#include <plat/s3c6410.h>
+#include <mach/s3c6400.h>
+#include <mach/s3c6410.h>
 
 /* uart registration process */
 
-- 
1.6.0.4

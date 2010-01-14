From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:21 +0100
Subject: [PATCH 03/21] ARM: S5PC1XX: create sub-platform for S5PC100 SoCs
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC100 and S5PC110 SoCs differs a lot in register map and other
core platform definitions, so it is not possible to have both SoCs in
the current platform framework without runtime hacks. To address this
issue a sub-platform has been introduced, so each SoC in sub-platform
can have its own set of include files (register map, irq&gpio
definitions, etc)

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/Makefile             |    2 +-
 arch/arm/mach-s5pc100/Kconfig |    4 ++++
 arch/arm/plat-s5pc1xx/Kconfig |   10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e9da084..f00d2d8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -161,7 +161,7 @@ machine-$(CONFIG_ARCH_RPC)		:= rpc
 machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c2443
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
-machine-$(CONFIG_ARCH_S5PC1XX)		:= s5pc100
+machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 27ec167..0628bc3 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -3,6 +3,8 @@
 #
 # Licensed under GPLv2
 
+if ARCH_S5PC100
+
 # Configuration options for the S5PC100 CPU
 
 config CPU_S5PC100
@@ -32,3 +34,5 @@ config MACH_SMDKC100
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
+
+endif
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index c7ccdf2..38f8998 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -24,6 +24,16 @@ config PLAT_S5PC1XX
 
 if PLAT_S5PC1XX
 
+choice
+	prompt "S5PC1xx SoC Type"
+	default ARCH_S5PC100
+
+config ARCH_S5PC100
+	bool "S5PC100"
+
+endchoice
+
+
 # Configuration options shared by all S3C64XX implementations
 
 config CPU_S5PC100_INIT
-- 
1.6.4

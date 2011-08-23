From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:30:38 +0100
Subject: [PATCH v2 1/5] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
References: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314135042-19908-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling CONFIG_DEBUG_LL (which is required for earlyprintk) hardwires
the debug UART address into the kernel, so that we can print before the
platform is initialised.

If the user inadvertently selects multiple platforms with DEBUG_LL
enabled, the UART address may not be correct and will likely cause the
kernel to hang in the very early stages of boot.

This patch, based on a skeleton from Russell, uses a Kconfig choice for
selecting the DEBUG_LL UART, therefore allowing the user to make a
choice about the supported platform when DEBUG_LL is enabled.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..11604c9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -72,6 +72,30 @@ config DEBUG_LL
 	  in the kernel.  This is helpful if you are debugging code that
 	  executes before the console is initialized.
 
+choice
+	prompt "Kernel low-level debugging port"
+	depends on DEBUG_LL
+
+	config DEBUG_DC21285_PORT
+		bool "Kernel low-level debugging messages via footbridge serial port"
+		depends on FOOTBRIDGE
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port in the DC21285 (Footbridge).
+		  Saying N will cause the debug messages to appear on the first
+		  16550 serial port.
+
+	config DEBUG_CLPS711X_UART2
+		bool "Kernel low-level debugging messages via UART2"
+		depends on ARCH_CLPS711X
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the second serial port on these devices.
+		  Saying N will cause the debug messages to appear on the first
+		  serial port.
+
+endchoice
+
 config EARLY_PRINTK
 	bool "Early printk"
 	depends on DEBUG_LL
@@ -100,23 +124,6 @@ config OC_ETM
 	  buffer driver that will allow you to collect traces of the
 	  kernel code.
 
-config DEBUG_DC21285_PORT
-	bool "Kernel low-level debugging messages via footbridge serial port"
-	depends on DEBUG_LL && FOOTBRIDGE
-	help
-	  Say Y here if you want the debug print routines to direct their
-	  output to the serial port in the DC21285 (Footbridge). Saying N
-	  will cause the debug messages to appear on the first 16550
-	  serial port.
-
-config DEBUG_CLPS711X_UART2
-	bool "Kernel low-level debugging messages via UART2"
-	depends on DEBUG_LL && ARCH_CLPS711X
-	help
-	  Say Y here if you want the debug print routines to direct their
-	  output to the second serial port on these devices.  Saying N will
-	  cause the debug messages to appear on the first serial port.
-
 config DEBUG_S3C_UART
 	depends on PLAT_SAMSUNG
 	int "S3C UART to use for low-level debug"
-- 
1.7.0.4

From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 28 Oct 2014 21:31:35 +0800
Subject: [PATCH v2 5/5] ARM: use early console instead of early debug in
 allmodconfig kernels
In-Reply-To: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1414503095-25986-6-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early debug could break something when booting 'allmodconfig'
kernels. So we use early console instead of early debug.

The early console didn't work yet on OMAP4460 because of missing
earlycon support and I am working on that.

Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
---
 arch/arm/Kconfig.debug | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 03dc4c1..897e4ab 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -78,7 +78,7 @@ config DEBUG_USER
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
 	bool "Kernel low-level debugging functions (read help!)"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !ARCH_MULTIPLATFORM_STRICT
 	help
 	  Say Y here to include definitions of printascii, printch, printhex
 	  in the kernel.  This is helpful if you are debugging code that
@@ -1297,6 +1297,29 @@ config EARLY_PRINTK
 	  kernel low-level debugging functions. Add earlyprintk to your
 	  kernel parameters to enable this console.
 
+config FORCE_EARLY_CONSOLE
+	bool "Enable all early console drivers"
+	depends on DEBUG_KERNEL && ARCH_MULTIPLATFORM_STRICT
+	select TTY
+	select SERIAL_8250
+	select SERIAL_8250_CONSOLE
+	select SERIAL_AMBA_PL011
+	select SERIAL_AMBA_PL011_CONSOLE
+	select SERIAL_EARLYCON_ARM_SEMIHOST
+	select SERIAL_MSM
+	select SERIAL_MSM_CONSOLE
+	select SERIAL_XILINX_PS_UART
+	select SERIAL_XILINX_PS_UART_CONSOLE
+	help
+	  On strict multiplatform configurations, the early debug code
+	  is not available, so the early console code should be used
+	  for debugging the startup code.
+	  This option ensures that all of the earlycon drivers are enabled,
+	  which is mainly useful for booting 'allmodconfig' kernels.
+
+	  It is always safe to say 'N' here for a smaller kernel and to
+	  select the required options individually.
+
 config OC_ETM
 	bool "On-chip ETM and ETB"
 	depends on ARM_AMBA
-- 
2.1.1

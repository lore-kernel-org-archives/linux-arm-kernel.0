From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:50 -0700
Subject: [PATCH 11/20 v2] msm: allow uart to be conditionally disabled
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-12-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Walker <dwalker@codeaurora.org>

Some MSM targets don't select the debug UART in this way. For those we
need to disable this selection mechanism.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig                    |    8 ++++++++
 arch/arm/mach-msm/include/mach/debug-macro.S |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index be05acc..def2a64 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -11,6 +11,7 @@ config ARCH_MSM7X00A
 	select MSM_SMD_PKG3
 	select CPU_V6
 	select MSM_PROC_COMM
+	select HAS_MSM_DEBUG_UART_PHYS
 
 config ARCH_MSM7X30
 	bool "MSM7x30"
@@ -20,6 +21,7 @@ config ARCH_MSM7X30
 	select CPU_V7
 	select MSM_REMOTE_SPINLOCK_DEKKERS
 	select MSM_PROC_COMM
+	select HAS_MSM_DEBUG_UART_PHYS
 
 config ARCH_QSD8X50
 	bool "QSD8X50"
@@ -29,6 +31,7 @@ config ARCH_QSD8X50
 	select CPU_V7
 	select MSM_REMOTE_SPINLOCK_LDREX
 	select MSM_PROC_COMM
+	select HAS_MSM_DEBUG_UART_PHYS
 
 endchoice
 
@@ -40,6 +43,9 @@ config  ARCH_MSM_ARM11
 config  ARCH_MSM_SCORPION
 	bool
 
+config HAS_MSM_DEBUG_UART_PHYS
+	bool
+
 config  MSM_VIC
 	bool
 
@@ -92,6 +98,7 @@ config MSM_DEBUG_UART
 	default 2 if MSM_DEBUG_UART2
 	default 3 if MSM_DEBUG_UART3
 
+if HAS_MSM_DEBUG_UART_PHYS
 choice
 	prompt "Debug UART"
 
@@ -109,6 +116,7 @@ choice
 	config MSM_DEBUG_UART3
 		bool "UART3"
 endchoice
+endif
 
 config MSM_SMD_PKG3
 	bool
diff --git a/arch/arm/mach-msm/include/mach/debug-macro.S b/arch/arm/mach-msm/include/mach/debug-macro.S
index 528750f..238c4f1 100644
--- a/arch/arm/mach-msm/include/mach/debug-macro.S
+++ b/arch/arm/mach-msm/include/mach/debug-macro.S
@@ -19,7 +19,7 @@
 #include <mach/hardware.h>
 #include <mach/msm_iomap.h>
 
-#ifdef CONFIG_MSM_DEBUG_UART
+#ifdef CONFIG_HAS_MSM_DEBUG_UART_PHYS
 	.macro	addruart, rx, tmp
 	@ see if the MMU is enabled and select appropriate base address
 	mrc	p15, 0, \rx, c1, c0
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

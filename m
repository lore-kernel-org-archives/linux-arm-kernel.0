From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 24 Aug 2010 21:57:44 -0700
Subject: [PATCH 15/24] msm: allow uart to be conditionally disabled
In-Reply-To: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282712273-344-16-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Walker <dwalker@codeaurora.org>

Some MSM targets don't select the debug UART in this way. For those we
need to disable this selection mechanism.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig                    |    8 +++++++-
 arch/arm/mach-msm/include/mach/debug-macro.S |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 60ad211..27fc183 100644
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
 
@@ -41,7 +44,8 @@ config  ARCH_MSM_SCORPION
 	bool
 config  ARCH_MSM_SCORPIONMP
 	bool
-
+config HAS_MSM_DEBUG_UART_PHYS
+	bool
 config  MSM_VIC
 	bool
 
@@ -95,6 +99,7 @@ config MSM_DEBUG_UART
 	default 2 if MSM_DEBUG_UART2
 	default 3 if MSM_DEBUG_UART3
 
+if HAS_MSM_DEBUG_UART_PHYS
 choice
 	prompt "Debug UART"
 
@@ -112,6 +117,7 @@ choice
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

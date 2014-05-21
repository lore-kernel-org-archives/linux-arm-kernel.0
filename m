From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Wed, 21 May 2014 17:57:05 +0300
Subject: [PATCH v1 4/4] ARM: debug: qcom: Add APQ8084 DEBUG_LL UART support
In-Reply-To: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
References: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1400684225-21381-5-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug UART support for Qualcomm APQ8084 SoC. This patch
adds a Kconfig entry and the base address of the debug UART.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/Kconfig.debug       |    9 +++++++++
 arch/arm/include/debug/msm.S |    5 +++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index eab8ecb..91d5184 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -101,6 +101,15 @@ choice
 		bool "Kernel low-level debugging on 9263 and 9g45"
 		depends on HAVE_AT91_DBGU1
 
+	config DEBUG_APQ8084_UART
+		bool "Kernel low-level debugging messages via APQ8084 UART"
+		depends on ARCH_QCOM
+		select MSM_HAS_DEBUG_UART_HS
+		select DEBUG_MSM_UART
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port on Qualcomm APQ8084 devices.
+
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835
diff --git a/arch/arm/include/debug/msm.S b/arch/arm/include/debug/msm.S
index 9d653d4..178636d 100644
--- a/arch/arm/include/debug/msm.S
+++ b/arch/arm/include/debug/msm.S
@@ -36,6 +36,11 @@
 #define MSM_DEBUG_UART_PHYS	MSM_UART3_PHYS
 #endif
 
+#ifdef CONFIG_DEBUG_APQ8084_UART
+#define MSM_DEBUG_UART_BASE	0xFA75E000
+#define MSM_DEBUG_UART_PHYS	0xF995E000
+#endif
+
 #ifdef CONFIG_DEBUG_MSM8660_UART
 #define MSM_DEBUG_UART_BASE	0xF0040000
 #define MSM_DEBUG_UART_PHYS	0x19C40000
-- 
1.7.9.5

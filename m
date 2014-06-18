From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 18 Jun 2014 09:48:33 +0100
Subject: [PATCH v1] ARM: debug: fix broken DEBUG_LL_INCLUDE for multi platform
In-Reply-To: <1402394236-14778-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1402394236-14778-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1403081313-28234-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On multi_v7_defconfig using def_bool in Kconfig can override the selection
made as part of DEBUG_LL. This is because def_bool will set the config to true
if the expression evaluates to true, which is what was happening in
multi_v7_defconfig. ARCH_SPEAR13XX selects DEBUG_UART_PL01X overriding any
previous DEBUG_LL selections and resulting in DEBUG_LL_INCLUDE to
always point to debug/pl01x.S.

Choice menu already provides options for selecting pl01x and 8250 via
DEBUG_LL_UART_PL01X and DEBUG_LL_UART_8250 options. so I don't see point of
having dependencies or def_bool options for PL01X and 8250.
Other than getting them selected automatically and overriding
DEBUG_LL selections.

Without this patch its impossible to get earlyprintk working with multi_v7_defconfig

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Am resending this patch as I missed arm-soc people in the loop.


 arch/arm/Kconfig.debug | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..4ee4103 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1019,22 +1019,11 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
-# Compatibility options for PL01x
 config DEBUG_UART_PL01X
-	def_bool ARCH_EP93XX || \
-		ARCH_INTEGRATOR || \
-		ARCH_SPEAR3XX || \
-		ARCH_SPEAR6XX || \
-		ARCH_SPEAR13XX || \
-		ARCH_VERSATILE
-
-# Compatibility options for 8250
+	bool
+
 config DEBUG_UART_8250
-	def_bool ARCH_DOVE || ARCH_EBSA110 || \
-		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
-		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
-		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
-		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
+	bool
 
 config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
-- 
1.9.1

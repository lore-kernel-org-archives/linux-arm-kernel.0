From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri,  4 Apr 2014 12:17:49 +0100
Subject: [PATCH] arm: Fix DEBUG_LL for multi-platform kernels (without PL01X)
Message-ID: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a multi_v7_defconfig kernel it is not possible to configure
DEBUG_LL to use any serial device except a ARM Primecell PL01X, or more
accurately and worse, it is possible to configure a different serial
device but KConfig does not honour this request.

The happens because the multi-platform mode may include ARCH_SPEAR13XX
and this forcibly engages DEBUG_UART_PL01X to provide some kind of
compatibility with single platform builds (SPEAr supports both single and
multi-platform). This in turn causes DEBUG_LL_INCLUDE to wedge at
debug/pl01x.S.

Problem is fixed by only deploying the compatibility options for SPEAr
when ARCH_MULTIPLATFORM is not set.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8..f10c784 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -991,9 +991,9 @@ config DEBUG_LL_INCLUDE
 config DEBUG_UART_PL01X
 	def_bool ARCH_EP93XX || \
 		ARCH_INTEGRATOR || \
-		ARCH_SPEAR3XX || \
-		ARCH_SPEAR6XX || \
-		ARCH_SPEAR13XX || \
+		(ARCH_SPEAR3XX && !ARCH_MULTIPLATFORM) || \
+		(ARCH_SPEAR6XX && !ARCH_MULTIPLATFORM) || \
+		(ARCH_SPEAR13XX && !ARCH_MULTIPLATFORM) || \
 		ARCH_VERSATILE
 
 # Compatibility options for 8250
-- 
1.9.0

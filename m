From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri,  4 Apr 2014 15:47:27 +0100
Subject: [PATCH v2] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
References: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1396622847-12718-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a multi_v7_defconfig kernel it is not possible to configure
DEBUG_LL to use any serial device except a ARM Primecell PL01X, or more
accurately and worse, it is possible to configure a different serial
device but KConfig does not honour this request.

This happens because DEBUG_UART_PL01X, which is intended to provide some
kind of compatibility with single platform builds, spuriously depends upon
ARCH_SPEAR13XX (and similar SPEAr options).

Problem is fixed by removing problematic dependancies.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    v2: Remove pointless single platform support (thanks Arnd Bergmann)

 arch/arm/Kconfig.debug | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8..e554d35 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -991,9 +991,6 @@ config DEBUG_LL_INCLUDE
 config DEBUG_UART_PL01X
 	def_bool ARCH_EP93XX || \
 		ARCH_INTEGRATOR || \
-		ARCH_SPEAR3XX || \
-		ARCH_SPEAR6XX || \
-		ARCH_SPEAR13XX || \
 		ARCH_VERSATILE
 
 # Compatibility options for 8250
-- 
1.9.0

From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 24 Oct 2014 11:54:36 +0100
Subject: [PATCH v12 15/15] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1414148076-12685-16-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a multi_v7_defconfig kernel it is not possible to configure
DEBUG_LL to use any serial device except a ARM Primecell PL01X, or more
accurately and worse, it is possible to configure a different serial
device but KConfig does not honour this request. In fact this also
overrides the user selection for some of the single platform kernels, for
example I don't think DEBUG_LL can be targeted at ICE or semihosted
supervisor for ARCH_VERSATILE.

This happens because DEBUG_UART_PL01X is automatically enabled by
some architectures and this means user decisions made regarding
the DEBUG_LL backend will be overridden. Problem is fixed by removing the
automatic enabling of this option.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 3f7ebc8..fc7f8a70 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1161,12 +1161,7 @@ config DEBUG_LL_INCLUDE
 
 # Compatibility options for PL01x
 config DEBUG_UART_PL01X
-	def_bool ARCH_EP93XX || \
-		ARCH_INTEGRATOR || \
-		ARCH_SPEAR3XX || \
-		ARCH_SPEAR6XX || \
-		ARCH_SPEAR13XX || \
-		ARCH_VERSATILE
+	bool
 
 # Compatibility options for 8250
 config DEBUG_UART_8250
-- 
1.9.3

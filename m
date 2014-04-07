From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  7 Apr 2014 16:54:15 +0100
Subject: [PATCH v4 4/5] arm: Seperate DEBUG_UART_PHYS from DEBUG_LL on EP93XX
In-Reply-To: <1396886056-18132-1-git-send-email-daniel.thompson@linaro.org>
References: <1396626102-13991-1-git-send-email-daniel.thompson@linaro.org>
 <1396886056-18132-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1396886056-18132-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On EP93XX uncompress.h uses CONFIG_DEBUG_UART_PHYS instead of a hard
coded serial port. This means the build breaks when DEBUG_LL
(and DEBUG_LL_UART_PL01X) is not enabled.

This is fixed by adding a new dependancy.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Having ARCH_EP93XX on its own here looks somewhat anomalous but
    I have searched for other users of CONFIG_DEBUG_UART_PHYS/VIRT
    (outside of DEBUG_LL) but I think the EP93XX really is unique
    here.

 arch/arm/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0702d6d..50fdc86 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1073,7 +1073,8 @@ config DEBUG_UART_PHYS
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		ARCH_EP93XX
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
-- 
1.9.0

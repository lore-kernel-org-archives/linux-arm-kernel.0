From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:23 +0100
Subject: [PATCH 07/11] ARM: integrator: fix build with INTEGRATOR_AP off
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
Message-ID: <1360849767-1463135-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conditional declaration of ap_uart_data is broken
and causes this build error:

In file included from arch/arm/mach-integrator/core.c:35:0:
arch/arm/mach-integrator/common.h:6:37: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token

Turning the check into an constant-expression if(IS_ENABLED()) statement
creates more readable code and solves this problem as well.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-integrator/common.h | 5 -----
 arch/arm/mach-integrator/core.c   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index 79197d8..72516658b 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1,10 +1,5 @@
 #include <linux/amba/serial.h>
-#ifdef CONFIG_ARCH_INTEGRATOR_AP
 extern struct amba_pl010_data ap_uart_data;
-#else
-/* Not used without Integrator/AP support anyway */
-struct amba_pl010_data ap_uart_data {};
-#endif
 void integrator_init_early(void);
 int integrator_init(bool is_cp);
 void integrator_reserve(void);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 39c060f..81461d2 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -71,7 +71,7 @@ int __init integrator_init(bool is_cp)
 	 * hard-code them. The Integator/CP and forward have proper cell IDs.
 	 * Else we leave them undefined to the bus driver can autoprobe them.
 	 */
-	if (!is_cp) {
+	if (!is_cp && IS_ENABLED(CONFIG_ARCH_INTEGRATOR_AP)) {
 		rtc_device.periphid	= 0x00041030;
 		uart0_device.periphid	= 0x00041010;
 		uart1_device.periphid	= 0x00041010;
-- 
1.8.1.2

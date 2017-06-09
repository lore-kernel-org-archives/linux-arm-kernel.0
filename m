From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  9 Jun 2017 12:18:02 +0200
Subject: [PATCH] ARM: at91: fix at91_suspend_entering_slow_clock link error
Message-ID: <20170609101821.2776168-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARCH_AT91 is enabled, but none of the specific SoC support
is in use, some at91 specific drivers fail to link:

drivers/tty/serial/atmel_serial.o: In function `atmel_serial_suspend':
atmel_serial.c:(.text.atmel_serial_suspend+0x1e): undefined reference to `at91_suspend_entering_slow_clock'
drivers/usb/host/ohci-at91.o: In function `ohci_hcd_at91_drv_suspend':
ohci-at91.c:(.text.ohci_hcd_at91_drv_suspend+0x12): undefined reference to `at91_suspend_entering_slow_clock'
drivers/usb/gadget/udc/at91_udc.o: In function `at91udc_suspend':
at91_udc.c:(.text.at91udc_suspend+0x26): undefined reference to `at91_suspend_entering_slow_clock'

This changes the at91_suspend_entering_slow_clock hack once more, adding
an alternative inline implementation that is used exactly in those cases
that don't provide the normal implementation.

Fixes: c1892c2379d2 ("ARM: at91: handle CONFIG_PM for armv7m configurations")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-at91/samv7.c          | 9 ---------
 include/linux/platform_data/atmel.h | 7 +++++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/samv7.c b/arch/arm/mach-at91/samv7.c
index 910f0c68db62..11386f190c83 100644
--- a/arch/arm/mach-at91/samv7.c
+++ b/arch/arm/mach-at91/samv7.c
@@ -15,15 +15,6 @@
 #include <asm/system_misc.h>
 #include "generic.h"
 
-#ifdef CONFIG_PM
-/* This function has to be defined for various drivers that are using it */
-int at91_suspend_entering_slow_clock(void)
-{
-	return 0;
-}
-EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
-#endif
-
 static const char *const samv7_dt_board_compat[] __initconst = {
 	"atmel,samv7",
 	NULL
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 3c8825b67298..7b6dce7d6d33 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -52,6 +52,13 @@ struct atmel_uart_data {
 };
 
 /* FIXME: this needs a better location, but gets stuff building again */
+#ifdef CONFIG_ATMEL_PM
 extern int at91_suspend_entering_slow_clock(void);
+#else
+static inline int at91_suspend_entering_slow_clock(void)
+{
+	return 0;
+}
+#endif
 
 #endif /* __ATMEL_H__ */
-- 
2.9.0

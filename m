From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 14 Dec 2012 16:26:28 +0100
Subject: [PATCH] ARM: ux500: fix missing include
Message-ID: <1355498788-8702-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Commit db298da2c31e1dcf7c9b7c9cef6217ad3449ebb7
"ARM: nomadik: move platform_data definition"
moved the Ux500-specific musb header from <mach/usb.h>
to <linux/platform_data/usb-musb-ux500.h>

However that makes some board code fail to compile
now:

CC      arch/arm/mach-ux500/board-mop500.o
linux/arch/arm/mach-ux500/cpu-db8500.c: In function 'u8500_init_devices':
linux/arch/arm/mach-ux500/cpu-db8500.c:226:2: error: implicit declaration of function 'ux500_add_usb' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[3]: *** [arch/arm/mach-ux500/cpu-db8500.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [arch/arm/mach-ux500] Error 2
make[2]: *** Waiting for unfinished jobs....

So fix this up by adding the proper include file that
appears to have been brought in implicitly one or another
way in the past.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC guys,
here is another patch I'd like to be applied right off on
the ARM SoC tree as a fixup for problems emerging during
the merge window.
---
 arch/arm/mach-ux500/devices-db8500.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 4b24c99..a5e05f6 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -8,6 +8,7 @@
 #ifndef __DEVICES_DB8500_H
 #define __DEVICES_DB8500_H
 
+#include <linux/platform_data/usb-musb-ux500.h>
 #include <mach/irqs.h>
 #include "devices-common.h"
 
-- 
1.7.11.3

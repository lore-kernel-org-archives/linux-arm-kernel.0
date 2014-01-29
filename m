From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jan 2014 13:23:14 +0100
Subject: [PATCH] ARM: sa1100: fix compile problem on Collie
Message-ID: <1390998194-9197-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a problem in the MFD Kconfig it was not possible to
compile the UCB battery driver for the Collie SA1100 system,
in turn making it impossible to compile in the battery driver.
(See patch "mfd: include all drivers in subsystem menu".)

After fixing the MFD Kconfig (separate patch) a compile error
appears in the Collie battery driver due to the <mach/collie.h>
implicitly requiring <mach/hardware.h> through <linux/gpio.h>
via <mach/gpio.h> prior to commit
40ca061b "ARM: 7841/1: sa1100: remove complex GPIO interface".

Fix this up by including the required header into
<mach/collie.h>.

Cc: stable at vger.kernel.org
Cc: Andrea Adami <andrea.adami@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/include/mach/collie.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sa1100/include/mach/collie.h b/arch/arm/mach-sa1100/include/mach/collie.h
index f33679d2d3ee..50e1d850ee2e 100644
--- a/arch/arm/mach-sa1100/include/mach/collie.h
+++ b/arch/arm/mach-sa1100/include/mach/collie.h
@@ -13,6 +13,8 @@
 #ifndef __ASM_ARCH_COLLIE_H
 #define __ASM_ARCH_COLLIE_H
 
+#include "hardware.h" /* Gives GPIO_MAX */
+
 extern void locomolcd_power(int on);
 
 #define COLLIE_SCOOP_GPIO_BASE	(GPIO_MAX + 1)
-- 
1.8.5.3

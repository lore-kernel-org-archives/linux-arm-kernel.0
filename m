From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2012 18:02:48 +0200
Subject: [PATCH V5 4/6] arm: mvebu: add L2 cache support
In-Reply-To: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
References: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1348675370-16359-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-mvebu/Kconfig             |    1 +
 arch/arm/mach-mvebu/irq-armada-370-xp.c |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index caa2c5e..e20c5e9 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -6,6 +6,7 @@ config MACH_ARMADA_370_XP
 	bool "Marvell Armada 370 and Aramada XP boards"
 	select ARMADA_370_XP_TIMER
 	select CPU_V7
+	select CACHE_L2X0
 	help
 
 	  Say 'Y' here if you want your kernel to support boards based on
diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 5f5f939..570be84 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -24,6 +24,7 @@
 #include <linux/irqdomain.h>
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
+#include <asm/hardware/cache-l2x0.h>
 
 /* Interrupt Controller Registers Map */
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
@@ -130,4 +131,7 @@ static const struct of_device_id mpic_of_match[] __initconst = {
 void __init armada_370_xp_init_irq(void)
 {
 	of_irq_init(mpic_of_match);
+#ifdef CONFIG_CACHE_L2X0
+	l2x0_of_init(0, ~0UL);
+#endif
 }
-- 
1.7.9.5

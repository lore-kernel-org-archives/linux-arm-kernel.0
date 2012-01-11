From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:32 +1100
Subject: [PATCH 07/11] ep93xx: Make syscon access functions private to SoC
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-8-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syscon access functions are no longer used outside of the core
EP93xx code. Move their definitions into the SoC code.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c                 |    1 +
 arch/arm/mach-ep93xx/core.c                  |    2 --
 arch/arm/mach-ep93xx/include/mach/platform.h |   14 --------------
 arch/arm/mach-ep93xx/soc.h                   |   14 ++++++++++++++
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index ca4de71..c95dbce 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -25,6 +25,7 @@
 
 #include <asm/div64.h>
 
+#include "soc.h"
 
 struct clk {
 	struct clk	*parent;
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 0726b7b..44beb5f 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -205,7 +205,6 @@ void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg)
 
 	spin_unlock_irqrestore(&syscon_swlock, flags);
 }
-EXPORT_SYMBOL(ep93xx_syscon_swlocked_write);
 
 void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
 {
@@ -222,7 +221,6 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
 
 	spin_unlock_irqrestore(&syscon_swlock, flags);
 }
-EXPORT_SYMBOL(ep93xx_devcfg_set_clear);
 
 /**
  * ep93xx_chip_revision() - returns the EP93xx chip revision
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 35e5d73..b7fb10f 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -21,20 +21,6 @@ struct ep93xx_eth_data
 void ep93xx_map_io(void);
 void ep93xx_init_irq(void);
 
-/* EP93xx System Controller software locked register write */
-void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg);
-void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits);
-
-static inline void ep93xx_devcfg_set_bits(unsigned int bits)
-{
-	ep93xx_devcfg_set_clear(bits, 0x00);
-}
-
-static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
-{
-	ep93xx_devcfg_set_clear(0x00, bits);
-}
-
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
 #define EP93XX_CHIP_REV_E0	5
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index b0ef89b..958282a 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -13,6 +13,20 @@
 #ifndef _EP93XX_SOC_H
 #define _EP93XX_SOC_H
 
+/* EP93xx System Controller software locked register write */
+void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg);
+void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits);
+
+static inline void ep93xx_devcfg_set_bits(unsigned int bits)
+{
+	ep93xx_devcfg_set_clear(bits, 0x00);
+}
+
+static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
+{
+	ep93xx_devcfg_set_clear(0x00, bits);
+}
+
 /*
  * EP93xx Physical Memory Map:
  *
-- 
1.7.0.4

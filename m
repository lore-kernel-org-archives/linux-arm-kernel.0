From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:19 +1100
Subject: [PATCH v4 08/11] ep93xx: Make syscon access functions private to SoC
Message-ID: <1331592502-9083-9-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syscon access functions are no longer used outside of the core
EP93xx code. Move their definitions into the SoC code.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
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
index bab6e47..c9511fe 100644
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
index ad63d4b..602bd87 100644
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
index a22e11b..1273013 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -104,4 +104,18 @@
 #define EP93XX_WATCHDOG_PHYS_BASE	EP93XX_APB_PHYS(0x00140000)
 #define EP93XX_WATCHDOG_BASE		EP93XX_APB_IOMEM(0x00140000)
 
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
 #endif /* _EP93XX_PHYS_BASE_H */
-- 
1.7.0.4

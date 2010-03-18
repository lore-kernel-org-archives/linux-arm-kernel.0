From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 18 Mar 2010 19:00:01 +0200
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
Message-ID: <c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a new function: ep93xx_chip_revision() which reads chip revision from the
sysconfig register.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/core.c                  |   14 ++++++++++++++
 arch/arm/mach-ep93xx/include/mach/platform.h |    8 ++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..07572bb 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -222,6 +222,20 @@ void ep93xx_devcfg_set_clear(unsigned int set_bits, unsigned int clear_bits)
 }
 EXPORT_SYMBOL(ep93xx_devcfg_set_clear);
 
+/**
+ * ep93xx_chip_revision() - returns the EP93xx chip revision
+ *
+ * See <mach/platform.h> for more information.
+ */
+unsigned int ep93xx_chip_revision(void)
+{
+	unsigned int v;
+
+	v = __raw_readl(EP93XX_SYSCON_SYSCFG);
+	v &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return v;
+}
 
 /*************************************************************************
  * EP93xx peripheral handling
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index c6dc14d..b663390 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -33,6 +33,14 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 	ep93xx_devcfg_set_clear(0x00, bits);
 }
 
+#define EP93XX_CHIP_REV_D0	3
+#define EP93XX_CHIP_REV_D1	4
+#define EP93XX_CHIP_REV_E0	5
+#define EP93XX_CHIP_REV_E1	6
+#define EP93XX_CHIP_REV_E2	7
+
+unsigned int ep93xx_chip_revision(void);
+
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 			 struct i2c_board_info *devices, int num);
-- 
1.5.6.5

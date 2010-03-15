From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 15 Mar 2010 18:26:11 +0200
Subject: [PATCH 2/3] ep93xx: added chip revision reading function
In-Reply-To: <774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg@iki.fi>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg@iki.fi>
Message-ID: <3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a new function: ep93xx_chip_revision() which reads chip revision from the
sysconfig register.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/core.c                  |   26 ++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/platform.h |   11 +++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..2e496c9 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -64,6 +64,32 @@ void __init ep93xx_map_io(void)
 	iotable_init(ep93xx_io_desc, ARRAY_SIZE(ep93xx_io_desc));
 }
 
+/**
+ * ep93xx_chip_revision() - returns EP93xx chip revision
+ *
+ * Returns EP93xx chip revision number read from sysconfig register. Possible
+ * values can be one of the following:
+ *
+ * %EP93XX_CHIP_REV_A
+ * %EP93XX_CHIP_REV_B
+ * %EP93XX_CHIP_REV_C
+ * %EP93XX_CHIP_REV_D0
+ * %EP93XX_CHIP_REV_D1
+ * %EP93XX_CHIP_REV_E0
+ * %EP93XX_CHIP_REV_E1
+ * %EP93XX_CHIP_REV_E2
+ *
+ * and in future maybe something else. See also <mach/platform.h>.
+ */
+u8 ep93xx_chip_revision(void)
+{
+	u32 v;
+
+	v = __raw_readl(EP93XX_SYSCON_SYSCFG);
+	v &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return (u8)v;
+}
 
 /*************************************************************************
  * Timer handling for EP93xx
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index c6dc14d..8603837 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -33,6 +33,17 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 	ep93xx_devcfg_set_clear(0x00, bits);
 }
 
+#define EP93XX_CHIP_REV_A      0
+#define EP93XX_CHIP_REV_B      1
+#define EP93XX_CHIP_REV_C      2
+#define EP93XX_CHIP_REV_D0     3
+#define EP93XX_CHIP_REV_D1     4
+#define EP93XX_CHIP_REV_E0     5
+#define EP93XX_CHIP_REV_E1     6
+#define EP93XX_CHIP_REV_E2     7
+
+u8 ep93xx_chip_revision(void);
+
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 			 struct i2c_board_info *devices, int num);
-- 
1.5.6.5

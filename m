From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Nov 2016 11:16:15 +0800
Subject: [PATCH v2 1/2] mfd: axp20x: Add address extension registers for
 AXP806 regmap
In-Reply-To: <20161123031616.10114-1-wens@csie.org>
References: <20161123031616.10114-1-wens@csie.org>
Message-ID: <20161123031616.10114-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP806 supports either master/standalone or slave mode.
Slave mode allows sharing the serial bus, even with multiple
AXP806 which all have the same hardware address.

This is done with extra "serial interface address extension",
or AXP806_BUS_ADDR_EXT, and "register address extension", or
AXP806_REG_ADDR_EXT, registers. The former is read-only, with
1 bit customizable at the factory, and 1 bit depending on the
state of an external pin. The latter is writable. Only when
the these device addressing bits (in the upper 4 bits of the
registers) match, will the device respond to operations on
its other registers.

Add these 2 registers to the regmap so we can access them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c       | 3 ++-
 include/linux/mfd/axp20x.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ba130be32e61..cdaeb34a9a38 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -135,6 +135,7 @@ static const struct regmap_range axp806_writeable_ranges[] = {
 	regmap_reg_range(AXP806_PWR_OUT_CTRL1, AXP806_CLDO3_V_CTRL),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ2_EN),
 	regmap_reg_range(AXP20X_IRQ1_STATE, AXP20X_IRQ2_STATE),
+	regmap_reg_range(AXP806_REG_ADDR_EXT, AXP806_REG_ADDR_EXT),
 };
 
 static const struct regmap_range axp806_volatile_ranges[] = {
@@ -305,7 +306,7 @@ static const struct regmap_config axp806_regmap_config = {
 	.val_bits	= 8,
 	.wr_table	= &axp806_writeable_table,
 	.volatile_table	= &axp806_volatile_table,
-	.max_register	= AXP806_VREF_TEMP_WARN_L,
+	.max_register	= AXP806_REG_ADDR_EXT,
 	.cache_type	= REGCACHE_RBTREE,
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index fec597fb34cb..7e85ececcedf 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -115,6 +115,8 @@ enum {
 #define AXP806_CLDO2_V_CTRL		0x25
 #define AXP806_CLDO3_V_CTRL		0x26
 #define AXP806_VREF_TEMP_WARN_L		0xf3
+#define AXP806_BUS_ADDR_EXT		0xfe
+#define AXP806_REG_ADDR_EXT		0xff
 
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
-- 
2.10.2

From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Nov 2016 11:16:16 +0800
Subject: [PATCH v2 2/2] mfd: axp20x: Fix AXP806 access errors on cold boot
In-Reply-To: <20161123031616.10114-1-wens@csie.org>
References: <20161123031616.10114-1-wens@csie.org>
Message-ID: <20161123031616.10114-3-wens@csie.org>
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

The AXP806_REG_ADDR_EXT was previously configured by Allwinner's
bootloader. Work on U-boot SPL support now allows us to switch
to mainline U-boot, which doesn't do this for us. There might
be other bare minimum bootloaders out there which don't to this
either. It's best to handle this in the kernel.

This patch sets AXP806_REG_ADDR_EXT to 0x10, which is what we
know to be the proper value for a standard AXP806 in slave mode.
Afterwards it will reinitialize the regmap cache, to purge any
invalid stale values.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index cdaeb34a9a38..a0166c667656 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -31,6 +31,8 @@
 
 #define AXP20X_OFF	0x80
 
+#define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE	BIT(4)
+
 static const char * const axp20x_model_names[] = {
 	"AXP152",
 	"AXP202",
@@ -829,6 +831,42 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 {
 	int ret;
 
+	/*
+	 * The AXP806 supports either master/standalone or slave mode.
+	 * Slave mode allows sharing the serial bus, even with multiple
+	 * AXP806 which all have the same hardware address.
+	 *
+	 * This is done with extra "serial interface address extension",
+	 * or AXP806_BUS_ADDR_EXT, and "register address extension", or
+	 * AXP806_REG_ADDR_EXT, registers. The former is read-only, with
+	 * 1 bit customizable at the factory, and 1 bit depending on the
+	 * state of an external pin. The latter is writable. Only when
+	 * the these device addressing bits (in the upper 4 bits of the
+	 * registers) match, will the device respond to operations on its
+	 * other registers.
+	 *
+	 * Since we only support an AXP806 chained to an AXP809 in slave
+	 * mode, and there isn't any existing hardware which uses AXP806
+	 * in master mode, or has 2 AXP806s in the same system, we can
+	 * just program the register address extension to the slave mode
+	 * address.
+	 */
+	if (axp20x->variant == AXP806_ID) {
+		/* Write to the register address extension register */
+		regmap_write(axp20x->regmap, AXP806_REG_ADDR_EXT,
+			     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
+
+		/* Make sure the write hits the device */
+		regcache_sync_region(axp20x->regmap, AXP806_REG_ADDR_EXT,
+				     AXP806_REG_ADDR_EXT);
+
+		/*
+		 * Reinitialize the regmap cache in case the device didn't
+		 * properly respond to our reads before.
+		 */
+		regmap_reinit_cache(axp20x->regmap, axp20x->regmap_cfg);
+	}
+
 	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
 				  IRQF_ONESHOT | IRQF_SHARED, -1,
 				  axp20x->regmap_irq_chip,
-- 
2.10.2

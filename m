From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 21 Nov 2016 14:32:45 +0100
Subject: [PATCH v5 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161121133247.29889-1-romain.perier@free-electrons.com>
References: <20161121133247.29889-1-romain.perier@free-electrons.com>
Message-ID: <20161121133247.29889-2-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 3700 has two I2C controllers that is compliant with the I2C
Bus Specificiation 2.1, supports multi-master and different bus speed:
Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
High speed mode (up to 3.4 Mhz).

This IP block has a lot of similarity with the PXA, except some register
offsets and bitfield. This commits adds a basic support for this I2C
unit.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---

Changes in v5:
 - Don't define registers for armada-3700, we can re-use the ones
   for PXA3XX.
 - Define registers mask when OF is not used, in probe_pdata. 

Changes in v4:
 - Replaced the type of hs_mask and fm_mask by u32, instead of
   unsigned int, As writel() take an u32 as first argument...

Changes in v3:
 - Replaced the type of hs_mask and fm_mask by unsigned int,
   instead of unsigned long.

 drivers/i2c/busses/Kconfig   |  2 +-
 drivers/i2c/busses/i2c-pxa.c | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d252276..2f56a26 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -763,7 +763,7 @@ config I2C_PUV3
 
 config I2C_PXA
 	tristate "Intel PXA2XX I2C adapter"
-	depends on ARCH_PXA || ARCH_MMP || (X86_32 && PCI && OF)
+	depends on ARCH_PXA || ARCH_MMP || ARCH_MVEBU || (X86_32 && PCI && OF)
 	help
 	  If you have devices in the PXA I2C bus, say yes to this option.
 	  This driver can also be built as a module.  If so, the module
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index e28b825..374d17c 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -98,6 +98,7 @@ static const struct platform_device_id i2c_pxa_id_table[] = {
 	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
 	{ "ce4100-i2c",		REGS_CE4100 },
 	{ "pxa910-i2c",		REGS_PXA910 },
+	{ "armada-3700-i2c",	REGS_PXA3XX  },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
@@ -122,7 +123,9 @@ MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
 #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
 #define ICR_UR		(1 << 14)	   /* unit reset */
 #define ICR_FM		(1 << 15)	   /* fast mode */
+#define ICR_BUSMODE_FM	(1 << 16)	   /* shifted fast mode for armada-3700 */
 #define ICR_HS		(1 << 16)	   /* High Speed mode */
+#define ICR_BUSMODE_HS	(1 << 17)	   /* shifted high speed mode for armada-3700 */
 #define ICR_GPIOEN	(1 << 19)	   /* enable GPIO mode for SCL in HS */
 
 #define ISR_RWM		(1 << 0)	   /* read/write mode */
@@ -193,6 +196,8 @@ struct pxa_i2c {
 	unsigned char		master_code;
 	unsigned long		rate;
 	bool			highmode_enter;
+	u32			fm_mask;
+	u32			hs_mask;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -503,8 +508,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 		writel(i2c->slave_addr, _ISAR(i2c));
 
 	/* set control register values */
-	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
-	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
+	writel(I2C_ICR_INIT | (i2c->fast_mode ? i2c->fm_mask : 0), _ICR(i2c));
+	writel(readl(_ICR(i2c)) | (i2c->high_mode ? i2c->hs_mask : 0), _ICR(i2c));
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
@@ -1137,6 +1142,7 @@ static const struct of_device_id i2c_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
 	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
 	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
+	{ .compatible = "marvell,armada-3700-i2c", .data = (void *)REGS_PXA3XX },
 	{}
 };
 MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
@@ -1158,6 +1164,13 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
 		i2c->fast_mode = 1;
+	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
+		i2c->fm_mask = ICR_BUSMODE_FM;
+		i2c->hs_mask = ICR_BUSMODE_HS;
+	} else {
+		i2c->fm_mask = ICR_FM;
+		i2c->hs_mask = ICR_HS;
+	}
 
 	*i2c_types = (enum pxa_i2c_types)(of_id->data);
 
@@ -1181,6 +1194,13 @@ static int i2c_pxa_probe_pdata(struct platform_device *pdev,
 			i2c->master_code = 0xe;
 		i2c->rate = plat->rate;
 	}
+	if (!strcmp(id->name, "armada-3700-i2c")) {
+		i2c->fm_mask = ICR_BUSMODE_FM;
+		i2c->hs_mask = ICR_BUSMODE_HS;
+	} else {
+		i2c->fm_mask = ICR_FM;
+		i2c->hs_mask = ICR_HS;
+	}
 	return 0;
 }
 
-- 
2.9.3

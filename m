From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu, 16 Feb 2017 22:16:32 +0100
Subject: AXP808 vs. AXP806 debugged, no difference? (Was: [PATCH v6 5/5] ARM:
 dts: sun9i: Initial support for the Sunchip CX-A99 board)
In-Reply-To: <20170214233538.enkffjiw3kkfromu@localhost>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
 <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
 <20170214233538.enkffjiw3kkfromu@localhost>
Message-ID: <20170216211630.u3xddzzcpazlodkz@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In summary: I'll propose a new property "extended-address" or so to the
existing "x-powers,axp806" compatible, because the axp808 does seem to have
the register at 0xff after all, it just needs a value of 0 instead of the 16
which drivers/mfd/axp20x.c as of recently is now writing unconditionally
to 0xff. A new "x-powers,axp808" compatible and new AXP808_ID is therefore
not needed. This should make for a simpler and smaller patch.

On Wed, Feb 15, 2017 at 12:35:39AM +0100, Rask Ingemann Lambertsen wrote:
> As to touching the register at 0xff, it would be interesting to know more
> precisely what goes wrong. The symptom is these messages in the log:
> 
> [    3.209573] axp20x-rsb sunxi-rsb-745: AXP20x variant AXP806 found
> [    3.210153] axp20x-rsb sunxi-rsb-745: Failed to set masks in 0x40: -5
> [    3.210178] axp20x-rsb sunxi-rsb-745: failed to add irq chip: -5
> [    3.210306] axp20x-rsb: probe of sunxi-rsb-745 failed with error -5
> 
> I haven't yet looked further into what happens at the RSB bus level.

With the patch below applied for debugging purposes and using the
"xpowers,axp806" compatible, I get:

[    3.209955] axp20x-rsb sunxi-rsb-745: AXP20x variant AXP806 found
[    3.210065] axp20x-rsb sunxi-rsb-745: Chip ID read 1 = 0x60
[    3.210119] axp20x-rsb sunxi-rsb-745: Reg addr ext = 0x0
[    3.210171] axp20x-rsb sunxi-rsb-745: Bus addr ext = 0x0
[    3.210381] axp20x-rsb sunxi-rsb-745: Chip ID read 2 = 0x60
(16 written to register 0xff here)
[    3.210570] sunxi-rsb 8003400.i2c: RSB transfer data error
[    3.210596] sunxi-rsb 8003400.i2c: RSB error reading dev 58 register 3 length 1.
[    3.210625] axp20x-rsb sunxi-rsb-745: Chip ID read 3 = 0xffffffff
(0 written to register 0xff here)
[    3.210828] axp20x-rsb sunxi-rsb-745: Chip ID read 4 = 0x60

I.e. register 0xff (Reg addr ext) and 0xfe (Bus addr ext) exist with a
default of 0. After writing 16 to register 0xff, the chip ID (register 3)
can not be read, but writing 0 to register 0xff makes the AXP808 respond
again and the board boots up as normal.

Also, can someone with an AXP806 confirm that it does use the same chip ID
of 0x60 as the AXP808?

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 125b470..db557f3 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -910,9 +910,40 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 	 * address.
 	 */
 	if (axp20x->variant == AXP806_ID)
+	{
+		int dummy;
+
+		dummy = -1;
+		regmap_read(axp20x->regmap, AXP806_CHIP_ID, &dummy);
+		dev_info(axp20x->dev, "Chip ID read 1 = 0x%x\n", dummy);
+
+		regmap_read(axp20x->regmap, AXP806_REG_ADDR_EXT, &dummy);
+		dev_info(axp20x->dev, "Reg addr ext = 0x%x\n", dummy);
+		regmap_read(axp20x->regmap, AXP806_BUS_ADDR_EXT, &dummy);
+		dev_info(axp20x->dev, "Bus addr ext = 0x%x\n", dummy);
+
+		regmap_reinit_cache(axp20x->regmap, axp20x->regmap_cfg);
+		dummy = -1;
+		regmap_read(axp20x->regmap, AXP806_CHIP_ID, &dummy);
+		dev_info(axp20x->dev, "Chip ID read 2 = 0x%x\n", dummy);
+
 		regmap_write(axp20x->regmap, AXP806_REG_ADDR_EXT,
 			     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
 
+		regmap_reinit_cache(axp20x->regmap, axp20x->regmap_cfg);
+		dummy = -1;
+		regmap_read(axp20x->regmap, AXP806_CHIP_ID, &dummy);
+		dev_info(axp20x->dev, "Chip ID read 3 = 0x%x\n", dummy);
+
+		regmap_write(axp20x->regmap, AXP806_REG_ADDR_EXT,
+			     0);
+
+		regmap_reinit_cache(axp20x->regmap, axp20x->regmap_cfg);
+		dummy = -1;
+		regmap_read(axp20x->regmap, AXP806_CHIP_ID, &dummy);
+		dev_info(axp20x->dev, "Chip ID read 4 = 0x%x\n", dummy);
+	}
+
 	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
 			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
 			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 795c9d9..85e4926 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -349,6 +349,10 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 unlock:
 	mutex_unlock(&rsb->lock);
 
+	if (ret)
+		dev_dbg(rsb->dev, "RSB error reading dev %u register %u length %u.\n",
+			rtaddr, addr, (unsigned int) len);
+
 	return ret;
 }
 
@@ -386,6 +390,10 @@ static int sunxi_rsb_write(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 
 	mutex_unlock(&rsb->lock);
 
+	if (ret)
+		dev_dbg(rsb->dev, "RSB error writing dev %u register %u length %u.\n",
+			rtaddr, addr, (unsigned int) len);
+
 	return ret;
 }
 
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index cc6364b..4b81226 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
+CFLAGS_sunxi-rsb.o		+= -DDEBUG -DEBUG

-- 
Rask Ingemann Lambertsen

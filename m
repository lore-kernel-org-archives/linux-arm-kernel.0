From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 18 Feb 2010 18:55:54 +0100
Subject: PL-330 DMA driver
In-Reply-To: <4B7D2C2A.8030802@samsung.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
	<4B7D2C2A.8030802@samsung.com>
Message-ID: <63386a3d1002180955h3d7c1257u9b7ef09621f869c7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/18 Joonyoung Shim <jy0922.shim@samsung.com>:

> You can find the prior patch of pl330 from the below url.
> http://patchwork.kernel.org/patch/47847/

This one has a number of review issues, I'll put them in here, hope
you can fix them for the next patch if you're at it now:

+#include <linux/platform_device.h>

No, please, #include <linux/amba/bus.h> instead. That's how
we register PrimeCells. More on that at the end.

+#include <plat/dma.h>

Move that dma.h to include/linux/amba/pl330.h and include as
#include <linux/amba/pl330.h>
And also include it in the patch or we have no chance to know
how struct pl330_platform_data looks (it is used a lot in the
driver).

+static unsigned int pl330_get_reg(struct pl330_device *pl330_dev,
+		unsigned int reg)
+{
+	void __iomem *base = pl330_dev->reg_base;
+
+	return readl(base + reg);
+}
+
+static void pl330_set_reg(struct pl330_device *pl330_dev, unsigned int reg,
+		unsigned int val)
+{
+	void __iomem *base = pl330_dev->reg_base;
+
+	writel(val, base + reg);
+}

Is this kind of abstraction really useful? Isn't it easier in any case to
just writel(FOO, pl330_dev->reg_base + BAR); ?
In case you really keep them, make them inline.

+static void pl330_dump_regs(struct pl330_chan *pl330_ch)
+{
+	struct device *dev = pl330_ch->pl330_dev->common.dev;
+	unsigned int val;
+	unsigned int id = pl330_ch->id;
+
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_DS);
+	dev_dbg(dev, "PL330_DS:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_DPC);
+	dev_dbg(dev, "PL330_DPC:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_INTEN);
+	dev_dbg(dev, "PL330_INTEN:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_ES);
+	dev_dbg(dev, "PL330_ES:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_INTSTATUS);
+	dev_dbg(dev, "PL330_INTSTATUS:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_FSM);
+	dev_dbg(dev, "PL330_FSM:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_FSC);
+	dev_dbg(dev, "PL330_FSC:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_FTM);
+	dev_dbg(dev, "PL330_FTM:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_FTC(id));
+	dev_dbg(dev, "PL330_FTC(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CS(id));
+	dev_dbg(dev, "PL330_CS(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CPC(id));
+	dev_dbg(dev, "PL330_CPC(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_SA(id));
+	dev_dbg(dev, "PL330_SA(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_DA(id));
+	dev_dbg(dev, "PL330_DA(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CC(id));
+	dev_dbg(dev, "PL330_CC(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_LC0(id));
+	dev_dbg(dev, "PL330_LC0(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_LC1(id));
+	dev_dbg(dev, "PL330_LC1(%d):\t\t0x%08x\n", id, val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_DBGSTATUS);
+	dev_dbg(dev, "PL330_DBGSTATUS:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CR0);
+	dev_dbg(dev, "PL330_CR0:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CR1);
+	dev_dbg(dev, "PL330_CR1:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CR2);
+	dev_dbg(dev, "PL330_CR2:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CR3);
+	dev_dbg(dev, "PL330_CR3:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CR4);
+	dev_dbg(dev, "PL330_CR4:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_CRDN);
+	dev_dbg(dev, "PL330_CRDN:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PERIPH_ID0);
+	dev_dbg(dev, "PL330_PERIPH_ID0:\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PERIPH_ID1);
+	dev_dbg(dev, "PL330_PERIPH_ID1:\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PERIPH_ID2);
+	dev_dbg(dev, "PL330_PERIPH_ID2:\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PERIPH_ID3);
+	dev_dbg(dev, "PL330_PERIPH_ID3:\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PCELL_ID0);
+	dev_dbg(dev, "PL330_PCELL_ID0:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PCELL_ID1);
+	dev_dbg(dev, "PL330_PCELL_ID0:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PCELL_ID2);
+	dev_dbg(dev, "PL330_PCELL_ID0:\t\t0x%08x\n", val);
+	val = pl330_get_reg(pl330_ch->pl330_dev, PL330_PCELL_ID3);
+	dev_dbg(dev, "PL330_PCELL_ID0:\t\t0x%08x\n", val);
+}

Turn this into a table.

struct pl330_regdump {
  char *name;
  u16 reg;
}

static const struct pl330_regdump dumpregs[] = {
 {
    .name = "PL330_DS",
    .reg = PL330_DS,
 },
 (....)
};

int i;
for (i = 0; i < ARRAY_SIZE(dumpregs); i++) {
  struct pl330_regdump *rd = &dumpregs[i];
  dev_dbg(dev, "%s:\t\t0x%08x\n",
    rd->name,
    readl(pl330_ch->pl330_dev->base + rd->reg));
}

Easy! (Beware of bugs in above code, just typing...)

+/* instruction set functions */
(...)

All these inlines make me think of serious rollerskating races.
Are they really necessary?

+	if (loop_size_rest)
+		dev_dbg(dev, "TODO\n");

Hm. Perhaps this can be a bit more descriptive...

+static struct dma_async_tx_descriptor *
+pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_data_direction direction,
+		unsigned long flags)
+{
+	struct pl330_chan *pl330_ch = to_pl330_chan(chan);
+	struct pl330_register_cc *pl330_reg_cc = &pl330_ch->pl330_reg_cc;
+	struct pl330_dma_slave *dma_slave = chan->private;
+	struct pl330_desc *desc;
+	struct scatterlist *sg;
+	unsigned int inst_size = 0;
+	unsigned int i;
+
+	BUG_ON(!dma_slave);
+	BUG_ON(direction == DMA_BIDIRECTIONAL);

Does the PL330 really prohibit bidirectional channels?

+static int pl330_probe(struct platform_device *pdev)

Add __init macro.

+static int pl330_remove(struct platform_device *pdev)

Add __exit macro.

+static struct platform_driver pl330_driver = {
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "pl330",
+	},
+	.probe		= pl330_probe,
+	.remove		= pl330_remove,
+};

This should be converted into an amba_device per <linux/amba/bus.h> as for
all other primecells. That inevitably involves changing the probe and
remove code a bit, and to register it differently, but we'll be thankful.
(See any other PrimeCell driver for examples, e.g. drivers/spi/amba-pl022.c
or drivers/mmc/host/mmci.c)

Yours,
Linus Walleij

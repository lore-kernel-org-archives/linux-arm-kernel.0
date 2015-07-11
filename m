From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 14:12:04 +0200
Subject: [PATCH 1/4] dmaengine: pl08x: support dt channel assignment
In-Reply-To: <1436616727-4847-1-git-send-email-manabian@gmail.com>
References: <1436616727-4847-1-git-send-email-manabian@gmail.com>
Message-ID: <1436616727-4847-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Add support for assigning DMA channels from a device tree.

[je: remove channel sub-node parsing, dynamic channel creation on xlate]

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/dma/amba-pl08x.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 5de3cf453f35..9b42c0588550 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -83,6 +83,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -2030,10 +2032,188 @@ static inline void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 }
 #endif
 
+#ifdef CONFIG_OF
+static struct dma_chan *pl08x_find_chan_id(struct pl08x_driver_data *pl08x,
+					 u32 id)
+{
+	struct pl08x_dma_chan *chan;
+
+	list_for_each_entry(chan, &pl08x->slave.channels, vc.chan.device_node) {
+		if (chan->signal == id)
+			return &chan->vc.chan;
+	}
+
+	return NULL;
+}
+
+static struct dma_chan *pl08x_of_xlate(struct of_phandle_args *dma_spec,
+				       struct of_dma *ofdma)
+{
+	struct pl08x_driver_data *pl08x = ofdma->of_dma_data;
+	struct pl08x_channel_data *data;
+	struct pl08x_dma_chan *chan;
+	struct dma_chan *dma_chan;
+
+	if (!pl08x)
+		return NULL;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	dma_chan = pl08x_find_chan_id(pl08x, dma_spec->args[0]);
+	if (dma_chan)
+		return dma_get_slave_channel(dma_chan);
+
+	chan = devm_kzalloc(pl08x->slave.dev, sizeof(*chan) + sizeof(*data),
+			    GFP_KERNEL);
+	if (!chan)
+		return NULL;
+
+	data = (void *)&chan[1];
+	data->bus_id = "(none)";
+	data->periph_buses = dma_spec->args[1];
+
+	chan->cd = data;
+	chan->host = pl08x;
+	chan->slave = true;
+	chan->name = data->bus_id;
+	chan->state = PL08X_CHAN_IDLE;
+	chan->signal = dma_spec->args[0];
+	chan->vc.desc_free = pl08x_desc_free;
+
+	vchan_init(&chan->vc, &pl08x->slave);
+
+	return dma_get_slave_channel(&chan->vc.chan);
+}
+
+static int pl08x_of_probe(struct amba_device *adev,
+			  struct pl08x_driver_data *pl08x,
+			  struct device_node *np)
+{
+	struct pl08x_platform_data *pd;
+	u32 cctl_memcpy = 0;
+	u32 val;
+	int ret;
+
+	pd = devm_kzalloc(&adev->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	/* Eligible bus masters for fetching LLIs */
+	if (of_property_read_bool(np, "lli-bus-interface-ahb1"))
+		pd->lli_buses |= PL08X_AHB1;
+	if (of_property_read_bool(np, "lli-bus-interface-ahb2"))
+		pd->lli_buses |= PL08X_AHB2;
+	if (!pd->lli_buses) {
+		dev_info(&adev->dev, "no bus masters for LLIs stated, assume all\n");
+		pd->lli_buses |= PL08X_AHB1 | PL08X_AHB2;
+	}
+
+	/* Eligible bus masters for memory access */
+	if (of_property_read_bool(np, "mem-bus-interface-ahb1"))
+		pd->mem_buses |= PL08X_AHB1;
+	if (of_property_read_bool(np, "mem-bus-interface-ahb2"))
+		pd->mem_buses |= PL08X_AHB2;
+	if (!pd->mem_buses) {
+		dev_info(&adev->dev, "no bus masters for memory stated, assume all\n");
+		pd->mem_buses |= PL08X_AHB1 | PL08X_AHB2;
+	}
+
+	/* Parse the memcpy channel properties */
+	ret = of_property_read_u32(np, "memcpy-burst-size", &val);
+	if (ret) {
+		dev_info(&adev->dev, "no memcpy burst size specified, using 1 byte\n");
+		val = 1;
+	}
+	switch (val) {
+	default:
+		dev_err(&adev->dev, "illegal burst size for memcpy, set to 1\n");
+		/* Fall through */
+	case 1:
+		cctl_memcpy |= PL080_BSIZE_1 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 4:
+		cctl_memcpy |= PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 8:
+		cctl_memcpy |= PL080_BSIZE_8 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_8 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 16:
+		cctl_memcpy |= PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 32:
+		cctl_memcpy |= PL080_BSIZE_32 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_32 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 64:
+		cctl_memcpy |= PL080_BSIZE_64 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_64 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 128:
+		cctl_memcpy |= PL080_BSIZE_128 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_128 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 256:
+		cctl_memcpy |= PL080_BSIZE_256 << PL080_CONTROL_SB_SIZE_SHIFT |
+			       PL080_BSIZE_256 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	}
+
+	ret = of_property_read_u32(np, "memcpy-bus-width", &val);
+	if (ret) {
+		dev_info(&adev->dev, "no memcpy bus width specified, using 8 bits\n");
+		val = 8;
+	}
+	switch (val) {
+	default:
+		dev_err(&adev->dev, "illegal bus width for memcpy, set to 8 bits\n");
+		/* Fall through */
+	case 8:
+		cctl_memcpy |= PL080_WIDTH_8BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			       PL080_WIDTH_8BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	case 16:
+		cctl_memcpy |= PL080_WIDTH_16BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			       PL080_WIDTH_16BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	case 32:
+		cctl_memcpy |= PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			       PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	}
+
+	/* This is currently the only thing making sense */
+	cctl_memcpy |= PL080_CONTROL_PROT_SYS;
+
+	/* Set up memcpy channel */
+	pd->memcpy_channel.bus_id = "memcpy";
+	pd->memcpy_channel.cctl_memcpy = cctl_memcpy;
+	/* Use the buses that can access memory, obviously */
+	pd->memcpy_channel.periph_buses = pd->mem_buses;
+
+	pl08x->pd = pd;
+
+	return of_dma_controller_register(adev->dev.of_node, pl08x_of_xlate,
+					  pl08x);
+}
+#else
+static inline int pl08x_of_probe(struct amba_device *adev,
+				 struct pl08x_driver_data *pl08x,
+				 struct device_node *np)
+{
+	return -EINVAL;
+}
+#endif
+
 static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct pl08x_driver_data *pl08x;
 	const struct vendor_data *vd = id->data;
+	struct device_node *np = adev->dev.of_node;
 	u32 tsfr_size;
 	int ret = 0;
 	int i;
@@ -2093,9 +2273,15 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	/* Get the platform data */
 	pl08x->pd = dev_get_platdata(&adev->dev);
 	if (!pl08x->pd) {
-		dev_err(&adev->dev, "no platform data supplied\n");
-		ret = -EINVAL;
-		goto out_no_platdata;
+		if (np) {
+			ret = pl08x_of_probe(adev, pl08x, np);
+			if (ret)
+				goto out_no_platdata;
+		} else {
+			dev_err(&adev->dev, "no platform data supplied\n");
+			ret = -EINVAL;
+			goto out_no_platdata;
+		}
 	}
 
 	/* Assign useful pointers to the driver state */
-- 
1.8.0

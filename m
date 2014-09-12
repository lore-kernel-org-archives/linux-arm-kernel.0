From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Sep 2014 09:37:36 +0200
Subject: [PATCH 3/4] dmaengine: support device tree channel assignment
Message-ID: <1410507456-32491-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the fixed signal case, support assigning channels with
specific signals taken from the device tree. For more information
see the device tree binding patch.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 1e523a094cc5..f2300e5ed55c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -91,6 +91,8 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/amba/pl080.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
 
 #include "dmaengine.h"
 #include "virt-dma.h"
@@ -2045,10 +2047,221 @@ static inline void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 }
 #endif
 
+#ifdef CONFIG_OF
+static int pl08x_of_parse_channel(struct amba_device *adev,
+				  struct device_node *np,
+				  struct pl08x_channel_data *chan)
+{
+	const char *signal_name;
+	int ret;
+
+	ret = of_property_read_string(np, "signal", &signal_name);
+	if (ret) {
+		dev_err(&adev->dev, "no signal name for channel\n");
+		return ret;
+	}
+	chan->bus_id = signal_name;
+
+	/* Parse the channel settings */
+	chan->bus_id = signal_name;
+	if (of_property_read_bool(np, "bus-interface-ahb1"))
+		chan->periph_buses |= PL08X_AHB1;
+	if (of_property_read_bool(np, "bus-interface-ahb2"))
+		chan->periph_buses |= PL08X_AHB2;
+	if (!chan->periph_buses) {
+		dev_err(&adev->dev, "no bus master for channel %s!\n",
+			signal_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct dma_chan *pl08x_of_xlate(struct of_phandle_args *dma_spec,
+				       struct of_dma *ofdma)
+{
+	struct pl08x_driver_data *pl08x = ofdma->of_dma_data;
+	u32 index = dma_spec->args[0];
+	const char *channel_name;
+	dma_cap_mask_t cap;
+	dma_cap_zero(cap);
+	dma_cap_set(DMA_SLAVE, cap);
+
+	if (index > pl08x->pd->num_slave_channels) {
+		dev_err(&pl08x->adev->dev, "undefined channel requested (%u)\n",
+			index);
+		return NULL;
+	}
+	channel_name = pl08x->pd->slave_channels[index].bus_id;
+	dev_dbg(&pl08x->adev->dev, "requested channel %u \"%s\"\n",
+		index, channel_name);
+
+	return dma_request_channel(cap, pl08x_filter_id, (void *) channel_name);
+}
+
+static int pl08x_of_probe(struct amba_device *adev,
+			  struct pl08x_driver_data *pl08x,
+			  struct device_node *np)
+{
+	struct device_node *child;
+	struct pl08x_channel_data *chanp = NULL;
+	struct pl08x_platform_data *pd;
+	u32 cctl_memcpy = 0;
+	u32 val;
+	int channels;
+	int ret;
+
+	pd = devm_kzalloc(&adev->dev,
+			sizeof(struct pl08x_platform_data),
+			GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+
+	/* Eligible bus masters for fetching LLIs */
+	if (of_property_read_bool(np, "lli-bus-interface-ahb1"))
+		pd->lli_buses |= PL08X_AHB1;
+	if (of_property_read_bool(np, "lli-bus-interface-ahb2"))
+		pd->lli_buses |= PL08X_AHB2;
+	if (!pd->lli_buses) {
+		dev_info(&adev->dev, "no bus masters for LLIs stated, assume all\n");
+	        pd->lli_buses |= PL08X_AHB1 | PL08X_AHB2;
+	}
+
+	/* Eligible bus masters for memory access */
+	if (of_property_read_bool(np, "mem-bus-interface-ahb1"))
+		pd->mem_buses |= PL08X_AHB1;
+	if (of_property_read_bool(np, "mem-bus-interface-ahb2"))
+		pd->mem_buses |= PL08X_AHB2;
+	if (!pd->mem_buses) {
+		dev_info(&adev->dev, "no bus masters for memory stated, assume all\n");
+	        pd->mem_buses |= PL08X_AHB1 | PL08X_AHB2;
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
+			PL080_BSIZE_1 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 4:
+		cctl_memcpy |= PL080_BSIZE_4 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_4 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 8:
+		cctl_memcpy |= PL080_BSIZE_8 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_8 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 16:
+		cctl_memcpy |= PL080_BSIZE_16 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_16 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 32:
+		cctl_memcpy |= PL080_BSIZE_32 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_32 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 64:
+		cctl_memcpy |= PL080_BSIZE_64 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_64 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 128:
+		cctl_memcpy |= PL080_BSIZE_128 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_128 << PL080_CONTROL_DB_SIZE_SHIFT;
+		break;
+	case 256:
+		cctl_memcpy |= PL080_BSIZE_256 << PL080_CONTROL_SB_SIZE_SHIFT |
+			PL080_BSIZE_256 << PL080_CONTROL_DB_SIZE_SHIFT;
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
+			PL080_WIDTH_8BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	case 16:
+		cctl_memcpy |= PL080_WIDTH_16BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			PL080_WIDTH_16BIT << PL080_CONTROL_DWIDTH_SHIFT;
+		break;
+	case 32:
+		cctl_memcpy |= PL080_WIDTH_32BIT << PL080_CONTROL_SWIDTH_SHIFT |
+			PL080_WIDTH_32BIT << PL080_CONTROL_DWIDTH_SHIFT;
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
+	channels = of_get_child_count(np);
+	if (!channels)
+		goto out_no_slaves;
+	if (channels > 32) {
+		dev_info(&adev->dev, "more than 32 channels specified, ignoring the surplus channels\n");
+		channels = 32;
+	}
+
+	pd->num_slave_channels = channels;
+	chanp = devm_kzalloc(&adev->dev,
+			channels *
+			sizeof(struct pl08x_channel_data),
+			GFP_KERNEL);
+	if (!chanp)
+		return -ENOMEM;
+	pd->slave_channels = chanp;
+
+	/* Parse all children, defining the channels */
+	for_each_child_of_node(np, child) {
+		ret = pl08x_of_parse_channel(adev, child, chanp);
+		if (ret)
+			return ret;
+		chanp++;
+	}
+
+	ret = of_dma_controller_register(adev->dev.of_node, pl08x_of_xlate,
+					 pl08x);
+	if (ret)
+		return ret;
+
+out_no_slaves:
+	pl08x->pd = pd;
+	return 0;
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
@@ -2096,9 +2309,15 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
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
1.9.3

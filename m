From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jan 2013 21:58:16 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <1359410300-26113-1-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
Message-ID: <1359410300-26113-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original device tree binding for this driver, from Viresh Kumar
unfortunately conflicted with the generic DMA binding, and did not allow
to completely seperate slave device configuration from the controller.

This is an attempt to replace it with an implementation of the generic
binding, but it is currently completely untested, because I do not have
any hardware with this particular controller.

The patch applies on top of linux-next, which contains both the base
support for the generic DMA binding, as well as the earlier attempt from
Viresh. Both of these are currently not merged upstream however.

There are a couple of TODO items that are left remaining and are open
for ideas from other people.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/dma/snps-dma.txt |  71 ++++++-----
 drivers/dma/dw_dmac.c                              | 137 ++++++++++-----------
 drivers/dma/dw_dmac_regs.h                         |   4 -
 include/linux/dw_dmac.h                            |   5 -
 4 files changed, 102 insertions(+), 115 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
index 5bb3dfb..212d387 100644
--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -3,59 +3,62 @@
 Required properties:
 - compatible: "snps,dma-spear1340"
 - reg: Address range of the DMAC registers
-- interrupt-parent: Should be the phandle for the interrupt controller
-  that services interrupts for this device
 - interrupt: Should contain the DMAC interrupt number
-- nr_channels: Number of channels supported by hardware
-- is_private: The device channels should be marked as private and not for by the
-  general purpose DMA channel allocator. False if not passed.
+- dma-channels: Number of channels supported by hardware
+- dma-requests: Number of DMA request lines supported
+- dma-masters: Number of AHB masters supported by the controller
+- #dma-cells: must be <3>
 - chan_allocation_order: order of allocation of channel, 0 (default): ascending,
   1: descending
 - chan_priority: priority of channels. 0 (default): increase from chan 0->n, 1:
   increase from chan n->0
 - block_size: Maximum block size supported by the controller
-- nr_masters: Number of AHB masters supported by the controller
 - data_width: Maximum data width supported by hardware per AHB master
   (0 - 8bits, 1 - 16bits, ..., 5 - 256bits)
-- slave_info:
-	- bus_id: name of this device channel, not just a device name since
-	  devices may have more than one channel e.g. "foo_tx". For using the
-	  dw_generic_filter(), slave drivers must pass exactly this string as
-	  param to filter function.
-	- cfg_hi: Platform-specific initializer for the CFG_HI register
-	- cfg_lo: Platform-specific initializer for the CFG_LO register
-	- src_master: src master for transfers on allocated channel.
-	- dst_master: dest master for transfers on allocated channel.
+
+
+Optional properties:
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- is_private: The device channels should be marked as private and not for by the
+  general purpose DMA channel allocator. False if not passed.
 
 Example:
 
-	dma at fc000000 {
+	dmahost: dma at fc000000 {
 		compatible = "snps,dma-spear1340";
 		reg = <0xfc000000 0x1000>;
 		interrupt-parent = <&vic1>;
 		interrupts = <12>;
 
-		nr_channels = <8>;
+		dma-channels = <8>;
+		dma-requests = <32>;
+		dma-masters = <2>;
+		#dma-cells = <3>;
 		chan_allocation_order = <1>;
 		chan_priority = <1>;
 		block_size = <0xfff>;
-		nr_masters = <2>;
 		data_width = <3 3 0 0>;
+	};
 
-		slave_info {
-			uart0-tx {
-				bus_id = "uart0-tx";
-				cfg_hi = <0x4000>;	/* 0x8 << 11 */
-				cfg_lo = <0>;
-				src_master = <0>;
-				dst_master = <1>;
-			};
-			spi0-tx {
-				bus_id = "spi0-tx";
-				cfg_hi = <0x2000>;	/* 0x4 << 11 */
-				cfg_lo = <0>;
-				src_master = <0>;
-				dst_master = <0>;
-			};
-		};
+DMA clients connected to the Designware DMA controller must use the format
+described in the dma.txt file, using a five-cell specifier for each channel.
+The five cells in order are:
+
+1. A phandle pointing to the DMA controller
+2. The value for the cfg_hi register.
+3. The value for the cfg_lo register.
+4. Source master for transfers on allocated channel.
+5. Destination master for transfers on allocated channel.
+
+Example:
+	
+	serial at e0000000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0xe0000000 0x1000>;
+		interrupts = <0 35 0x4>;
+		status = "disabled";
+		dmas = <&dmahost 0x6000 0 0 1>,
+			<&dmahost 0x680 0 1 0>;
+		dma-names = "rx", "rx";
 	};
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 8cfaaf8..88504c2 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -1179,49 +1180,69 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 
-bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
+/* forward declaration used in filter */
+static struct platform_driver dw_driver;
+
+struct dw_dma_filter_args {
+	struct dw_dma *dw;
+	u32 cfg_lo;
+	u32 cfg_hi;
+	unsigned src;
+	unsigned dst;
+};
+
+static bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma *dw = to_dw_dma(chan->device);
-	static struct dw_dma *last_dw;
-	static char *last_bus_id;
-	int i = -1;
+	struct dw_dma_filter_args *fargs = param;
+	struct dw_dma_slave *sd;
 
-	/*
-	 * dmaengine framework calls this routine for all channels of all dma
-	 * controller, until true is returned. If 'param' bus_id is not
-	 * registered with a dma controller (dw), then there is no need of
-	 * running below function for all channels of dw.
-	 *
-	 * This block of code does this by saving the parameters of last
-	 * failure. If dw and param are same, i.e. trying on same dw with
-	 * different channel, return false.
-	 */
-	if ((last_dw == dw) && (last_bus_id == param))
+	/* both the driver and the device must match */
+        if (chan->device->dev->driver != &dw_driver.driver)
+                return false;
+	if (dw != fargs->dw)
 		return false;
-	/*
-	 * Return true:
-	 * - If dw_dma's platform data is not filled with slave info, then all
-	 *   dma controllers are fine for transfer.
-	 * - Or if param is NULL
-	 */
-	if (!dw->sd || !param)
-		return true;
 
-	while (++i < dw->sd_count) {
-		if (!strcmp(dw->sd[i].bus_id, param)) {
-			chan->private = &dw->sd[i];
-			last_dw = NULL;
-			last_bus_id = NULL;
+	/* FIXME: memory leak! could we put this into dw_dma_chan? */
+	sd = devm_kzalloc(dw->dma.dev, sizeof (*sd), GFP_KERNEL);
+	if (!sd)
+		return false;
 
-			return true;
-		}
-	}
+	sd->dma_dev	= dw->dma.dev;
+	sd->cfg_hi	= fargs->cfg_hi;
+	sd->cfg_lo	= fargs->cfg_lo;
+	sd->src_master	= fargs->src;
+	sd->dst_master	= fargs->dst;
+
+	chan->private = sd;
 
-	last_dw = dw;
-	last_bus_id = param;
-	return false;
+	return true;
+}
+
+static struct dma_chan *dw_dma_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct dw_dma *dw = ofdma->of_dma_data;
+	struct dw_dma_filter_args fargs = {
+		.dw = dw,
+	};
+	dma_cap_mask_t cap;
+
+	if (dma_spec->args_count != 4)
+		return NULL;
+
+	/* FIXME: This binding is rather clumsy. Can't we use the
+	   request line numbers here instead? */
+	fargs.cfg_lo = be32_to_cpup(dma_spec->args+0);
+	fargs.cfg_hi = be32_to_cpup(dma_spec->args+1);
+	fargs.src = be32_to_cpup(dma_spec->args+2);
+	fargs.dst = be32_to_cpup(dma_spec->args+3);
+
+	dma_cap_zero(cap);
+	dma_cap_set(DMA_SLAVE, cap);
+	/* FIXME: there should be a simpler way to do this */
+	return dma_request_channel(cap, dw_dma_generic_filter, &dma_spec->args[0]);
 }
-EXPORT_SYMBOL(dw_dma_generic_filter);
 
 /* --------------------- Cyclic DMA API extensions -------------------- */
 
@@ -1510,9 +1531,8 @@ static void dw_dma_off(struct dw_dma *dw)
 static struct dw_dma_platform_data *
 dw_dma_parse_dt(struct platform_device *pdev)
 {
-	struct device_node *sn, *cn, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct dw_dma_platform_data *pdata;
-	struct dw_dma_slave *sd;
 	u32 tmp, arr[4];
 
 	if (!np) {
@@ -1524,7 +1544,7 @@ dw_dma_parse_dt(struct platform_device *pdev)
 	if (!pdata)
 		return NULL;
 
-	if (of_property_read_u32(np, "nr_channels", &pdata->nr_channels))
+	if (of_property_read_u32(np, "dma-channels", &pdata->nr_channels))
 		return NULL;
 
 	if (of_property_read_bool(np, "is_private"))
@@ -1539,7 +1559,7 @@ dw_dma_parse_dt(struct platform_device *pdev)
 	if (!of_property_read_u32(np, "block_size", &tmp))
 		pdata->block_size = tmp;
 
-	if (!of_property_read_u32(np, "nr_masters", &tmp)) {
+	if (!of_property_read_u32(np, "dma-masters", &tmp)) {
 		if (tmp > 4)
 			return NULL;
 
@@ -1551,36 +1571,6 @@ dw_dma_parse_dt(struct platform_device *pdev)
 		for (tmp = 0; tmp < pdata->nr_masters; tmp++)
 			pdata->data_width[tmp] = arr[tmp];
 
-	/* parse slave data */
-	sn = of_find_node_by_name(np, "slave_info");
-	if (!sn)
-		return pdata;
-
-	/* calculate number of slaves */
-	tmp = of_get_child_count(sn);
-	if (!tmp)
-		return NULL;
-
-	sd = devm_kzalloc(&pdev->dev, sizeof(*sd) * tmp, GFP_KERNEL);
-	if (!sd)
-		return NULL;
-
-	pdata->sd = sd;
-	pdata->sd_count = tmp;
-
-	for_each_child_of_node(sn, cn) {
-		sd->dma_dev = &pdev->dev;
-		of_property_read_string(cn, "bus_id", &sd->bus_id);
-		of_property_read_u32(cn, "cfg_hi", &sd->cfg_hi);
-		of_property_read_u32(cn, "cfg_lo", &sd->cfg_lo);
-		if (!of_property_read_u32(cn, "src_master", &tmp))
-			sd->src_master = tmp;
-
-		if (!of_property_read_u32(cn, "dst_master", &tmp))
-			sd->dst_master = tmp;
-		sd++;
-	}
-
 	return pdata;
 }
 #else
@@ -1644,8 +1634,6 @@ static int dw_probe(struct platform_device *pdev)
 	clk_prepare_enable(dw->clk);
 
 	dw->regs = regs;
-	dw->sd = pdata->sd;
-	dw->sd_count = pdata->sd_count;
 
 	/* get hardware configuration parameters */
 	if (autocfg) {
@@ -1765,7 +1753,11 @@ static int dw_probe(struct platform_device *pdev)
 
 	dma_async_device_register(&dw->dma);
 
-	return 0;
+	err = of_dma_controller_register(pdev->dev.of_node, dw_dma_xlate, dw);
+	if (err)
+		dma_async_device_unregister(&dw->dma);
+
+	return err;
 }
 
 static int dw_remove(struct platform_device *pdev)
@@ -1773,6 +1765,7 @@ static int dw_remove(struct platform_device *pdev)
 	struct dw_dma		*dw = platform_get_drvdata(pdev);
 	struct dw_dma_chan	*dwc, *_dwc;
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dw_dma_off(dw);
 	dma_async_device_unregister(&dw->dma);
 
diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
index 88a069f..8896559 100644
--- a/drivers/dma/dw_dmac_regs.h
+++ b/drivers/dma/dw_dmac_regs.h
@@ -239,10 +239,6 @@ struct dw_dma {
 	struct tasklet_struct	tasklet;
 	struct clk		*clk;
 
-	/* slave information */
-	struct dw_dma_slave	*sd;
-	unsigned int		sd_count;
-
 	u8			all_chan_mask;
 
 	/* hardware configuration */
diff --git a/include/linux/dw_dmac.h b/include/linux/dw_dmac.h
index 41766de..481ab23 100644
--- a/include/linux/dw_dmac.h
+++ b/include/linux/dw_dmac.h
@@ -27,7 +27,6 @@
  */
 struct dw_dma_slave {
 	struct device		*dma_dev;
-	const char		*bus_id;
 	u32			cfg_hi;
 	u32			cfg_lo;
 	u8			src_master;
@@ -60,9 +59,6 @@ struct dw_dma_platform_data {
 	unsigned short	block_size;
 	unsigned char	nr_masters;
 	unsigned char	data_width[4];
-
-	struct dw_dma_slave *sd;
-	unsigned int sd_count;
 };
 
 /* bursts size */
@@ -114,6 +110,5 @@ void dw_dma_cyclic_stop(struct dma_chan *chan);
 dma_addr_t dw_dma_get_src_addr(struct dma_chan *chan);
 
 dma_addr_t dw_dma_get_dst_addr(struct dma_chan *chan);
-bool dw_dma_generic_filter(struct dma_chan *chan, void *param);
 
 #endif /* DW_DMAC_H */
-- 
1.8.0

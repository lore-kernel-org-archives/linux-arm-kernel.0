From: s-anna@ti.com (Suman Anna)
Date: Fri, 26 May 2017 15:21:38 -0500
Subject: [PATCH 2/4] remoteproc/davinci: add support to parse internal memories
In-Reply-To: <20170526202140.10472-1-s-anna@ti.com>
References: <20170526202140.10472-1-s-anna@ti.com>
Message-ID: <20170526202140.10472-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSP subsystem on OMAP-L13x SoCs has various internal RAM
memories that can accessed from the ARM side. These memories
can be configured to be used as either RAM or Cache.

The Davinci remoteproc driver has been enhanced to parse and
store the kernel mappings for these internal RAM memories.
These mappings can then be used to support direct loading of
text/data into these memories from the remoteproc driver.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 0919176b52c1..5250cc494775 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -38,9 +38,27 @@ MODULE_PARM_DESC(da8xx_fw_name,
 #define SYSCFG_CHIPSIG3 BIT(3)
 #define SYSCFG_CHIPSIG4 BIT(4)
 
+#define DA8XX_RPROC_LOCAL_ADDRESS_MASK	(SZ_16M - 1)
+
+/**
+ * struct da8xx_rproc_mem - internal memory structure
+ * @cpu_addr: MPU virtual address of the memory region
+ * @bus_addr: Bus address used to access the memory region
+ * @dev_addr: Device address of the memory region from DSP view
+ * @size: Size of the memory region
+ */
+struct da8xx_rproc_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	u32 dev_addr;
+	size_t size;
+};
+
 /**
  * struct da8xx_rproc - da8xx remote processor instance state
  * @rproc: rproc handle
+ * @mem: internal memory regions data
+ * @num_mems: number of internal memory regions
  * @dsp_clk: placeholder for platform's DSP clk
  * @ack_fxn: chip-specific ack function for ack'ing irq
  * @irq_data: ack_fxn function parameter
@@ -50,6 +68,8 @@ MODULE_PARM_DESC(da8xx_fw_name,
  */
 struct da8xx_rproc {
 	struct rproc *rproc;
+	struct da8xx_rproc_mem *mem;
+	int num_mems;
 	struct clk *dsp_clk;
 	void (*ack_fxn)(struct irq_data *data);
 	struct irq_data *irq_data;
@@ -169,6 +189,44 @@ static const struct rproc_ops da8xx_rproc_ops = {
 	.kick = da8xx_rproc_kick,
 };
 
+static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
+					     struct da8xx_rproc *drproc)
+{
+	static const char * const mem_names[] = {"l2sram", "l1pram", "l1dram"};
+	int num_mems = ARRAY_SIZE(mem_names);
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int i;
+
+	drproc->mem = devm_kcalloc(dev, num_mems, sizeof(*drproc->mem),
+				   GFP_KERNEL);
+	if (!drproc->mem)
+		return -ENOMEM;
+
+	for (i = 0; i < num_mems; i++) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   mem_names[i]);
+		drproc->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
+		if (IS_ERR(drproc->mem[i].cpu_addr)) {
+			dev_err(dev, "failed to parse and map %s memory\n",
+				mem_names[i]);
+			return PTR_ERR(drproc->mem[i].cpu_addr);
+		}
+		drproc->mem[i].bus_addr = res->start;
+		drproc->mem[i].dev_addr =
+				res->start & DA8XX_RPROC_LOCAL_ADDRESS_MASK;
+		drproc->mem[i].size = resource_size(res);
+
+		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
+			mem_names[i], &drproc->mem[i].bus_addr,
+			drproc->mem[i].size, drproc->mem[i].cpu_addr,
+			drproc->mem[i].dev_addr);
+	}
+	drproc->num_mems = num_mems;
+
+	return 0;
+}
+
 static int da8xx_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -224,6 +282,10 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	drproc->dsp_clk = dsp_clk;
 	rproc->has_iommu = false;
 
+	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
+	if (ret)
+		goto free_rproc;
+
 	platform_set_drvdata(pdev, rproc);
 
 	/*
-- 
2.12.0

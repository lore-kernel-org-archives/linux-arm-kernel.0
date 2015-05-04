From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:44 +0200
Subject: [PATCH 6/8] soc/tegra: fuse: Unify Tegra20 and Tegra30 drivers
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Unifying the drivers makes it easier to restrict the legacy probing
paths to 32-bit ARM. This in turn will come in handy as support for
new 64-bit ARM SoCs is added.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/iomap.h              |   3 -
 drivers/soc/tegra/fuse/Makefile          |   1 +
 drivers/soc/tegra/fuse/fuse-tegra.c      | 243 +++++++++++++++++++++++++------
 drivers/soc/tegra/fuse/fuse-tegra20.c    | 170 ++++++++-------------
 drivers/soc/tegra/fuse/fuse-tegra30.c    | 205 ++++++++------------------
 drivers/soc/tegra/fuse/fuse.h            |  87 +++++++----
 drivers/soc/tegra/fuse/speedo-tegra114.c |   8 +-
 drivers/soc/tegra/fuse/speedo-tegra124.c |  14 +-
 drivers/soc/tegra/fuse/speedo-tegra20.c  |   8 +-
 drivers/soc/tegra/fuse/speedo-tegra30.c  |  22 +--
 drivers/soc/tegra/fuse/tegra-apbmisc.c   |   9 +-
 11 files changed, 404 insertions(+), 366 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 81dc950b4881..9e5b2f869fc8 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -82,9 +82,6 @@
 #define TEGRA_EMC_BASE			0x7000F400
 #define TEGRA_EMC_SIZE			SZ_1K
 
-#define TEGRA_FUSE_BASE			0x7000F800
-#define TEGRA_FUSE_SIZE			SZ_1K
-
 #define TEGRA_EMC0_BASE			0x7001A000
 #define TEGRA_EMC0_SIZE			SZ_2K
 
diff --git a/drivers/soc/tegra/fuse/Makefile b/drivers/soc/tegra/fuse/Makefile
index 3af357da91f3..4adfce09d3a9 100644
--- a/drivers/soc/tegra/fuse/Makefile
+++ b/drivers/soc/tegra/fuse/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= speedo-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= speedo-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= speedo-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= speedo-tegra124.o
+obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= speedo-tegra124.o
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index c0d660f1aaac..de81eb6b4e92 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kobject.h>
 #include <linux/kernel.h>
@@ -28,8 +29,6 @@
 
 #include "fuse.h"
 
-static u32 (*fuse_readl)(const unsigned int offset);
-static int fuse_size;
 struct tegra_sku_info tegra_sku_info;
 EXPORT_SYMBOL(tegra_sku_info);
 
@@ -42,11 +41,11 @@ static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
 	[TEGRA_REVISION_A04]     = "A04",
 };
 
-static u8 fuse_readb(const unsigned int offset)
+static u8 fuse_readb(struct tegra_fuse *fuse, unsigned int offset)
 {
 	u32 val;
 
-	val = fuse_readl(round_down(offset, 4));
+	val = fuse->read(fuse, round_down(offset, 4));
 	val >>= (offset % 4) * 8;
 	val &= 0xff;
 
@@ -54,19 +53,21 @@ static u8 fuse_readb(const unsigned int offset)
 }
 
 static ssize_t fuse_read(struct file *fd, struct kobject *kobj,
-			struct bin_attribute *attr, char *buf,
-			loff_t pos, size_t size)
+			 struct bin_attribute *attr, char *buf,
+			 loff_t pos, size_t size)
 {
+	struct device *dev = kobj_to_dev(kobj);
+	struct tegra_fuse *fuse = dev_get_drvdata(dev);
 	int i;
 
-	if (pos < 0 || pos >= fuse_size)
+	if (pos < 0 || pos >= attr->size)
 		return 0;
 
-	if (size > fuse_size - pos)
-		size = fuse_size - pos;
+	if (size > attr->size - pos)
+		size = attr->size - pos;
 
 	for (i = 0; i < size; i++)
-		buf[i] = fuse_readb(pos + i);
+		buf[i] = fuse_readb(fuse, pos + i);
 
 	return i;
 }
@@ -76,6 +77,14 @@ static struct bin_attribute fuse_bin_attr = {
 	.read = fuse_read,
 };
 
+static int tegra_fuse_create_sysfs(struct device *dev, unsigned int size,
+				   const struct tegra_fuse_info *info)
+{
+	fuse_bin_attr.size = size;
+
+	return device_create_bin_file(dev, &fuse_bin_attr);
+}
+
 static const struct of_device_id car_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-car", },
 	{ .compatible = "nvidia,tegra30-car", },
@@ -85,73 +94,211 @@ static const struct of_device_id car_match[] __initconst = {
 	{},
 };
 
-static void tegra_enable_fuse_clk(void __iomem *base)
+static struct tegra_fuse *fuse = &(struct tegra_fuse) {
+	.base = NULL,
+	.soc = NULL,
+};
+
+static const struct of_device_id tegra_fuse_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_132_SOC
+	{ .compatible = "nvidia,tegra132-efuse", .data = &tegra124_fuse_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+	{ .compatible = "nvidia,tegra124-efuse", .data = &tegra124_fuse_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+	{ .compatible = "nvidia,tegra114-efuse", .data = &tegra114_fuse_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+	{ .compatible = "nvidia,tegra30-efuse", .data = &tegra30_fuse_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+	{ .compatible = "nvidia,tegra20-efuse", .data = &tegra20_fuse_soc },
+#endif
+	{ /* sentinel */ }
+};
+
+static int tegra_fuse_probe(struct platform_device *pdev)
 {
-	u32 reg;
+	void __iomem *base = fuse->base;
+	struct resource *res;
+	int err;
+
+	/* take over the memory region from the early initialization */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	fuse->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fuse->base))
+		return PTR_ERR(fuse->base);
+
+	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
+	if (IS_ERR(fuse->clk)) {
+		dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
+			PTR_ERR(fuse->clk));
+		return PTR_ERR(fuse->clk);
+	}
 
-	reg = readl_relaxed(base + 0x48);
-	reg |= 1 << 28;
-	writel(reg, base + 0x48);
+	platform_set_drvdata(pdev, fuse);
+	fuse->dev = &pdev->dev;
 
-	/*
-	 * Enable FUSE clock. This needs to be hardcoded because the clock
-	 * subsystem is not active during early boot.
-	 */
-	reg = readl(base + 0x14);
-	reg |= 1 << 7;
-	writel(reg, base + 0x14);
+	if (fuse->soc->probe) {
+		err = fuse->soc->probe(fuse);
+		if (err < 0)
+			return err;
+	}
+
+	if (tegra_fuse_create_sysfs(&pdev->dev, fuse->soc->info->size,
+				    fuse->soc->info))
+		return -ENODEV;
+
+	/* release the early I/O memory mapping */
+	iounmap(base);
+
+	return 0;
+}
+
+static struct platform_driver tegra_fuse_driver = {
+	.driver = {
+		.name = "tegra-fuse",
+		.of_match_table = tegra_fuse_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = tegra_fuse_probe,
+};
+module_platform_driver(tegra_fuse_driver);
+
+bool __init tegra_fuse_read_spare(unsigned int spare)
+{
+	unsigned int offset = fuse->soc->info->spare + spare * 4;
+
+	return fuse->read_early(fuse, offset) & 1;
+}
+
+u32 __init tegra_fuse_read_early(unsigned int offset)
+{
+	return fuse->read_early(fuse, offset);
 }
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse_readl)
+	if (!fuse->read)
 		return -EPROBE_DEFER;
 
-	*value = fuse_readl(offset);
+	*value = fuse->read(fuse, offset);
 
 	return 0;
 }
 EXPORT_SYMBOL(tegra_fuse_readl);
 
-int tegra_fuse_create_sysfs(struct device *dev, int size,
-		     u32 (*readl)(const unsigned int offset))
+static void tegra_enable_fuse_clk(void __iomem *base)
 {
-	if (fuse_size)
-		return -ENODEV;
-
-	fuse_bin_attr.size = size;
-	fuse_bin_attr.read = fuse_read;
+	u32 reg;
 
-	fuse_size = size;
-	fuse_readl = readl;
+	reg = readl_relaxed(base + 0x48);
+	reg |= 1 << 28;
+	writel(reg, base + 0x48);
 
-	return device_create_bin_file(dev, &fuse_bin_attr);
+	/*
+	 * Enable FUSE clock. This needs to be hardcoded because the clock
+	 * subsystem is not active during early boot.
+	 */
+	reg = readl(base + 0x14);
+	reg |= 1 << 7;
+	writel(reg, base + 0x14);
 }
 
 static int __init tegra_init_fuse(void)
 {
+	const struct of_device_id *match;
 	struct device_node *np;
-	void __iomem *car_base;
-
-	if (!soc_is_tegra())
-		return 0;
+	struct resource regs;
 
 	tegra_init_apbmisc();
 
-	np = of_find_matching_node(NULL, car_match);
-	car_base = of_iomap(np, 0);
-	if (car_base) {
-		tegra_enable_fuse_clk(car_base);
-		iounmap(car_base);
+	np = of_find_matching_node_and_match(NULL, tegra_fuse_match, &match);
+	if (!np) {
+		/*
+		 * Fall back to legacy initialization for 32-bit ARM only. All
+		 * 64-bit ARM device tree files for Tegra are required to have
+		 * a FUSE node.
+		 *
+		 * This is for backwards-compatibility with old device trees
+		 * that didn't contain a FUSE node.
+		 */
+		if (IS_ENABLED(CONFIG_ARM) && soc_is_tegra()) {
+			u8 chip = tegra_get_chip_id();
+
+			regs.start = 0x7000f800;
+			regs.end = 0x7000fbff;
+			regs.flags = IORESOURCE_MEM;
+
+			switch (chip) {
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+			case TEGRA20:
+				fuse->soc = &tegra20_fuse_soc;
+				break;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+			case TEGRA30:
+				fuse->soc = &tegra30_fuse_soc;
+				break;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+			case TEGRA114:
+				fuse->soc = &tegra114_fuse_soc;
+				break;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+			case TEGRA124:
+				fuse->soc = &tegra124_fuse_soc;
+				break;
+#endif
+
+			default:
+				pr_warn("Unsupported SoC: %02x\n", chip);
+				break;
+			}
+		} else {
+			/*
+			 * At this point we're not running on Tegra, so play
+			 * nice with multi-platform kernels.
+			 */
+			return 0;
+		}
 	} else {
-		pr_err("Could not enable fuse clk. ioremap tegra car failed.\n");
+		/*
+		 * Extract information from the device tree if we've found a
+		 * matching node.
+		 */
+		if (of_address_to_resource(np, 0, &regs) < 0) {
+			pr_err("failed to get FUSE register\n");
+			return -ENXIO;
+		}
+
+		fuse->soc = match->data;
+	}
+
+	np = of_find_matching_node(NULL, car_match);
+	if (np) {
+		void __iomem *base = of_iomap(np, 0);
+		if (base) {
+			tegra_enable_fuse_clk(base);
+			iounmap(base);
+		} else {
+			pr_err("failed to map clock registers\n");
+			return -ENXIO;
+		}
+	}
+
+	fuse->base = ioremap_nocache(regs.start, resource_size(&regs));
+	if (!fuse->base) {
+		pr_err("failed to map FUSE registers\n");
 		return -ENXIO;
 	}
 
-	if (tegra_get_chip_id() == TEGRA20)
-		tegra20_init_fuse_early();
-	else
-		tegra30_init_fuse_early();
+	fuse->soc->init(fuse);
 
 	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
 		tegra_revision_name[tegra_sku_info.revision],
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 5eff6f097f98..f695799c69d4 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -34,157 +34,104 @@
 #include "fuse.h"
 
 #define FUSE_BEGIN	0x100
-#define FUSE_SIZE	0x1f8
 #define FUSE_UID_LOW	0x08
 #define FUSE_UID_HIGH	0x0c
 
-static phys_addr_t fuse_phys;
-static struct clk *fuse_clk;
-static void __iomem __initdata *fuse_base;
-
-static DEFINE_MUTEX(apb_dma_lock);
-static DECLARE_COMPLETION(apb_dma_wait);
-static struct dma_chan *apb_dma_chan;
-static struct dma_slave_config dma_sconfig;
-static u32 *apb_buffer;
-static dma_addr_t apb_buffer_phys;
+static u32 tegra20_fuse_read_early(struct tegra_fuse *fuse, unsigned int offset)
+{
+	return readl_relaxed(fuse->base + FUSE_BEGIN + offset);
+}
 
 static void apb_dma_complete(void *args)
 {
-	complete(&apb_dma_wait);
+	struct tegra_fuse *fuse = args;
+
+	complete(&fuse->apbdma.wait);
 }
 
-static u32 tegra20_fuse_readl(const unsigned int offset)
+static u32 tegra20_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 {
-	int ret;
-	u32 val = 0;
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	struct dma_async_tx_descriptor *dma_desc;
+	u32 value = 0;
+	int err;
+
+	mutex_lock(&fuse->apbdma.lock);
 
-	mutex_lock(&apb_dma_lock);
+	fuse->apbdma.config.src_addr = fuse->apbdma.phys + FUSE_BEGIN + offset;
 
-	dma_sconfig.src_addr = fuse_phys + FUSE_BEGIN + offset;
-	ret = dmaengine_slave_config(apb_dma_chan, &dma_sconfig);
-	if (ret)
+	err = dmaengine_slave_config(fuse->apbdma.chan, &fuse->apbdma.config);
+	if (err)
 		goto out;
 
-	dma_desc = dmaengine_prep_slave_single(apb_dma_chan, apb_buffer_phys,
-			sizeof(u32), DMA_DEV_TO_MEM,
-			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	dma_desc = dmaengine_prep_slave_single(fuse->apbdma.chan,
+					       fuse->apbdma.phys,
+					       sizeof(u32), DMA_DEV_TO_MEM,
+					       flags);
 	if (!dma_desc)
 		goto out;
 
 	dma_desc->callback = apb_dma_complete;
-	dma_desc->callback_param = NULL;
+	dma_desc->callback_param = fuse;
 
-	reinit_completion(&apb_dma_wait);
+	reinit_completion(&fuse->apbdma.wait);
 
-	clk_prepare_enable(fuse_clk);
+	clk_prepare_enable(fuse->clk);
 
 	dmaengine_submit(dma_desc);
-	dma_async_issue_pending(apb_dma_chan);
+	dma_async_issue_pending(fuse->apbdma.chan);
 	ret = wait_for_completion_timeout(&apb_dma_wait, msecs_to_jiffies(50));
 
 	if (WARN(ret == 0, "apb read dma timed out"))
-		dmaengine_terminate_all(apb_dma_chan);
+		dmaengine_terminate_all(fuse->apbdma.chan);
 	else
-		val = *apb_buffer;
+		value = *fuse->apbdma.virt;
 
-	clk_disable_unprepare(fuse_clk);
-out:
-	mutex_unlock(&apb_dma_lock);
+	clk_disable_unprepare(fuse->clk);
 
-	return val;
+out:
+	mutex_unlock(&fuse->apbdma.lock);
+	return value;
 }
 
-static const struct of_device_id tegra20_fuse_of_match[] = {
-	{ .compatible = "nvidia,tegra20-efuse" },
-	{},
-};
-
-static int apb_dma_init(void)
+static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 {
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-	apb_dma_chan = dma_request_channel(mask, NULL, NULL);
-	if (!apb_dma_chan)
+
+	fuse->apbdma.chan = dma_request_channel(mask, NULL, NULL);
+	if (!fuse->apbdma.chan)
 		return -EPROBE_DEFER;
 
-	apb_buffer = dma_alloc_coherent(NULL, sizeof(u32), &apb_buffer_phys,
-					GFP_KERNEL);
-	if (!apb_buffer) {
-		dma_release_channel(apb_dma_chan);
+	fuse->apbdma.virt = dma_alloc_coherent(fuse->dev, sizeof(u32),
+					       &fuse->apbdma.phys,
+					       GFP_KERNEL);
+	if (!fuse->apbdma.virt) {
+		dma_release_channel(fuse->apbdma.chan);
 		return -ENOMEM;
 	}
 
-	dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	dma_sconfig.src_maxburst = 1;
-	dma_sconfig.dst_maxburst = 1;
+	fuse->apbdma.config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	fuse->apbdma.config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	fuse->apbdma.config.src_maxburst = 1;
+	fuse->apbdma.config.dst_maxburst = 1;
 
-	return 0;
-}
-
-static int tegra20_fuse_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	int err;
-
-	fuse_clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(fuse_clk)) {
-		dev_err(&pdev->dev, "missing clock");
-		return PTR_ERR(fuse_clk);
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	fuse_phys = res->start;
-
-	err = apb_dma_init();
-	if (err)
-		return err;
-
-	if (tegra_fuse_create_sysfs(&pdev->dev, FUSE_SIZE, tegra20_fuse_readl))
-		return -ENODEV;
-
-	dev_dbg(&pdev->dev, "loaded\n");
+	init_completion(&fuse->apbdma.wait);
+	mutex_init(&fuse->apbdma.lock);
 
 	return 0;
 }
 
-static struct platform_driver tegra20_fuse_driver = {
-	.probe = tegra20_fuse_probe,
-	.driver = {
-		.name = "tegra20_fuse",
-		.of_match_table = tegra20_fuse_of_match,
-	}
+static const struct tegra_fuse_info tegra20_fuse_info = {
+	.read = tegra20_fuse_read,
+	.size = 0x1f8,
+	.spare = 0x100,
 };
 
-static int __init tegra20_fuse_init(void)
-{
-	return platform_driver_register(&tegra20_fuse_driver);
-}
-postcore_initcall(tegra20_fuse_init);
-
 /* Early boot code. This code is called before the devices are created */
 
-u32 __init tegra20_fuse_early(const unsigned int offset)
-{
-	return readl_relaxed(fuse_base + FUSE_BEGIN + offset);
-}
-
-bool __init tegra20_spare_fuse_early(int spare_bit)
-{
-	u32 offset = spare_bit * 4;
-	bool value;
-
-	value = tegra20_fuse_early(offset + 0x100);
-
-	return value;
-}
-
 static void __init tegra20_fuse_add_randomness(void)
 {
 	u32 randomness[7];
@@ -196,19 +143,24 @@ static void __init tegra20_fuse_add_randomness(void)
 	randomness[3] |= tegra_sku_info.core_process_id;
 	randomness[4] = tegra_sku_info.cpu_speedo_id << 16;
 	randomness[4] |= tegra_sku_info.soc_speedo_id;
-	randomness[5] = tegra20_fuse_early(FUSE_UID_LOW);
-	randomness[6] = tegra20_fuse_early(FUSE_UID_HIGH);
+	randomness[5] = tegra_fuse_read_early(FUSE_UID_LOW);
+	randomness[6] = tegra_fuse_read_early(FUSE_UID_HIGH);
 
 	add_device_randomness(randomness, sizeof(randomness));
 }
 
-void __init tegra20_init_fuse_early(void)
+static void __init tegra20_fuse_init(struct tegra_fuse *fuse)
 {
-	fuse_base = ioremap(TEGRA_FUSE_BASE, TEGRA_FUSE_SIZE);
+	fuse->read_early = tegra20_fuse_read_early;
 
 	tegra_init_revision();
-	tegra20_init_speedo_data(&tegra_sku_info);
+	fuse->soc->speedo_init(&tegra_sku_info);
 	tegra20_fuse_add_randomness();
-
-	iounmap(fuse_base);
 }
+
+const struct tegra_fuse_soc tegra20_fuse_soc = {
+	.init = tegra20_fuse_init,
+	.speedo_init = tegra20_init_speedo_data,
+	.probe = tegra20_fuse_probe,
+	.info = &tegra20_fuse_info,
+};
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 4d2f71bf65c5..4a7f207171ad 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -42,23 +42,11 @@
 
 #define FUSE_HAS_REVISION_INFO	BIT(0)
 
-enum speedo_idx {
-	SPEEDO_TEGRA30 = 0,
-	SPEEDO_TEGRA114,
-	SPEEDO_TEGRA124,
-};
-
-struct tegra_fuse_info {
-	int		size;
-	int		spare_bit;
-	enum speedo_idx	speedo_idx;
-};
-
-static void __iomem *fuse_base;
-static struct clk *fuse_clk;
-static const struct tegra_fuse_info *fuse_info;
-
-u32 tegra30_fuse_readl(const unsigned int offset)
+#if defined(CONFIG_ARCH_TEGRA_3x_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_114_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_124_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_132_SOC)
+static u32 tegra30_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 {
 	u32 val;
 
@@ -67,89 +55,17 @@ u32 tegra30_fuse_readl(const unsigned int offset)
 	 * tegra_init_fuse()
 	 */
 
-	if (fuse_clk)
-		clk_prepare_enable(fuse_clk);
+	if (fuse->clk)
+		clk_prepare_enable(fuse->clk);
 
-	val = readl_relaxed(fuse_base + FUSE_BEGIN + offset);
+	val = readl_relaxed(fuse->base + FUSE_BEGIN + offset);
 
-	if (fuse_clk)
-		clk_disable_unprepare(fuse_clk);
+	if (fuse->clk)
+		clk_disable_unprepare(fuse->clk);
 
 	return val;
 }
 
-static const struct tegra_fuse_info tegra30_info = {
-	.size			= 0x2a4,
-	.spare_bit		= 0x144,
-	.speedo_idx		= SPEEDO_TEGRA30,
-};
-
-static const struct tegra_fuse_info tegra114_info = {
-	.size			= 0x2a0,
-	.speedo_idx		= SPEEDO_TEGRA114,
-};
-
-static const struct tegra_fuse_info tegra124_info = {
-	.size			= 0x300,
-	.speedo_idx		= SPEEDO_TEGRA124,
-};
-
-static const struct of_device_id tegra30_fuse_of_match[] = {
-	{ .compatible = "nvidia,tegra30-efuse", .data = &tegra30_info },
-	{ .compatible = "nvidia,tegra114-efuse", .data = &tegra114_info },
-	{ .compatible = "nvidia,tegra124-efuse", .data = &tegra124_info },
-	{},
-};
-
-static int tegra30_fuse_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *of_dev_id;
-
-	of_dev_id = of_match_device(tegra30_fuse_of_match, &pdev->dev);
-	if (!of_dev_id)
-		return -ENODEV;
-
-	fuse_clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(fuse_clk)) {
-		dev_err(&pdev->dev, "missing clock");
-		return PTR_ERR(fuse_clk);
-	}
-
-	platform_set_drvdata(pdev, NULL);
-
-	if (tegra_fuse_create_sysfs(&pdev->dev, fuse_info->size,
-				    tegra30_fuse_readl))
-		return -ENODEV;
-
-	dev_dbg(&pdev->dev, "loaded\n");
-
-	return 0;
-}
-
-static struct platform_driver tegra30_fuse_driver = {
-	.probe = tegra30_fuse_probe,
-	.driver = {
-		.name = "tegra_fuse",
-		.of_match_table = tegra30_fuse_of_match,
-	}
-};
-
-static int __init tegra30_fuse_init(void)
-{
-	return platform_driver_register(&tegra30_fuse_driver);
-}
-postcore_initcall(tegra30_fuse_init);
-
-/* Early boot code. This code is called before the devices are created */
-
-typedef void (*speedo_f)(struct tegra_sku_info *sku_info);
-
-static speedo_f __initdata speedo_tbl[] = {
-	[SPEEDO_TEGRA30]	= tegra30_init_speedo_data,
-	[SPEEDO_TEGRA114]	= tegra114_init_speedo_data,
-	[SPEEDO_TEGRA124]	= tegra124_init_speedo_data,
-};
-
 static void __init tegra30_fuse_add_randomness(void)
 {
 	u32 randomness[12];
@@ -161,64 +77,63 @@ static void __init tegra30_fuse_add_randomness(void)
 	randomness[3] |= tegra_sku_info.core_process_id;
 	randomness[4] = tegra_sku_info.cpu_speedo_id << 16;
 	randomness[4] |= tegra_sku_info.soc_speedo_id;
-	randomness[5] = tegra30_fuse_readl(FUSE_VENDOR_CODE);
-	randomness[6] = tegra30_fuse_readl(FUSE_FAB_CODE);
-	randomness[7] = tegra30_fuse_readl(FUSE_LOT_CODE_0);
-	randomness[8] = tegra30_fuse_readl(FUSE_LOT_CODE_1);
-	randomness[9] = tegra30_fuse_readl(FUSE_WAFER_ID);
-	randomness[10] = tegra30_fuse_readl(FUSE_X_COORDINATE);
-	randomness[11] = tegra30_fuse_readl(FUSE_Y_COORDINATE);
+	randomness[5] = tegra_fuse_read_early(FUSE_VENDOR_CODE);
+	randomness[6] = tegra_fuse_read_early(FUSE_FAB_CODE);
+	randomness[7] = tegra_fuse_read_early(FUSE_LOT_CODE_0);
+	randomness[8] = tegra_fuse_read_early(FUSE_LOT_CODE_1);
+	randomness[9] = tegra_fuse_read_early(FUSE_WAFER_ID);
+	randomness[10] = tegra_fuse_read_early(FUSE_X_COORDINATE);
+	randomness[11] = tegra_fuse_read_early(FUSE_Y_COORDINATE);
 
 	add_device_randomness(randomness, sizeof(randomness));
 }
 
-static void __init legacy_fuse_init(void)
+static void __init tegra30_fuse_init(struct tegra_fuse *fuse)
 {
-	switch (tegra_get_chip_id()) {
-	case TEGRA30:
-		fuse_info = &tegra30_info;
-		break;
-	case TEGRA114:
-		fuse_info = &tegra114_info;
-		break;
-	case TEGRA124:
-	case TEGRA132:
-		fuse_info = &tegra124_info;
-		break;
-	default:
-		return;
-	}
-
-	fuse_base = ioremap(TEGRA_FUSE_BASE, TEGRA_FUSE_SIZE);
+	fuse->read_early = tegra30_fuse_read;
+
+	tegra_init_revision();
+	fuse->soc->speedo_init(&tegra_sku_info);
+	tegra30_fuse_add_randomness();
 }
+#endif
 
-bool __init tegra30_spare_fuse(int spare_bit)
-{
-	u32 offset = fuse_info->spare_bit + spare_bit * 4;
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+static const struct tegra_fuse_info tegra30_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x2a4,
+	.spare = 0x144,
+};
 
-	return tegra30_fuse_readl(offset) & 1;
-}
+const struct tegra_fuse_soc tegra30_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.speedo_init = tegra30_init_speedo_data,
+	.info = &tegra30_fuse_info,
+};
+#endif
 
-void __init tegra30_init_fuse_early(void)
-{
-	struct device_node *np;
-	const struct of_device_id *of_match;
-
-	np = of_find_matching_node_and_match(NULL, tegra30_fuse_of_match,
-						&of_match);
-	if (np) {
-		fuse_base = of_iomap(np, 0);
-		fuse_info = (struct tegra_fuse_info *)of_match->data;
-	} else
-		legacy_fuse_init();
-
-	if (!fuse_base) {
-		pr_warn("fuse DT node missing and unknown chip id: 0x%02x\n",
-			tegra_get_chip_id());
-		return;
-	}
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+static const struct tegra_fuse_info tegra114_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x2a0,
+};
 
-	tegra_init_revision();
-	speedo_tbl[fuse_info->speedo_idx](&tegra_sku_info);
-	tegra30_fuse_add_randomness();
-}
+const struct tegra_fuse_soc tegra114_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.speedo_init = tegra114_init_speedo_data,
+	.info = &tegra114_fuse_info,
+};
+#endif
+
+#if defined(CONFIG_ARCH_TEGRA_124_SOC) || defined(CONFIG_ARCH_TEGRA_132_SOC)
+static const struct tegra_fuse_info tegra124_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x300,
+};
+
+const struct tegra_fuse_soc tegra124_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.speedo_init = tegra124_init_speedo_data,
+	.info = &tegra124_fuse_info,
+};
+#endif
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 3a398bf3572c..2a32bf9381ce 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -19,53 +19,82 @@
 #ifndef __DRIVERS_MISC_TEGRA_FUSE_H
 #define __DRIVERS_MISC_TEGRA_FUSE_H
 
-#define TEGRA_FUSE_BASE	0x7000f800
-#define TEGRA_FUSE_SIZE	0x400
+#include <linux/dmaengine.h>
+#include <linux/types.h>
 
-int tegra_fuse_create_sysfs(struct device *dev, int size,
-		     u32 (*readl)(const unsigned int offset));
+struct tegra_fuse;
+
+struct tegra_fuse_info {
+	u32 (*read)(struct tegra_fuse *fuse, unsigned int offset);
+	unsigned int size;
+	unsigned int spare;
+};
+
+struct tegra_fuse_soc {
+	void (*init)(struct tegra_fuse *fuse);
+	void (*speedo_init)(struct tegra_sku_info *info);
+	int (*probe)(struct tegra_fuse *fuse);
+
+	const struct tegra_fuse_info *info;
+};
+
+struct tegra_fuse {
+	struct device *dev;
+	void __iomem *base;
+	phys_addr_t phys;
+	struct clk *clk;
+
+	u32 (*read_early)(struct tegra_fuse *fuse, unsigned int offset);
+	u32 (*read)(struct tegra_fuse *fuse, unsigned int offset);
+	const struct tegra_fuse_soc *soc;
+
+	/* APBDMA on Tegra20 */
+	struct {
+		struct mutex lock;
+		struct completion wait;
+		struct dma_chan *chan;
+		struct dma_slave_config config;
+		dma_addr_t phys;
+		u32 *virt;
+	} apbdma;
+};
 
-bool tegra30_spare_fuse(int bit);
-u32 tegra30_fuse_readl(const unsigned int offset);
-void tegra30_init_fuse_early(void);
 void tegra_init_revision(void);
 void tegra_init_apbmisc(void);
 
+bool __init tegra_fuse_read_spare(unsigned int spare);
+u32 __init tegra_fuse_read_early(unsigned int offset);
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_init_speedo_data(struct tegra_sku_info *sku_info);
-bool tegra20_spare_fuse_early(int spare_bit);
-void tegra20_init_fuse_early(void);
-u32 tegra20_fuse_early(const unsigned int offset);
-#else
-static inline void tegra20_init_speedo_data(struct tegra_sku_info *sku_info) {}
-static inline bool tegra20_spare_fuse_early(int spare_bit)
-{
-	return false;
-}
-static inline void tegra20_init_fuse_early(void) {}
-static inline u32 tegra20_fuse_early(const unsigned int offset)
-{
-	return 0;
-}
 #endif
 
-
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 void tegra30_init_speedo_data(struct tegra_sku_info *sku_info);
-#else
-static inline void tegra30_init_speedo_data(struct tegra_sku_info *sku_info) {}
 #endif
 
 #ifdef CONFIG_ARCH_TEGRA_114_SOC
 void tegra114_init_speedo_data(struct tegra_sku_info *sku_info);
-#else
-static inline void tegra114_init_speedo_data(struct tegra_sku_info *sku_info) {}
 #endif
 
-#ifdef CONFIG_ARCH_TEGRA_124_SOC
+#if defined(CONFIG_ARCH_TEGRA_124_SOC) || defined(CONFIG_ARCH_TEGRA_132_SOC)
 void tegra124_init_speedo_data(struct tegra_sku_info *sku_info);
-#else
-static inline void tegra124_init_speedo_data(struct tegra_sku_info *sku_info) {}
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+extern const struct tegra_fuse_soc tegra20_fuse_soc;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+extern const struct tegra_fuse_soc tegra30_fuse_soc;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+extern const struct tegra_fuse_soc tegra114_fuse_soc;
+#endif
+
+#if defined(CONFIG_ARCH_TEGRA_124_SOC) || defined(CONFIG_ARCH_TEGRA_132_SOC)
+extern const struct tegra_fuse_soc tegra124_fuse_soc;
 #endif
 
 #endif
diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra/fuse/speedo-tegra114.c
index 2a6ca036f09f..554c54b98b0c 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra114.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
@@ -74,8 +74,8 @@ static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info,
 	}
 
 	if (rev == TEGRA_REVISION_A01) {
-		tmp = tegra30_fuse_readl(0x270) << 1;
-		tmp |= tegra30_fuse_readl(0x26c);
+		tmp = tegra_fuse_read_early(0x270) << 1;
+		tmp |= tegra_fuse_read_early(0x26c);
 		if (!tmp)
 			sku_info->cpu_speedo_id = 0;
 	}
@@ -95,8 +95,8 @@ void __init tegra114_init_speedo_data(struct tegra_sku_info *sku_info)
 
 	rev_sku_to_speedo_ids(sku_info, &threshold);
 
-	cpu_speedo_val = tegra30_fuse_readl(0x12c) + 1024;
-	core_speedo_val = tegra30_fuse_readl(0x134);
+	cpu_speedo_val = tegra_fuse_read_early(0x12c) + 1024;
+	core_speedo_val = tegra_fuse_read_early(0x134);
 
 	for (i = 0; i < CPU_PROCESS_CORNERS; i++)
 		if (cpu_speedo_val < cpu_process_speedos[threshold][i])
diff --git a/drivers/soc/tegra/fuse/speedo-tegra124.c b/drivers/soc/tegra/fuse/speedo-tegra124.c
index 46362387d974..d1e896d8d8a2 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra124.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra124.c
@@ -122,16 +122,16 @@ void __init tegra124_init_speedo_data(struct tegra_sku_info *sku_info)
 	BUILD_BUG_ON(ARRAY_SIZE(core_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
 
-	cpu_speedo_0_value = tegra30_fuse_readl(FUSE_CPU_SPEEDO_0);
+	cpu_speedo_0_value = tegra_fuse_read_early(FUSE_CPU_SPEEDO_0);
 
 	/* GPU Speedo is stored in CPU_SPEEDO_2 */
-	sku_info->gpu_speedo_value = tegra30_fuse_readl(FUSE_CPU_SPEEDO_2);
+	sku_info->gpu_speedo_value = tegra_fuse_read_early(FUSE_CPU_SPEEDO_2);
 
-	soc_speedo_0_value = tegra30_fuse_readl(FUSE_SOC_SPEEDO_0);
+	soc_speedo_0_value = tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
 
-	cpu_iddq_value = tegra30_fuse_readl(FUSE_CPU_IDDQ);
-	soc_iddq_value = tegra30_fuse_readl(FUSE_SOC_IDDQ);
-	gpu_iddq_value = tegra30_fuse_readl(FUSE_GPU_IDDQ);
+	cpu_iddq_value = tegra_fuse_read_early(FUSE_CPU_IDDQ);
+	soc_iddq_value = tegra_fuse_read_early(FUSE_SOC_IDDQ);
+	gpu_iddq_value = tegra_fuse_read_early(FUSE_GPU_IDDQ);
 
 	sku_info->cpu_speedo_value = cpu_speedo_0_value;
 
@@ -143,7 +143,7 @@ void __init tegra124_init_speedo_data(struct tegra_sku_info *sku_info)
 
 	rev_sku_to_speedo_ids(sku_info, &threshold);
 
-	sku_info->cpu_iddq_value = tegra30_fuse_readl(FUSE_CPU_IDDQ);
+	sku_info->cpu_iddq_value = tegra_fuse_read_early(FUSE_CPU_IDDQ);
 
 	for (i = 0; i < GPU_PROCESS_CORNERS; i++)
 		if (sku_info->gpu_speedo_value <
diff --git a/drivers/soc/tegra/fuse/speedo-tegra20.c b/drivers/soc/tegra/fuse/speedo-tegra20.c
index eff1b63f330d..ed5180b01e17 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra20.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra20.c
@@ -80,8 +80,8 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
 
 	val = 0;
 	for (i = CPU_SPEEDO_MSBIT; i >= CPU_SPEEDO_LSBIT; i--) {
-		reg = tegra20_spare_fuse_early(i) |
-			tegra20_spare_fuse_early(i + CPU_SPEEDO_REDUND_OFFS);
+		reg = tegra_fuse_read_spare(i) |
+			tegra_fuse_read_spare(i + CPU_SPEEDO_REDUND_OFFS);
 		val = (val << 1) | (reg & 0x1);
 	}
 	val = val * SPEEDO_MULT;
@@ -95,8 +95,8 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
 
 	val = 0;
 	for (i = CORE_SPEEDO_MSBIT; i >= CORE_SPEEDO_LSBIT; i--) {
-		reg = tegra20_spare_fuse_early(i) |
-			tegra20_spare_fuse_early(i + CORE_SPEEDO_REDUND_OFFS);
+		reg = tegra_fuse_read_spare(i) |
+			tegra_fuse_read_spare(i + CORE_SPEEDO_REDUND_OFFS);
 		val = (val << 1) | (reg & 0x1);
 	}
 	val = val * SPEEDO_MULT;
diff --git a/drivers/soc/tegra/fuse/speedo-tegra30.c b/drivers/soc/tegra/fuse/speedo-tegra30.c
index b17f0dcdfebe..fd0cefae54ef 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra30.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra30.c
@@ -93,25 +93,25 @@ static void __init fuse_speedo_calib(u32 *speedo_g, u32 *speedo_lp)
 	int bit_minus1;
 	int bit_minus2;
 
-	reg = tegra30_fuse_readl(FUSE_SPEEDO_CALIB_0);
+	reg = tegra_fuse_read_early(FUSE_SPEEDO_CALIB_0);
 
 	*speedo_lp = (reg & 0xFFFF) * 4;
 	*speedo_g = ((reg >> 16) & 0xFFFF) * 4;
 
-	ate_ver = tegra30_fuse_readl(FUSE_TEST_PROG_VER);
+	ate_ver = tegra_fuse_read_early(FUSE_TEST_PROG_VER);
 	pr_debug("Tegra ATE prog ver %d.%d\n", ate_ver/10, ate_ver%10);
 
 	if (ate_ver >= 26) {
-		bit_minus1 = tegra30_spare_fuse(LP_SPEEDO_BIT_MINUS1);
-		bit_minus1 |= tegra30_spare_fuse(LP_SPEEDO_BIT_MINUS1_R);
-		bit_minus2 = tegra30_spare_fuse(LP_SPEEDO_BIT_MINUS2);
-		bit_minus2 |= tegra30_spare_fuse(LP_SPEEDO_BIT_MINUS2_R);
+		bit_minus1 = tegra_fuse_read_spare(LP_SPEEDO_BIT_MINUS1);
+		bit_minus1 |= tegra_fuse_read_spare(LP_SPEEDO_BIT_MINUS1_R);
+		bit_minus2 = tegra_fuse_read_spare(LP_SPEEDO_BIT_MINUS2);
+		bit_minus2 |= tegra_fuse_read_spare(LP_SPEEDO_BIT_MINUS2_R);
 		*speedo_lp |= (bit_minus1 << 1) | bit_minus2;
 
-		bit_minus1 = tegra30_spare_fuse(G_SPEEDO_BIT_MINUS1);
-		bit_minus1 |= tegra30_spare_fuse(G_SPEEDO_BIT_MINUS1_R);
-		bit_minus2 = tegra30_spare_fuse(G_SPEEDO_BIT_MINUS2);
-		bit_minus2 |= tegra30_spare_fuse(G_SPEEDO_BIT_MINUS2_R);
+		bit_minus1 = tegra_fuse_read_spare(G_SPEEDO_BIT_MINUS1);
+		bit_minus1 |= tegra_fuse_read_spare(G_SPEEDO_BIT_MINUS1_R);
+		bit_minus2 = tegra_fuse_read_spare(G_SPEEDO_BIT_MINUS2);
+		bit_minus2 |= tegra_fuse_read_spare(G_SPEEDO_BIT_MINUS2_R);
 		*speedo_g |= (bit_minus1 << 1) | bit_minus2;
 	} else {
 		*speedo_lp |= 0x3;
@@ -121,7 +121,7 @@ static void __init fuse_speedo_calib(u32 *speedo_g, u32 *speedo_lp)
 
 static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info)
 {
-	int package_id = tegra30_fuse_readl(FUSE_PACKAGE_INFO) & 0x0F;
+	int package_id = tegra_fuse_read_early(FUSE_PACKAGE_INFO) & 0x0F;
 
 	switch (sku_info->revision) {
 	case TEGRA_REVISION_A01:
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index ab2df9373308..5a11ce968200 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -75,8 +75,8 @@ void __init tegra_init_revision(void)
 		rev = TEGRA_REVISION_A02;
 		break;
 	case 3:
-		if (chip_id == TEGRA20 && (tegra20_spare_fuse_early(18) ||
-					   tegra20_spare_fuse_early(19)))
+		if (chip_id == TEGRA20 && (tegra_fuse_read_spare(18) ||
+					   tegra_fuse_read_spare(19)))
 			rev = TEGRA_REVISION_A03p;
 		else
 			rev = TEGRA_REVISION_A03;
@@ -90,10 +90,7 @@ void __init tegra_init_revision(void)
 
 	tegra_sku_info.revision = rev;
 
-	if (chip_id == TEGRA20)
-		tegra_sku_info.sku_id = tegra20_fuse_early(FUSE_SKU_INFO);
-	else
-		tegra_sku_info.sku_id = tegra30_fuse_readl(FUSE_SKU_INFO);
+	tegra_sku_info.sku_id = tegra_fuse_read_early(FUSE_SKU_INFO);
 }
 
 void __init tegra_init_apbmisc(void)
-- 
2.3.5

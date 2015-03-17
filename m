From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Mar 2015 01:32:21 -0700
Subject: [PATCHv2 2/3] amba: tegra-ahb: use correct base address for future
 chip support
In-Reply-To: <20150317083221.32662.14647.stgit@baseline>
References: <20150317083221.32662.14647.stgit@baseline>
Message-ID: <20150317083221.32662.7448.stgit@baseline>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From a hardware SoC integration point of view, the starting address of
this IP block in our existing DT files is off by 4 bytes from the
actual base address.  Since we attempt to make old DT files
forward-compatible with newer kernels, we cannot fix the IP block base
address in old DT data.  However, we can fix this for DT files for
newer chips that have not yet been added to the kernel.  This patch
defines a new DT 'compatible' string that doesn't require the 4 byte
variance from the hardware integration data.  SoC DT data for future
Tegra chips should use this new 'compatible' string and the correct
Tegra AHB base address.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel at vger.kernel.org
---
 drivers/amba/tegra-ahb.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 30759a5..eac6934 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <soc/tegra/ahb.h>
 
@@ -120,16 +121,17 @@ struct tegra_ahb {
 	void __iomem	*regs;
 	struct device	*dev;
 	u32		ctx[0];
+	short		offset;
 };
 
 static inline u32 gizmo_readl(struct tegra_ahb *ahb, u32 offset)
 {
-	return readl(ahb->regs - 4 + offset);
+	return readl(ahb->regs + ahb->offset + offset);
 }
 
 static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
 {
-	writel(value, ahb->regs - 4 + offset);
+	writel(value, ahb->regs + ahb->offset + offset);
 }
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
@@ -246,11 +248,30 @@ static void tegra_ahb_gizmo_init(struct tegra_ahb *ahb)
 	gizmo_writel(ahb, val, AHB_MEM_PREFETCH_CFG4);
 }
 
+struct ahb_data {
+	short offset;
+};
+
+static const struct ahb_data correct_offset;
+static const struct ahb_data broken_offset = {
+	.offset = -4,
+};
+
+static const struct of_device_id tegra_ahb_of_match[] = {
+	{ .compatible = "nvidia,tegra132-ahb", .data = &correct_offset },
+	{ .compatible = "nvidia,tegra30-ahb", .data = &broken_offset },
+	{ .compatible = "nvidia,tegra20-ahb", .data = &broken_offset },
+	{},
+};
+
 static int tegra_ahb_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct tegra_ahb *ahb;
 	size_t bytes;
+	const struct of_device_id *of_id =
+		of_match_device(tegra_ahb_of_match, &pdev->dev);
+	const struct ahb_data *ad;
 
 	bytes = sizeof(*ahb) + sizeof(u32) * ARRAY_SIZE(tegra_ahb_gizmo);
 	ahb = devm_kzalloc(&pdev->dev, bytes, GFP_KERNEL);
@@ -262,18 +283,15 @@ static int tegra_ahb_probe(struct platform_device *pdev)
 	if (IS_ERR(ahb->regs))
 		return PTR_ERR(ahb->regs);
 
+	ad = of_id->data;
 	ahb->dev = &pdev->dev;
+	ahb->offset = ad->offset;
+
 	platform_set_drvdata(pdev, ahb);
 	tegra_ahb_gizmo_init(ahb);
 	return 0;
 }
 
-static const struct of_device_id tegra_ahb_of_match[] = {
-	{ .compatible = "nvidia,tegra30-ahb", },
-	{ .compatible = "nvidia,tegra20-ahb", },
-	{},
-};
-
 static struct platform_driver tegra_ahb_driver = {
 	.probe = tegra_ahb_probe,
 	.driver = {

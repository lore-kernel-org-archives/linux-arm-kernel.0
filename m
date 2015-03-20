From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Mar 2015 00:11:02 -0600
Subject: [PATCH v3 2/3] amba: tegra-ahb: detect and correct bogus base address
In-Reply-To: <20150320061102.14355.4781.stgit@mcwayne>
References: <20150320061102.14355.4781.stgit@mcwayne>
Message-ID: <20150320061102.14355.95682.stgit@mcwayne>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From a hardware SoC integration point of view, the starting address of
this IP block in the existing Tegra SoC DT files is off by 4 bytes
from the actual base address.  Since we attempt to make old DT files
forward-compatible with newer kernels, we cannot fix the IP block base
address in old DT data. This patch works around the problem by
detecting the four byte base address offset in the driver code, and
correcting it if it's detected.  (In general, IP block base addresses
almost always have a null low byte.)

Future SoC DT data for Tegra AHB should use the correct Tegra AHB base
address, in cases where there is no DT data backward compatibility
requirement.

This patch is a revision of the patch originally titled
"amba: tegra-ahb: use correct base address for future chip support".
This revision implements changes requested by Russell King:

http://marc.info/?l=linux-tegra&m=142658851825062&w=2
http://marc.info/?l=linux-tegra&m=142658873925178&w=2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel at vger.kernel.org
---
 drivers/amba/tegra-ahb.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 30759a55efe4..b0b688c481e8 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -82,6 +82,16 @@
 
 #define AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE BIT(17)
 
+/*
+ * INCORRECT_BASE_ADDR_LOW_BYTE: Legacy kernel DT files for Tegra SoCs
+ * prior to Tegra124 generally use a physical base address ending in
+ * 0x4 for the AHB IP block.  According to the TRM, the low byte
+ * should be 0x0.  During device probing, this macro is used to detect
+ * whether the passed-in physical address is incorrect, and if so, to
+ * correct it.
+ */
+#define INCORRECT_BASE_ADDR_LOW_BYTE		0x4
+
 static struct platform_driver tegra_ahb_driver;
 
 static const u32 tegra_ahb_gizmo[] = {
@@ -124,12 +134,12 @@ struct tegra_ahb {
 
 static inline u32 gizmo_readl(struct tegra_ahb *ahb, u32 offset)
 {
-	return readl(ahb->regs - 4 + offset);
+	return readl(ahb->regs + offset);
 }
 
 static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
 {
-	writel(value, ahb->regs - 4 + offset);
+	writel(value, ahb->regs + offset);
 }
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
@@ -258,6 +268,15 @@ static int tegra_ahb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/* Correct the IP block base address if necessary */
+	if (res &&
+	    (res->start & INCORRECT_BASE_ADDR_LOW_BYTE) ==
+	    INCORRECT_BASE_ADDR_LOW_BYTE) {
+		dev_warn(&pdev->dev, "incorrect AHB base address in DT data - enabling workaround\n");
+		res->start -= INCORRECT_BASE_ADDR_LOW_BYTE;
+	}
+
 	ahb->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ahb->regs))
 		return PTR_ERR(ahb->regs);

From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 20 Mar 2015 00:11:02 -0600
Subject: [PATCH v3 1/3] amba: tegra-ahb: fix register offsets in the macros
In-Reply-To: <20150320061102.14355.4781.stgit@mcwayne>
References: <20150320061102.14355.4781.stgit@mcwayne>
Message-ID: <20150320061102.14355.19921.stgit@mcwayne>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From a hardware SoC integration point of view, the offsets of the
Tegra AHB registers that are currently defined in tegra-ahb.c macros
are all off by four bytes.  Similarly, the starting address of this IP
block in our existing DT files is also off by four bytes.  Since we
attempt to make old DT files forward-compatible with newer kernels, we
cannot fix the IP block base address in old DT data.  However, we can
fix the offsets in the driver so that they are correct with respect to
the hardware, which is what this patch does.  And a subsequent patch
will allow the offset to be removed for DT 'compatible' strings used
in future DT files for newer Tegra chips that the kernel does not yet
support.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel at vger.kernel.org
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/amba/tegra-ahb.c |   63 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index c6dc3548e5d1..30759a55efe4 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -25,49 +25,50 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <soc/tegra/ahb.h>
 
 #define DRV_NAME "tegra-ahb"
 
-#define AHB_ARBITRATION_DISABLE		0x00
-#define AHB_ARBITRATION_PRIORITY_CTRL	0x04
+#define AHB_ARBITRATION_DISABLE		0x04
+#define AHB_ARBITRATION_PRIORITY_CTRL	0x08
 #define   AHB_PRIORITY_WEIGHT(x)	(((x) & 0x7) << 29)
 #define   PRIORITY_SELECT_USB BIT(6)
 #define   PRIORITY_SELECT_USB2 BIT(18)
 #define   PRIORITY_SELECT_USB3 BIT(17)
 
-#define AHB_GIZMO_AHB_MEM		0x0c
+#define AHB_GIZMO_AHB_MEM		0x10
 #define   ENB_FAST_REARBITRATE BIT(2)
 #define   DONT_SPLIT_AHB_WR     BIT(7)
 
-#define AHB_GIZMO_APB_DMA		0x10
-#define AHB_GIZMO_IDE			0x18
-#define AHB_GIZMO_USB			0x1c
-#define AHB_GIZMO_AHB_XBAR_BRIDGE	0x20
-#define AHB_GIZMO_CPU_AHB_BRIDGE	0x24
-#define AHB_GIZMO_COP_AHB_BRIDGE	0x28
-#define AHB_GIZMO_XBAR_APB_CTLR		0x2c
-#define AHB_GIZMO_VCP_AHB_BRIDGE	0x30
-#define AHB_GIZMO_NAND			0x3c
-#define AHB_GIZMO_SDMMC4		0x44
-#define AHB_GIZMO_XIO			0x48
-#define AHB_GIZMO_BSEV			0x60
-#define AHB_GIZMO_BSEA			0x70
-#define AHB_GIZMO_NOR			0x74
-#define AHB_GIZMO_USB2			0x78
-#define AHB_GIZMO_USB3			0x7c
+#define AHB_GIZMO_APB_DMA		0x14
+#define AHB_GIZMO_IDE			0x1c
+#define AHB_GIZMO_USB			0x20
+#define AHB_GIZMO_AHB_XBAR_BRIDGE	0x24
+#define AHB_GIZMO_CPU_AHB_BRIDGE	0x28
+#define AHB_GIZMO_COP_AHB_BRIDGE	0x2c
+#define AHB_GIZMO_XBAR_APB_CTLR		0x30
+#define AHB_GIZMO_VCP_AHB_BRIDGE	0x34
+#define AHB_GIZMO_NAND			0x40
+#define AHB_GIZMO_SDMMC4		0x48
+#define AHB_GIZMO_XIO			0x4c
+#define AHB_GIZMO_BSEV			0x64
+#define AHB_GIZMO_BSEA			0x74
+#define AHB_GIZMO_NOR			0x78
+#define AHB_GIZMO_USB2			0x7c
+#define AHB_GIZMO_USB3			0x80
 #define   IMMEDIATE	BIT(18)
 
-#define AHB_GIZMO_SDMMC1		0x80
-#define AHB_GIZMO_SDMMC2		0x84
-#define AHB_GIZMO_SDMMC3		0x88
-#define AHB_MEM_PREFETCH_CFG_X		0xd8
-#define AHB_ARBITRATION_XBAR_CTRL	0xdc
-#define AHB_MEM_PREFETCH_CFG3		0xe0
-#define AHB_MEM_PREFETCH_CFG4		0xe4
-#define AHB_MEM_PREFETCH_CFG1		0xec
-#define AHB_MEM_PREFETCH_CFG2		0xf0
+#define AHB_GIZMO_SDMMC1		0x84
+#define AHB_GIZMO_SDMMC2		0x88
+#define AHB_GIZMO_SDMMC3		0x8c
+#define AHB_MEM_PREFETCH_CFG_X		0xdc
+#define AHB_ARBITRATION_XBAR_CTRL	0xe0
+#define AHB_MEM_PREFETCH_CFG3		0xe4
+#define AHB_MEM_PREFETCH_CFG4		0xe8
+#define AHB_MEM_PREFETCH_CFG1		0xf0
+#define AHB_MEM_PREFETCH_CFG2		0xf4
 #define   PREFETCH_ENB	BIT(31)
 #define   MST_ID(x)	(((x) & 0x1f) << 26)
 #define   AHBDMA_MST_ID	MST_ID(5)
@@ -77,7 +78,7 @@
 #define   ADDR_BNDRY(x)	(((x) & 0xf) << 21)
 #define   INACTIVITY_TIMEOUT(x)	(((x) & 0xffff) << 0)
 
-#define AHB_ARBITRATION_AHB_MEM_WRQUE_MST_ID	0xf8
+#define AHB_ARBITRATION_AHB_MEM_WRQUE_MST_ID	0xfc
 
 #define AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE BIT(17)
 
@@ -123,12 +124,12 @@ struct tegra_ahb {
 
 static inline u32 gizmo_readl(struct tegra_ahb *ahb, u32 offset)
 {
-	return readl(ahb->regs + offset);
+	return readl(ahb->regs - 4 + offset);
 }
 
 static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
 {
-	writel(value, ahb->regs + offset);
+	writel(value, ahb->regs - 4 + offset);
 }
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU

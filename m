From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 12 Nov 2011 21:00:05 +0100
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers and
 into platform.
In-Reply-To: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
Message-ID: <1321128007-3520-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/pcie.c                   |    3 +-
 arch/arm/mach-kirkwood/mpp.c                |    1 -
 arch/arm/mach-kirkwood/pcie.c               |    3 +-
 arch/arm/mach-mv78xx0/mpp.c                 |    1 -
 arch/arm/mach-mv78xx0/pcie.c                |    3 +-
 arch/arm/mach-orion5x/mpp.c                 |    1 -
 arch/arm/mach-orion5x/pci.c                 |    2 +-
 arch/arm/plat-orion/addr-map.c              |  182 +++++++++++++++++++++++++++
 arch/arm/plat-orion/include/plat/addr-map.h |    8 ++
 arch/arm/plat-orion/include/plat/pcie.h     |    3 +-
 arch/arm/plat-orion/pcie.c                  |    6 +-
 drivers/ata/sata_mv.c                       |   36 +-----
 drivers/dma/mv_xor.c                        |   37 +-----
 drivers/dma/mv_xor.h                        |    5 -
 drivers/mmc/host/mvsdio.c                   |   28 +----
 drivers/mmc/host/mvsdio.h                   |    4 -
 drivers/net/mv643xx_eth.c                   |   45 +------
 drivers/usb/host/ehci-orion.c               |   30 +----
 sound/soc/kirkwood/kirkwood-dma.c           |   30 +----
 sound/soc/kirkwood/kirkwood.h               |    4 -
 20 files changed, 218 insertions(+), 214 deletions(-)

diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 42e7d22..6c11a4d 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/mbus.h>
 #include <video/vga.h>
 #include <asm/mach/pci.h>
 #include <asm/mach/arch.h>
@@ -51,7 +50,7 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 
-	orion_pcie_setup(pp->base, &orion_mbus_dram_info);
+	orion_pcie_setup(pp->base);
 
 	/*
 	 * IORESOURCE_IO
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index b0a7d97..43a495f 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mbus.h>
 #include <linux/io.h>
 #include <asm/gpio.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index 8def894..fb451bf 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/mbus.h>
 #include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
@@ -209,7 +208,7 @@ static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 
-	orion_pcie_setup(pp->base, &orion_mbus_dram_info);
+	orion_pcie_setup(pp->base);
 
 	return 1;
 }
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 59b7686..34cb967 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mbus.h>
 #include <linux/io.h>
 #include <plat/mpp.h>
 #include <asm/gpio.h>
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 9208667..12fcb10 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/mbus.h>
 #include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
@@ -154,7 +153,7 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 	 * Generic PCIe unit setup.
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
-	orion_pcie_setup(pp->base, &orion_mbus_dram_info);
+	orion_pcie_setup(pp->base);
 
 	sys->resource[0] = &pp->res[0];
 	sys->resource[1] = &pp->res[1];
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index b6ddd7a..5b70026 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mbus.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <plat/mpp.h>
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index ddfa01a..a494c47 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -146,7 +146,7 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	/*
 	 * Generic PCIe unit setup.
 	 */
-	orion_pcie_setup(PCIE_BASE, &orion_mbus_dram_info);
+	orion_pcie_setup(PCIE_BASE);
 
 	/*
 	 * Check whether to apply Orion-1/Orion-NAS PCIe config
diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index c27ad88..cfb9ee3 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -9,10 +9,12 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <plat/addr-map.h>
+#include <plat/ehci-orion.h>
 
 struct mbus_dram_target_info orion_mbus_dram_info;
 
@@ -165,3 +167,183 @@ void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 	}
 	orion_mbus_dram_info.num_cs = cs;
 }
+
+#define XOR_WINDOW_BASE(w)		(0x250 + ((w) << 2))
+#define XOR_WINDOW_SIZE(w)		(0x270 + ((w) << 2))
+#define XOR_WINDOW_REMAP_HIGH(w)	(0x290 + ((w) << 2))
+#define XOR_WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
+
+void
+mv_xor_conf_mbus_windows(void __iomem *base)
+{
+	u32 win_enable = 0;
+	struct mbus_dram_window *cs;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		writel(0, base + XOR_WINDOW_BASE(i));
+		writel(0, base + XOR_WINDOW_SIZE(i));
+		if (i < 4)
+			writel(0, base + XOR_WINDOW_REMAP_HIGH(i));
+	}
+
+	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
+		cs = orion_mbus_dram_info.cs + i;
+
+		writel((cs->base & 0xffff0000) |
+		       (cs->mbus_attr << 8) |
+		       orion_mbus_dram_info.mbus_dram_target_id,
+		       base + XOR_WINDOW_BASE(i));
+		writel((cs->size - 1) & 0xffff0000, base + XOR_WINDOW_SIZE(i));
+
+		win_enable |= (1 << i);
+		win_enable |= 3 << (16 + (2 * i));
+	}
+
+	writel(win_enable, base + XOR_WINDOW_BAR_ENABLE(0));
+	writel(win_enable, base + XOR_WINDOW_BAR_ENABLE(1));
+}
+
+#define USB_WINDOW_CTRL(i)	(0x320 + ((i) << 4))
+#define USB_WINDOW_BASE(i)	(0x324 + ((i) << 4))
+#define rdl(off)	__raw_readl(base + (off))
+#define wrl(off, val)	__raw_writel((val), base + (off))
+
+void __init
+ehci_orion_conf_mbus_windows(void __iomem *base)
+{
+	int i;
+	struct mbus_dram_window *cs;
+
+	for (i = 0; i < 4; i++) {
+		wrl(USB_WINDOW_CTRL(i), 0);
+		wrl(USB_WINDOW_BASE(i), 0);
+	}
+
+	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
+		cs = orion_mbus_dram_info.cs + i;
+
+		wrl(USB_WINDOW_CTRL(i),
+		    ((cs->size - 1) & 0xffff0000) |
+		    (cs->mbus_attr << 8) |
+		    (orion_mbus_dram_info.mbus_dram_target_id << 4) | 1);
+		wrl(USB_WINDOW_BASE(i), cs->base);
+	}
+}
+
+#define SATA_WINDOW_CTRL(i)		(0x20030 + ((i) << 4))
+#define SATA_WINDOW_BASE(i)		(0x20034 + ((i) << 4))
+
+
+void mv_sata_conf_mbus_windows(void __iomem *base)
+{
+	int i;
+	struct mbus_dram_window *cs;
+
+	for (i = 0; i < 4; i++) {
+		writel(0, base + SATA_WINDOW_CTRL(i));
+		writel(0, base + SATA_WINDOW_BASE(i));
+	}
+
+	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
+		cs = orion_mbus_dram_info.cs + i;
+
+		writel(((cs->size - 1) & 0xffff0000) |
+			(cs->mbus_attr << 8) |
+			(orion_mbus_dram_info.mbus_dram_target_id << 4) | 1,
+			base + SATA_WINDOW_CTRL(i));
+		writel(cs->base, base + SATA_WINDOW_BASE(i));
+	}
+}
+
+
+#define ETH_WINDOW_BASE(w)		(0x0200 + ((w) << 3))
+#define ETH_WINDOW_SIZE(w)		(0x0204 + ((w) << 3))
+#define ETH_WINDOW_REMAP_HIGH(w)	(0x0280 + ((w) << 2))
+#define ETH_WINDOW_BAR_ENABLE		0x0290
+
+u32
+mv643xx_eth_conf_mbus_windows(void __iomem *base)
+{
+	u32 win_enable;
+	u32 win_protect;
+	int i;
+	struct mbus_dram_window *cs;
+
+	for (i = 0; i < 6; i++) {
+		writel(0, base + ETH_WINDOW_BASE(i));
+		writel(0, base + ETH_WINDOW_SIZE(i));
+		if (i < 4)
+			writel(0, base + ETH_WINDOW_REMAP_HIGH(i));
+	}
+
+	win_enable = 0x3f;
+	win_protect = 0;
+
+	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
+		cs = orion_mbus_dram_info.cs + i;
+		writel((cs->base & 0xffff0000) |
+		       (cs->mbus_attr << 8) |
+		       orion_mbus_dram_info.mbus_dram_target_id,
+		       base + ETH_WINDOW_BASE(i));
+		writel((cs->size - 1) & 0xffff0000, base + ETH_WINDOW_SIZE(i));
+
+		win_enable &= ~(1 << i);
+		win_protect |= 3 << (2 * i);
+	}
+
+	writel(win_enable, base + ETH_WINDOW_BAR_ENABLE);
+	return win_protect;
+}
+
+#define MVSD_WINDOW_CTRL(i)			(0x108 + ((i) << 3))
+#define MVSD_WINDOW_BASE(i)			(0x10c + ((i) << 3))
+
+void mvsd_conf_mbus_windows(void __iomem *base)
+{
+	int i;
+	struct mbus_dram_window *cs;
+
+	for (i = 0; i < 4; i++) {
+		writel(0, base + MVSD_WINDOW_CTRL(i));
+		writel(0, base + MVSD_WINDOW_BASE(i));
+	}
+
+	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
+		cs = orion_mbus_dram_info.cs + i;
+		writel(((cs->size - 1) & 0xffff0000) |
+		       (cs->mbus_attr << 8) |
+		       (orion_mbus_dram_info.mbus_dram_target_id << 4) | 1,
+		       base + MVSD_WINDOW_CTRL(i));
+		writel(cs->base, base + MVSD_WINDOW_BASE(i));
+	}
+}
+
+#define KIRKWOOD_AUDIO_WIN_BASE_REG(win)	(0xA00 + ((win)<<3))
+#define KIRKWOOD_AUDIO_WIN_CTRL_REG(win)	(0xA04 + ((win)<<3))
+
+void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
+				    unsigned long dma)
+{
+	int i;
+	struct mbus_dram_window *cs;
+
+	/* First disable and clear windows */
+	writel(0, base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
+	writel(0, base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
+
+	/* try to find matching cs for current dma address */
+	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
+		cs = orion_mbus_dram_info.cs + i;
+		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
+			writel(cs->base & 0xffff0000,
+				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
+			writel(((cs->size - 1) & 0xffff0000) |
+				(cs->mbus_attr << 8) |
+				(orion_mbus_dram_info.mbus_dram_target_id << 4)
+			       | 1,
+				base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(kirkwood_dma_conf_mbus_windows);
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index fd556f7..4be2cac 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -50,4 +50,12 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 					const u32 ddr_window_cpu_base);
+
+void mv_xor_conf_mbus_windows(void __iomem *base);
+void ehci_orion_conf_mbus_windows(void __iomem *base);
+void mv_sata_conf_mbus_windows(void __iomem *base);
+u32 mv643xx_eth_conf_mbus_windows(void __iomem *base);
+void mv_sd_conf_mbus_windows(void __iomem *base);
+void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
+				    unsigned long dma);
 #endif
diff --git a/arch/arm/plat-orion/include/plat/pcie.h b/arch/arm/plat-orion/include/plat/pcie.h
index cc99163..fe5b9e8 100644
--- a/arch/arm/plat-orion/include/plat/pcie.h
+++ b/arch/arm/plat-orion/include/plat/pcie.h
@@ -20,8 +20,7 @@ int orion_pcie_x4_mode(void __iomem *base);
 int orion_pcie_get_local_bus_nr(void __iomem *base);
 void orion_pcie_set_local_bus_nr(void __iomem *base, int nr);
 void orion_pcie_reset(void __iomem *base);
-void orion_pcie_setup(void __iomem *base,
-		      struct mbus_dram_target_info *dram);
+void orion_pcie_setup(void __iomem *base);
 int orion_pcie_rd_conf(void __iomem *base, struct pci_bus *bus,
 		       u32 devfn, int where, int size, u32 *val);
 int orion_pcie_rd_conf_tlp(void __iomem *base, struct pci_bus *bus,
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index af2d733..86dbb5b 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -13,6 +13,7 @@
 #include <linux/mbus.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
+#include <plat/addr-map.h>
 #include <linux/delay.h>
 
 /*
@@ -175,8 +176,7 @@ static void __init orion_pcie_setup_wins(void __iomem *base,
 	writel(((size - 1) & 0xffff0000) | 1, base + PCIE_BAR_CTRL_OFF(1));
 }
 
-void __init orion_pcie_setup(void __iomem *base,
-			     struct mbus_dram_target_info *dram)
+void __init orion_pcie_setup(void __iomem *base)
 {
 	u16 cmd;
 	u32 mask;
@@ -184,7 +184,7 @@ void __init orion_pcie_setup(void __iomem *base,
 	/*
 	 * Point PCIe unit MBUS decode windows to DRAM space.
 	 */
-	orion_pcie_setup_wins(base, dram);
+	orion_pcie_setup_wins(base, &orion_mbus_dram_info);
 
 	/*
 	 * Master + slave enable.
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 4b6b209..43c6d2a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -62,13 +62,13 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/mbus.h>
 #include <linux/bitops.h>
 #include <linux/gfp.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
+#include <plat/addr-map.h>
 
 #define DRV_NAME	"sata_mv"
 #define DRV_VERSION	"1.28"
@@ -444,9 +444,6 @@ enum {
 #define IS_PCIE(hpriv) ((hpriv)->hp_flags & MV_HP_PCIE)
 #define IS_SOC(hpriv) ((hpriv)->hp_flags & MV_HP_FLAG_SOC)
 
-#define WINDOW_CTRL(i)		(0x20030 + ((i) << 4))
-#define WINDOW_BASE(i)		(0x20034 + ((i) << 4))
-
 enum {
 	/* DMA boundary 0xffff is required by the s/g splitting
 	 * we need on /length/ in mv_fill-sg().
@@ -3987,27 +3984,6 @@ static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
 	return 0;
 }
 
-static void mv_conf_mbus_windows(struct mv_host_priv *hpriv,
-				 struct mbus_dram_target_info *dram)
-{
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		writel(0, hpriv->base + WINDOW_CTRL(i));
-		writel(0, hpriv->base + WINDOW_BASE(i));
-	}
-
-	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
-
-		writel(((cs->size - 1) & 0xffff0000) |
-			(cs->mbus_attr << 8) |
-			(dram->mbus_dram_target_id << 4) | 1,
-			hpriv->base + WINDOW_CTRL(i));
-		writel(cs->base, hpriv->base + WINDOW_BASE(i));
-	}
-}
-
 /**
  *      mv_platform_probe - handle a positive probe of an soc Marvell
  *      host
@@ -4070,10 +4046,9 @@ static int mv_platform_probe(struct platform_device *pdev)
 #endif
 
 	/*
-	 * (Re-)program MBUS remapping windows if we are asked to.
+	 * (Re-)program MBUS remapping windows.
 	 */
-	if (mv_platform_data->dram != NULL)
-		mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
+	mv_sata_conf_mbus_windows(hpriv->base);
 
 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
 	if (rc)
@@ -4146,10 +4121,9 @@ static int mv_platform_resume(struct platform_device *pdev)
 		const struct mv_sata_platform_data *mv_platform_data = \
 			pdev->dev.platform_data;
 		/*
-		 * (Re-)program MBUS remapping windows if we are asked to.
+		 * (Re-)program MBUS remapping windows.
 		 */
-		if (mv_platform_data->dram != NULL)
-			mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
+		mv_sata_conf_mbus_windows(hpriv->base);
 
 		/* initialize adapter */
 		ret = mv_init_host(host);
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 9a353c2..10f8518 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <plat/mv_xor.h>
+#include <plat/addr-map.h>
 #include "mv_xor.h"
 
 static void mv_xor_issue_pending(struct dma_chan *chan);
@@ -1248,37 +1249,6 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void
-mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
-			 struct mbus_dram_target_info *dram)
-{
-	void __iomem *base = msp->xor_base;
-	u32 win_enable = 0;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		writel(0, base + WINDOW_BASE(i));
-		writel(0, base + WINDOW_SIZE(i));
-		if (i < 4)
-			writel(0, base + WINDOW_REMAP_HIGH(i));
-	}
-
-	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
-
-		writel((cs->base & 0xffff0000) |
-		       (cs->mbus_attr << 8) |
-		       dram->mbus_dram_target_id, base + WINDOW_BASE(i));
-		writel((cs->size - 1) & 0xffff0000, base + WINDOW_SIZE(i));
-
-		win_enable |= (1 << i);
-		win_enable |= 3 << (16 + (2 * i));
-	}
-
-	writel(win_enable, base + WINDOW_BAR_ENABLE(0));
-	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
-}
-
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
 	.remove		= __devexit_p(mv_xor_remove),
@@ -1321,10 +1291,9 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, msp);
 
 	/*
-	 * (Re-)program MBUS remapping windows if we are asked to.
+	 * (Re-)program MBUS remapping windows.
 	 */
-	if (msd != NULL && msd->dram != NULL)
-		mv_xor_conf_mbus_windows(msp, msd->dram);
+	mv_xor_conf_mbus_windows(msp->xor_base);
 
 	return 0;
 }
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 977b592..b6b13fb 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -47,11 +47,6 @@
 #define XOR_ERROR_ADDR(chan)	(chan->mmr_base + 0x60)
 #define XOR_INTR_MASK_VALUE	0x3F5
 
-#define WINDOW_BASE(w)		(0x250 + ((w) << 2))
-#define WINDOW_SIZE(w)		(0x270 + ((w) << 2))
-#define WINDOW_REMAP_HIGH(w)	(0x290 + ((w) << 2))
-#define WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
-
 struct mv_xor_shared_private {
 	void __iomem	*xor_base;
 	void __iomem	*xor_high_base;
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a5bf60e..9e1a1be 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/mbus.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
@@ -25,6 +24,7 @@
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
 #include <plat/mvsdio.h>
+#include <plat/addr-map.h>
 
 #include "mvsdio.h"
 
@@ -679,27 +679,6 @@ static const struct mmc_host_ops mvsd_ops = {
 	.enable_sdio_irq	= mvsd_enable_sdio_irq,
 };
 
-static void __init mv_conf_mbus_windows(struct mvsd_host *host,
-					struct mbus_dram_target_info *dram)
-{
-	void __iomem *iobase = host->base;
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		writel(0, iobase + MVSD_WINDOW_CTRL(i));
-		writel(0, iobase + MVSD_WINDOW_BASE(i));
-	}
-
-	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
-		writel(((cs->size - 1) & 0xffff0000) |
-		       (cs->mbus_attr << 8) |
-		       (dram->mbus_dram_target_id << 4) | 1,
-		       iobase + MVSD_WINDOW_CTRL(i));
-		writel(cs->base, iobase + MVSD_WINDOW_BASE(i));
-	}
-}
-
 static int __init mvsd_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = NULL;
@@ -754,9 +733,8 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	/* (Re-)program MBUS remapping windows if we are asked to. */
-	if (mvsd_data->dram != NULL)
-		mv_conf_mbus_windows(host, mvsd_data->dram);
+	/* (Re-)program MBUS remapping windows. */
+	mvsd_conf_mbus_windows(host->base);
 
 	mvsd_power_down(host);
 
diff --git a/drivers/mmc/host/mvsdio.h b/drivers/mmc/host/mvsdio.h
index 7d9727b..7e07793 100644
--- a/drivers/mmc/host/mvsdio.h
+++ b/drivers/mmc/host/mvsdio.h
@@ -63,10 +63,6 @@
 #define MVSD_AUTO_RSP2				0x098
 #define MVSD_CLK_DIV				0x128
 
-#define MVSD_WINDOW_CTRL(i)			(0x108 + ((i) << 3))
-#define MVSD_WINDOW_BASE(i)			(0x10c + ((i) << 3))
-
-
 /*
  * MVSD_CMD
  */
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 2596999..17263b6 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -58,6 +58,7 @@
 #include <linux/inet_lro.h>
 #include <linux/slab.h>
 #include <asm/system.h>
+#include <plat/addr-map.h>
 
 static char mv643xx_eth_driver_name[] = "mv643xx_eth";
 static char mv643xx_eth_driver_version[] = "1.4";
@@ -75,10 +76,6 @@ static char mv643xx_eth_driver_version[] = "1.4";
 #define ERR_INT_CAUSE			0x0080
 #define  ERR_INT_SMI_DONE		0x00000010
 #define ERR_INT_MASK			0x0084
-#define WINDOW_BASE(w)			(0x0200 + ((w) << 3))
-#define WINDOW_SIZE(w)			(0x0204 + ((w) << 3))
-#define WINDOW_REMAP_HIGH(w)		(0x0280 + ((w) << 2))
-#define WINDOW_BAR_ENABLE		0x0290
 #define WINDOW_PROTECT(w)		(0x0294 + ((w) << 4))
 
 /*
@@ -2510,41 +2507,6 @@ static void mv643xx_eth_netpoll(struct net_device *dev)
 
 
 /* platform glue ************************************************************/
-static void
-mv643xx_eth_conf_mbus_windows(struct mv643xx_eth_shared_private *msp,
-			      struct mbus_dram_target_info *dram)
-{
-	void __iomem *base = msp->base;
-	u32 win_enable;
-	u32 win_protect;
-	int i;
-
-	for (i = 0; i < 6; i++) {
-		writel(0, base + WINDOW_BASE(i));
-		writel(0, base + WINDOW_SIZE(i));
-		if (i < 4)
-			writel(0, base + WINDOW_REMAP_HIGH(i));
-	}
-
-	win_enable = 0x3f;
-	win_protect = 0;
-
-	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
-
-		writel((cs->base & 0xffff0000) |
-			(cs->mbus_attr << 8) |
-			dram->mbus_dram_target_id, base + WINDOW_BASE(i));
-		writel((cs->size - 1) & 0xffff0000, base + WINDOW_SIZE(i));
-
-		win_enable &= ~(1 << i);
-		win_protect |= 3 << (2 * i);
-	}
-
-	writel(win_enable, base + WINDOW_BAR_ENABLE);
-	msp->win_protect = win_protect;
-}
-
 static void infer_hw_params(struct mv643xx_eth_shared_private *msp)
 {
 	/*
@@ -2642,10 +2604,9 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * (Re-)program MBUS remapping windows if we are asked to.
+	 * (Re-)program MBUS remapping windows.
 	 */
-	if (pd != NULL && pd->dram != NULL)
-		mv643xx_eth_conf_mbus_windows(msp, pd->dram);
+	msp->win_protect = mv643xx_eth_conf_mbus_windows(msp->base);
 
 	/*
 	 * Detect hardware parameters.
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 395bdb0..e233865 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -11,8 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/mbus.h>
 #include <plat/ehci-orion.h>
+#include <plat/addr-map.h>
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
 #define wrl(off, val)	__raw_writel((val), hcd->regs + (off))
@@ -21,8 +21,6 @@
 #define USB_MODE		0x1a8
 #define USB_CAUSE		0x310
 #define USB_MASK		0x314
-#define USB_WINDOW_CTRL(i)	(0x320 + ((i) << 4))
-#define USB_WINDOW_BASE(i)	(0x324 + ((i) << 4))
 #define USB_IPG			0x360
 #define USB_PHY_PWR_CTRL	0x400
 #define USB_PHY_TX_CTRL		0x420
@@ -170,27 +168,6 @@ static const struct hc_driver ehci_orion_hc_driver = {
 	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
 
-static void __init
-ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
-				struct mbus_dram_target_info *dram)
-{
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		wrl(USB_WINDOW_CTRL(i), 0);
-		wrl(USB_WINDOW_BASE(i), 0);
-	}
-
-	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
-
-		wrl(USB_WINDOW_CTRL(i), ((cs->size - 1) & 0xffff0000) |
-					(cs->mbus_attr << 8) |
-					(dram->mbus_dram_target_id << 4) | 1);
-		wrl(USB_WINDOW_BASE(i), cs->base);
-	}
-}
-
 static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
@@ -257,10 +234,9 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	ehci->sbrn = 0x20;
 
 	/*
-	 * (Re-)program MBUS remapping windows if we are asked to.
+	 * (Re-)program MBUS remapping windows.
 	 */
-	if (pd != NULL && pd->dram != NULL)
-		ehci_orion_conf_mbus_windows(hcd, pd->dram);
+	ehci_orion_conf_mbus_windows(hcd->regs);
 
 	/*
 	 * setup Orion USB controller.
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index cd33de1..ce4b624 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -17,8 +17,8 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
-#include <linux/mbus.h>
 #include <sound/soc.h>
+#include <plat/addr-map.h>
 #include "kirkwood.h"
 
 #define KIRKWOOD_RATES \
@@ -94,30 +94,6 @@ static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
-					unsigned long dma,
-					struct mbus_dram_target_info *dram)
-{
-	int i;
-
-	/* First disable and clear windows */
-	writel(0, base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
-	writel(0, base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
-
-	/* try to find matching cs for current dma address */
-	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
-		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
-			writel(cs->base & 0xffff0000,
-				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
-			writel(((cs->size - 1) & 0xffff0000) |
-				(cs->mbus_attr << 8) |
-				(dram->mbus_dram_target_id << 4) | 1,
-				base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
-		}
-	}
-}
-
 static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 {
 	int err;
@@ -179,11 +155,11 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		prdata->play_stream = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
-			KIRKWOOD_PLAYBACK_WIN, addr, priv->dram);
+			KIRKWOOD_PLAYBACK_WIN, addr);
 	} else {
 		prdata->rec_stream = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
-			KIRKWOOD_RECORD_WIN, addr, priv->dram);
+			KIRKWOOD_RECORD_WIN, addr);
 	}
 
 	return 0;
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index bb6e6a5..1293689 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -16,10 +16,6 @@
 #define KIRKWOOD_PLAYBACK_WIN			1
 #define KIRKWOOD_MAX_AUDIO_WIN			2
 
-#define KIRKWOOD_AUDIO_WIN_BASE_REG(win)	(0xA00 + ((win)<<3))
-#define KIRKWOOD_AUDIO_WIN_CTRL_REG(win)	(0xA04 + ((win)<<3))
-
-
 #define KIRKWOOD_RECCTL			0x1000
 #define KIRKWOOD_RECCTL_SPDIF_EN		(1<<11)
 #define KIRKWOOD_RECCTL_I2S_EN			(1<<10)
-- 
1.7.7.1

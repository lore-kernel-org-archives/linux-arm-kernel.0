From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Nov 2011 07:59:31 +0100
Subject: [PATCH 3/4] [orion] Get address map from plat-orion instead of via
 platform_data.
In-Reply-To: <1321599572-705-1-git-send-email-andrew@lunn.ch>
References: <1321599572-705-1-git-send-email-andrew@lunn.ch>
Message-ID: <1321599572-705-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use an getter function in plat-orion/addr-map.c to get the address map
structure, rather than pass it to drivers in the platfrom_data
structures. When the drivers are built for none orion platforms, a
dummy function is provided instead which returns NULL.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/pcie.c               |    3 +--
 arch/arm/mach-kirkwood/mpp.c            |    1 -
 arch/arm/mach-kirkwood/pcie.c           |    3 +--
 arch/arm/mach-mv78xx0/mpp.c             |    1 -
 arch/arm/mach-mv78xx0/pcie.c            |    3 +--
 arch/arm/mach-orion5x/mpp.c             |    1 -
 arch/arm/mach-orion5x/pci.c             |    2 +-
 arch/arm/plat-orion/addr-map.c          |    7 +++++++
 arch/arm/plat-orion/include/plat/pcie.h |    3 +--
 arch/arm/plat-orion/pcie.c              |    6 +++---
 drivers/ata/sata_mv.c                   |   19 +++++++++++--------
 drivers/dma/mv_xor.c                    |   11 ++++++-----
 drivers/mmc/host/mvsdio.c               |   13 ++++++++-----
 drivers/net/mv643xx_eth.c               |   10 ++++++----
 drivers/usb/host/ehci-orion.c           |   10 ++++++----
 include/linux/mbus.h                    |   13 ++++++++++++-
 sound/soc/kirkwood/kirkwood-dma.c       |   15 +++++++++------
 17 files changed, 73 insertions(+), 48 deletions(-)

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
index c27ad88..367ca89 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
@@ -16,6 +17,12 @@
 
 struct mbus_dram_target_info orion_mbus_dram_info;
 
+const struct mbus_dram_target_info *mv_mbus_dram_info(void)
+{
+	return &orion_mbus_dram_info;
+}
+EXPORT_SYMBOL_GPL(mv_mbus_dram_info);
+
 /*
  * DDR target is the same on all Orion platforms.
  */
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
index 4b6b209..bc9b2fc 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3988,7 +3988,7 @@ static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
 }
 
 static void mv_conf_mbus_windows(struct mv_host_priv *hpriv,
-				 struct mbus_dram_target_info *dram)
+				 const struct mbus_dram_target_info *dram)
 {
 	int i;
 
@@ -3998,7 +3998,7 @@ static void mv_conf_mbus_windows(struct mv_host_priv *hpriv,
 	}
 
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 
 		writel(((cs->size - 1) & 0xffff0000) |
 			(cs->mbus_attr << 8) |
@@ -4019,6 +4019,7 @@ static void mv_conf_mbus_windows(struct mv_host_priv *hpriv,
 static int mv_platform_probe(struct platform_device *pdev)
 {
 	const struct mv_sata_platform_data *mv_platform_data;
+	const struct mbus_dram_target_info *dram;
 	const struct ata_port_info *ppi[] =
 	    { &mv_port_info[chip_soc], NULL };
 	struct ata_host *host;
@@ -4072,8 +4073,9 @@ static int mv_platform_probe(struct platform_device *pdev)
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
-	if (mv_platform_data->dram != NULL)
-		mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
+	dram = mv_mbus_dram_info();
+	if (dram)
+		mv_conf_mbus_windows(hpriv, dram);
 
 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
 	if (rc)
@@ -4139,17 +4141,18 @@ static int mv_platform_suspend(struct platform_device *pdev, pm_message_t state)
 static int mv_platform_resume(struct platform_device *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	const struct mbus_dram_target_info *dram;
 	int ret;
 
 	if (host) {
 		struct mv_host_priv *hpriv = host->private_data;
-		const struct mv_sata_platform_data *mv_platform_data = \
-			pdev->dev.platform_data;
+
 		/*
 		 * (Re-)program MBUS remapping windows if we are asked to.
 		 */
-		if (mv_platform_data->dram != NULL)
-			mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
+		dram = mv_mbus_dram_info();
+		if (dram)
+			mv_conf_mbus_windows(hpriv, dram);
 
 		/* initialize adapter */
 		ret = mv_init_host(host);
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 9a353c2..e779b43 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1250,7 +1250,7 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 
 static void
 mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
-			 struct mbus_dram_target_info *dram)
+			 const struct mbus_dram_target_info *dram)
 {
 	void __iomem *base = msp->xor_base;
 	u32 win_enable = 0;
@@ -1264,7 +1264,7 @@ mv_xor_conf_mbus_windows(struct mv_xor_shared_private *msp,
 	}
 
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 
 		writel((cs->base & 0xffff0000) |
 		       (cs->mbus_attr << 8) |
@@ -1290,7 +1290,7 @@ static struct platform_driver mv_xor_driver = {
 
 static int mv_xor_shared_probe(struct platform_device *pdev)
 {
-	struct mv_xor_platform_shared_data *msd = pdev->dev.platform_data;
+	const struct mbus_dram_target_info *dram;
 	struct mv_xor_shared_private *msp;
 	struct resource *res;
 
@@ -1323,8 +1323,9 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
-	if (msd != NULL && msd->dram != NULL)
-		mv_xor_conf_mbus_windows(msp, msd->dram);
+	dram = mv_mbus_dram_info();
+	if (dram)
+		mv_xor_conf_mbus_windows(msp, dram);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a5bf60e..1b09325 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -679,8 +679,9 @@ static const struct mmc_host_ops mvsd_ops = {
 	.enable_sdio_irq	= mvsd_enable_sdio_irq,
 };
 
-static void __init mv_conf_mbus_windows(struct mvsd_host *host,
-					struct mbus_dram_target_info *dram)
+static void __init
+mv_conf_mbus_windows(struct mvsd_host *host,
+		     const struct mbus_dram_target_info *dram)
 {
 	void __iomem *iobase = host->base;
 	int i;
@@ -691,7 +692,7 @@ static void __init mv_conf_mbus_windows(struct mvsd_host *host,
 	}
 
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 		writel(((cs->size - 1) & 0xffff0000) |
 		       (cs->mbus_attr << 8) |
 		       (dram->mbus_dram_target_id << 4) | 1,
@@ -705,6 +706,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	struct mmc_host *mmc = NULL;
 	struct mvsd_host *host = NULL;
 	const struct mvsdio_platform_data *mvsd_data;
+	const struct mbus_dram_target_info *dram;
 	struct resource *r;
 	int ret, irq;
 
@@ -755,8 +757,9 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	}
 
 	/* (Re-)program MBUS remapping windows if we are asked to. */
-	if (mvsd_data->dram != NULL)
-		mv_conf_mbus_windows(host, mvsd_data->dram);
+	dram = mv_mbus_dram_info();
+	if (dram)
+		mv_conf_mbus_windows(host, dram);
 
 	mvsd_power_down(host);
 
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 2596999..7ada4c2 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -2512,7 +2512,7 @@ static void mv643xx_eth_netpoll(struct net_device *dev)
 /* platform glue ************************************************************/
 static void
 mv643xx_eth_conf_mbus_windows(struct mv643xx_eth_shared_private *msp,
-			      struct mbus_dram_target_info *dram)
+			      const struct mbus_dram_target_info *dram)
 {
 	void __iomem *base = msp->base;
 	u32 win_enable;
@@ -2530,7 +2530,7 @@ mv643xx_eth_conf_mbus_windows(struct mv643xx_eth_shared_private *msp,
 	win_protect = 0;
 
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 
 		writel((cs->base & 0xffff0000) |
 			(cs->mbus_attr << 8) |
@@ -2580,6 +2580,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	static int mv643xx_eth_version_printed;
 	struct mv643xx_eth_shared_platform_data *pd = pdev->dev.platform_data;
 	struct mv643xx_eth_shared_private *msp;
+	const struct mbus_dram_target_info *dram;
 	struct resource *res;
 	int ret;
 
@@ -2644,8 +2645,9 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
-	if (pd != NULL && pd->dram != NULL)
-		mv643xx_eth_conf_mbus_windows(msp, pd->dram);
+	dram = mv_mbus_dram_info();
+	if (dram)
+		mv643xx_eth_conf_mbus_windows(msp, dram);
 
 	/*
 	 * Detect hardware parameters.
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 395bdb0..d07181b 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -172,7 +172,7 @@ static const struct hc_driver ehci_orion_hc_driver = {
 
 static void __init
 ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
-				struct mbus_dram_target_info *dram)
+			     const struct mbus_dram_target_info *dram)
 {
 	int i;
 
@@ -182,7 +182,7 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 
 		wrl(USB_WINDOW_CTRL(i), ((cs->size - 1) & 0xffff0000) |
 					(cs->mbus_attr << 8) |
@@ -194,6 +194,7 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
+	const struct mbus_dram_target_info *dram;
 	struct resource *res;
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
@@ -259,8 +260,9 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
-	if (pd != NULL && pd->dram != NULL)
-		ehci_orion_conf_mbus_windows(hcd, pd->dram);
+	dram = mv_mbus_dram_info();
+	if (dram)
+		ehci_orion_conf_mbus_windows(hcd, dram);
 
 	/*
 	 * setup Orion USB controller.
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index c11ff29..efa1a6d 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -32,5 +32,16 @@ struct mbus_dram_target_info
 	} cs[4];
 };
 
-
+/*
+ * The Marvell mbus is to be found only on SOCs from the Orion family
+ * at the moment.  Provide a dummy stub for other architectures.
+ */
+#ifdef CONFIG_PLAT_ORION
+extern const struct mbus_dram_target_info *mv_mbus_dram_info(void);
+#else
+static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
+{
+	return NULL;
+}
+#endif
 #endif
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index cd33de1..df12e09 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -94,9 +94,10 @@ static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
-					unsigned long dma,
-					struct mbus_dram_target_info *dram)
+static void
+kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
+			       unsigned long dma,
+			       const struct mbus_dram_target_info *dram)
 {
 	int i;
 
@@ -106,7 +107,7 @@ static void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
 
 	/* try to find matching cs for current dma address */
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
 			writel(cs->base & 0xffff0000,
 				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
@@ -127,6 +128,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
 	struct kirkwood_dma_priv *prdata = snd_soc_platform_get_drvdata(platform);
+	const struct mbus_dram_target_info *dram;
 	unsigned long addr;
 
 	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -175,15 +177,16 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 		writel((unsigned long)-1, priv->io + KIRKWOOD_ERR_MASK);
 	}
 
+	dram = mv_mbus_dram_info();
 	addr = virt_to_phys(substream->dma_buffer.area);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		prdata->play_stream = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
-			KIRKWOOD_PLAYBACK_WIN, addr, priv->dram);
+			KIRKWOOD_PLAYBACK_WIN, addr, dram);
 	} else {
 		prdata->rec_stream = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
-			KIRKWOOD_RECORD_WIN, addr, priv->dram);
+			KIRKWOOD_RECORD_WIN, addr, dram);
 	}
 
 	return 0;
-- 
1.7.2.5

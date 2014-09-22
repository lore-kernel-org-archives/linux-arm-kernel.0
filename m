From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 22 Sep 2014 10:51:09 +0100
Subject: [PATCH 2/3] PCI: rcar-internal-pci: Add call to get domain nr
In-Reply-To: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1411379470-20639-3-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car devices (r8a7790 and r8a7791) need to place the internal PCI and external
PCIe controllers on separate domains so that they can work at the same time.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 3ef854f..17681ea 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -99,6 +99,7 @@ struct rcar_pci_priv {
 	struct resource io_res;
 	struct resource mem_res;
 	struct resource *cfg_res;
+	int domain;
 	unsigned busnr;
 	int irq;
 	unsigned long window_size;
@@ -373,6 +374,8 @@ static int rcar_pci_probe(struct platform_device *pdev)
 
 	priv->window_size = SZ_1G;
 
+	priv->domain = of_pci_get_domain_nr(pdev->dev.of_node, true);
+
 	if (pdev->dev.of_node) {
 		struct resource busnr;
 		int ret;
@@ -397,6 +400,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;
 	hw.setup = rcar_pci_setup;
+#ifdef CONFIG_PCI_DOMAINS
+	hw.domain = priv->domain;
+#endif
 	pci_common_init_dev(&pdev->dev, &hw);
 	return 0;
 }
-- 
2.1.0

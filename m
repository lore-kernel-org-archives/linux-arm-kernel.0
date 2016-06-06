From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:07:06 -0500
Subject: [PATCH v1 19/25] PCI: rcar Gen2: Request host bridge window resources
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230706.20936.13086.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request host bridge window resources so they appear in ioport_resource and
iomem_resource and are reflected in /proc/ioports and /proc/iomem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-rcar-gen2.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 9980a4b..617a6b2 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -194,6 +194,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	struct rcar_pci_priv *priv = sys->private_data;
 	void __iomem *reg = priv->reg;
 	u32 val;
+	int ret;
 
 	pm_runtime_enable(priv->dev);
 	pm_runtime_get_sync(priv->dev);
@@ -275,6 +276,9 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	/* Add PCI resources */
 	pci_add_resource(&sys->resources, &priv->io_res);
 	pci_add_resource(&sys->resources, &priv->mem_res);
+	ret = devm_request_pci_bus_resources(priv->dev, &sys->resources);
+	if (ret < 0)
+		return ret;
 
 	/* Setup bus number based on platform device id / of bus-range */
 	sys->busnr = priv->busnr;

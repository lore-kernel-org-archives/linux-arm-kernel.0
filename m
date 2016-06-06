From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:08 -0500
Subject: [PATCH v1 03/25] PCI: designware: Request host bridge window resources
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230508.20936.81845.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request host bridge window resources so they appear in ioport_resource and
iomem_resource and are reflected in /proc/ioports and /proc/iomem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9ade767..8304aeb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -452,6 +452,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
+	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
+	if (ret)
+		goto error;
+
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &res) {
 		switch (resource_type(win->res)) {

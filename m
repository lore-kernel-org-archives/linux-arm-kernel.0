From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Apr 2017 17:49:02 +0100
Subject: [PATCH v4 13/21] PCI: iproc-platform: update PCI config space remap
 function
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170419164913.19674-14-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
---
 drivers/pci/host/pcie-iproc-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 8c6a327..90d2bdd 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
+	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
+					     resource_size(&reg));
 	if (!pcie->base) {
 		dev_err(dev, "unable to map controller registers\n");
 		return -ENOMEM;
-- 
2.10.0

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:42 +0100
Subject: [PATCH v2 14/22] PCI: iproc-platform: update PCI config space remap
 function
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-15-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
---
 drivers/pci/host/pcie-iproc-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index f4909bb..b13d4a2 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
+	pcie->base = devm_ioremap_nopost(dev, reg.start,
+					 resource_size(&reg));
 	if (!pcie->base) {
 		dev_err(dev, "unable to map controller registers\n");
 		return -ENOMEM;
-- 
2.10.0

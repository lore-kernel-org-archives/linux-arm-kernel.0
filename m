From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 24 Apr 2018 17:13:38 +0200
Subject: [PATCH 2/6] PCI: Fix memory leak of devm_pci_alloc_host_bridge
In-Reply-To: <cover.1524582822.git.jan.kiszka@siemens.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
Message-ID: <2a083b46d55687d01d43d4013cfb957cb3720db5.1524582822.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

devm_pci_release_host_bridge_dev failed to release the resource list.

Fixes: 5c3f18cce083 ("PCI: Add devm_pci_alloc_host_bridge() interface")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..eccf204c9160 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -526,12 +526,14 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
 
 	if (bridge->release_fn)
 		bridge->release_fn(bridge);
+
+	pci_free_resource_list(&bridge->windows);
 }
 
 static void pci_release_host_bridge_dev(struct device *dev)
 {
 	devm_pci_release_host_bridge_dev(dev);
-	pci_free_host_bridge(to_pci_host_bridge(dev));
+	kfree(to_pci_host_bridge(dev));
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
-- 
2.13.6

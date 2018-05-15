From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 15 May 2018 11:07:01 +0200
Subject: [PATCH v4 2/8] PCI: Fix memory leak of devm_pci_alloc_host_bridge()
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
Message-ID: <b8a0bde43293c275094df6d3611cd401353d7f12.1526375226.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

devm_pci_release_host_bridge_dev() failed to release the resource list.

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

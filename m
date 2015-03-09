From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 9 Mar 2015 10:34:16 +0800
Subject: [PATCH v6 19/30] sparc/PCI: Claim bus resources before
 pci_bus_add_devices()
In-Reply-To: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425868467-9667-20-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pci_claim_bus_resources() should be called before
pci_bus_add_devices(), or driver may failed to
load, because the resources had not claimed.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/sparc/kernel/pci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 838fe1e..21f804a 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -678,11 +678,10 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	}
 
 	pci_of_scan_bus(pbm, node, bus);
-	pci_bus_add_devices(bus);
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
-
+	pci_bus_add_devices(bus);
 	return bus;
 }
 
-- 
1.7.1

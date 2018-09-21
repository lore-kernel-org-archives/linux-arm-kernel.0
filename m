From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:44 +0530
Subject: [RFC PATCH 29/40] PCI: keystone: Prevent ARM32 specific code to be
 compiled for ARM64
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-30-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hook_fault_code is an ARM32 specific API for hooking into data abort.
Since pci-keystone.c will be used for AM65X platforms which is an
ARM64 platform, allow hook_fault_code to be compiled only for ARM32.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e8328039a017..91337e9c87a5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -493,6 +493,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
+#ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -512,6 +513,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 
 	return 0;
 }
+#endif
 
 static void ks_pcie_setup_mem_space(struct keystone_pcie *ks_pcie)
 {
@@ -592,12 +594,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	if (ret < 0)
 		return ret;
 
+#ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
 	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+#endif
 
 	ks_pcie_start_link(pci);
 	return dw_pcie_wait_for_link(pci);
-- 
2.17.1

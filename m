From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon,  8 Sep 2014 14:54:31 +0100
Subject: [PATCH v10 09/10] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
In-Reply-To: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1410184472-17630-10-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the firmware has not assigned all the bus resources and
we are not just probing the PCIe busses, it makes sense to
assign the unassigned resources in pci_scan_root_bus().

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef891d2..508cf61 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1953,6 +1953,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	if (!found)
 		pci_bus_update_busn_res_end(b, max);
 
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_assign_unassigned_bus_resources(b);
+
 	pci_bus_add_devices(b);
 	return b;
 }
-- 
2.0.4

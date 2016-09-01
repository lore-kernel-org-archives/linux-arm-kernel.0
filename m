From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 1 Sep 2016 15:44:46 +0530
Subject: [PATCH 6/6] Microblaze: Modify microblaze pci specific code to
 support multidomain.
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1472724886-28301-6-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proc entries will be created for every pci bus.
With current implementation,in multidomain same bus number
will repaeat but in different domain, which causes kernel crash
as already same bus number exists.

Return domain number when kernel requests while creating proc
entries for each bus.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 arch/microblaze/pci/pci-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 81556b8..7f696f9 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -632,10 +632,10 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	}
 }
 
-/* Decide whether to display the domain number in /proc */
+/* Display the domain number in /proc */
 int pci_proc_domain(struct pci_bus *bus)
 {
-	return 0;
+	return pci_domain_nr(bus);
 }
 
 /* This header fixup will do the resource fixup for all devices as they are
-- 
2.1.1

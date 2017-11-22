From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:30:46 -0500
Subject: [PATCH 01/30] alpha/PCI: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/alpha/kernel/pci.c          | 2 +-
 arch/alpha/kernel/sys_nautilus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 08235bb..e866daf 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -416,7 +416,7 @@ struct resource * __init
 		if (bus == 0 && dfn == 0) {
 			hose = pci_isa_hose;
 		} else {
-			dev = pci_get_bus_and_slot(bus, dfn);
+			dev = pci_get_domain_bus_and_slot(0, bus, dfn);
 			if (!dev)
 				return -ENODEV;
 			hose = dev->sysdata;
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 239dc0e..5eacaf9 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -237,7 +237,7 @@
 	bus = hose->bus = bridge->bus;
 	pcibios_claim_one_bus(bus);
 
-	irongate = pci_get_bus_and_slot(0, 0);
+	irongate = pci_get_domain_bus_and_slot(0, 0, 0);
 	bus->self = irongate;
 	bus->resource[0] = &irongate_io;
 	bus->resource[1] = &irongate_mem;
-- 
1.9.1

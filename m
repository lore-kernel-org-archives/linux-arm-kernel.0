From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Apr 2017 17:33:12 +0100
Subject: [PATCH 1/2] drivers: pci: do not disregard parent resources starting
 at 0x0
In-Reply-To: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
Message-ID: <20170411163313.18577-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f44116ae8818 ("PCI: Remove pci_find_parent_resource() use for
allocation") updated the logic that iterates over all bus resources
and compares them to a given resource, in order to decide whether one
is the parent of the latter.

This change inadvertently causes pci_find_parent_resource() to disregard
resources starting at address 0x0, resulting in an error such as the one
below on ARM systems whose I/O window starts at 0x0.

pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
pci_bus 0000:00: root bus resource [bus 00-0f]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:03.0: PCI bridge to [bus 03]
pci 0000:00:03.0: can't claim BAR 13 [io  0x0000-0x0fff]: no compatible bridge window
pci 0000:03:01.0: can't claim BAR 0 [io  0x0000-0x001f]: no compatible bridge window

While this never happens on x86, it is perfectly legal in general for a
PCI MMIO or IO window to start at address 0x0, and it was supported in
the code before commit f44116ae8818.

So let's drop the test for res->start != 0; resource_contains() already
checks whether [start, end) completely covers the resource, and so it
should be redundant.

Fixes: f44116ae8818 ("PCI: Remove pci_find_parent_resource() use for allocation")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02ffdb9..53a41b1f7ef7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -454,7 +454,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 	pci_bus_for_each_resource(bus, r, i) {
 		if (!r)
 			continue;
-		if (res->start && resource_contains(r, res)) {
+		if (resource_contains(r, res)) {
 
 			/*
 			 * If the window is prefetchable but the BAR is
-- 
2.9.3

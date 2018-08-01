From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  1 Aug 2018 18:31:34 +0100
Subject: [PATCH] arm64: PCI: Remove node-local allocations when initialising
 host controller
Message-ID: <20180801173132.19739-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory for host controller data structures is allocated local to the
node to which the controller is associated with. This has been the
behaviour since support for ACPI was added in
commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").

Drop the node local allocation as there is no benefit from doing so -
the usage of these structures is independent from where the controller
is located. It also causes problem during probe if the associated numa
node hasn't been initialised due to booting with restricted cpus via
kernel command line or where the node doesn't have cpus or memory
associated with it.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Hi,

This came up in the context of investigating the boot issues reported
due to restricted cpus or buggy firmware. Part of the problem is fixed
by Lorenzo's rework of NUMA initialisation[0].

But there also doesn't seem to be any justification for using
node-local allocation to begin with.

Thanks,
Punit

[0] https://patchwork.kernel.org/patch/10486001/

 arch/arm64/kernel/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c78542..bb85e2f4603f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -165,16 +165,15 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
 /* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	int node = acpi_get_node(root->device->handle);
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
 
-	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return NULL;
 
-	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
 	if (!root_ops) {
 		kfree(ri);
 		return NULL;
-- 
2.18.0

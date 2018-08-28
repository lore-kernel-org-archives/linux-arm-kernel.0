From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 28 Aug 2018 16:05:13 +0100
Subject: [PATCH 2/2] x86/PCI: Remove node-local allocation when initialising
 host controller
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
Message-ID: <20180828150513.32458-3-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory for host controller data structures is allocated local to the
node to which the controller is associated with. This has been the
behaviour since 965cd0e4a5e5 ("x86, PCI, ACPI: Use kmalloc_node() to
optimize for performance") where the node local allocation was added
without additional context.

Drop the node local allocation as there is no benefit from doing so -
the usage of these structures is independent from where the controller
is located.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
---
 arch/x86/pci/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5559dcaddd5e..948656069cdd 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -356,7 +356,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	} else {
 		struct pci_root_info *info;
 
-		info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			dev_err(&root->device->dev,
 				"pci_bus %04x:%02x: ignored (out of memory)\n",
-- 
2.18.0

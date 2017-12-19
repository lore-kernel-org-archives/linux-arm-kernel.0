From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Dec 2017 00:37:39 -0500
Subject: [PATCH V4 03/26] x86/PCI: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513661883-28662-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Use domain number of 0 as the domain number is not available in struct
irq_routing_table.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/pci/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 04526291..52e5510 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -839,7 +839,8 @@ static void __init pirq_find_router(struct irq_router *r)
 	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for [%04x:%04x]\n",
 	    rt->rtr_vendor, rt->rtr_device);
 
-	pirq_router_dev = pci_get_bus_and_slot(rt->rtr_bus, rt->rtr_devfn);
+	pirq_router_dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
+						      rt->rtr_devfn);
 	if (!pirq_router_dev) {
 		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
 			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-- 
1.9.1

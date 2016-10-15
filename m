From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 15 Oct 2016 00:31:05 -0400
Subject: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
In-Reply-To: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed PCI_USING penalty from
acpi_pci_link_allocate function as there is no longer a fixed size penalty
array for both PCI interrupts greater than 16.

The array size has been reduced to 16 and array name got prefixed as ISA
since it only is accountable for the ISA interrupts.

The original change in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed penalty assignment in the code for PCI
thinking that we will add the penalty later in acpi_irq_pci_sharing_penalty
function.

However, this function only gets called if the IRQ number is greater than
16 and acpi_irq_get_penalty function gets called before ACPI start in
acpi_isa_irq_available and acpi_penalize_isa_irq functions. We can't rely
on iterating the link list.

We need to add the PCI_USING penalty for ISA interrupts too if the link is
in use and matches our ISA IRQ number.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..a212709 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -619,6 +619,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
+		if (link->irq.active < ACPI_MAX_ISA_IRQS)
+			acpi_isa_irq_penalty[link->irq.active] +=
+				PIRQ_PENALTY_PCI_USING;
+
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
-- 
1.9.1

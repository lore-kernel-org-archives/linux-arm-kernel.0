From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 24 Oct 2016 00:31:30 -0400
Subject: [PATCH V5 1/3] ACPI, PCI,
 IRQ: assign ISA IRQ directly during early boot stages
In-Reply-To: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1477283492-26657-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not want to store the SCI penalty in the acpi_isa_irq_penalty[]
table because acpi_isa_irq_penalty[] only holds ISA IRQ penalties and
there's no guarantee that the SCI is an ISA IRQ.  We add in the SCI
penalty as a special case in acpi_irq_get_penalty().

But if we called acpi_penalize_isa_irq() or acpi_irq_penalty_update()
for an SCI that happened to be an ISA IRQ, they stored the SCI
penalty (part of the acpi_irq_get_penalty() return value) in
acpi_isa_irq_penalty[].  Subsequent calls to acpi_irq_get_penalty()
returned a penalty that included *two* SCI penalties.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..6229b02 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -849,7 +849,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 			continue;
 
 		if (used)
-			new_penalty = acpi_irq_get_penalty(irq) +
+			new_penalty = acpi_isa_irq_penalty[irq] +
 					PIRQ_PENALTY_ISA_USED;
 		else
 			new_penalty = 0;
@@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 void acpi_penalize_isa_irq(int irq, int active)
 {
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
-		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+		acpi_isa_irq_penalty[irq] +=
 		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
-- 
1.9.1

From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 15 Nov 2015 15:00:52 -0500
Subject: [PATCH V3] acpi: add support for extended IRQ to PCI link
Message-ID: <1447617653-29743-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACPI compiler uses the extended format when used
interrupt numbers are greater than 256. The PCI link code
currently only supports simple interrupt format. The IRQ
numbers are represented using 32 bits when extended IRQ
syntax. This patch changes the interrupt number type to
32 bits and places an upper limit of 1020 as possible
interrupt id.

1020 is the maximum interrupt ID that can be assigned to
an ARM SPI interrupt according to ARM architecture.

Additional checks have been placed to prevent out of bounds
writes.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 7c8408b..7777c13 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -1,6 +1,7 @@
 /*
  *  pci_link.c - ACPI PCI Interrupt Link Device Driver ($Revision: 34 $)
  *
+ *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
@@ -67,12 +68,12 @@ static struct acpi_scan_handler pci_link_handler = {
  * later even the link is disable. Instead, we just repick the active irq
  */
 struct acpi_pci_link_irq {
-	u8 active;		/* Current IRQ */
+	u32 active;		/* Current IRQ */
 	u8 triggering;		/* All IRQs */
 	u8 polarity;		/* All IRQs */
 	u8 resource_type;
 	u8 possible_count;
-	u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
+	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 	u8 initialized:1;
 	u8 reserved:7;
 };
@@ -437,7 +438,11 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  * enabled system.
  */
 
-#define ACPI_MAX_IRQS		256
+/*
+ * 1020 is the maximum interrupt ID that can be assigned to
+ * an ARM SPI interrupt according to ARM architecture.
+ */
+#define ACPI_MAX_IRQS		1020
 #define ACPI_MAX_ISA_IRQ	16
 
 #define PIRQ_PENALTY_PCI_AVAILABLE	(0)
@@ -493,7 +498,8 @@ int __init acpi_irq_penalty_init(void)
 					    penalty;
 			}
 
-		} else if (link->irq.active) {
+		} else if (link->irq.active &&
+			(link->irq.active < ACPI_MAX_IRQS)) {
 			acpi_irq_penalty[link->irq.active] +=
 			    PIRQ_PENALTY_PCI_POSSIBLE;
 		}
@@ -541,14 +547,16 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	else
 		irq = link->irq.possible[link->irq.possible_count - 1];
 
-	if (acpi_irq_balance || !link->irq.active) {
+	if ((acpi_irq_balance || !link->irq.active) && (irq < ACPI_MAX_IRQS)) {
 		/*
 		 * Select the best IRQ.  This is done in reverse to promote
 		 * the use of IRQs 9, 10, 11, and >15.
 		 */
-		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
-			if (acpi_irq_penalty[irq] >
-			    acpi_irq_penalty[link->irq.possible[i]])
+		i = link->irq.possible_count;
+		while (--i) {
+			if ((link->irq.possible[i] < ACPI_MAX_IRQS) &&
+			    (acpi_irq_penalty[irq] >
+			    acpi_irq_penalty[link->irq.possible[i]]))
 				irq = link->irq.possible[i];
 		}
 	}
@@ -568,7 +576,9 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
-		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
+		if (link->irq.active < ACPI_MAX_IRQS)
+			acpi_irq_penalty[link->irq.active] +=
+				PIRQ_PENALTY_PCI_USING;
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 14 May 2017 20:27:23 +0200
Subject: [patch 07/18] ACPI: Adjust system_state check
References: <20170514182716.347236777@linutronix.de>
Message-ID: <20170514183613.002084749@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Make the decision wether a pci root is hotplugged depend on SYSTEM_RUNNING
instead of !SYSTEM_BOOTING.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/acpi/pci_root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -523,7 +523,7 @@ static int acpi_pci_root_add(struct acpi
 	struct acpi_pci_root *root;
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
-	bool hotadd = system_state != SYSTEM_BOOTING;
+	bool hotadd = system_state == SYSTEM_RUNNING;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)

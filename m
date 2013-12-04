From: al.stone@linaro.org (al.stone at linaro.org)
Date: Wed,  4 Dec 2013 14:22:05 -0700
Subject: [PATCH v3 3/5] ACPI: HW reduced mode does not allow use of the FADT
 sci_interrupt field
In-Reply-To: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Message-ID: <1386192127-28564-4-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

In HW reduced mode, the use of the SCI interrupt is not allowed.  In
all those places that use the FADT sci_interrupt field, remove that
usage when in HW reduced mode.

In the case of acpi_os_install_interrupt_handler() in osl.c, this allows
us to open up the routine to installing interrupt handlers other than
acpi_gbl_FADT.sci_interrupt regardless of whether we are in ACPI legacy
mode or reduced HW mode; acpi_os_remove_interrupt_handler() changes to
maintain symmetry.

The function acpi_reserve_resources() is not stubbed but removed to
quiet a compiler warning about an unused function when using ACPI
reduced hardware mode.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/bus.c      |  3 ++-
 drivers/acpi/osl.c      | 16 +++++-----------
 drivers/acpi/pci_link.c |  2 ++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bba9b72..de3a259 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -541,7 +541,8 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-#ifdef CONFIG_X86
+#ifndef CONFIG_ACPI_REDUCED_HARDWARE
+	/* NOTE: in HW reduced mode, FADT sci_interrupt has no meaning */
 	if (!acpi_ioapic) {
 		/* compatible (0) means level (3) */
 		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 44c07eb..613e4a1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -84,6 +84,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
 
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
+static u32 acpi_irq_number;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
@@ -159,6 +160,7 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 	return supported;
 }
 
+#ifndef CONFIG_ACPI_REDUCED_HARDWARE
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
 {
@@ -209,6 +211,7 @@ static int __init acpi_reserve_resources(void)
 	return 0;
 }
 device_initcall(acpi_reserve_resources);
+#endif
 
 void acpi_os_printf(const char *fmt, ...)
 {
@@ -795,13 +798,6 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 
 	acpi_irq_stats_init();
 
-	/*
-	 * ACPI interrupts different from the SCI in our copy of the FADT are
-	 * not supported.
-	 */
-	if (gsi != acpi_gbl_FADT.sci_interrupt)
-		return AE_BAD_PARAMETER;
-
 	if (acpi_irq_handler)
 		return AE_ALREADY_ACQUIRED;
 
@@ -818,15 +814,13 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_irq_number = irq;
 
 	return AE_OK;
 }
 
 acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 {
-	if (irq != acpi_gbl_FADT.sci_interrupt)
-		return AE_BAD_PARAMETER;
-
 	free_irq(irq, acpi_irq);
 	acpi_irq_handler = NULL;
 
@@ -1806,7 +1800,7 @@ acpi_status __init acpi_os_initialize1(void)
 acpi_status acpi_os_terminate(void)
 {
 	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
+		acpi_os_remove_interrupt_handler(acpi_irq_number,
 						 acpi_irq_handler);
 	}
 
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 2652a61..d5c155e 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -505,6 +505,8 @@ int __init acpi_irq_penalty_init(void)
 		}
 	}
 	/* Add a penalty for the SCI */
+	if (acpi_gbl_reduced_hardware)
+		return 0;
 	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
 	return 0;
 }
-- 
1.8.3.1

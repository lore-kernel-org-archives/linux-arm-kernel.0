From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Feb 2018 14:11:18 +0000
Subject: [RFC PATCH] irqchip/gic-v3-its: apply ACPI device based quirks
Message-ID: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reapply the SynQuacer quirk for ITS frames that are matched by 'SCX0005'
based ACPI devices, replacing the dummy fwnode with the one populated by
the ACPI device core.

This allows the SynQuacer ACPI tables to publish a device node such
as

    Device (ITS0) {
      Name (_HID, "SCX0005")
      Name (_ADR, 0x30020000)
      Name (_DSD, Package ()  // _DSD: Device-Specific Data
      {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
          Package (2) {
            "socionext,synquacer-pre-its",
            Package () { 0x58000000, 0x200000 }
          },
        }
      })
    }

which will trigger the existing quirk that replaces the doorbell
address with the appropriate address in the pre-ITS frame.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Marc, Lorenzo,

I am aware that this patch may be seen as controversial, but I would like to
propose it nonetheless. The reason is that this is the only thing standing in
the way of full ACPI support in Socionext SynQuacer based platforms.

The pre-ITS is a monstrosity, but as it turns out, Socionext had help from
ARM designing it, and the reason we need DT/ACPI based quirks in the first
place is that the IIDR of this GICv3 implementation is simply the ARM Ltd.
one (as they designed the IP)

Please take this into consideration when reviewing this patch,

Thanks,
Ard.

 drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..a63973baf08a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3517,3 +3517,42 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 
 	return 0;
 }
+
+#if defined(CONFIG_SOCIONEXT_SYNQUACER_PREITS) && defined(CONFIG_ACPI)
+static acpi_status __init acpi_its_device_probe (acpi_handle handle,
+						 u32 depth, void *context,
+						 void **ret)
+{
+	struct acpi_device *adev;
+	unsigned long long phys_base;
+	struct its_node *its;
+	acpi_status status;
+	int err;
+
+	err = acpi_bus_get_device(handle, &adev);
+	if (err)
+		return AE_CTRL_TERMINATE;
+
+	status = acpi_evaluate_integer(handle, "_ADR", NULL, &phys_base);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	list_for_each_entry(its, &its_nodes, entry)
+		if (its->phys_base == phys_base) {
+			irq_domain_free_fwnode(its->fwnode_handle);
+			its->fwnode_handle = &adev->fwnode;
+			its_enable_quirk_socionext_synquacer(its);
+			break;
+		}
+
+	return AE_CTRL_TERMINATE;
+}
+
+static int __init acpi_its_device_probe_init(void)
+{
+	if (!acpi_disabled)
+		acpi_get_devices("SCX0005", acpi_its_device_probe, NULL, NULL);
+	return 0;
+}
+subsys_initcall_sync(acpi_its_device_probe_init);
+#endif
-- 
2.11.0

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  7 Nov 2017 11:47:38 +0100
Subject: [PULL 05/26] KVM: arm/arm64: Check that system supports split
 eoi/deactivate
In-Reply-To: <20171107104800.30021-1-christoffer.dall@linaro.org>
References: <20171107104800.30021-1-christoffer.dall@linaro.org>
Message-ID: <20171107104800.30021-6-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@linaro.org>

Some systems without proper firmware and/or hardware description data
don't support the split EOI and deactivate operation.

On such systems, we cannot leave the physical interrupt active after the
timer handler on the host has run, so we cannot support KVM with an
in-kernel GIC with the timer changes we are about to introduce.

This patch makes sure that trying to initialize the KVM GIC code will
fail on such systems.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 8 ++++++--
 drivers/irqchip/irq-gic.c    | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b5df99c6f680..854334a6f225 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1228,7 +1228,9 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		goto out_unmap_rdist;
 
 	gic_populate_ppi_partitions(node);
-	gic_of_setup_kvm_info(node);
+
+	if (static_key_true(&supports_deactivate))
+		gic_of_setup_kvm_info(node);
 	return 0;
 
 out_unmap_rdist:
@@ -1517,7 +1519,9 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 		goto out_fwhandle_free;
 
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
-	gic_acpi_setup_kvm_info();
+
+	if (static_key_true(&supports_deactivate))
+		gic_acpi_setup_kvm_info();
 
 	return 0;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 651d726e8b12..cd9371b749c2 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1367,7 +1367,8 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	if (ret)
 		return;
 
-	gic_set_kvm_info(&gic_v2_kvm_info);
+	if (static_key_true(&supports_deactivate))
+		gic_set_kvm_info(&gic_v2_kvm_info);
 }
 
 int __init
@@ -1599,7 +1600,8 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 		gicv2m_init(NULL, gic_data[0].domain);
 
-	gic_acpi_setup_kvm_info();
+	if (static_key_true(&supports_deactivate))
+		gic_acpi_setup_kvm_info();
 
 	return 0;
 }
-- 
2.14.2

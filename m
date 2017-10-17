From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Oct 2017 17:55:56 +0100
Subject: [PATCH v5 3/3] drivers/irqchip: gicv3: add workaround for Synquacer
 pre-ITS
In-Reply-To: <20171017165556.30250-1-ard.biesheuvel@linaro.org>
References: <20171017165556.30250-1-ard.biesheuvel@linaro.org>
Message-ID: <20171017165556.30250-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Socionext Synquacer SoC's implementation of GICv3 has a so-called
'pre-ITS', which maps 32-bit writes targeted at a separate window of
size '4 << device_id_bits' onto writes to GITS_TRANSLATER with device
ID taken from bits [device_id_bits + 1:2] of the window offset.
Writes that target GITS_TRANSLATER directly are reported as originating
from device ID #0.

So add a workaround for this. Given that this breaks isolation, clear
the IRQ_DOMAIN_FLAG_MSI_REMAP flag as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt |  4 ++
 arch/arm64/Kconfig                                                    |  8 +++
 drivers/irqchip/irq-gic-v3-its.c                                      | 72 +++++++++++++++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 4c29cdab0ea5..c3e6092f3add 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -75,6 +75,10 @@ These nodes must have the following properties:
 - reg: Specifies the base physical address and size of the ITS
   registers.
 
+Optional:
+- socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
+  address and size of the pre-ITS window.
+
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
 nodes.
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..c4361dff2b74 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -539,6 +539,14 @@ config QCOM_QDF2400_ERRATUM_0065
 
 	  If unsure, say Y.
 
+config SOCIONEXT_SYNQUACER_PREITS
+	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
+	default y
+	help
+	  Socionext Synquacer SoCs implement a separate h/w block to generate
+	  MSI doorbell writes with non-zero values for the device ID.
+
+	  If unsure, say Y.
 endmenu
 
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c34f21c7a38e..1172b8583db4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -83,6 +83,8 @@ struct its_baser {
 	u32		psz;
 };
 
+struct its_device;
+
 /*
  * The ITS structure - contains most of the infrastructure, with the
  * top-level MSI domain, the command queue, the collections, and the
@@ -97,11 +99,15 @@ struct its_node {
 	struct its_cmd_block	*cmd_write;
 	struct its_baser	tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
+	struct fwnode_handle	*fwnode_handle;
+	u64			(*get_msi_base)(struct its_device *its_dev);
 	struct list_head	its_device_list;
 	u64			flags;
 	u32			ite_size;
 	u32			device_ids;
 	int			numa_node;
+	unsigned int		msi_domain_flags;
+	u32			pre_its_base; /* for Socionext Synquacer */
 	bool			is_v4;
 };
 
@@ -1095,6 +1101,13 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
+static u64 its_irq_get_msi_base(struct its_device *its_dev)
+{
+	struct its_node *its = its_dev->its;
+
+	return its->phys_base + GITS_TRANSLATER;
+}
+
 static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -1102,7 +1115,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	u64 addr;
 
 	its = its_dev->its;
-	addr = its->phys_base + GITS_TRANSLATER;
+	addr = its->get_msi_base(its_dev);
 
 	msg->address_lo		= lower_32_bits(addr);
 	msg->address_hi		= upper_32_bits(addr);
@@ -2758,6 +2771,45 @@ static bool __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
 	return true;
 }
 
+static u64 its_irq_get_msi_base_pre_its(struct its_device *its_dev)
+{
+	struct its_node *its = its_dev->its;
+
+	/*
+	 * The Socionext Synquacer SoC has a so-called 'pre-ITS',
+	 * which maps 32-bit writes targeted at a separate window of
+	 * size '4 << device_id_bits' onto writes to GITS_TRANSLATER
+	 * with device ID taken from bits [device_id_bits + 1:2] of
+	 * the window offset.
+	 */
+	return its->pre_its_base + (its_dev->device_id << 2);
+}
+
+static bool __maybe_unused its_enable_quirk_socionext_synquacer(void *data)
+{
+	struct its_node *its = data;
+	u32 pre_its_window[2];
+	u32 ids;
+
+	if (!fwnode_property_read_u32_array(its->fwnode_handle,
+					   "socionext,synquacer-pre-its",
+					   pre_its_window,
+					   ARRAY_SIZE(pre_its_window))) {
+
+		its->pre_its_base = pre_its_window[0];
+		its->get_msi_base = its_irq_get_msi_base_pre_its;
+
+		ids = ilog2(pre_its_window[1]) - 2;
+		if (its->device_ids > ids)
+			its->device_ids = ids;
+
+		/* the pre-ITS breaks isolation, so disable MSI remapping */
+		its->msi_domain_flags &= ~IRQ_DOMAIN_FLAG_MSI_REMAP;
+		return true;
+	}
+	return false;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -2783,6 +2835,19 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_qdf2400_e0065,
 	},
 #endif
+#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
+	{
+		/*
+		 * The Socionext Synquacer SoC incorporates ARM's own GIC-500
+		 * implementation, but with a 'pre-ITS' added that requires
+		 * special handling in software.
+		 */
+		.desc	= "ITS: Socionext Synquacer pre-ITS",
+		.iidr	= 0x0001143b,
+		.mask	= 0xffffffff,
+		.init	= its_enable_quirk_socionext_synquacer,
+	},
+#endif
 	{
 	}
 };
@@ -2811,7 +2876,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 
 	inner_domain->parent = its_parent;
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_REMAP;
+	inner_domain->flags |= its->msi_domain_flags;
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
 	inner_domain->host_data = info;
@@ -2965,6 +3030,9 @@ static int __init its_probe_one(struct resource *res,
 		goto out_free_its;
 	}
 	its->cmd_write = its->cmd_base;
+	its->fwnode_handle = handle;
+	its->get_msi_base = its_irq_get_msi_base;
+	its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
 
 	its_enable_quirks(its);
 
-- 
2.11.0

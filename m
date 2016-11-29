From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 29 Nov 2016 17:57:38 -0500
Subject: [PATCH V8 2/3] ACPI: Retry IRQ conversion if it failed previously
In-Reply-To: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
References: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1480460259-8585-3-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows probe deferral to work properly when a dependent device
fails to get a valid IRQ because the IRQ domain was not registered
at the time the resources were added to the platform_device.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/irq.c      | 144 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/platform.c |   9 ++-
 include/linux/acpi.h    |   9 +++
 3 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index e82eb6e..9279168 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -158,6 +158,150 @@ void acpi_unregister_gsi(u32 gsi)
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
 /**
+ * Context for the resource walk used to lookup IRQ resources.
+ */
+struct acpi_irq_parse_one_ctx {
+	int rc;
+	unsigned int index;
+	unsigned long *res_flags;
+	struct irq_fwspec *fwspec;
+};
+
+/**
+ * acpi_irq_parse_one_match - Handle a matching IRQ resource
+ */
+static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
+					    u32 hwirq, u8 triggering,
+					    u8 polarity, u8 shareable,
+					    struct acpi_irq_parse_one_ctx *ctx)
+{
+	ctx->rc = 0;
+	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable);
+	ctx->fwspec->fwnode = fwnode;
+	ctx->fwspec->param[0] = hwirq;
+	ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
+	ctx->fwspec->param_count = 2;
+}
+
+/**
+ * acpi_irq_parse_one_cb - Handle the given resource
+ * @ares: resource to handle
+ * @context: context for the walk, contains the lookup index and references
+ *           to the flags and fwspec where the result is returned
+ *
+ * This is called by acpi_walk_resources passing each resource returned by
+ * the _CRS method. We only inspect IRQ resources. Since IRQ resources
+ * might contain multiple interrupts we check if the index is within this
+ * one's interrupt array, otherwise we subtract the current resource IRQ
+ * count from the lookup index to prepare for the next resource.
+ * Once a match is found we call acpi_irq_parse_one_match to populate
+ * the result and end the walk by returning AE_CTRL_TERMINATE.
+ *
+ * Return AE_OK if the walk should continue, AE_CTRL_TERMINATE if a matching
+ * IRQ resource was found.
+ */
+static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
+					 void *context)
+{
+	struct acpi_irq_parse_one_ctx *ctx = context;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_extended_irq *eirq;
+	struct fwnode_handle *fwnode;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		irq = &ares->data.irq;
+		if (ctx->index >= irq->interrupt_count) {
+			ctx->index -= irq->interrupt_count;
+			return AE_OK;
+		}
+		fwnode = acpi_gsi_domain_id;
+		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
+					 irq->triggering, irq->polarity,
+					 irq->sharable, ctx);
+		return AE_CTRL_TERMINATE;
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		eirq = &ares->data.extended_irq;
+		if (ctx->index >= eirq->interrupt_count) {
+			ctx->index -= eirq->interrupt_count;
+			return AE_OK;
+		}
+		fwnode = acpi_get_irq_source_fwhandle(&eirq->resource_source);
+		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
+					 eirq->triggering, eirq->polarity,
+					 eirq->sharable, ctx);
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+/**
+ * acpi_irq_parse_one - Resolve an interrupt for a device
+ * @handle: the device whose interrupt is to be resolved
+ * @index: index of the interrupt to resolve
+ * @fwspec: structure irq_fwspec filled by this function
+ * @flags: resource flags filled by this function
+ *
+ * This function resolves an interrupt for a device by walking its CRS resources
+ * to find the appropriate ACPI IRQ resource and populating the given structure
+ * which can be used to retrieve a Linux IRQ number.
+ *
+ * Returns the result stored in ctx.rc by the callback, or -EINVAL if the given
+ * index is out of range.
+ */
+static int acpi_irq_parse_one(acpi_handle handle, unsigned int index,
+			      struct irq_fwspec *fwspec, unsigned long *flags)
+{
+	struct acpi_irq_parse_one_ctx ctx = { -EINVAL, index, flags, fwspec };
+	acpi_status status;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_irq_parse_one_cb, &ctx);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+	return ctx.rc;
+}
+
+/**
+ * acpi_irq_get - Look for the ACPI IRQ resource with the given index and
+ *                use it to initialize the given Linux IRQ resource.
+ * @handle ACPI device handle
+ * @index  ACPI IRQ resource index to lookup
+ * @res    Linux IRQ resource to initialize
+ *
+ * Return: 0 on success
+ *         -EINVAL if an error occurs
+ *         -EPROBE_DEFER if the IRQ lookup/conversion failed
+ */
+int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
+{
+	int rc;
+	struct irq_fwspec fwspec;
+	struct irq_domain *domain;
+	unsigned long flags;
+
+	rc = acpi_irq_parse_one(handle, index, &fwspec, &flags);
+	if (rc)
+		return rc;
+
+	domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
+	if (!domain)
+		return -EPROBE_DEFER;
+
+	rc = irq_create_fwspec_mapping(&fwspec);
+	if (rc <= 0)
+		return -EINVAL;
+
+	res->start = rc;
+	res->end = rc;
+	res->flags = flags;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_irq_get);
+
+/**
  * acpi_set_irq_model - Setup the GSI irqdomain information
  * @model: the value assigned to acpi_irq_model
  * @fwnode: the irq_domain identifier for mapping and looking up
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c4af003..61423d2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -102,6 +102,14 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	}
 
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
+	if (r && r->flags & IORESOURCE_DISABLED && ACPI_COMPANION(&dev->dev)) {
+		int ret;
+
+		ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * The resources may pass trigger flags to the irqs that need
 	 * to be set up. It so happens that the trigger flags for
@@ -1450,4 +1458,3 @@ void __init early_platform_cleanup(void)
 		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
 	}
 }
-
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 154e576..6919bfd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -327,6 +327,7 @@ struct fwnode_handle *
 int acpi_register_irq(struct fwnode_handle *source, u32 hwirq, int trigger,
 		      int polarity);
 void acpi_unregister_irq(struct fwnode_handle *source, u32 hwirq);
+int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
 #else
 #define acpi_get_irq_source_fwhandle(source) (NULL)
 static inline int acpi_register_irq(struct fwnode_handle *source, u32 hwirq,
@@ -785,6 +786,14 @@ static inline int acpi_reconfig_notifier_unregister(struct notifier_block *nb)
 
 #endif	/* !CONFIG_ACPI */
 
+#ifndef CONFIG_ACPI_GENERIC_GSI
+static inline int acpi_irq_get(acpi_handle handle, unsigned int index,
+			       struct resource *res)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_ACPI_GENERIC_GSI */
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_ioapic_add(acpi_handle root);
 #else
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

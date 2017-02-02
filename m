From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu,  2 Feb 2017 18:23:58 -0500
Subject: [PATCH V12 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
References: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1486077839-25547-3-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI extended IRQ resources may contain a ResourceSource to specify
an alternate interrupt controller. Introduce acpi_irq_get and use it
to implement ResourceSource/IRQ domain mapping.

The new API is similar to of_irq_get and allows re-initialization
of a platform resource from the ACPI extended IRQ resource, and
provides proper behavior for probe deferral when the domain is not
yet present when called.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/Makefile         |   2 +-
 drivers/acpi/{gsi.c => irq.c} | 199 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/platform.c       |  10 +++
 include/linux/acpi.h          |  10 +++
 4 files changed, 220 insertions(+), 1 deletion(-)
 rename drivers/acpi/{gsi.c => irq.c} (31%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9ed0878..a391bbc 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,7 +55,7 @@ acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
-acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
+acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 
 # These are (potentially) separate modules
diff --git a/drivers/acpi/gsi.c b/drivers/acpi/irq.c
similarity index 31%
rename from drivers/acpi/gsi.c
rename to drivers/acpi/irq.c
index ee9e0f2..830299a 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/irq.c
@@ -85,6 +85,205 @@ void acpi_unregister_gsi(u32 gsi)
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
 /**
+ * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
+ * @source: acpi_resource_source to use for the lookup.
+ *
+ * Description:
+ * Retrieve the fwhandle of the device referenced by the given IRQ resource
+ * source.
+ *
+ * Return:
+ * The referenced device fwhandle or NULL on failure
+ */
+static struct fwnode_handle *
+acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
+{
+	struct fwnode_handle *result;
+	struct acpi_device *device;
+	acpi_handle handle;
+	acpi_status status;
+
+	if (!source->string_length)
+		return acpi_gsi_domain_id;
+
+	status = acpi_get_handle(NULL, source->string_ptr, &handle);
+	if (WARN_ON(ACPI_FAILURE(status)))
+		return NULL;
+
+	device = acpi_bus_get_acpi_device(handle);
+	if (WARN_ON(!device))
+		return NULL;
+
+	result = &device->fwnode;
+	acpi_bus_put_acpi_device(device);
+	return result;
+}
+
+/*
+ * Context for the resource walk used to lookup IRQ resources.
+ * Contains a return code, the lookup index, and references to the flags
+ * and fwspec where the result is returned.
+ */
+struct acpi_irq_parse_one_ctx {
+	int rc;
+	unsigned int index;
+	unsigned long *res_flags;
+	struct irq_fwspec *fwspec;
+};
+
+/**
+ * acpi_irq_parse_one_match - Handle a matching IRQ resource.
+ * @fwnode: matching fwnode
+ * @hwirq: hardware IRQ number
+ * @triggering: triggering attributes of hwirq
+ * @polarity: polarity attributes of hwirq
+ * @polarity: polarity attributes of hwirq
+ * @shareable: shareable attributes of hwirq
+ * @ctx: acpi_irq_parse_one_ctx updated by this function
+ *
+ * Description:
+ * Handle a matching IRQ resource by populating the given ctx with
+ * the information passed.
+ */
+static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
+					    u32 hwirq, u8 triggering,
+					    u8 polarity, u8 shareable,
+					    struct acpi_irq_parse_one_ctx *ctx)
+{
+	if (!fwnode)
+		return;
+	ctx->rc = 0;
+	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable);
+	ctx->fwspec->fwnode = fwnode;
+	ctx->fwspec->param[0] = hwirq;
+	ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
+	ctx->fwspec->param_count = 2;
+}
+
+/**
+ * acpi_irq_parse_one_cb - Handle the given resource.
+ * @ares: resource to handle
+ * @context: context for the walk
+ *
+ * Description:
+ * This is called by acpi_walk_resources passing each resource returned by
+ * the _CRS method. We only inspect IRQ resources. Since IRQ resources
+ * might contain multiple interrupts we check if the index is within this
+ * one's interrupt array, otherwise we subtract the current resource IRQ
+ * count from the lookup index to prepare for the next resource.
+ * Once a match is found we call acpi_irq_parse_one_match to populate
+ * the result and end the walk by returning AE_CTRL_TERMINATE.
+ *
+ * Return:
+ * AE_OK if the walk should continue, AE_CTRL_TERMINATE if a matching
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
+		if (eirq->producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
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
+ * Description:
+ * Resolves an interrupt for a device by walking its CRS resources to find
+ * the appropriate ACPI IRQ resource and populating the given struct irq_fwspec
+ * and flags.
+ *
+ * Return:
+ * The result stored in ctx.rc by the callback, or the default -EINVAL value
+ * if an error occurs.
+ */
+static int acpi_irq_parse_one(acpi_handle handle, unsigned int index,
+			      struct irq_fwspec *fwspec, unsigned long *flags)
+{
+	struct acpi_irq_parse_one_ctx ctx = { -EINVAL, index, flags, fwspec };
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS, acpi_irq_parse_one_cb, &ctx);
+	return ctx.rc;
+}
+
+/**
+ * acpi_irq_get - Lookup an ACPI IRQ resource and use it to initialize resource.
+ * @handle: ACPI device handle
+ * @index:  ACPI IRQ resource index to lookup
+ * @res:    Linux IRQ resource to initialize
+ *
+ * Description:
+ * Look for the ACPI IRQ resource with the given index and use it to initialize
+ * the given Linux IRQ resource.
+ *
+ * Return:
+ * 0 on success
+ * -EINVAL if an error occurs
+ * -EPROBE_DEFER if the IRQ lookup/conversion failed
+ */
+int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
+{
+	struct irq_fwspec fwspec;
+	struct irq_domain *domain;
+	unsigned long flags;
+	int rc;
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
index c4af003..647e476 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -102,6 +102,16 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	}
 
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
+	if (has_acpi_companion(&dev->dev)) {
+		if (r && r->flags & IORESOURCE_DISABLED) {
+			int ret;
+
+			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
+			if (ret)
+				return ret;
+		}
+	}
+
 	/*
 	 * The resources may pass trigger flags to the irqs that need
 	 * to be set up. It so happens that the trigger flags for
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5b36974..8e577c2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1153,4 +1153,14 @@ static inline void acpi_table_upgrade(void) { }
 static inline int parse_spcr(bool earlycon) { return 0; }
 #endif
 
+#if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
+int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
+#else
+static inline
+int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

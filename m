From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Wed, 14 Dec 2016 17:10:37 -0500
Subject: [PATCH V9 2/3] ACPI: Add support for ResourceSource/IRQ domain mapping
In-Reply-To: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1481753438-3905-3-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI extended IRQ resources may contain a ResourceSource to specify
an alternate interrupt controller. Introduce acpi_irq_get and use it
to implement ResourceSource/IRQ domain mapping.

The new API is similar to of_irq_get and allows re-initialization
of a platform resource from the ACPI extended IRQ resource, and
provides proper behavior for probe deferral when the domain is not
yet present when called.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/Makefile         |   2 +-
 drivers/acpi/{gsi.c => irq.c} | 182 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/platform.c       |   9 ++-
 include/linux/acpi.h          |  10 +++
 4 files changed, 201 insertions(+), 2 deletions(-)
 rename drivers/acpi/{gsi.c => irq.c} (32%)

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
similarity index 32%
rename from drivers/acpi/gsi.c
rename to drivers/acpi/irq.c
index ee9e0f2..133d3f8 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/irq.c
@@ -85,6 +85,188 @@ void acpi_unregister_gsi(u32 gsi)
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
 /**
+ * acpi_get_irq_source_fwhandle() - Retrieve the fwhandle of the given
+ *                                  acpi_resource_source which is used
+ *                                  as an IRQ domain id
+ * @source: acpi_resource_source to use for the lookup
+ *
+ * Returns: The appropriate IRQ fwhandle domain id
+ *          NULL on failure
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
+	if (ACPI_FAILURE(status)) {
+		pr_warn("Could not find handle for %s\n", source->string_ptr);
+		return NULL;
+	}
+
+	device = acpi_bus_get_acpi_device(handle);
+	if (!device) {
+		pr_warn("Could not get device for %s\n", source->string_ptr);
+		return NULL;
+	}
+
+	result = &device->fwnode;
+	acpi_bus_put_acpi_device(device);
+
+	return result;
+}
+
+/**
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
index 61a3d90..2284fc6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1123,4 +1123,14 @@ static inline void acpi_table_upgrade(void) { }
 static inline int parse_spcr(bool earlycon) { return 0; }
 #endif
 
+#ifdef CONFIG_ACPI_GENERIC_GSI
+int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
+#else
+static inline int acpi_irq_get(acpi_handle handle, unsigned int index,
+			       struct resource *res)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

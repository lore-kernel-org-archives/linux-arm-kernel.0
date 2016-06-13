From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 13 Jun 2016 13:45:21 +0800
Subject: [PATCH V3 1/2] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <575D45E1.1000603@huawei.com>
References: <1463156203-10970-1-git-send-email-agustinv@codeaurora.org>
 <1463156203-10970-2-git-send-email-agustinv@codeaurora.org>
 <20160604133012.581d7dbe@arm.com>
 <cac968a4060040adaf70e7cdb4835730@codeaurora.org>
 <575D45E1.1000603@huawei.com>
Message-ID: <575E4871.1090609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+cc linux-acpi, linux-arm-kernel
(blocked, send again, sorry for the noise)

On 2016/6/12 19:22, Hanjun Guo wrote:
> Hi,
>
> On 2016/6/7 5:54, agustinv at codeaurora.org wrote:
>> On 2016-06-04 08:30, Marc Zyngier wrote:
>>> On Fri, 13 May 2016 12:16:42 -0400
>>> Agustin Vega-Frias <agustinv@codeaurora.org> wrote:
>
>>>
>>>> + * @rcirq: IRQ number
>>>> + * @trigger: trigger type of the IRQ number to be mapped
>>>> + * @polarity: polarity of the IRQ to be mapped
>>>
>>> So if I'm right in my above understanding, you've reinvented an
>>> existing abstraction (irq_fwspec).
>>>
>>>
>
>>> So at this point, you should be able to create a irq_fwspec, and call
>>> into irq_create_fwspec_mapping(), without the need to open-code stuff
>>> we already have. And as a bonus point, you'd end-up with code that'd be
>>> similar to what is in gsi.c...
>>>
>>
>> Got it.
>>
>>>>
>
>>>
>>> Again, this smell a lot like gsi.c, with added sugar on top.
>>
>> Yes, this can go away since a client can just call irq_dispose_mapping which finds the domain from the irq_data.
>
> I reworked my previous patches [1] which trying to support a mbi-gen interrupt
> controller, here is the updated one for discussion to see it's a option or not:
>
> [1]: http://git.linaro.org/people/hanjun.guo/acpi.git/shortlog/refs/heads/7-topic-d02-mbi-gen
> patch: ACPI: resource: pass acpi dev to acpi_register_gsi()
> acpi: gsi: make the interrupt parent be selectable</people/hanjun.guo/acpi.git/commit/28867116a69e4907e6f08971e75b533ec90a4dd2>
>
 drivers/acpi/gsi.c      |  8 +++--
 drivers/acpi/resource.c | 85 ++++++++++++++++++++++++++++++++++---------------
 include/acpi/acpi_bus.h |  1 +
 3 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index fa4585a..afcb343 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -74,13 +74,17 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	struct irq_fwspec fwspec;
+	struct acpi_device *adev = dev ? to_acpi_device(dev) : NULL;
 
-	if (WARN_ON(!acpi_gsi_domain_id)) {
+	if (acpi_gsi_domain_id)
+		fwspec.fwnode = acpi_gsi_domain_id;
+	else if (adev && &adev->fwnode && adev->interrupt_parent)
+		fwspec.fwnode = adev->interrupt_parent;
+	else {
 		pr_warn("GSI: No registered irqchip, giving up\n");
 		return -EINVAL;
 	}
 
-	fwspec.fwnode = acpi_gsi_domain_id;
 	fwspec.param[0] = gsi;
 	fwspec.param[1] = acpi_gsi_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 627f8fb..ed9491d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -355,7 +355,7 @@ static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
 	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
 }
 
-static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
+static void acpi_dev_get_irqresource(struct acpi_device *adev, struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
 {
@@ -389,7 +389,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	}
 
 	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
-	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
+	irq = acpi_register_gsi(&adev->dev, gsi, triggering, polarity);
 	if (irq >= 0) {
 		res->start = irq;
 		res->end = irq;
@@ -398,27 +398,9 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	}
 }
 
-/**
- * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
- * @ares: Input ACPI resource object.
- * @index: Index into the array of GSIs represented by the resource.
- * @res: Output generic resource object.
- *
- * Check if the given ACPI resource object represents an interrupt resource
- * and @index does not exceed the resource's interrupt count (true is returned
- * in that case regardless of the results of the other checks)).  If that's the
- * case, register the GSI corresponding to @index from the array of interrupts
- * represented by the resource and populate the generic resource object pointed
- * to by @res accordingly.  If the registration of the GSI is not successful,
- * IORESOURCE_DISABLED will be set it that object's flags.
- *
- * Return:
- * 1) false with res->flags setting to zero: not the expected resource type
- * 2) false with IORESOURCE_DISABLED in res->flags: valid unassigned resource
- * 3) true: valid assigned resource
- */
-bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
-				 struct resource *res)
+static bool __acpi_dev_resource_interrupt(struct acpi_device *adev,
+					  struct acpi_resource *ares, int index,
+					  struct resource *res)
 {
 	struct acpi_resource_irq *irq;
 	struct acpi_resource_extended_irq *ext_irq;
@@ -434,7 +416,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			acpi_dev_irqresource_disabled(res, 0);
 			return false;
 		}
-		acpi_dev_get_irqresource(res, irq->interrupts[index],
+		acpi_dev_get_irqresource(adev, res, irq->interrupts[index],
 					 irq->triggering, irq->polarity,
 					 irq->sharable, true);
 		break;
@@ -444,7 +426,31 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			acpi_dev_irqresource_disabled(res, 0);
 			return false;
 		}
-		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
+
+		/*
+		 * It's a interrupt consumer and connecting to specfic
+		 * interrupt controller. For now, we only support connecting
+		 * interrupts to one irq controller for a single device (fix me!)
+		 */
+		if (ext_irq->producer_consumer == ACPI_CONSUMER
+		    && ext_irq->resource_source.string_length != 0
+		    && !adev->interrupt_parent) {
+			acpi_status status;
+			acpi_handle handle;
+			struct acpi_device *device;
+
+			status = acpi_get_handle(NULL, ext_irq->resource_source.string_ptr, &handle);
+			if (ACPI_FAILURE(status))
+				return false;
+
+			device = acpi_bus_get_acpi_device(handle);
+			if (!device)
+				return false;
+
+			adev->interrupt_parent = &device->fwnode;
+		}
+
+		acpi_dev_get_irqresource(adev, res, ext_irq->interrupts[index],
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->sharable, false);
 		break;
@@ -455,6 +461,31 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 
 	return true;
 }
+
+/**
+ * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
+ * @ares: Input ACPI resource object.
+ * @index: Index into the array of GSIs represented by the resource.
+ * @res: Output generic resource object.
+ *
+ * Check if the given ACPI resource object represents an interrupt resource
+ * and @index does not exceed the resource's interrupt count (true is returned
+ * in that case regardless of the results of the other checks)).  If that's the
+ * case, register the GSI corresponding to @index from the array of interrupts
+ * represented by the resource and populate the generic resource object pointed
+ * to by @res accordingly.  If the registration of the GSI is not successful,
+ * IORESOURCE_DISABLED will be set it that object's flags.
+ *
+ * Return:
+ * 1) false with res->flags setting to zero: not the expected resource type
+ * 2) false with IORESOURCE_DISABLED in res->flags: valid unassigned resource
+ * 3) true: valid assigned resource
+ */
+bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
+				 struct resource *res)
+{
+	return __acpi_dev_resource_interrupt(NULL, ares, index, res);
+}
 EXPORT_SYMBOL_GPL(acpi_dev_resource_interrupt);
 
 /**
@@ -473,6 +504,7 @@ struct res_proc_context {
 	void *preproc_data;
 	int count;
 	int error;
+	struct acpi_device *adev;
 };
 
 static acpi_status acpi_dev_new_resource_entry(struct resource_win *win,
@@ -520,7 +552,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
 	    || acpi_dev_resource_ext_address_space(ares, &win))
 		return acpi_dev_new_resource_entry(&win, c);
 
-	for (i = 0; acpi_dev_resource_interrupt(ares, i, res); i++) {
+	for (i = 0; __acpi_dev_resource_interrupt(c->adev, ares, i, res); i++) {
 		acpi_status status;
 
 		status = acpi_dev_new_resource_entry(&win, c);
@@ -573,6 +605,7 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 	c.preproc_data = preproc_data;
 	c.count = 0;
 	c.error = 0;
+	c.adev = adev;
 	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
 				     acpi_dev_process_resource, &c);
 	if (ACPI_FAILURE(status)) {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ea4d2b5..371a086 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -353,6 +353,7 @@ struct acpi_device {
 	int device_type;
 	acpi_handle handle;		/* no handle for fixed hardware */
 	struct fwnode_handle fwnode;
+	struct fwnode_handle *interrupt_parent;
 	struct acpi_device *parent;
 	struct list_head children;
 	struct list_head node;
-- 1.9.1

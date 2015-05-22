From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Fri, 22 May 2015 17:24:15 -0500
Subject: [V5 PATCH 1/5] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <1815824.lIg0NQ97lU@vostro.rjw.lan>
References: <1432159758-4486-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1432159758-4486-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1815824.lIg0NQ97lU@vostro.rjw.lan>
Message-ID: <555FAC8F.4010306@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not sure if this went out earlier. So I am resending.

On 5/22/15 16:56, Rafael J. Wysocki wrote:
>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>> >index 39c485b..b9657af 100644
>> >--- a/drivers/acpi/glue.c
>> >+++ b/drivers/acpi/glue.c
>> >@@ -13,6 +13,7 @@
>> >  #include <linux/slab.h>
>> >  #include <linux/rwsem.h>
>> >  #include <linux/acpi.h>
>> >+#include <linux/dma-mapping.h>
>> >
>> >  #include "internal.h"
>> >
>> >@@ -167,6 +168,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>> >  	struct list_head *physnode_list;
>> >  	unsigned int node_id;
>> >  	int retval = -EINVAL;
>> >+	bool coherent;
>> >
>> >  	if (has_acpi_companion(dev)) {
>> >  		if (acpi_dev) {
>> >@@ -223,6 +225,9 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>> >  	if (!has_acpi_companion(dev))
>> >  		ACPI_COMPANION_SET(dev, acpi_dev);
>> >
>> >+	if (acpi_check_dma(acpi_dev, &coherent))
>> >+		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>> >+
> Well, so is this going to work for PCI too after all?
>

No, as Bjorn suggested, PCI changes for setting DMA coherent from _CCA 
(patch 3/6 in V4) will be submitted separately. We are working on 
cleaning up and up-streaming the PCI ACPI support for ARM64.

Thanks,

Suravee

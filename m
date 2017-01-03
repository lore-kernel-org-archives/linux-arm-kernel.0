From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 3 Jan 2017 12:24:57 +0100
Subject: [PATCH v6 05/14] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <4ab6a7e3-7aa3-367d-a333-effb24399fd5@semihalf.com>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org>
 <13cb0c87-e1c0-c4d6-4793-a3edd20944dc@semihalf.com>
 <4ab6a7e3-7aa3-367d-a333-effb24399fd5@semihalf.com>
Message-ID: <168e53f0-1e56-7937-7dbb-bd5c6460437a@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.01.2017 10:37, Tomasz Nowicki wrote:
> On 03.01.2017 09:43, Tomasz Nowicki wrote:
>> On 02.01.2017 14:31, Hanjun Guo wrote:
>>> For devices connecting to ITS, it needs dev id to identify
>>> itself, and this dev id is represented in the IORT table in
>>> named componant node [1] for platform devices, so in this
>>> patch we will scan the IORT to retrieve device's dev id.
>>>
>>> Introduce iort_pmsi_get_dev_id() with pointer dev passed
>>> in for that purpose.
>>>
>>> [1]:
>>> https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> Tested-by: Sinan Kaya <okaya@codeaurora.org>
>>> Tested-by: Majun <majun258@huawei.com>
>>> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Tomasz Nowicki <tn@semihalf.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>>  drivers/acpi/arm64/iort.c                     | 26
>>> ++++++++++++++++++++++++++
>>>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +++-
>>>  include/linux/acpi_iort.h                     |  8 ++++++++
>>>  3 files changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index 174e983..ab7bae7 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -444,6 +444,32 @@ u32 iort_msi_map_rid(struct device *dev, u32
>>> req_id)
>>>  }
>>>
>>>  /**
>>> + * iort_pmsi_get_dev_id() - Get the device id for a device
>>> + * @dev: The device for which the mapping is to be done.
>>> + * @dev_id: The device ID found.
>>> + *
>>> + * Returns: 0 for successful find a dev id, errors otherwise
>>> + */
>>> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>>> +{
>>> +    struct acpi_iort_node *node;
>>> +
>>> +    if (!iort_table)
>>> +        return -ENODEV;
>>> +
>>> +    node = iort_find_dev_node(dev);
>>> +    if (!node) {
>>> +        dev_err(dev, "can't find related IORT node\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    if(!iort_node_get_id(node, dev_id, IORT_MSI_TYPE, 0))
>>> +        return -ENODEV;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>> Giving that you are extending this to NC->
>> SMMU->ITS case in later patch, we can use existing helpers from iort.c,
>> like that:
>>
>> +/**
>> + * iort_pmsi_get_dev_id() - Get the device id for a device
>> + * @dev: The device for which the mapping is to be done.
>> + * @dev_id: The device ID found.
>> + *
>> + * Returns: 0 for successful find a dev id, errors otherwise
>> + */
>> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>> +{
>> +    struct acpi_iort_node *node;
>> +
>> +    node = iort_find_dev_node(dev);
>> +    if (!node)
>> +        return -ENODEV;
>> +
>> +    if (!iort_node_map_rid(node, 0, dev_id, IORT_MSI_TYPE))
>> +        return -ENODEV;
>> +
>> +    return 0;
>> +}
>>
>> Correct me if I am wrong.
>>
>
> "0" as rid_in for iort_node_map_rid() isn't good idea, sorry...
>

I refactored iort_node_map_rid() and added new 
iort_node_map_single_rid() which should works for you. Below patch bases 
on v4.10-rc2:

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e0d2e6e..2526b89 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -297,8 +297,17 @@ static acpi_status iort_match_node_callback(struct 
acpi_iort_node *node,
  }

  static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 
rid_in,
-		       u32 *rid_out)
+		       u32 *rid_out, bool single)
  {
+	if (!single) {
+		if (rid_in < map->input_base ||
+		    (rid_in >= map->input_base + map->id_count))
+			return -ENXIO;
+
+		*rid_out = map->output_base + (rid_in - map->input_base);
+		return 0;
+	}
+
  	/* Single mapping does not care for input id */
  	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
  		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
@@ -309,15 +318,9 @@ static int iort_id_map(struct acpi_iort_id_mapping 
*map, u8 type, u32 rid_in,

  		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node 
type %d, skipping ID map\n",
  			map, type);
-		return -ENXIO;
  	}

-	if (rid_in < map->input_base ||
-	    (rid_in >= map->input_base + map->id_count))
-		return -ENXIO;
-
-	*rid_out = map->output_base + (rid_in - map->input_base);
-	return 0;
+	return -ENXIO;
  }

  static
@@ -359,6 +362,38 @@ struct acpi_iort_node *iort_node_get_id(struct 
acpi_iort_node *node,
  	return NULL;
  }

+static struct acpi_iort_node *iort_node_map_rid_one(struct 
acpi_iort_node *node,
+						    u32 *rid, bool single)
+{
+	struct acpi_iort_id_mapping *map;
+	struct acpi_iort_node *next;
+	int i;
+
+	if (!node->mapping_offset || !node->mapping_count)
+		return NULL;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset);
+
+	/* Firmware bug! */
+	if (!map->output_reference) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	next = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+			    map->output_reference);
+
+	/* Do the RID translation */
+	for (i = 0; i < node->mapping_count; i++, map++) {
+		if (!iort_id_map(map, node->type, *rid, rid, single))
+			return next;
+	}
+
+	return NULL;
+}
+
  static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node 
*node,
  						u32 rid_in, u32 *rid_out,
  						u8 type_mask)
@@ -367,42 +402,15 @@ static struct acpi_iort_node 
*iort_node_map_rid(struct acpi_iort_node *node,

  	/* Parse the ID mapping tree to find specified node type */
  	while (node) {
-		struct acpi_iort_id_mapping *map;
-		int i;
-
  		if (IORT_TYPE_MASK(node->type) & type_mask) {
  			if (rid_out)
  				*rid_out = rid;
  			return node;
  		}

-		if (!node->mapping_offset || !node->mapping_count)
-			goto fail_map;
-
-		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
-				   node->mapping_offset);
-
-		/* Firmware bug! */
-		if (!map->output_reference) {
-			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
-			       node, node->type);
-			goto fail_map;
-		}
-
-		/* Do the RID translation */
-		for (i = 0; i < node->mapping_count; i++, map++) {
-			if (!iort_id_map(map, node->type, rid, &rid))
-				break;
-		}
-
-		if (i == node->mapping_count)
-			goto fail_map;
-
-		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
-				    map->output_reference);
+		node = iort_node_map_rid_one(node, &rid, false);
  	}

-fail_map:
  	/* Map input RID to output RID unchanged on mapping failure*/
  	if (rid_out)
  		*rid_out = rid_in;
@@ -410,6 +418,20 @@ static struct acpi_iort_node 
*iort_node_map_rid(struct acpi_iort_node *node,
  	return NULL;
  }

+static struct acpi_iort_node *iort_node_map_single_rid(
+						struct acpi_iort_node *node,
+						u32 *rid_out, u8 type_mask)
+{
+	u32 rid;
+
+	/* Get the initial rid */
+	node = iort_node_map_rid_one(node, &rid, true);
+	if (!node)
+		return NULL;
+
+	return iort_node_map_rid(node, rid, rid_out, type_mask);
+}
+
  static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
  {
  	struct pci_bus *pbus;

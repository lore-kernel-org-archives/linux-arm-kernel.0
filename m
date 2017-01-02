From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 2 Jan 2017 17:30:15 -0500
Subject: [PATCH v6 10/14] ACPI: ARM64: IORT: rework iort_node_get_id() for
 NC->SMMU->ITS case
In-Reply-To: <1483363905-2806-11-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-11-git-send-email-hanjun.guo@linaro.org>
Message-ID: <d221a280-d73a-91ad-c984-b6cd114f3a40@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 1/2/2017 8:31 AM, Hanjun Guo wrote:
> iort_node_get_id() for now only support NC(named componant)->SMMU
> or NC->ITS cases, we also have other device topology such NC->
> SMMU->ITS, so rework iort_node_get_id() for those cases.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 61 ++++++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 6b72fcb..99f079b 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -292,22 +292,28 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>  	return status;
>  }
>  
> -static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> -		       u32 *rid_out)
> +static int iort_id_single_map(struct acpi_iort_id_mapping *map, u8 type,
> +			      u32 *rid_out)
>  {
>  	/* Single mapping does not care for input id */
>  	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>  		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>  		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			*rid_out = map->output_base;
> +			if (rid_out)
> +				*rid_out = map->output_base;
>  			return 0;
>  		}
>  
>  		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
>  			map, type);
> -		return -ENXIO;
>  	}
>  
> +	return -ENXIO;
> +}
> +
> +static int iort_id_map(struct acpi_iort_id_mapping *map, u32 rid_in,
> +		       u32 *rid_out)
> +{
>  	if (rid_in < map->input_base ||
>  	    (rid_in >= map->input_base + map->id_count))
>  		return -ENXIO;
> @@ -324,33 +330,34 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  	struct acpi_iort_node *parent;
>  	struct acpi_iort_id_mapping *map;
>  
> -	if (!node->mapping_offset || !node->mapping_count ||
> -				     index >= node->mapping_count)
> -		return NULL;
> -
> -	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> -			   node->mapping_offset);
> +	while (node) {
> +		if (!node->mapping_offset || !node->mapping_count ||
> +					     index >= node->mapping_count)
> +			return NULL;
>  
> -	/* Firmware bug! */
> -	if (!map->output_reference) {
> -		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> -		       node, node->type);
> -		return NULL;
> -	}
> +		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +				   node->mapping_offset);
>  
> -	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> -			       map->output_reference);
> +		/* Firmware bug! */
> +		if (!map->output_reference) {
> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> +			       node, node->type);
> +			return NULL;
> +		}
>  
> -	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
> -		return NULL;
> +		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				      map->output_reference);
>  
> -	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> -		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> -		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			if (id_out)
> -				*id_out = map[index].output_base;
> -			return parent;
> +		/* go upstream to find its parent */
> +		if (!(IORT_TYPE_MASK(parent->type) & type_mask)) {
> +			node = parent;
> +			continue;
>  		}
> +
> +		if (iort_id_single_map(&map[index], node->type, id_out))
> +			break;
> +
> +		return parent;
>  	}
>  
>  	return NULL;
> @@ -388,7 +395,7 @@ static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
>  
>  		/* Do the RID translation */
>  		for (i = 0; i < node->mapping_count; i++, map++) {
> -			if (!iort_id_map(map, node->type, rid, &rid))
> +			if (!iort_id_map(map, rid, &rid))
>  				break;
>  		}
>  
> 

I wanted to follow up on your note for NC->SMMU->ITS case as I do have this use case on the 
Qualcomm QDF2400 server and HIDMA DMA Engine. HIDMA is capable of sending MSI interrupts
towards the GIC ITS. 

I don't know if this patch is supposed to fix the NC->SMMU->ITS case as it suggests in the commit
message but it doesn't seems to be working for me. Maybe, it was a to do for you. It wasn't quite
clear from the commit. 

I debugged the code and came up with the following patch. Feel free to incorporate/rework with
your existing patch.

A named node can have an output ID of 0x20 and SMMU can have an output
parameter of 0x80000. The device ID needs to be 0x80000+0x20 for this
use case. 

With the addition of this patch on top of the first 11 patches, I'm also providing my tested by here
for the first 11 patches.

Tested-by: Sinan Kaya <okaya@codeaurora.org>

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
-------------- next part --------------
>From c5ab7172a400bfd5b460374e70394fe78c260603 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Mon, 2 Jan 2017 17:16:45 -0500
Subject: [PATCH] ACPI: ARM64: IORT: rework iort_node_get_id() for
 NC->SMMU->ITS case part #2

Code won't collect the output ID as it traverses NC->SMMU->ITS path.
Adding support for this use case.

A named node can have an output ID of 0x20 and SMMU can have an output
parameter of 0x80000. The device ID needs to be 0x80000+0x20 for this
use case.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/arm64/iort.c | 58 ++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 882e624..19cb97a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -296,18 +296,16 @@ static int iort_id_single_map(struct acpi_iort_id_mapping *map, u8 type,
 			      u32 *rid_out)
 {
 	/* Single mapping does not care for input id */
-	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
-		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
-		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
-			if (rid_out)
-				*rid_out = map->output_base;
-			return 0;
-		}
-
-		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
-			map, type);
+	if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
+	    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
+		if (rid_out)
+			*rid_out = map->output_base;
+		return 0;
 	}

+	pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
+		map, type);
+
 	return -ENXIO;
 }

@@ -327,13 +325,20 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 					u32 *id_out, u8 type_mask,
 					int index)
 {
-	struct acpi_iort_node *parent;
-	struct acpi_iort_id_mapping *map;
+	u32 id = 0;

 	while (node) {
-		if (!node->mapping_offset || !node->mapping_count ||
-					     index >= node->mapping_count)
-			return NULL;
+		struct acpi_iort_id_mapping *map;
+
+		if (IORT_TYPE_MASK(node->type) & type_mask) {
+			if (id_out)
+				*id_out = id;
+
+			return node;
+		}
+
+		if (!node->mapping_offset || !node->mapping_count)
+			goto fail_map;

 		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
 				   node->mapping_offset);
@@ -342,24 +347,25 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		if (!map->output_reference) {
 			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
 			       node, node->type);
-			return NULL;
+			goto fail_map;
 		}

-		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
-				      map->output_reference);
-
-		/* go upstream to find its parent */
-		if (!(IORT_TYPE_MASK(parent->type) & type_mask)) {
-			node = parent;
-			continue;
+		if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
+			if (iort_id_single_map(&map[index], node->type, &id))
+				goto fail_map;
+		} else {
+			if (iort_id_map(map, id, &id))
+				goto fail_map;
 		}

-		if (iort_id_single_map(&map[index], node->type, id_out))
-			break;
+		if (index == node->mapping_count)
+			goto fail_map;

-		return parent;
+		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				      map->output_reference);
 	}

+fail_map:
 	return NULL;
 }

--
1.9.1

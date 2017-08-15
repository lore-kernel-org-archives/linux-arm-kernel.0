From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 15 Aug 2017 18:13:43 +0100
Subject: [RFC PATCH 3/4] ACPI: IORT: Skip SMMUv3 device ID map for two
 steps mappings
In-Reply-To: <1502276017-63108-4-git-send-email-guohanjun@huawei.com>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-4-git-send-email-guohanjun@huawei.com>
Message-ID: <20170815171343.GA13707@e107981-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 06:53:36PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> IORT revision C introduced SMMUv3 MSI support which adding a
> device ID mapping index in SMMUv3 sub table, to get the SMMUv3
> device ID mapping for the output ID (dev ID for ITS) and the
> link to which ITS.
> 
> So if a platform supports SMMUv3 MSI for control interrupt,
> there will be a additional single map entry under SMMU, this
> will not introduce any difference for devices just use one
> step map to get its output ID and parent (ITS or SMMU), such
> as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
> do the spcial handling for two steps map case such as
> PCI/NC--->SMMUv3--->ITS.
> 
> Take a PCI hostbridge for example,
> 
> |----------------------|
> |  Root Complex Node   |
> |----------------------|
> |    map entry[x]      |
> |----------------------|
> |       id value       |
> | output_reference     |
> |---|------------------|
>     |
>     |   |----------------------|
>     |-->|        SMMUv3        |
>         |----------------------|
>         |     SMMU dev ID      |
>         |     mapping index 0  |
>         |----------------------|
>         |      map entry[0]    |
>         |----------------------|
>         |       id value       |
>         | output_reference-----------> ITS 1 (SMMU MSI domain)
>         |----------------------|
>         |      map entry[1]    |
>         |----------------------|
>         |       id value       |
>         | output_reference-----------> ITS 2 (PCI MSI domain)
>         |----------------------|
> 
> When the SMMU dev ID mapping index is 0, there is entry[0]
> to map to a ITS, we need to skip that map entry for PCI
> or NC (named component), or we may get the wrong ITS parent.
> 
> For now we have two APIs for ID mapping, iort_node_map_id()
> and iort_node_map_platform_id(), and iort_node_map_id() is
> used for optional two steps mapping, so we just need to
> skip the map entry in iort_node_map_id() for non-SMMUv3
> devices.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)

Tweaked it slightly, so that you can apply my 4/4 on top of it:

-- >8 --
Subject: [PATCH 3/4] ACPI: IORT: Skip SMMUv3 device ID map for two steps
 mappings

IORT revision C introduced SMMUv3 MSI support which adding a
device ID mapping index in SMMUv3 sub table, to get the SMMUv3
device ID mapping for the output ID (dev ID for ITS) and the
link to which ITS.

So if a platform supports SMMUv3 MSI for control interrupt,
there will be a additional single map entry under SMMU, this
will not introduce any difference for devices just use one
step map to get its output ID and parent (ITS or SMMU), such
as PCI/NC/PMCG ---> ITS or PCI/NC ---> SMMU, but we need to
do the spcial handling for two steps map case such as
PCI/NC--->SMMUv3--->ITS.

Take a PCI hostbridge for example,

|----------------------|
|  Root Complex Node   |
|----------------------|
|    map entry[x]      |
|----------------------|
|       id value       |
| output_reference     |
|---|------------------|
    |
    |   |----------------------|
    |-->|        SMMUv3        |
        |----------------------|
        |     SMMU dev ID      |
        |     mapping index 0  |
        |----------------------|
        |      map entry[0]    |
        |----------------------|
        |       id value       |
        | output_reference-----------> ITS 1 (SMMU MSI domain)
        |----------------------|
        |      map entry[1]    |
        |----------------------|
        |       id value       |
        | output_reference-----------> ITS 2 (PCI MSI domain)
        |----------------------|

When the SMMU dev ID mapping index is 0, there is entry[0]
to map to a ITS, we need to skip that map entry for PCI
or NC (named component), or we may get the wrong ITS parent.

For now we have two APIs for ID mapping, iort_node_map_id()
and iort_node_map_platform_id(), and iort_node_map_id() is
used for optional two steps mapping, so we just need to
skip the map entry in iort_node_map_id() for non-SMMUv3
devices.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2514845..24678c3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -366,6 +366,34 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
+static int iort_get_smmu_v3_id_mapping_index(struct acpi_iort_node *node,
+					     u32 *index)
+{
+	struct acpi_iort_smmu_v3 *smmu;
+
+	/*
+	 * SMMUv3 dev ID mapping index was introdueced in revision 1
+	 * table, not avaible in revision 0
+	 */
+	if (node->revision < 1)
+		return -EINVAL;
+
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+	/* if any of the gsi for control interrupts is not 0, ignore the MSI */
+	if (smmu->event_gsiv || smmu->pri_gsiv || smmu->gerr_gsiv
+	    || smmu->sync_gsiv)
+		return -EINVAL;
+
+	if (smmu->id_mapping_index >= node->mapping_count) {
+		pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
+		       node, node->type);
+		return -EINVAL;
+	}
+
+	*index = smmu->id_mapping_index;
+	return 0;
+}
+
 static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 					       u32 id_in, u32 *id_out,
 					       u8 type_mask)
@@ -375,7 +403,9 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 	/* Parse the ID mapping tree to find specified node type */
 	while (node) {
 		struct acpi_iort_id_mapping *map;
-		int i;
+		int i, ret = -EINVAL;
+		/* big enough for an invalid id index in practical */
+		u32 index = U32_MAX;
 
 		if (IORT_TYPE_MASK(node->type) & type_mask) {
 			if (id_out)
@@ -396,8 +426,19 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 			goto fail_map;
 		}
 
+		/*
+		 *  we need to get SMMUv3 dev ID mapping index and skip its
+		 *  associated ID map for single mapping cases.
+		 */
+		if (node->type == ACPI_IORT_NODE_SMMU_V3)
+			ret = iort_get_smmu_v3_id_mapping_index(node, &index);
+
 		/* Do the ID translation */
 		for (i = 0; i < node->mapping_count; i++, map++) {
+			/* if it's a SMMUv3 device id mapping index, skip it */
+			if (!ret && i == index)
+				continue;
+
 			if (!iort_id_map(map, node->type, id, &id))
 				break;
 		}
-- 
2.10.0

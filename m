From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 3 Aug 2017 21:40:06 +0800
Subject: [PATCH v4] acpi/iort: numa: Add numa node mapping for smmuv3
 devices
In-Reply-To: <598326B1.7040508@huawei.com>
References: <20170725050237.11033-1-ganapatrao.kulkarni@cavium.com>
 <20170725151305.GU17961@rric.localdomain> <20170802162119.GA3984@red-moon>
 <598326B1.7040508@huawei.com>
Message-ID: <598327B6.8030201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/8/3 21:35, Hanjun Guo wrote:
> On 2017/8/3 0:21, Lorenzo Pieralisi wrote:
>> > Patch that I will send upstream below, please check, thanks.
>> >
>> > -- >8 --
>> > Subject: [PATCH] ACPI/IORT: numa: Add numa node mapping for smmuv3 devices
>> >
>> > ARM IORT specification(rev. C) has added  provision to define proximity
>> > domain in SMMUv3 IORT table. Adding required code to parse Proximity
>> > domain and set numa_node of smmv3 platform devices.
>> >
>> > Add code to parse proximity domain in SMMUv3 IORT table to
>> > set numa node mapping for smmuv3 devices.
>> >
>> > Link: http://lkml.kernel.org/r/20170706112017.GA16981 at rric.localdomain
>> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> > [lorenzo.pieralisi at arm.com: updated review comments]
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > ---
>> >  drivers/acpi/arm64/iort.c | 29 ++++++++++++++++++++++++++++-
>> >  1 file changed, 28 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> > index a3215ee..35dd803 100644
>> > --- a/drivers/acpi/arm64/iort.c
>> > +++ b/drivers/acpi/arm64/iort.c
>> > @@ -908,6 +908,27 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>> >  	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>> >  }
>> >  
>> > +#if defined(CONFIG_ACPI_NUMA) && defined(ACPI_IORT_SMMU_v3_PXM_VALID)
> Typo here, s/v3/V3, wit this typo, smmu proximity callback will be set to NULL.
>
>> > +/*
>> > + * set numa proximity domain for smmuv3 device
>> > + */
>> > +static void  __init arm_smmu_v3_set_proximity(struct device *dev,
>> > +					      struct acpi_iort_node *node)
>> > +{
>> > +	struct acpi_iort_smmu_v3 *smmu;
>> > +
>> > +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>> > +	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
>> > +		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
>> > +		dev_info(dev, "SMMUV3[%llx] Mapped to Proximity domain %d\n",
>> > +			smmu->base_address,
>> > +			smmu->pxm);
> Here I got:
>
> [    5.074246]  (null): SMMUV3[a0040000] Mapped to Proximity domain 0
> [    5.074296]  (null): SMMUV3[700a0040000] Mapped to Proximity domain 2
> [    5.074319]  (null): SMMUV3[c0040000] Mapped to Proximity domain 0
> [    5.074344]  (null): SMMUV3[8a0040000] Mapped to Proximity domain 1
> [    5.074368]  (null): SMMUV3[600a0040000] Mapped to Proximity domain 2

And SMMU-v3 or SMMUv3 is better I think.

Thanks
Hanjun

From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 23 Jun 2015 19:18:55 +0800
Subject: [PATCH v2 3/9] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <20150622164520.GA26129@red-moon>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-4-git-send-email-hanjun.guo@linaro.org>
 <20150622164520.GA26129@red-moon>
Message-ID: <5589409F.8020208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2015 12:45 AM, Lorenzo Pieralisi wrote:
> On Fri, Jun 19, 2015 at 09:46:06AM +0100, Hanjun Guo wrote:
>
> [...]
>
>> +
>> +static int __init
>> +match_gic_redist(struct acpi_subtable_header *header, const unsigned long end)
>> +{
>> +	return 0;
>> +}
>> +static bool __init acpi_gic_redist_is_present(void)
>> +{
>> +	int count;
>> +
>> +	/* scan MADT table to find if we have redistributor entries */
>> +	count  =  acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR,
>> +					match_gic_redist, 0);
>> +
>> +	/* has at least one GIC redistributor entry */
>> +	if (count > 0)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>
> return count > 0;
>
> What about systems where the redistributor data is in the GICC subtable ? Do
> you treat them as GIC V2 :) ?

Good catch :)

It's in my TODO list and I didn't put some notes here, my bad.

If we want to support that feature, it seems we need to refactor
the GICv3 code for rdist too, in gic_populate_rdist(), it use
redistributor regions and jump to each cpu's redistributor using
the stride, but with the redistributor data is in the GICC subtable,
we only have the base address for each cpu's redistributor, have
no regions.

Another way to do that we can repack all the base address for
redistributors into regions then no need to refactor the code,
but all the CPUs in MADT have to be listed in order which is
insane.

>
> On a side note, having to define an empty function like match_gic_redist is
> horrible.
>
> I wonder whether it is not better to refactor map_madt_entry(), create
> a MADT subtable iterator out of it and make that code generic, instead
> of being forced to add these useless MADT handlers just to count
> entries, it is not the first I noticed.

I agree, I also think that parse GICC for each driver (SMP, GIC) is
duplicate, trying to consolidate them, but I haven't figure out a
good way to do that.

>
>> +static int __init acpi_gic_version_init(void)
>> +{
>> +	int count;
>> +	void __iomem *dist_base;
>> +	u32 reg;
>> +
>> +	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
>> +					acpi_gic_parse_distributor, 0);
>> +
>> +	if (count <= 0) {
>> +		pr_err("No valid GIC distributor entry exists\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (gic_version >= ACPI_MADT_GIC_VERSION_RESERVED) {
>> +		pr_err("Invalid GIC version %d in MADT\n", gic_version);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * when the GIC version is 0, we fallback to hardware discovery.
>> +	 * this is also needed to keep compatiable with ACPI 5.1,
>> +	 * which has no gic_version field in distributor structure and
>> +	 * reserved as 0.
>> +	 *
>> +	 * For hardware discovery, the offset for GICv1/2 and GICv3/4 to
>> +	 * get the GIC version is different (0xFE8 for GICv1/2 and 0xFFE8
>> +	 * for GICv3/4), so we need to handle it separately.
>
>> +	 */
>> +	if (gic_version	== ACPI_MADT_GIC_VERSION_NONE) {
>> +		/* it's GICv3/v4 if redistributor is present */
>> +		if (acpi_gic_redist_is_present()) {
>
> See above, IIUC you might have systems with GIC v3 where this call
> would fail, and we do not want to fall back to GIC v2.

Yes, but we need to find a way to refactor the GICv3 code for
populating redistributors first.

Thanks
Hanjun

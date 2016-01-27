From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 27 Jan 2016 15:01:09 +0100
Subject: [PATCH v3 05/12] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <56A86DCF.1020205@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
 <20160125102148.GE24726@rric.localdomain>
 <56A86DCF.1020205@huawei.com>
Message-ID: <20160127140109.GQ24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.01.16 15:12:15, Hanjun Guo wrote:
> On 2016/1/25 18:21, Robert Richter wrote:
> > On 23.01.16 17:39:20, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> >> new file mode 100644
> >> index 0000000..f7f7533
> >> --- /dev/null
> >> +++ b/arch/arm64/kernel/acpi_numa.c
> >> +/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
> >> +int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> >> +{
> >> +	u64 start, end;
> >> +	int node, pxm;
> >> +
> >> +	if (srat_disabled())
> >> +		return -EINVAL;
> >> +
> >> +	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
> > Must be:
> >
> > 	ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
> >
> > Allow extensions to struct acpi_srat_mem_affinity in newer versions.
> 
> Hmm, I think we need to remove the check here now.

No, we might have an out-of-bound access then.

> 
> There are three cases:
> 
>  - firmware ACPI version is consistent with the ACPICA one, then
>    ma->header.length == sizeof(struct acpi_srat_mem_affinity )
> 
>  - firmware ACPI version is not consistent with the ACPICA one,
>    for example, struct acpi_srat_mem_affinity is extended in
>    new ACI version, but the formware is using the older one,
>   then it's ok to use
>   ma->header.length < sizeof(struct acpi_srat_mem_affinity )

The check above is ok as we need@least struct
acpi_srat_mem_affinity as it is now.

If we later change the kernel to support multiple versions of struct
acpi_srat_mem_affinity, i.e. use data from an extended section, we
will need to add code to handle that. This will include support of
data with length < acpi_srat_mem_affinity, in this case we may not use
extended data.

> 
>  - but if we use the older kernel + updated new firmware,
>    then
>    ma->header.length > sizeof(struct acpi_srat_mem_affinity )
>   will be the case, right?

Right, and this is a valid case not resulting in an error with my
suggestion above.

> 
> >
> >> +		bad_srat();
> >> +		return -EINVAL;
> > We need a pr_err() here to avoid that numa setup fails silently due to
> > bad fw. This applies to all error paths.
> >
> > See my delta patch below. You can merge it with your patch.
> 
> Thanks! I wil merge it into next version.

Thanks,

-Robert

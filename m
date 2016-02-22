From: labbott@redhat.com (Laura Abbott)
Date: Mon, 22 Feb 2016 11:37:28 -0800
Subject: [PATCH 1/3] arm64: ptdump: use static initializers for vmemmap
 region boundaries
In-Reply-To: <20160222113310.GB3435@leverpostej>
References: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456135239-3607-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160222113310.GB3435@leverpostej>
Message-ID: <56CB6378.9090207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2016 03:33 AM, Mark Rutland wrote:
> Hi,
>
> On Mon, Feb 22, 2016 at 11:00:37AM +0100, Ard Biesheuvel wrote:
>> There is no need to initialize the vmemmap region boundaries dynamically,
>> since they are compile time constants. So just add these constants to the
>> global struct initializer, and drop the dynamic assignment and related code.
>
> This does look nicer.
>
> I believe the intention here was to mark the end of the _populated_
> vmemmap region rather than the static VA carveout, so this is a slight
> change in behaviour.
>
> However, I don't think we gained much by only handling the populated
> region, and we didn't do the same for the linear map. So FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Yes, I implemented it off of the existing calculation for printing in
init.c which at the time was static. Going the full range does match
up better with the rest of the markers.

Acked-by: Laura Abbott <labbott@redhat.com>
  
> Mark.
>
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>   arch/arm64/mm/dump.c | 47 +++++---------------
>>   1 file changed, 12 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
>> index 6be918478f85..eadcb70e733c 100644
>> --- a/arch/arm64/mm/dump.c
>> +++ b/arch/arm64/mm/dump.c
>> @@ -34,37 +34,21 @@ struct addr_marker {
>>   	const char *name;
>>   };
>>
>> -enum address_markers_idx {
>> -	MODULES_START_NR = 0,
>> -	MODULES_END_NR,
>> -	VMALLOC_START_NR,
>> -	VMALLOC_END_NR,
>> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -	VMEMMAP_START_NR,
>> -	VMEMMAP_END_NR,
>> -#endif
>> -	FIXADDR_START_NR,
>> -	FIXADDR_END_NR,
>> -	PCI_START_NR,
>> -	PCI_END_NR,
>> -	KERNEL_SPACE_NR,
>> -};
>> -
>>   static struct addr_marker address_markers[] = {
>> -	{ MODULES_VADDR,	"Modules start" },
>> -	{ MODULES_END,		"Modules end" },
>> -	{ VMALLOC_START,	"vmalloc() Area" },
>> -	{ VMALLOC_END,		"vmalloc() End" },
>> +	{ MODULES_VADDR,		"Modules start" },
>> +	{ MODULES_END,			"Modules end" },
>> +	{ VMALLOC_START,		"vmalloc() Area" },
>> +	{ VMALLOC_END,			"vmalloc() End" },
>>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -	{ 0,			"vmemmap start" },
>> -	{ 0,			"vmemmap end" },
>> +	{ (u64)vmemmap,			"vmemmap start" },
>> +	{ (u64)vmemmap + VMEMMAP_SIZE,	"vmemmap end" },
>>   #endif
>> -	{ FIXADDR_START,	"Fixmap start" },
>> -	{ FIXADDR_TOP,		"Fixmap end" },
>> -	{ PCI_IO_START,		"PCI I/O start" },
>> -	{ PCI_IO_END,		"PCI I/O end" },
>> -	{ PAGE_OFFSET,		"Linear Mapping" },
>> -	{ -1,			NULL },
>> +	{ FIXADDR_START,		"Fixmap start" },
>> +	{ FIXADDR_TOP,			"Fixmap end" },
>> +	{ PCI_IO_START,			"PCI I/O start" },
>> +	{ PCI_IO_END,			"PCI I/O end" },
>> +	{ PAGE_OFFSET,			"Linear Mapping" },
>> +	{ -1,				NULL },
>>   };
>>
>>   /*
>> @@ -349,13 +333,6 @@ static int ptdump_init(void)
>>   			for (j = 0; j < pg_level[i].num; j++)
>>   				pg_level[i].mask |= pg_level[i].bits[j].mask;
>>
>> -#ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -	address_markers[VMEMMAP_START_NR].start_address =
>> -				(unsigned long)virt_to_page(PAGE_OFFSET);
>> -	address_markers[VMEMMAP_END_NR].start_address =
>> -				(unsigned long)virt_to_page(high_memory);
>> -#endif
>> -
>>   	pe = debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
>>   				 &ptdump_fops);
>>   	return pe ? 0 : -ENOMEM;
>> --
>> 2.5.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

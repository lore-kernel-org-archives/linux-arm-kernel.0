From: yuanzhichang@hisilicon.com (yuanzhichang)
Date: Fri, 27 Mar 2015 13:08:49 +0800
Subject: [PATCH v1] arm64:mm: enable the kernel execute attribute for
 HEAD_TEXT segment
In-Reply-To: <20150326221014.GA1696@flaeskesteg-linux.aus.arm.com>
References: <1427378028-126465-1-git-send-email-yuanzhichang@hisilicon.com>
 <20150326221014.GA1696@flaeskesteg-linux.aus.arm.com>
Message-ID: <5514E5E1.8010702@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark



On 2015/3/27 6:10, Mark Rutland wrote:
> On Thu, Mar 26, 2015 at 01:53:48PM +0000, Zhichang Yuan wrote:
>> From: yuanzhichang <yuanzhichang@hisilicon.com>
>>
>> In the patch whose title is "add better page protections to arm64"
>> (commit da141706aea52c1a9fbd28cb8d289b78819f5436), The direct mapping
>> page table entries for HEAD_TEXT segment were configured as PAGE_KERNEL,
>> without the executable attribute. But when the secondary CPUs are booting
>> based on spin-table mechanism, some functions in head.S are needed to run.
>
> In mainline today, the only functions I see in head.S before the .section
> change (and hence are not executable) are:
>
> * stext
> * __vet_fdt
> * __create_page_tables
> * __mmap_switched
>
> These are never executed by secondary CPUs. So your problem does not seem to be
> related to functions falling withing HEAD_TEXT -- all other functions in head.S
> are placed in .text, and thus will be executable regardless.
>

Yes. It is my fault. We had not used the new kernel version to do the 
test. The functions needed for secondary CPUs and CPU restarting are not 
put into the text section. I checked the head.S in the source tree for 
our board, there is no this instruction in head.S:
	.section ".text","ax"

Thank you very much!

Sorry for the disturbance caused by this patch:(

-Zhichang

-

> If you had a problem with spin-table, then I don't see why it wouldn't also
> apply to PSCI -- in both cases we go via secondary_startup before we enable the
> MMU.
>
> So I suspect that you have another bug, and some layout change (or difference
> in maintenance) is masking that when the better protections are enabled. It's
> also possible that we have a bug in the logic updating the page tables.
>
> Have you actually seen an issue, or was this theoretical?
>
> What exactly do you see happen when booting secondary CPUs?
>
> Do you see the issue in mainline?
>
>> Only PAGE_KERNEL dosen't work for this case.
>> This patch will configure the page attributes as PAGE_KERNEL_EXEC for
>> HEAD_TEXT segment.
>
> I don't see how this should be necessary.  All the text in that section should
> only be executed on the first CPU, prior to permissions being applied, and
> prior to the MMU being enabled.
>
>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> ---
>>   arch/arm64/mm/mmu.c | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index c6daaf6..ad08dfd 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -305,8 +305,8 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
>>   	 * for now. This will get more fine grained later once all memory
>>   	 * is mapped
>>   	 */
>> -	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
>> -	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>> +	phys_addr_t kernel_x_start = round_down(__pa(_text), SECTION_SIZE);
>> +	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>
> As mentioned above, none of the text in this section needs to be run with the
> MMU on. So I don't think this is necessary.
>
>>
>>   	if (end < kernel_x_start) {
>>   		create_mapping(start, __phys_to_virt(start),
>> @@ -315,6 +315,18 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
>>   		create_mapping(start, __phys_to_virt(start),
>>   			end - start, PAGE_KERNEL);
>>   	} else {
>> +	/*
>> +	 * At this moment, the text segment must reside in valid physical
>> +	 * memory section range to make sure the text are totally mapped.
>> +	 * If mapping from non-section aligned address is support, then
>> +	 * _text can be used here directly in replace to kernel_x_start.
>> +	 */
>> +		phys_addr_t max_left, min_right;
>> +
>> +		max_left = max(kernel_x_start, start);
>> +		min_right = min(kernel_x_end, end);
>> +		BUG_ON(max_left != kernel_x_start || min_right != kernel_x_end);
>
> Huh?
>
> Mark.
>
> .
>

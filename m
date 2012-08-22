From: mnalajal@codeaurora.org (Murali Nalajala)
Date: Wed, 22 Aug 2012 12:11:10 +0530
Subject: ioremap() fail on physical address 0x0 in 3.4 kernel
In-Reply-To: <5033C428.2050607@codeaurora.org>
References: <50339AF6.1060601@codeaurora.org> <5033C428.2050607@codeaurora.org>
Message-ID: <50347F06.9010902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/2012 10:53 PM, Laura Abbott wrote:
> On 8/21/2012 7:28 AM, Murali Nalajala wrote:
>> Hi All,
>> I am doing a below call in my driver to get the virtual address
>> equivalent to physical address 0x0.
>>
>> pdata->v_addr = ioremap(pdata->p_addr, PAGE_SIZE); /* pdata->p_addr=0 */
>>
>> Above call returns me a valid virtual address i.e: 0xfa200000. After
>> that when i try to access the address i am getting a kernel panic like
>> below.
>
> <snip>
>
>> [ 0.161784] ioremap: pfn=0x0 phys=0x0 offset=0x0 size=0x1000
>> [ 0.161813] ioremap: area da0fbdc0: phys_addr=0xc0100000 pfn=0xc0100
>> size=0x1000
>> [ 0.161838] ioremap: area da0fbe20: phys_addr=0xa8600000 pfn=0xa8600
>> size=0x1000
>> [ 0.161861] ioremap: area da0fbd80: phys_addr=0xc0000000 pfn=0xc0000
>> size=0x1000
>> [ 0.161886] ioremap: area da0fbda0: phys_addr=0xc0100000 pfn=0xc0100
>> size=0x1000
>> [ 0.161909] ioremap: area da0fbde0: phys_addr=0xa9200000 pfn=0xa9200
>> size=0x1000
>> [ 0.161933] ioremap: area da0fbe00: phys_addr=0xa9300000 pfn=0xa9300
>> size=0x1000
>> [ 0.161956] ioremap: area da0fbd40: phys_addr=0x0 pfn=0x0 size=0x100000
>> [ 0.161979] ioremap: found: addr fa200000 => 0xfa200000 => 0xfa200000
>> [ 0.161999] *** reset_vector = 0xfa200000
>>
>>
>> Can someone know me what is wrong in ioremap call?
>> Why i am not seeing a crash after i commented out the loop above?
>>
>
> Looks like you are hitting the empty section gap:
>
> 0xfa200000-0xfa300000 1048576 pmd_empty_section_gap+0x0/0x3c ioremap
>
> pmd_empty_section_gap ends up with vm->phys_addr = 0x0 because it was
> never set. This section isn't actually mapped so when searching for the
> range in the static io map it finds this address and returns it but it
> isn't actually a valid address to return. Perhaps ioremap should not
> bother trying to re-use the static iomap if the address is zero and let
> pmd_empty_section_gap use 0x0 as a dummy value?
>
>
>
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -228,7 +228,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned
> long pfn,
> */
> read_lock(&vmlist_lock);
> for (area = vmlist; area; area = area->next) {
> - if (!size || (sizeof(phys_addr_t) == 4 && pfn >= 0x100000))
> + if (!size || !pfn || (sizeof(phys_addr_t) == 4 &&
> + pfn >= 0x100000))
> break;
> if (!(area->flags & VM_ARM_STATIC_MAPPING))
> continue;
>
>
>
>>
>> Thanks,
>> Murali N
>>
>
> Thanks,
> Laura
>

Hi Nicolas,
Laura's code helps me to resolve the issue. But not sure of side effects 
of this change and other implications.

If the above changes are ok, can you please provide the ack.

Thanks,
Murali N

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

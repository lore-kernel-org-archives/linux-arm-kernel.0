From: hejianet@gmail.com (Jia He)
Date: Wed, 22 Aug 2018 09:38:51 +0800
Subject: [RESEND PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary
 search in memblock_next_valid_pfn()
In-Reply-To: <20180821140829.7d804678e9db8725f52180c2@linux-foundation.org>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-4-git-send-email-hejianet@gmail.com>
 <61ca29b9-a985-cce0-03e9-d216791c802c@microsoft.com>
 <334337ca-811e-4a2e-09ff-65ebe37ef6df@gmail.com>
 <20180821140829.7d804678e9db8725f52180c2@linux-foundation.org>
Message-ID: <5b9ed490-9e17-70ac-6b03-7ae5c6ea7b87@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

On 8/22/2018 5:08 AM, Andrew Morton Wrote:
> On Tue, 21 Aug 2018 14:14:30 +0800 Jia He <hejianet@gmail.com> wrote:
> 
>> Hi Pasha
>>
>> On 8/17/2018 9:08 AM, Pasha Tatashin Wrote:
>>>
>>>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>>>> ---
>>>>  mm/memblock.c | 37 +++++++++++++++++++++++++++++--------
>>>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>>> index ccad225..84f7fa7 100644
>>>> --- a/mm/memblock.c
>>>> +++ b/mm/memblock.c
>>>> @@ -1140,31 +1140,52 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>>>>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>>>  
>>>>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
>>>> +static int early_region_idx __init_memblock = -1;
>>>
>>> One comment:
>>>
>>> This should be __initdata, but even better bring it inside the function
>>> as local static variable.
>>>
>> Seems it should be __initdata_memblock instead of __initdata?
>>
> 
> Eh, it's 4 bytes.
> 
> It should however be local to the sole function which uses it.

Sorry, I am not clear for this comment^
early_region_idx records the *last* valid region idx in last
memblock_next_valid_pfn. So it should be static instead of local variable?

> 
> And what's this "ulong" thing?  mm/ uses unsigned long.

ok, will change it

-- 
Cheers,
Jia
> 
> --- a/mm/memblock.c~mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn-fix
> +++ a/mm/memblock.c
> @@ -1232,15 +1232,15 @@ int __init_memblock memblock_set_node(ph
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>  
>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> -static int early_region_idx __init_memblock = -1;
> -ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
> +unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>  {
>  	struct memblock_type *type = &memblock.memory;
>  	struct memblock_region *regions = type->regions;
>  	uint right = type->cnt;
>  	uint mid, left = 0;
> -	ulong start_pfn, end_pfn, next_start_pfn;
> +	unsigned long start_pfn, end_pfn, next_start_pfn;
>  	phys_addr_t addr = PFN_PHYS(++pfn);
> +	static int early_region_idx __initdata_memblock = -1;
>  
>  	/* fast path, return pfn+1 if next pfn is in the same region */
>  	if (early_region_idx != -1) {
> --- a/include/linux/mmzone.h~mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn-fix
> +++ a/include/linux/mmzone.h
> @@ -1269,7 +1269,7 @@ static inline int pfn_present(unsigned l
>  
>  #define early_pfn_valid(pfn)	pfn_valid(pfn)
>  #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> -extern ulong memblock_next_valid_pfn(ulong pfn);
> +extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>  #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
>  #endif
>  void sparse_init(void);
> _
> 
> 

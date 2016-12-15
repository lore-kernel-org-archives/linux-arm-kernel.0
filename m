From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Thu, 15 Dec 2016 11:01:04 +0800
Subject: [PATCH] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <20161214094542.GE5588@rric.localdomain>
References: <1481307042-29773-1-git-send-email-rrichter@cavium.com>
 <83d6e6d0-cfb3-ec8b-241b-ec6a50dc2aa9@huawei.com>
 <9168b603-04aa-4302-3197-00f17fb336bd@huawei.com>
 <20161214094542.GE5588@rric.localdomain>
Message-ID: <4bc9df75-1b67-2428-184e-ce52b5f95528@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Robert,

On 2016/12/14 17:45, Robert Richter wrote:
> On 12.12.16 17:53:02, Yisheng Xie wrote:
>> It seems that memblock_is_memory() is also too strict for early_pfn_valid,
>> so what about this patch, which use common pfn_valid as early_pfn_valid
>> when CONFIG_HAVE_ARCH_PFN_VALID=y:
>> ------------
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 0f088f3..9d596f3 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1200,7 +1200,17 @@ static inline int pfn_present(unsigned long pfn)
>>  #define pfn_to_nid(pfn)                (0)
>>  #endif
>>
>> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
>> +static inline int early_pfn_valid(unsigned long pfn)
>> +{
>> +       if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>> +               return 0;
>> +       return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
>> +}
> 
> I sent a V2 patch that uses pfn_present(). This only initilizes
> sections with memory.
hmm? maybe I do not quite catch what your mean, but I do not think
pfn_present is right for this case.

IMO, The valid_section() means the section with mem_map, not section with memory.

And:
    pfn_present
        -> present_section
which means the section is present but may not have mem_map, so it may not
have page struct at all for that section.

Please let me know, if I miss anything.

Thanks,
Yisheng Xie.


> 
> -Robert
> 
>> +#define early_pfn_valid early_pfn_valid
>> +#else
>>  #define early_pfn_valid(pfn)   pfn_valid(pfn)
>> +#endif
>>  void sparse_init(void);
>>  #else
>>  #define sparse_init()  do {} while (0)
>>
>>
>>
> 
> 

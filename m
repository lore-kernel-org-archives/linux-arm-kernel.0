From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 12 Dec 2016 17:53:02 +0800
Subject: [PATCH] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <83d6e6d0-cfb3-ec8b-241b-ec6a50dc2aa9@huawei.com>
References: <1481307042-29773-1-git-send-email-rrichter@cavium.com>
 <83d6e6d0-cfb3-ec8b-241b-ec6a50dc2aa9@huawei.com>
Message-ID: <9168b603-04aa-4302-3197-00f17fb336bd@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Robert,

On 2016/12/12 11:12, Yisheng Xie wrote:
> hi Robert,
> 
> On 2016/12/10 2:10, Robert Richter wrote:
>> On ThunderX systems with certain memory configurations we see the
>> following BUG_ON():
>>
>>  kernel BUG at mm/page_alloc.c:1848!
>>
>> This happens for some configs with 64k page size enabled. The BUG_ON()
>> checks if start and end page of a memmap range belongs to the same
>> zone.
>>
>> The BUG_ON() check fails if a memory zone contains NOMAP regions. In
>> this case the node information of those pages is not initialized. This
>> causes an inconsistency of the page links with wrong zone and node
>> information for that pages. NOMAP pages from node 1 still point to the
>> mem zone from node 0 and have the wrong nid assigned.
>>
> The patch can work for zone contains NOMAP regions.
> 
> However, if BIOS do not add WB/WT/WC attribute to a physical address range, the
> is_memory(md) will return false and this range will not be added to memblock.
>    efi_init
>       -> reserve_regions
>             if (is_memory(md)) {
>                 early_init_dt_add_memory_arch(paddr, size);
> 
>                 if (!is_usable_memory(md))
>                     memblock_mark_nomap(paddr, size);
>             }
> 
> Then BUG_ON() check will also fails. Any idea about it?
> 
It seems that memblock_is_memory() is also too strict for early_pfn_valid,
so what about this patch, which use common pfn_valid as early_pfn_valid
when CONFIG_HAVE_ARCH_PFN_VALID=y:
------------
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0f088f3..9d596f3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1200,7 +1200,17 @@ static inline int pfn_present(unsigned long pfn)
 #define pfn_to_nid(pfn)                (0)
 #endif

+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+static inline int early_pfn_valid(unsigned long pfn)
+{
+       if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
+               return 0;
+       return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
+}
+#define early_pfn_valid early_pfn_valid
+#else
 #define early_pfn_valid(pfn)   pfn_valid(pfn)
+#endif
 void sparse_init(void);
 #else
 #define sparse_init()  do {} while (0)

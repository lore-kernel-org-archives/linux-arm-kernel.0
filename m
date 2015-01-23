From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 23 Jan 2015 10:05:48 +0100
Subject: [PATCHv2] mm: Don't offset memmap for flatmem
In-Reply-To: <54C196D0.6040900@codeaurora.org>
References: <1421804273-29947-1-git-send-email-lauraa@codeaurora.org>	<1421888500-24364-1-git-send-email-lauraa@codeaurora.org>
 <20150122162021.aa861aeb53c22206a19ebbcb@linux-foundation.org>
 <54C196D0.6040900@codeaurora.org>
Message-ID: <54C20EEC.1060809@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2015 01:33 AM, Laura Abbott wrote:
> On 1/22/2015 4:20 PM, Andrew Morton wrote:
>> On Wed, 21 Jan 2015 17:01:40 -0800 Laura Abbott <lauraa@codeaurora.org> wrote:
>>
>>> Srinivas Kandagatla reported bad page messages when trying to
>>> remove the bottom 2MB on an ARM based IFC6410 board
>>>
>>> BUG: Bad page state in process swapper  pfn:fffa8
>>> page:ef7fb500 count:0 mapcount:0 mapping:  (null) index:0x0
>>> flags: 0x96640253(locked|error|dirty|active|arch_1|reclaim|mlocked)
>>> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>> bad because of flags:
>>> flags: 0x200041(locked|active|mlocked)
>>> Modules linked in:
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 3.19.0-rc3-00007-g412f9ba-dirty #816
>>> Hardware name: Qualcomm (Flattened Device Tree)
>>> [<c0218280>] (unwind_backtrace) from [<c0212be8>] (show_stack+0x20/0x24)
>>> [<c0212be8>] (show_stack) from [<c0af7124>] (dump_stack+0x80/0x9c)
>>> [<c0af7124>] (dump_stack) from [<c0301570>] (bad_page+0xc8/0x128)
>>> [<c0301570>] (bad_page) from [<c03018a8>] (free_pages_prepare+0x168/0x1e0)
>>> [<c03018a8>] (free_pages_prepare) from [<c030369c>] (free_hot_cold_page+0x3c/0x174)
>>> [<c030369c>] (free_hot_cold_page) from [<c0303828>] (__free_pages+0x54/0x58)
>>> [<c0303828>] (__free_pages) from [<c030395c>] (free_highmem_page+0x38/0x88)
>>> [<c030395c>] (free_highmem_page) from [<c0f62d5c>] (mem_init+0x240/0x430)
>>> [<c0f62d5c>] (mem_init) from [<c0f5db3c>] (start_kernel+0x1e4/0x3c8)
>>> [<c0f5db3c>] (start_kernel) from [<80208074>] (0x80208074)
>>> Disabling lock debugging due to kernel taint
>>>
>>> Removing the lower 2MB made the start of the lowmem zone to no longer
>>> be page block aligned. IFC6410 uses CONFIG_FLATMEM where
>>> alloc_node_mem_map allocates memory for the mem_map. alloc_node_mem_map
>>> will offset for unaligned nodes with the assumption the pfn/page
>>> translation functions will account for the offset. The functions for
>>> CONFIG_FLATMEM do not offset however, resulting in overrunning
>>> the memmap array. Just use the allocated memmap without any offset
>>> when running with CONFIG_FLATMEM to avoid the overrun.
>>>
>>
>> I don't think v2 addressed Vlastimil's review comment?
>>
>
> We're still adding the offset to node_mem_map and then subtracting it from
> just mem_map. Did I miss another comment somewhere?

Yes that was addressed, thanks. But I don't feel comfortable acking it 
yet, as I have no idea if we are doing the right thing for 
CONFIG_HAVE_MEMBLOCK_NODE_MAP && CONFIG_FLATMEM case here.

Also putting the CONFIG_FLATMEM && !CONFIG_HAVE_MEMBLOCK_NODE_MAP under 
the "if (page_to_pfn(mem_map) != pgdat->node_start_pfn)" will probably 
do the right thing, but looks like a weird test for this case here.

I have no good suggestion though, so let's CC Mel who apparently wrote 
the ARCH_PFN_OFFSET correction?

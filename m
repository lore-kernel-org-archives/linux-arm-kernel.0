From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 12 Apr 2016 23:03:41 +0900
Subject: [PATCH 1/2] arm64: mem-model: add flatmem model for arm64
In-Reply-To: <570B10B2.2000000@hisilicon.com>
References: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
 <20160407142148.GI5657@arm.com> <570B10B2.2000000@hisilicon.com>
Message-ID: <BB685A51-165C-424C-8359-58F7F3E379B7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 11, 2016, at 11:49 AM, Chen Feng wrote:

Dear Chen,

> Hi will,
> Thanks for review.
> 
> On 2016/4/7 22:21, Will Deacon wrote:
>> On Tue, Apr 05, 2016 at 04:22:51PM +0800, Chen Feng wrote:
>>> We can reduce the memory allocated at mem-map
>>> by flatmem.
>>> 
>>> currently, the default memory-model in arm64 is
>>> sparse memory. The mem-map array is not freed in
>>> this scene. If the physical address is too long,
>>> it will reserved too much memory for the mem-map
>>> array.
>> 
>> Can you elaborate a bit more on this, please? We use the vmemmap, so any
>> spaces between memory banks only burns up virtual space. What exactly is
>> the problem you're seeing that makes you want to use flatmem (which is
>> probably unsuitable for the majority of arm64 machines).
>> 
> The root cause we want to use flat-mem is the mam_map alloced in sparse-mem
> is not freed.
> 
> take a look at here:
> arm64/mm/init.c
> void __init mem_init(void)
> {
> #ifndef CONFIG_SPARSEMEM_VMEMMAP
> 	free_unused_memmap();
> #endif
> }
> 
> Memory layout (3GB)
> 
> 0             1.5G    2G             3.5G            4G
> |              |      |               |              |
> +--------------+------+---------------+--------------+
> |    MEM       | hole |     MEM       |   IO (regs)  |
> +--------------+------+---------------+--------------+
> 
> 
> Memory layout (4GB)
> 
> 0                                    3.5G            4G    4.5G
> |                                     |              |       |
> +-------------------------------------+--------------+-------+
> |                   MEM               |   IO (regs)  |  MEM  |
> +-------------------------------------+--------------+-------+
> 
> Currently, the sparse memory section is 1GB.
> 
> 3GB ddr: the 1.5 ~2G and 3.5 ~ 4G are holes.
> 3GB ddr: the 3.5 ~ 4G and 4.5 ~ 5G are holes.
> 
> This will alloc 1G/4K * (struct page) memory for mem_map array.
> 
> We want to use flat-mem to reduce the alloced mem_map.
> 
> I don't know why you tell us the flatmem is unsuitable for the
> majority of arm64 machines. Can tell us the reason of it?
> 
> And we are not going to limit the memdel in arm64, we just want to
> make the flat-mem is an optional item in arm64.

I've experienced the same problem and considered the ideas mentioned
in this thread: flatmem and small SECTION_SIZE_BITS. However, I was
reluctant to post any patch since the issue is highly related to memory
map design document, [1], saying 1GB aligned RAM. The majority of arm64
platforms might follow the information although it is not spec. IOW,
a machine I've played was at least unusual *at that time*, so I didn't
consider upstream work.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0001c/DEN0001C_principles_of_arm_memory_maps.pdf  

Best Regards
Jungseok Lee

From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 31 Mar 2014 12:51:07 +0900
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
Message-ID: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All

Current ARM64 kernel cannot support 4KB pages for 40-bit physical address
space described in [1] due to one major issue + one minor issue.

Firstly, kernel logical memory map (0xffffffc000000000-0xffffffffffffffff)
cannot cover DRAM region from 544GB to 1024GB in [1]. Specifically, ARM64
kernel fails to create mapping for this region in map_mem function
(arch/arm64/mm/mmu.c) since __phys_to_virt for this region reaches to
address overflow. I've used 3.14-rc8+Fast Models to validate the statement.

Secondly, vmemmap space is not enough to cover over about 585GB physical
address space. Fortunately, this issue can be resolved as utilizing an extra
vmemmap space (0xffffffbe00000000-0xffffffbffbbfffff) in [2]. However,
it would not cover systems having a couple of terabytes DRAM.

Therefore, it would be needed to implement 4 level page table translations
for 4KB pages on 40-bit physical address space platforms. Someone might
suggest use of 64KB pages in this case, but I'm not sure about how to
deal with internal memory fragmentation.

I would like to contribute 4 level page table translations to upstream,
the target of which is 3.16 kernel, if there is no movement on it. I saw
some related RFC patches a couple of months ago, but they didn't seem to 
be merged into maintainer's tree.


Best Regards
Jungseok Lee


References
----------
[1]: Principles of ARM Memory Maps, Whit Paper, Issue C

[2]: Documentation/arm64/memory.txt

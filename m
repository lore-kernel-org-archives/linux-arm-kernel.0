From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 14 Mar 2013 16:05:27 -0700
Subject: gen_pool_add broken with LPAE based systems
Message-ID: <514257B7.5080206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We use genalloc for managing certain pools of physical memory. genalloc 
currently uses unsigned long for virtual addresses and phys_addr_t for 
physical addresses. Our ARM LPAE systems have 64-bit physical addresses 
but unsigned long is still 32 bits.  Using gen_pool_add breaks with 
addresses > 4G because gen_pool_add treats the address passed in as the 
virtual address. gen_pool allocates internally based on the 32 bit 
virtual address as well so everything is broken if we want to be able to 
manage the full address space after 4G. I see a couple of options:

1) Change gen_pool_add to use physical addresses and allocate based on 
physical addresses instead of virtual addresses
2) Change the virtual address to be a 64 bit type or something 
selectable to a 64 bit type.
3) Allow a flag per pool to select whether the allocator is virtual or 
physical and switch between those.
4) Split the APIs into virtual <-> physical and physical only and have 
separate types for each.

Any of these suggestions seem reasonable or is there another option to 
consider?

Thanks,
Laura
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

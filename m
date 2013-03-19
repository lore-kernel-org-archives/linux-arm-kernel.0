From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 19 Mar 2013 14:54:24 -0700
Subject: gen_pool_add broken with LPAE based systems
In-Reply-To: <514257B7.5080206@codeaurora.org>
References: <514257B7.5080206@codeaurora.org>
Message-ID: <20130319145424.8711f4c1b23fb457d2611007@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Mar 2013 16:05:27 -0700 Laura Abbott <lauraa@codeaurora.org> wrote:

> Hi,
> 
> We use genalloc for managing certain pools of physical memory. genalloc 
> currently uses unsigned long for virtual addresses and phys_addr_t for 
> physical addresses. Our ARM LPAE systems have 64-bit physical addresses 
> but unsigned long is still 32 bits.  Using gen_pool_add breaks with 
> addresses > 4G because gen_pool_add treats the address passed in as the 
> virtual address. gen_pool allocates internally based on the 32 bit 
> virtual address as well so everything is broken if we want to be able to 
> manage the full address space after 4G. I see a couple of options:

The above only makes sense if ARM LPAE has 64-bit (actually >= 33-bit)
virtual addresses.  If so, I don't understand how ARM LPAE can work at
all - the core MM assumes that addresses-fit-in-ulongs in eleventy
trillion places.

I think we need a better description of the problem, please.

> 1) Change gen_pool_add to use physical addresses and allocate based on 
> physical addresses instead of virtual addresses
> 2) Change the virtual address to be a 64 bit type or something 
> selectable to a 64 bit type.
> 3) Allow a flag per pool to select whether the allocator is virtual or 
> physical and switch between those.
> 4) Split the APIs into virtual <-> physical and physical only and have 
> separate types for each.
> 
> Any of these suggestions seem reasonable or is there another option to 
> consider?

2) sounds least intrusive but I can't think with my head spinning so fast.

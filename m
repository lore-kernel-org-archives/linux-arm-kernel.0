From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 14:57:08 +0000
Subject: [RFC 07/11] ARM: Allocate ZERO_PAGE from highmem
In-Reply-To: <551619d0fd5153ca4a5e1821aea8d867d9581c9a.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<551619d0fd5153ca4a5e1821aea8d867d9581c9a.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <20091204145708.GA20386@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2009 at 10:59:08AM +0000, Russell King wrote:
> The zero page does not need to be in low memory, so allocate it from
> high memory.

Unfortunately, this patch is about to be thrown out - mm/shmem.c does
this:

static inline void shmem_swp_balance_unmap(void)
{
	/*
	 * When passing a pointer to an i_direct entry, to code which
	 * also handles indirect entries and so will shmem_swp_unmap,
	 * we must arrange for the preempt count to remain in balance.
	 * What kmap_atomic of a lowmem page does depends on config
	 * and architecture, so pretend to kmap_atomic some lowmem page.
	 */
	(void) kmap_atomic(ZERO_PAGE(0), KM_USER1);
}

which causes:

               callsite vaddr      pteptr    *pteptr    page_to_phys(page)
kmap_atomic:   c007d108 0xfff04000 c046ac10, 0x00000000 0x7800000
kunmap_atomic: c007d88c 0xc1c2a000
kmap_atomic:   c007d108 0xfff04000 c046ac10, 0x078002cf 0x7800000
*BUG*

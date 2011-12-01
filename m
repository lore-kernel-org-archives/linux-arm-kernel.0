From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 23:55:52 +0000
Subject: [PATCH] ARM: put memblock stuff into init sections
In-Reply-To: <1322778290-32536-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1322778290-32536-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111201235552.GJ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:24:50PM +0100, Uwe Kleine-K?nig wrote:
> memblock is only used during early boot for ARM, so the function and
> data can safely go into the init sections.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

NAK, for several reasons.  Tejun has a patch whose description starts
with this:

| 24aa07882b (memblock, x86: Replace memblock_x86_reserve/free_range()
| with generic ones) removed arch/x86/include/asm/memblock.h and dropped
| its inclusion from include/linux/memblock.h which breaks other
| architectures which depended on the generic memblock.h pulling in the
| arch specific one.

so, this definition in our asm/memblock.h won't have any effect for much
longer.

Second reason: defining this discards the memblock arrays.  Now look at
this:

#ifdef CONFIG_HAVE_ARCH_PFN_VALID
int pfn_valid(unsigned long pfn)
{
        return memblock_is_memory(__pfn_to_phys(pfn));
}
EXPORT_SYMBOL(pfn_valid);
#endif

Third reason: my comment about memblock only being used during early boot
was made because that's the case for using it to do _allocations_, because
once memblock has passed the memory and reserved areas to bootmem, using
memblock _from that point_ means that bootmem will not be updated - and
that in turn means that the kernel's page allocator will also not be
updated correctly.

During boot, memory information is passed thusly:

atags or dt -> memblock -> bootmem -> page allocator

Ideally, we should get rid of bootmem from that sequence, which will make
things a little less complicated - but I believe this is not possible at
the moment due to our use of sparsemem, and iirc sparsemem depends on
certain aspects of bootmem.

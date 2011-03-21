From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 15:03:49 +0000
Subject: Revert "[ARM] pxa: remove now unnecessary dma_needs_bounce()"
In-Reply-To: <AANLkTin0hVKnicRtxLwxwPJZU6tYiuTZnbGUfxt9bLYe@mail.gmail.com>
References: <AANLkTin0hVKnicRtxLwxwPJZU6tYiuTZnbGUfxt9bLYe@mail.gmail.com>
Message-ID: <20110321150349.GC4340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2011 at 11:12:29PM -0700, Barry Song wrote:
> Hi Eric/Fujita/Russell,
> As i checked the "remove now unnecessary dma_needs_bounce()" patches
> of Eric, I found you were all involved. Due to compiling error of
> IXP4xx platforms, the patch was reverted by Russell in
> http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=commit;h=0485e18bc4112a3b548baa314c24bfbece4d156b
> 
> But I think Eric's patch made much sense. dma_needs_bounce() is very
> ambiguous in the whole arm arch, if devices use dma_mask right,
> map_single() will decide whether it needs DMA bounce by the following
> logic:
>         if (dev->dma_mask) {
>                 unsigned long mask = *dev->dma_mask;
>                 unsigned long limit;
> 
>                 limit = (mask + 1) & ~mask;
>                 if (limit && size > limit) {
>                         dev_err(dev, "DMA mapping too big (requested %#x "
>                                 "mask %#Lx)\n", size, *dev->dma_mask);
>                         return ~0;
>                 }
> 
>                 /*
>                  * Figure out if we need to bounce from the DMA mask.
>                  */
>                 needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;
>         }
> 
> Basically, we don't need dma_needs_bounce() for all chips at all. For
> saa1111, it is needed only because a bug in the SoC.
> For  assabet and pfs168 machines, it gave a workaound by self-defined
> a dma_needs_bounce function.
> return ((machine_is_assabet() || machine_is_pfs168()) &&
>                 (addr >= 0xc8000000 || (addr + size) >= 0xc8000000));

No, you don't understand what's a bug and what's a design issue.

The SA1111 (not SAA which would be a Phillips device) is designed to only
access one SDRAM chip.  From memory, the SA1110 can have up to four SDRAM
chips connected to it - at 0xc0000000, 0xc8000000, 0xd0000000, 0xd8000000
phys.

Depending on how the platform is wired up, the SA1111 can only access
memory from exactly _one_ of those banks.  It can _never_ access all of
those banks of memory.

However, as an entirely separate issue, the SA1111 has a bug in that it
incorrectly drives one of the SDRAM address inputs during part of the
access cycle, which if logic one causes the SDRAM to become confused.
This means that we end up with situations where odd MB of SDRAM are
unavailable for DMA, whereas even MB of SDRAM are perfectly fine.

So, not only do we need to ensure that we bounce any memory which is not
in the right bank, but also any memory which conflicts with the buggy
behaviour.

The buggy behaviour is dealt with setting an appropriate DMA mask,
which clears the problematical bit.  This would be legal if the DMA mask
was a mask, but it isn't - it's misnamed as its actually a DMA _limit_.

This is where the problem comes - a DMA limit can't incorporate the
information necessary to indicate which bank of SDRAM is accessible to
the SA1111 as it can't indicate that only the second bank should be
used for DMA.

This is exactly where dma_needs_bounce() comes in to provide this kind
of platform knowledge into the DMA bounce code - and I think trying to
remove the function is a big mistake.

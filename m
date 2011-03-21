From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 20 Mar 2011 23:12:29 -0700
Subject: Revert "[ARM] pxa: remove now unnecessary dma_needs_bounce()"
Message-ID: <AANLkTin0hVKnicRtxLwxwPJZU6tYiuTZnbGUfxt9bLYe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric/Fujita/Russell,
As i checked the "remove now unnecessary dma_needs_bounce()" patches
of Eric, I found you were all involved. Due to compiling error of
IXP4xx platforms, the patch was reverted by Russell in
http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=commit;h=0485e18bc4112a3b548baa314c24bfbece4d156b

But I think Eric's patch made much sense. dma_needs_bounce() is very
ambiguous in the whole arm arch, if devices use dma_mask right,
map_single() will decide whether it needs DMA bounce by the following
logic:
        if (dev->dma_mask) {
                unsigned long mask = *dev->dma_mask;
                unsigned long limit;

                limit = (mask + 1) & ~mask;
                if (limit && size > limit) {
                        dev_err(dev, "DMA mapping too big (requested %#x "
                                "mask %#Lx)\n", size, *dev->dma_mask);
                        return ~0;
                }

                /*
                 * Figure out if we need to bounce from the DMA mask.
                 */
                needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;
        }

Basically, we don't need dma_needs_bounce() for all chips at all. For
saa1111, it is needed only because a bug in the SoC.
For  assabet and pfs168 machines, it gave a workaound by self-defined
a dma_needs_bounce function.
return ((machine_is_assabet() || machine_is_pfs168()) &&
                (addr >= 0xc8000000 || (addr + size) >= 0xc8000000));

I think the right workaround for saa1111 should be setting dma_mask of
related devices to 0xc8000000 for the assabet and pfs168 machines but
not add a unnecessary APIs,  which will cause other SoCs need to
finish the function if they use dma bounce too.

Eric's path make much sense, we should delete the unnecessary
dma_needs_bounce() from the whole arm arch at all. If all related
people agree, we need another patch to fix it.

Thanks
Barry

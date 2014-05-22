From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 May 2014 17:09:08 +0100
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <5057707.jNCXlqf9dH@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5678119.IM3FN0FlT6@wuerfel> <20140522144503.GA27931@arm.com>
 <5057707.jNCXlqf9dH@wuerfel>
Message-ID: <20140522160908.GD27931@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 04:49:16PM +0100, Arnd Bergmann wrote:
> On Thursday 22 May 2014 15:45:03 Catalin Marinas wrote:
> > On Thu, May 22, 2014 at 09:31:37AM +0100, Arnd Bergmann wrote:
> > > commit 42c4dafe803dcad82980fd8b0831a89032156f93
> > > Author: Catalin Marinas <catalin.marinas@arm.com>
> > > Date:   Thu Jul 1 13:22:48 2010 +0100
> > > 
> > >     ARM: 6202/1: Do not ARM_DMA_MEM_BUFFERABLE on RealView boards with L210/L220
> > >     
> > >     RealView boards with certain revisions of the L210/L220 cache controller
> > >     may have issues (hardware deadlock) with the mandatory barriers (DSB
> > >     followed by an L2 cache sync) when ARM_DMA_MEM_BUFFERABLE is enabled.
> > >     The patch disables ARM_DMA_MEM_BUFFERABLE for these boards.
> > >     
> > >     Tested-by: Linus Walleij <linus.walleij@stericsson.com>
> > >     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > >     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Looking through the L220 errata document, I think this relates to 425331
> > which says that a cache sync can deadlock the system if the write buffer
> > is not empty.
> 
> Hmm, but isn't the write buffer empty here because we have just issued
> a dsb()?

The problem with these outer caches is that DSB doesn't propagate to
them (and I hope to never see such caches again ;)). So an mb() on such
systems needs to be dsb()+outer_sync(). The dsb() pushes data from the
CPU write buffer into the L2x0 write buffer and outer_sync() does the
flushing out of the outer cache write buffer (which strangely enough
buffers even if the memory access is Normal NonCacheable).

> > If we only use the DMA coherent buffers for CLCD on these boards, we
> > don't really need the outer_sync() either so we could go back to
> > bufferable DMA memory (strangely enough, this L2 cache workaround looks
> > similar to Marvell's PCI+PL310 problem where we want to avoid
> > outer_sync()).
> 
> Ah, so you think we can add another hook to NULL out outer_cache.sync
> per platform?

Yes, with the note that mb() no longer guarantees the write being
flushed to RAM but just to the L2 write buffer. If CLCD framebuffer is
the only DMA device, we don't need to worry about such barriers since we
map it as writecombine anyway (hence bufferable).

Unless Linus or Pawel think there are other DMA capable devices in use
here, I'm happy to enable ARM_DMA_MEM_BUFFERABLE for these boards.

-- 
Catalin

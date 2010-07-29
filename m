From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 29 Jul 2010 13:15:37 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100728212156.GA6729@n2100.arm.linux.org.uk>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<201007281950.20847.arnd@arndb.de>
	<20100728212156.GA6729@n2100.arm.linux.org.uk>
Message-ID: <20100729131500Q.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jul 2010 22:21:56 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jul 28, 2010 at 07:50:20PM +0200, Arnd Bergmann wrote:
> > The DMA API is extremely flexible, it works just fine with all the
> > IOMMUs that I've seen so far. Please take a look at
> > include/asm-generic/dma-mapping-common.h and its users to see how
> > to use multiple IOMMUs depending on the device.
> 
> We don't yet use those DMA API interface extensions because we haven't
> had the need.  If someone who has the need wants to put the effort in
> though...
> 
> One of the problems with it though is the abstraction of the sync*
> operations is the wrong way around for stuff like dmabounce - we want
> to be passed the base address of the buffer (so we can look this up),
> plus offset and length.  We don't want to know just the region which
> is affected.

We can't pass the base address because the DMA API callers don't pass
the base address for dma_sync_single_for_{device|cpu}.

dma_sync_single_range_for_* requires the base address but they are
obsolete.

So you need to fix dmabounce. Actually, I send you a patch to fix
dmabounce long ago (looks like not applied yet):

http://kerneltrap.org/mailarchive/linux-netdev/2010/4/5/6274046

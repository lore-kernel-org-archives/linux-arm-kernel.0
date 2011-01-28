From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Jan 2011 14:46:21 +0000
Subject: RAM bank with features
In-Reply-To: <AANLkTimDFdP7O3h9Zrx2gacqaBS=8TVfpeZP5cFX+T2e@mail.gmail.com>
References: <AANLkTimDFdP7O3h9Zrx2gacqaBS=8TVfpeZP5cFX+T2e@mail.gmail.com>
Message-ID: <20110128144621.GA18376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 05:28:29PM +0300, Sergey Mironov wrote:
> Hello, community. I am porting Linux to arm1176-based SoC. Our system
> has 2 RAM banks. First one (EM0) is quite common, but another (EM1)
> has some "features" :
> 1) Critical one. There are devices that can't use DMA buffers outside EM1.
> 2) CPU can read and write to it, but can't execute instructions.
> 
> What is the finest way of implementing those restrictions? I thought
> about defining custom memory zone, but I can't see how to link zones
> with platform_device.dev.dma_mask.

Sigh.  When will hardware people get the idea that adding silly
restrictions just makes things impossible.

1. You can't restrict the system such that code only executes from EM0
   and still use EM1 in the general memory pool.

2. You can only restrict DMA buffers from physical address zero to a
   limit determined by a bitmask in Linux.  If this means EM1 is at
   a lower physical address, you lose.

I think your best solution is going to be to totally ignore EM1, and tell
the hardware people that they're being silly.  It's really not worth the
hastle.

> Also, is it possible to allocate user pages from EM1 but prevent users
> from executing code from them? Say, tell allocator to mark them with
> L_PTE_* flag?

How would userspace programs execute their code if their pages were
allocated from EM1?

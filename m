From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 13:12:39 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <20110120130246.GA23941@n2100.arm.linux.org.uk>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
	<20110120130246.GA23941@n2100.arm.linux.org.uk>
Message-ID: <20110120131239.GB23941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 01:02:46PM +0000, Russell King - ARM Linux wrote:
> Strongly ordered requires no additional maintainence to ensure that writes
> to it are immediately visible to hardware.  However, ARMv6 and later
> requires a data synchronization barrier to ensure that writes to 'normal
> non-cachable' memory are visible before writes to 'device' memory complete.
> 
> >From what I can see, the driver does use writel() as does the DMA driver
> in arch/arm/mach-msm/dma.c, so there should be no problem with ARMv6 CPUs.

BTW, it looks like the work-around was added at the time when writel() did
not have the necessary barriers:

commit 56a8b5b8ae81bd766e527a0e5274a087c3c1109d
Author: San Mehat <san@google.com>
Date:   Sat Nov 21 12:29:46 2009 -0800

    mmc: msm_sdcc: Reduce command timeouts and improve reliability.

+       n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
+                       host->dma.num_ents, host->dma.dir);
+/* dsb inside dma_map_sg will write nc out to mem as well */
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    so we are talking about ARMv6 or later as previous versions did not
    have dsb.

vs

commit e936771a76a7b61ca55a5142a3de835c2e196871
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Wed Jul 28 22:00:54 2010 +0100

    ARM: 6271/1: Introduce *_relaxed() I/O accessors

commit 79f64dbf68c8a9779a7e9a25e0a9f0217a25b57a
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Wed Jul 28 22:01:55 2010 +0100

    ARM: 6273/1: Add barriers to the I/O accessors if ARM_DMA_MEM_BUFFERABLE

    When the coherent DMA buffers are mapped as Normal Non-cacheable
    (ARM_DMA_MEM_BUFFERABLE enabled), buffer accesses are no longer ordered
    with Device memory accesses causing failures in device drivers that do
    not use the mandatory memory barriers before starting a DMA transfer.
    LKML discussions led to the conclusion that such barriers have to be
    added to the I/O accessors:

    http://thread.gmane.org/gmane.linux.kernel/683509/focus=686153
    http://thread.gmane.org/gmane.linux.ide/46414
    http://thread.gmane.org/gmane.linux.kernel.cross-arch/5250

    This patch introduces a wmb() barrier to the write*() I/O accessors to
    handle the situations where Normal Non-cacheable writes are still in the
    processor (or L2 cache controller) write buffer before a DMA transfer
    command is issued. For the read*() accessors, a rmb() is introduced
    after the I/O to avoid speculative loads where the driver polls for a
    DMA transfer ready bit.

So the necessary barriers were found to be necessary way after MSM
discovered the problem.  It _is_ related to the ARMv6 weakly ordered
memory model, and it _was_ a bug in the ARM IO accessor implementation.

It would've been nice to have had the problem discussed at architecture
level so maybe the problem could've been found sooner and fixed earlier.

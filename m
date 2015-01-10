From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 10 Jan 2015 20:57:21 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <2707920.rUFmbmVqu6@wuerfel>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150110163001.GA5392@lunn.ch>
 <20150110175030.186ef929@free-electrons.com>
 <2707920.rUFmbmVqu6@wuerfel>
Message-ID: <20150110205721.6b3f71f8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Sat, 10 Jan 2015 19:56:59 +0100, Arnd Bergmann wrote:

> Despite my earlier analysis that concluded that the just using the
> normal coherent dma_ops with this fix was correct on all hardware,
> we have now seen a bug in the xor dmaengine driver (I haven't
> seen a confirmation for my oneline fix yet, but I still think it's
> the one), which gives us less confidence in the other drivers
> being correct.
> 
> I think that your patch is the only sensible approach going forward
> if we want coherent mappings, but we will need both more extensive
> testing and more review of each affected device driver before
> putting it into stable.

We will indeed need to do more extensive testing and review. However, I
don't agree that this should prevent this patch from going to stable:
the current situation in the kernel (and also past kernels) is known to
be broken: DMA coherent mappings allocated by dma_alloc_coherent() are
*not* coherent in the current situation. Writes made by the device to
the memory are not guaranteed to be immediately visible to the CPU,
unless an explicit I/O sync barrier is done, which obviously is never
done for DMA coherent mappings since those are assumed by Linux to be
coherent, and therefore not require any cache maintenance operation.

So, while I clearly agree that we haven't yet gotten to the bottom of
all problems, this patch is going in the right direction and making
things slightly better.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

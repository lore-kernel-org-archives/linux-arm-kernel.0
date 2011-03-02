From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Mar 2011 08:39:04 +0000
Subject: CONFIG_ARM_DMA_MEM_BUFFERABLE and readl/writel weirdness
In-Reply-To: <4D6D9C03.2080906@codeaurora.org>
References: <4D6D9C03.2080906@codeaurora.org>
Message-ID: <20110302083904.GA4493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 05:23:15PM -0800, Saravana Kannan wrote:
> If I'm not missing some magic, this would mean that  
> "CONFIG_ARM_DMA_MEM_BUFFERABLE" determines if readl(s)/writel(s) get to  
> have a built in mb() or not.

You're missing that CONFIG_ARM_DMA_MEM_BUFFERABLE not only changes
readl/writel but also the type for DMA coherent memory from strongly
ordered to memory, non-cacheable.

The barriers are required to ensure that reads and writes to DMA
coherent memory are visible to the DMA device before the write
completes, and any value read from DMA coherent memory will not
bypass a read from a DMA device.

The barriers in the IO macros have nothing to do with whether reads/writes
to normal cacheable memory are visible to DMA devices.  That is what the
streaming DMA API is for.

In any case, the IO macros are always ordered with respect to other
device writes irrespective of CONFIG_ARM_DMA_MEM_BUFFERABLE.

> There are so many other drivers that don't use or care about DMA and  
> might still want to ensure some ordering constraints between their  
> readl(s)/writel(s). They can't depend on readl/writel taking care of it  
> for them since their code could be used in a kernel configuration that  
> doesn't enable this config.

The majority of device drivers don't need ordering on their IO macros.
However, Linus refuses to introduce relaxed IO ordering to the kernel,
saying that architectures must reflect the x86 behaviour as much as
possible.

So, we're stuck with device drivers which use readl/writel both where
they don't need the ordering constraints _and_ where they do need the
ordering constraints.  That means we must provide the ordering in these
macros to ensure proper system functioning.

> Firstly, I don't know how many people noticed this and realize they  
> can't depend on readl/writel to take care of the mb()s for them. Seems  
> like an unnecessary encouragement to make mistakes when it didn't need  
> to be so.

I think you misunderstand what's going on.  IO accesses are always ordered
with respect to themselves.  The barriers are there to ensure ordering
between DMA coherent memory (normal non-cached memory) and IO accesses
(device).

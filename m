From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Sep 2012 20:47:33 +0100
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for
 clean and flush range
In-Reply-To: <1347890398-22088-1-git-send-email-robherring2@gmail.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120917194733.GQ12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 08:59:58AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> All but background ops are atomic on the pl310, so a spinlock is not
> needed for a cache sync if background operations are not used. Using
> background ops was an optimization for flushing large buffers, but that's
> not needed for platforms where i/o is coherent and/or that have a larger
> cache size than likely to flush at once. The cache sync spinlock is
> taken on every readl/writel and can be a bottleneck for code paths with
> register accesses.
> 
> The default behaviour is unchanged. Platforms can enable using atomic
> cache ops only by adding "arm,use-atomic-ops" to pl310 device-tree
> node.
> 
> It is assumed that remaining background ops are only used in non-SMP
> code paths.

(a) you're not describing hardware, you're describing a feature of the
    Linux kernel's implementation - no, you're describing a configuration
    feature of the kernel.  This should not be in DT.
(b) you're disabling the optimization to avoid doing a lengthy line-by-line
    cache operation when the size is larger than the cache size, and trading
    it for possibly slightly quicker accesses.

The problem I have with this is it's likely that you've only looked at
"oh, this makes IO accesses faster" and not the total picture wrt the
effect on time taken by the DMA API.

Plus, because there's little justification behind this patch (apart
from a vague reference to the speed of IO accesses) I'm going to say
NAK to this until further information is forthcoming justifying this
change.

In any case (a) applies whatever.  This is not hardware description,
this is implementation configuration which has nothing to do with DT.
Don't use DT as a dumping ground for implementation configuration.

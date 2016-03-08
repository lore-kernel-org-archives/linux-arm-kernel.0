From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Mar 2016 15:35:38 +0530
Subject: [linux-sunxi] Re: [PATCH] dma: sun4i: expose block size and wait
 cycle configuration to DMA users
In-Reply-To: <56DE9077.3020905@redhat.com>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160308075131.GE8418@lukather> <56DE9077.3020905@redhat.com>
Message-ID: <20160308100538.GO11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 09:42:31AM +0100, Hans de Goede wrote:
> <wild speculation>
> 
> I see 2 possible reasons why waiting till checking for drq can help:
> 
> 1) A lot of devices have an internal fifo hooked up to a single mmio data
> register which gets read using the general purpose dma-engine, it allows
> this fifo to fill, and thus do burst transfers
> (We've seen similar issues with the scanout engine for the display which
>  has its own dma engine, and doing larger transfers helps a lot).
> 
> 2) Physical memory on the sunxi SoCs is (often) divided into banks
> with a shared data / address bus doing bank-switches is expensive, so
> this wait cycles may introduce latency which allows a user of another
> bank to complete its RAM accesses before the dma engine forces a
> bank switch, which ends up avoiding a lot of (interleaved) bank switches
> while both try to access a different banj and thus waiting makes things
> (much) faster in the end (again a known problem with the display
> scanout engine).
> 
> </wild speculation>
> 
> Note the differences these kinda tweaks make can be quite dramatic,
> when using a 1920x1080p60 hdmi output on the A10 SoC with a 16 bit
> memory bus (real world worst case scenario), the memory bandwidth
> left for userspace processes (measured through memset) almost doubles
> from 48 MB/s to 85 MB/s, source:
> http://ssvb.github.io/2014/11/11/revisiting-fullhd-x11-desktop-performance-of-the-allwinner-a10.html
> 
> TL;DR: Waiting before starting DMA allows for doing larger burst
> transfers which ends up making things more efficient.
> 
> Given this, I really expect there to be other dma-engines which
> have some option to wait a bit before starting/unpausing a transfer
> instead of starting it as soon as (more) data is available, so I think
> this would make a good addition to dma_slave_config.

I tend to agree but before we do that I would like this hypothesis to be
confirmed :)

-- 
~Vinod

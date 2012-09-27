From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 12:48:05 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API
In-Reply-To: <20120925125758.GA16842@e102568-lin.cambridge.arm.com>
References: <20120925125758.GA16842@e102568-lin.cambridge.arm.com>
Message-ID: <20120927114805.GC14358@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 01:57:58PM +0100, Lorenzo Pieralisi wrote:
> Hi Russell,
> 
> I know it is coming quite late in the cycle but please consider pulling
> the patch series implementing the new cache maintenance LoUIS API, since
> it provides a stepping stone to implementing power management on upcoming
> A15 and A7 based platforms, leaving functionality for earlier processor
> versions unchanged.
> 
> It has been tested on:
> 
> - OMAP4/5
>   # suspend/hotplug and CPU idle
> - iMX6q
>   # suspend and hotplug
> - TC2 big.LITTLE testchip
>   # CPU idle

Ok, last night's PXA build regressed with this:

arch/arm/mm/built-in.o: In function `xscale_dma_unmap_area':
cache-xsc3l2.c:(.text+0x4194): undefined reference to `xscale_80200_A0_A1_flush_kern_cache_louis'

That's because we missed that proc-xscale.S aliases a bunch of functions to
xscale_80200_A0_A1_xxx from xscale_xxx.  And looking at that, it seems that
we also .type equivalent symbols - have you tested this on T2 builds to
check whether it works correctly there?

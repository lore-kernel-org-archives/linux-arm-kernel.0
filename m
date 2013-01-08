From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Jan 2013 22:56:30 +0000
Subject: Build failure with DMA_OMAP=m and a caller built-in
In-Reply-To: <20130107203834.GB2637@n2100.arm.linux.org.uk>
References: <1357449969.4324.25.camel@deadeye.wl.decadent.org.uk>
 <20130107202106.GG14149@atomide.com>
 <20130107203834.GB2637@n2100.arm.linux.org.uk>
Message-ID: <201301082256.30639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 January 2013, Russell King - ARM Linux wrote:
> The problem we have is that the way peripheral devices are connected to
> their DMA engines can involve additional complexity, which if not handled
> correctly results in some platforms being crippled by the API.
> 
> I think Vinod was working on something, however I've not heard anything on
> that for a while now.
> 
> How we avoid this problem outside of OMAP is that the DMA filter function
> gets passed from platform code, and we only ever allow the DMA engine
> driver to be configured into the kernel (iow, non-modular).  This means
> that the DMA users never directly reference the DMA engine driver itself.
> However, as OMAP headed down the DT path, many drivers no longer make use
> of platform data, which makes that approach impractical.

Hmm, it seems the generic DT binding for dmaengine missed the merge window
again, Vinod's pull request came a bit too late for this[1].

Anyway, once the binding and code from Jon Hunter is there, and the omap-dma
converted over to use it, the problem should be gone, unless you see any
other issues with it. Drivers no longer need to reference a filter function
directly, since the dma channel can get described completely in the DT.

	Arnd

[1] http://lkml.org/lkml/2012/12/21/466

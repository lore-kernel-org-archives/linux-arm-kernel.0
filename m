From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 May 2013 22:39:08 +0100
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <201305080924.44622.arnd@arndb.de>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <5189B7BF.8070607@wwwdotorg.org>
 <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
 <201305080924.44622.arnd@arndb.de>
Message-ID: <20130509213908.GP21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 09:24:44AM +0200, Arnd Bergmann wrote:
> It probably should. The main thing is that the dma_mask setting in
> of_platform (and elsewhere) is a mess and that nobody so far had the
> guts to try to get it right for good.
> 
> Setting a 32 bit DMA mask is /probably/ the right default on all
> ARM systems, but there are caveats:
> 
> - Once you get to systems with larger than 32 bit addressing (powerpc64,
>   arm64, arm32 with LPAE), it's not so obvious: you may have some devices
>   that need a 32 bit mask and some that need a 64 bit mask.

This is precisely why drivers should be using dma_set_mask() and the
coherent version to provide the mask for which the driver knows about
- iow, if the device itself is only capable of 32-bit DMA, then the
device must use dma_set_mask(dev, DMA_BIT_MASK(32)).

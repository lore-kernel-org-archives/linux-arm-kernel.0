From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 May 2013 22:36:37 +0100
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com>
 <5189B7BF.8070607@wwwdotorg.org>
 <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
Message-ID: <20130509213637.GO21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:54:48AM +0800, Peter Chen wrote:
> >
> > This probably could be initialized from some DT property. However,
> > there's no such property defined right now, and considering that DT is
> > supposed to be an ABI, we'd always need the code in this patch as a
> > fallback for DTs that were created before any such property was defined.
> >
> > Equally, since the data is SoC-specific rather than board-specific, and
> > is even fairly unlikely to vary between SoC versions since these values
> > are all 0xffffffff anyway, I don't really see much point in putting it
> > into DT, rather than just putting the static data into the driver.
> 
> I mean there is already dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> at function of_platform_device_create, why can't add
> dev->dev.dma_mask = &dev->dev.coherent_dma_mask after that?

Because technically they're different things, and if we have a driver
somewhere which uses the DMA API correctly by making use of
dma_set_mask() and dma_set_coherent_mask(), the two will interfere with
each other.

These two masks have always been separate.

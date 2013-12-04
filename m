From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Dec 2013 17:51:19 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
Message-ID: <20131204175119.GD26581@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> > I noticed these with last night's -next on the snowball:
> >> >
> >> > of_dma_request_slave_channel: dma-names property of node
> >> > '/soc/msp at 80124000' missing or empty
> >> > of_dma_request_slave_channel: dma-names property of node
> >> > '/soc/msp at 80124000' missing or empty
> >> > of_dma_request_slave_channel: dma-names property of node
> >> > '/soc/msp at 80125000' missing or empty
> >> > of_dma_request_slave_channel: dma-names property of node
> >> > '/soc/msp at 80125000' missing or empty
> >> > dma dma0chan22: [d40_config_memcpy] No memcpy`
> >> > dma dma0chan22: [d40_alloc_chan_resources] Failed to configure memcpy channel
> >> > ux500-msp-i2s ux500-msp-i2s.1: Missing dma channel for stream: 0
> >> > ux500-msp-i2s ux500-msp-i2s.1: ASoC: pcm constructor failed: -22
> >>
> >> I don't see this when booting from the stuff I sent for v3.14,
> >> but I know Mark applied some fixes from Lee yesterday,
> >> Lee can you see if you recognize this?
> >
> > It looks like whatever tree you're building from is missing this patch:
> >
> >   ARM: ux500: Add DMA config bindings for MSP devices
> >
> > Which is part of the initial reason I said this:
> >
> >   "If this patch-set could go through ASoC as a whole, it would drive
> >   down the chance of a dependency mess. Vinod has already provided
> >   Acks for his parts, so it's just between you two Linus and Mark."
> >
> > But in Mark's defence, I also tentatively said this:
> >
> >   "I'm not aware of any dependencies on the ARM changes. I haven't
> >   tested the arch/arm and sound/soc adaptions orthogonally, but I
> >   _think_ the right decisions should be made depending on the
> >   information passed from platform/dt code."
> >
> > But this error seems strange, as I thought we were still passing the
> > MSP stuff as AUXDATA for this very reason i.e. lack of DMA support. So
> > I assumed that the MSP driver(s) would take the platform data
> > route. At least until the AUXDATAs have been removed, which was my
> > next step.
> 
> By the way, if these things keep happening, then it's an indicator
> that you should slow down the rate of change a bit and make sure
> things are tested properly. You get a lot of patches produced quickly,
> which is awesome, but please make sure things are coordinated and
> tested especially for the more complex and inter-dependent changes
> like these. If it needs to take another release (or just another week
> or two) to get something staged in the right order, then that's OK.

I know that you've had a bee in your bonnet about the rate of which I
sent patches for a while, but this instance has nothing to do with
rushing. This is merely an ordering issue and the speed in which
varying subsystems are merged into -next.

This is what -next is for though right? To identify these kinds of
decencies before they're merged into Mainline. So let's do something
about it now. I'm not sure what though, as I know that Mark isn't fond
of rebasing his tree.

Ideally we should have setup an immutable branch between ASoC and
either ux500 or ARM-SoC where both parties can pull from. That's what
Mark and I usually do when ASoC/Regulators and MFD have dependencies
on one another.

It might not even be an issue though. We just need to ensure that
Linus pulls from ARM-SoC prior to ASoC during the next merge
window. Can that be done?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

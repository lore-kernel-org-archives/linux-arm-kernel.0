From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Dec 2013 14:47:56 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131205094927.GJ26581@lee--X1>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
 <20131204185947.GC29268@sirena.org.uk>
 <20131205094927.GJ26581@lee--X1>
Message-ID: <20131217144756.GJ19810@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, so I think I figured this out.

Original comment from Olof:

> > > of_dma_request_slave_channel: dma-names property of node
> > > '/soc/msp at 80124000' missing or empty
> > > of_dma_request_slave_channel: dma-names property of node
> > > '/soc/msp at 80124000' missing or empty
> > > of_dma_request_slave_channel: dma-names property of node
> > > '/soc/msp at 80125000' missing or empty
> > > of_dma_request_slave_channel: dma-names property of node
> > > '/soc/msp at 80125000' missing or empty
> > > dma dma0chan22: [d40_config_memcpy] No memcpy
> > > dma dma0chan22: [d40_alloc_chan_resources] Failed to configure memcpy chan
> > > ux500-msp-i2s ux500-msp-i2s.1: Missing dma channel for stream: 0
> > > ux500-msp-i2s ux500-msp-i2s.1: ASoC: pcm constructor failed: -22

> > As far as I'm aware there shouldn't be any dependency or ordering
> > issues here. I planned on the transition from platform data to DT to
> > be fully seamless. We should be using the platform data up until we
> > remove the AUXDATA, but the driver (or the dmaengine) is attempting to
> > pull in DMA configuration from the Device Tree, which isn't populated
> > fully yet.
> > 
> > There is something going on here that I am missing and I'd very much
> > like to get to the bottom of it before merging upstream.

Okay so the basic issue here is the way in which we're requesting our
DMA channel. The Sound DMA handlers make an assumption that because
we're enabling the device via Device Tree, our channels should be
allocated using dma_request_slave_channel(). Sadly this is a Device
Tree only routine and expects certain properties to be present,
including 'dma-names' mentioned above.

The solution is to continue using .compat_request_channel() until all
of the required Device Tree properties are provided. We will be able
to pull this back out to force full Device Tree enablement in the next
cycle.

When I mentioned the use of AUXDATA for smooth platform data -> Device
Tree transition, that only covers the slave configuration. Something
which only comes into force _after_ we've obtained the DMA
channel. Thus, it doesn't help us in this case.

> > Please remove the asoc/topic/ux500 altogether and I will resubmit in
> > its entirety once I've solved all of the issues.

> > Done - the whole thing with the MMC is very weird.

Right, and was actually unrelated. -next still has this issue. Sadly
this will have to be looked at by someone other than myself, as I have
far too much on at the moment.

Linus, can you ask Ulf to have a look at this please?

So unless there are any objections, I'm going to fix-up my set now and
resubmit.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

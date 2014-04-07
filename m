From: daniel@zonque.org (Daniel Mack)
Date: Mon, 07 Apr 2014 15:25:19 +0200
Subject: Porting plat-pxa to the MMP PDMA driver
In-Reply-To: <3296408.nMPs78xkYH@avalon>
References: <3296408.nMPs78xkYH@avalon>
Message-ID: <5342A73F.8010907@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

(copying some more people)

On 04/07/2014 03:12 PM, Laurent Pinchart wrote:
> The MMP DMA (drivers/dma/mmap_pdma.c) driver supports the DMA engine found in 
> PXA chips. However, PXA platforms still use a mix of custom platform code 
> (arch/arm/plat-pxa/dma.c) and direct DMA controller access in various drivers 
> (pata_pxa, spi-pxa2xx, pxa3xx_nand, pxaficp_ir, pxamci, smc91x, smc911x and 
> pxa_camera).
> 
> I'd like to use the MMP PDMA driver through the DMA engine API in a new driver 
> I'm writing instead of the legacy PXA DMA code. However, this requires porting 
> the platform to the MMP PDMA driver first, which involves porting all the 
> above drivers to the DMA engine API. The spi-pxa2xx driver has already been 
> ported and currently supports both the legacy PXA DMA API and the DMA engine 
> API. All the other drivers seem to require the legacy PXA DMA API.
>
> I was wondering if any effort had been started in that direction. I could 
> possibly help with the pxamci driver, but not with the other drivers as the 
> corresponding peripherals are not used on my test platform (a custom PXA27x 
> board).

Yes, I've started working on this a long time ago, but got stuck because
of the lack of support from users, as I don't have hardware with all
possible DMA-capable components in use. Have a look here, the tree
should be easily rebasable onto newer versions:

  https://github.com/zonque/linux/tree/pxa-dma-v3

* I ported some drivers blindly, and Marek Vasut reported success on the
pxa-pata driver.

* The spi-driver just works thanks to previous preparations.

* The mmc driver seems to work, but people reported significant
performance loss in comparison to the current code.

* I ported over the ASoC drivers so the dma framework can be used as
drop-in replacement. One patch for mmp-pdma residue reporting is pending
though, I need to get back to Vinod on that.

* One thing that was especially tricky to port was the camera driver,
and Robert wasn't sure whether the type of DMA hot-linking which his
driver does was at all doable with the DMA framework as it stands.


Which PXA based hardware can you get your hands on for testing? It would
be good to get some movement into this topic again :)


Thanks,
Daniel

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Aug 2011 15:15:47 +0200
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <CAGsJ_4yb9vvKYzyXwQSwaBw1VnZWbv4jGBC4qe7uD032DL0y9A@mail.gmail.com>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
	<CAGsJ_4yb9vvKYzyXwQSwaBw1VnZWbv4jGBC4qe7uD032DL0y9A@mail.gmail.com>
Message-ID: <201108091515.47961.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 August 2011, Barry Song wrote:
> I guess same issues exist for other hardwares except GPIO. For
> example, almost every different SoC has different DMA API, for
> example:
> mach-bcmring/dma.c:EXPORT_SYMBOL(dma_alloc_descriptor_ring);
> mach-davinci/dma.c:EXPORT_SYMBOL(edma_alloc_channel);
> mach-davinci/dma.c:EXPORT_SYMBOL(edma_clear_event);
> mach-imx/dma-v1.c:EXPORT_SYMBOL(imx_dma_setup_single);
> mach-s3c64xx/dma.c:EXPORT_SYMBOL(s3c2410_dma_enqueue);
> 
> Do we also want to delete all arch/arm/mach-xxx/include/mach/dma.h?

We need to eliminate all header files that have conflicting names
and that are used by drivers or other header files outside of mach-*.
How we get there is very different for each of these headers.

> Or do we want to delete the whole arch/arm/mach-xxx/include/mach directory?

Ideally, yes. However, that will take a lot of time. Meanwhile, we should
rename the individual header files to have unique names for each API,
and ensure that the symbols don't clash.

> If not, it is probably that SoC can still hold some chip-specific APIs
> in arch/arm/mach-xxx/include/mach/yyy.h.

Can you name an example? Most of the ones I can think of will not work
in a multiplatform kernel.

	Arnd

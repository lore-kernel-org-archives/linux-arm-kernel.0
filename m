From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 9 Aug 2011 15:22:44 +0800
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
	<20110726104628.GP9653@n2100.arm.linux.org.uk>
	<CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
	<20110726183958.GG1655@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107261502251.12766@xanadu.home>
	<CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
Message-ID: <CAGsJ_4yb9vvKYzyXwQSwaBw1VnZWbv4jGBC4qe7uD032DL0y9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2011/7/26 Nicolas Pitre <nicolas.pitre@linaro.org>:
>> On Tue, 26 Jul 2011, Russell King - ARM Linux wrote:
>>
>>> I don't think there's any plans to break the:
>>>
>>> linux/gpio.h -> asm/gpio.h -> mach/gpio.h
>>>
>>> include path at the moment, as platforms do define ARCH_NR_GPIO,
>>> which has to be done before asm-generic/gpiolib.h is included.
>>
>> Well, this GPIO business is the biggest hurdle towards a single kernel
>> image that can support multiple SOCs at the moment, and the only one for
>> which I have no solution yet. ?Anything that could help removing
>> mach/gpio.h from asm/gpio.h would be welcome.
>
> I've been trying to address it somewhat by converting existing users to
> use struct gpio_chip and struct irq_chip.
>
> However I ran into a brick wall as soon as an advanced GPIO controller
> such as those in U8500 or the OMAPs needed anything custom apart
> from what is done in the API in <linux/gpio.h>, such as configuring pin
> bias and muxing pins.

The patch wants to eliminate the requirement of self-defined
SoC-specific gpio APIs. The intent is that you want to delete files
arch/arm/mach-xxx/include/mach/gpio.h.

I guess same issues exist for other hardwares except GPIO. For
example, almost every different SoC has different DMA API, for
example:
mach-bcmring/dma.c:EXPORT_SYMBOL(dma_alloc_descriptor_ring);
mach-davinci/dma.c:EXPORT_SYMBOL(edma_alloc_channel);
mach-davinci/dma.c:EXPORT_SYMBOL(edma_clear_event);
mach-imx/dma-v1.c:EXPORT_SYMBOL(imx_dma_setup_single);
mach-s3c64xx/dma.c:EXPORT_SYMBOL(s3c2410_dma_enqueue);

Do we also want to delete all arch/arm/mach-xxx/include/mach/dma.h?

Or do we want to delete the whole arch/arm/mach-xxx/include/mach directory?

If not, it is probably that SoC can still hold some chip-specific APIs
in arch/arm/mach-xxx/include/mach/yyy.h.

>
> Different alternatives have been floated to LKML, also a post
> of two different approaches for patches resolving the issue
> in two different ways (see subject [PATCH 0/2] RFC:
> gpio: driver-local pin configuration)
>
> Due to lack of interest i.e. no ACKing nor NACKing of the patches,
> nor any approach being chosen by the subsystem maintainer, I'm
> mainly resting my case, intially we (me & Grant) planned to have
> a solution for this early in the 3.1 cycle but that has failed.
>
> A third solution is to complete the pincfg subsystem that I'm
> working on and which will naturally (hopefully) split off the
> controversial parts of GPIO drivers. Sadly this will involve a bit of
> upfront overhead work :-/
>
> Thanks,
> Linus Walleij

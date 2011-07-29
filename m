From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 29 Jul 2011 17:58:12 +0200
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <alpine.LFD.2.00.1107261502251.12766@xanadu.home>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
	<20110726104628.GP9653@n2100.arm.linux.org.uk>
	<CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
	<20110726183958.GG1655@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107261502251.12766@xanadu.home>
Message-ID: <CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/26 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Tue, 26 Jul 2011, Russell King - ARM Linux wrote:
>
>> I don't think there's any plans to break the:
>>
>> linux/gpio.h -> asm/gpio.h -> mach/gpio.h
>>
>> include path at the moment, as platforms do define ARCH_NR_GPIO,
>> which has to be done before asm-generic/gpiolib.h is included.
>
> Well, this GPIO business is the biggest hurdle towards a single kernel
> image that can support multiple SOCs at the moment, and the only one for
> which I have no solution yet. ?Anything that could help removing
> mach/gpio.h from asm/gpio.h would be welcome.

I've been trying to address it somewhat by converting existing users to
use struct gpio_chip and struct irq_chip.

However I ran into a brick wall as soon as an advanced GPIO controller
such as those in U8500 or the OMAPs needed anything custom apart
from what is done in the API in <linux/gpio.h>, such as configuring pin
bias and muxing pins.

Different alternatives have been floated to LKML, also a post
of two different approaches for patches resolving the issue
in two different ways (see subject [PATCH 0/2] RFC:
gpio: driver-local pin configuration)

Due to lack of interest i.e. no ACKing nor NACKing of the patches,
nor any approach being chosen by the subsystem maintainer, I'm
mainly resting my case, intially we (me & Grant) planned to have
a solution for this early in the 3.1 cycle but that has failed.

A third solution is to complete the pincfg subsystem that I'm
working on and which will naturally (hopefully) split off the
controversial parts of GPIO drivers. Sadly this will involve a bit of
upfront overhead work :-/

Thanks,
Linus Walleij

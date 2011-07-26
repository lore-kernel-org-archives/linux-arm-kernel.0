From: ccross@google.com (Colin Cross)
Date: Tue, 26 Jul 2011 11:32:22 -0700
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <20110726104628.GP9653@n2100.arm.linux.org.uk>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
	<20110726104628.GP9653@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 3:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jul 26, 2011 at 11:09:28AM +0100, Russell King - ARM Linux wrote:
>> Hmm, yet another trivial gpio implementation. ?We have 24 others just like
>> this. ?Well, mainline does... I have just one. ?Patches after the merge
>> window closes.
>
> As an additional note to this: we _really_ need to get on top of the
> includes of mach/gpio.h rather than linux/gpio.h - there are around 139
> files in mainline (this morning) which include mach/gpio.h directly.
>
> There's one which includes both asm/gpio.h and mach/gpio.h, which is
> silly when you look at what asm/gpio.h contains - maybe one attempt
> to include mach/gpio.h wasn't enough!
>
> These includes get in the way of consolidating stuff out of mach/gpio.h
> into asm/gpio.h - moving stuff out of mach/gpio.h could take it out of
> view of these files, thereby causing build errors.
>
> What is even less clear is whether changing these mach/gpio.h includes
> to linux/gpio.h is correct or not.
>
> So, what I'd like all platform and all soc maintainers to do is to:
>
> ? ? ? ?grep -rl '<mach/gpio.h>' arch/arm drivers
>
> and investigate their files from that list which they're responsible for,
> and submit patches to _me_ to fix these includes up (preferably to use
> linux/gpio.h). ?I'd also like them to do a better job at spotting these
> while reviewing patches on the list to help reduce new occurances of
> this.
>
> Thanks.

Tegra has four uses of mach/gpio.h:
arch/arm/mach-tegra/board-trimslice-pinmux.c
arch/arm/mach-tegra/board-paz00.c
arch/arm/mach-tegra/board-trimslice.c
drivers/mmc/host/sdhci-tegra.c

Each of these files calls tegra_gpio_enable/tegra_gpio_disable, which
flip the pin in/out of gpio mode.  Including linux/gpio.h and
mach/gpio.h was deliberate, so that when linux/gpio.h stops causing
mach/gpio.h to be included, the tegra gpio apis are still available.
Should I move the tegra gpio apis to a separate include and drop
mach/gpio.h?

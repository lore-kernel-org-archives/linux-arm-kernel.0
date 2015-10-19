From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Oct 2015 11:29:32 +0100
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <5624C31D.3070906@arm.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com>
Message-ID: <20151019102932.GB10678@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 11:17:01AM +0100, Sudeep Holla wrote:
> 
> 
> On 18/10/15 10:25, Linus Walleij wrote:
> >On Thu, Oct 15, 2015 at 5:30 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>Me
> >>>  Results after
> >>>enabling MTD, MTD_CFI, MTD_PHYSMAP, MTD_PHYSMAP_OF,
> >>>MTD_CFI_INTELEXT:
> >>
> >>Just a note on this: we can't enable these when CPUIDLE is enabled as
> >>the firmware assumes the flash is always in read mode while Linux leaves
> >>NOR flash in "read id" mode after initialization.
> >
> >Sorry I'm too unfamiliar with this lingo. Can you give me some detail
> >on what "read mode" and "read id" mode is all about?
> >
> 
> OK, sorry for that I just quoted from my understanding. Here is the
> actual one from the data sheet:
> 
> "The device can be in any of four read states: Read Array, Read
>  Identifier, Read Status or Read Query. Upon power-up, or after a reset,
>  the device defaults to Read Array. To change the read state, the
>  appropriate read command must be written to the device..."
> 
> After the driver gets initialized, it usually leaves the device in Read
> Identifier state as the last command sent is to read ID from the chip.
> 
> >>So until the firmware is ready to handle that, we can't enabled both
> >>on Juno. We had same issue even on TC2. I will follow up internally to
> >>see if we can fix on Juno at-least.
> >
> >Sounds like something that should be fixed for all Versatile
> >Express that have cpuidle?
> >
> 
> Correct, I just mentioned so that if you see/get any boot issue report
> with NOR flash and CPUIdle enabled, you will have the background instead
> of investigating the known issue again.

Also, for non U-Boot systems I was under the impression that the flash
was effectively owned by EFI (for variable storage), so it doesn't seem
like a sensible idea to me to poke the flash behind its back in that
case.

Given that, I'm not sure that the flash node should be enabled by
default in the DT.

Leif?

Thanks,
Mark.

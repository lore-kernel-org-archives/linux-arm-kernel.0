From: dianders@chromium.org (Doug Anderson)
Date: Fri, 12 Jun 2015 13:17:10 -0700
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set on
 suspend
In-Reply-To: <557B34A7.4090507@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com> <557AC23D.8040602@collabora.co.uk>
 <557AC85E.5070705@arm.com> <557AD728.7090908@collabora.co.uk>
 <557B34A7.4090507@collabora.co.uk>
Message-ID: <CAD=FV=UQF+n8AjSXYajqUb0qswcoUrSgnsasV82JaS3dBtNO8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 12, 2015 at 12:36 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>>> registers are lost assuming the combiner was powered down, even the
>>> status register will be lost and you will not know exactly the wakeup
>>> reason right ?
>>>
>>
>> Good question, I didn't find in the documentation I've access to that
>> this happen but just found through experimentation that the IRQ enable
>> set register values are lost after a resume and that saving/restoring
>> the values makes the interrupts to be triggered again.
>>
>
> I'll share here too the findings I mentioned over IRC. As you suggested I
> add some printouts and noticed that the ISTRn (Interrupt Status) registers
> values are indeed preserved on resume so I can know for example if the
> wakeup source was the power gpio-key or cros_ec keyboard. I've checked the
> values of the registers against the Exynos manual and they corresponds to
> the interrupt sources in each case so the values are correct.
>
> So as you said, it seems that is not that the IP block loses its state on
> S2R but that something is blindly writing the IESRn (Interrupt Enable Set)
> registers.

I'll postulate an alternate theory here.  You can tell me if you buy
it or if you think I've been out in the sun too long.

Let's say that the interrupt combiner's status registers show the raw
status as asserted by whatever is hooked up to the combiner.  This
means that even if the combiner got reset we could still read the
status register and get the status of the source.  Imagine that the
combiner is like a GPIO bank.  If you reset the GPIO bank, you'll lose
all kinds of config (input vs. output, edge interrupt status, maybe
pulls, etc).  ...but you can still read the state asserted by an
external source, right?

In this case the combiner's interrupt source is 'EINT 11'.  ...and I'm
pretty sure that the controller managine 'EINT 11' _doesn't_ lose
power across suspend/resume...


I'll further bolster my theory by saying that _almost nothing_ in the
exynos keeps power across suspend/resume.  The UART?  Nope.  The GPIO
controllers?  Nuh-uh.  The GIC?  Sorry, but no.  The clock tree?  It
might be nice, but you're out of luck.  ...so it would make me
terribly surprised to see the combiner keep power.


> To reduce the possible s/w components that could be doing this, I booted a
> signed FIT image directly using the RO U-Boot instead of chain loading a
> mainline nv-uboot. In this configuration I've the same issue so it seems
> that if something is zeroing those registers on S2R, this can't be changed
> without void the warranty of these machines.
>
> I also looked at the downstream ChromiumOS v3.8 tree [0] and I see that
> they have a very similar solution than my patch, the IESRn are also saved
> but using a notifier for the CPU_PM_ENTER and CPU_PM_EXIT events instead
> or registering a syscore ops but the idea is basically the same.

Yup, you can see where kliegs added it in
<https://chromium-review.googlesource.com/#/c/27964/>.  As per the
comments in that CL, this was probably broken in:

063bd6f ARM: EXYNOS: Remove GIC save & restore function


> I have to take a look to the U-boot that is shipped on the device, I think
> the correct branch is [1] but I'm not sure if that is the correct one.

It is the right one.  If U-Boot were touching this (which would
greatly surprise me) it should be here:

arch/arm/include/asm/arch-exynos/cpu.h

...and it's not.  Doing a grep for '10440000' (the combiner base
address) doesn't find anything in U-Boot either, which makes it less
likely.  ...and it's even less likely since the amount of code that is
in U-Boot that runs at resume time is a very small subset and I'm
fairly familiar with it and I would have remembered it touching the
combiner.

It's POSSIBLE that the internal ROM in exynos is clobbering this, but
as per above it seems crazy unlikely and I think it's just losing
power.


-Doug

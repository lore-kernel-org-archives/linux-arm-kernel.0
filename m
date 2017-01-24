From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Jan 2017 17:35:51 +0100
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <35cf654f-3944-fc76-5120-25e33f71be4f@arm.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
 <765699aa-cbc6-67eb-9108-cbf335338e4c@linaro.org>
 <35cf654f-3944-fc76-5120-25e33f71be4f@arm.com>
Message-ID: <20170124163551.GB2021@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 03:27:51PM +0000, Marc Zyngier wrote:
> On 24/01/17 15:08, Daniel Lezcano wrote:
> > On 19/01/2017 14:35, Ding Tianhong wrote:
> >> Erratum Hisilicon-161010101 says that the ARM generic timer counter "has the
> >> potential to contain an erroneous value when the timer value changes".
> >> Accesses to TVAL (both read and write) are also affected due to the implicit counter
> >> read.  Accesses to CVAL are not affected.
> >>
> >> The workaround is to reread the system count registers until the value of the second
> >> read is larger than the first one by less than 32, the system counter can be guaranteed
> >> not to return wrong value twice by back-to-back read and the error value is always larger
> >> than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.
> > 
> > Why not use another clocksource instead of adding a workaround with a
> > non negligible overhead and more complexity in the code ?
> 
> The overhead only affects the affected systems, since it is guarded by a
> static key (the same static key that guards the FSL workaround that is
> already in mainline).

Yes, that is what I understood so far.
 
> As for creating a different clocksources, this would in turn make the
> integration with the arch code more complex (arm64 relies on having
> working architected timers, with or without workarounds) and the
> integration with KVM (which relies on the same), and in the end create
> quite a lot of duplication. Are we going to create a separate
> clocksource for each potential erratum that people with screwed hardware
> come up with?

That wasn't my point. The way the errata are handled in this patchset is
elegant and I have nothing against it. I'm worried about the accumulation of
fixes, hacks, workarounds in this driver. So my naive question is about not
using an identified bogus clocksource and use another one available on the
board, which is I believe often the case, instead of trying to deal with bogus
hardware. Apparently, that is not possible because 1) of KVM, 2) of duplication
and 3) of integration with the ARM64 code.

Does it mean it is not possible to use another clocksource/clockevent than the
armv8-timer ?

Can you elaborate these three points ? 

> I'd prefer to organise the mess rather than spread it everywhere.

I will add this punchline to my fortune database :)

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

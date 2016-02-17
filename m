From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 17 Feb 2016 22:52:10 +0100
Subject: [PATCH 1/2] clk: add lpc18xx creg clk driver
In-Reply-To: <20160217202824.2278.25956@quark.deferred.io>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
 <1436651307-24098-2-git-send-email-manabian@gmail.com>
 <20150811204127.31346.16729@quantum>
 <CAGhQ9VwZaM_iWTkQYVTuTiyb6gCG2y6s8WFVySCHt7YHE1qbcA@mail.gmail.com>
 <20150818002604.31346.18322@quantum>
 <CAGhQ9VzOYbHsFZQxM8823OiWpGB6vLEwX8LfvjC=DnL1iqK_qQ@mail.gmail.com>
 <20160217005629.2278.90197@quark.deferred.io>
 <CAGhQ9VzB_WgB8b4_c3Z17W+K2MC7Fq7SD9zEvZUN_UJVGDZ3Wg@mail.gmail.com>
 <20160217202824.2278.25956@quark.deferred.io>
Message-ID: <CAGhQ9VxPt7FmE4JN_-rBJMNpLpGoKVKocVFPWc3siV29Pk0_mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2016 at 21:28, Michael Turquette <mturquette@baylibre.com> wrote:
> Quoting Joachim Eastwood (2016-02-17 10:24:12)
>> On 17 February 2016 at 01:56, Michael Turquette <mturquette@baylibre.com> wrote:
>> > Quoting Joachim Eastwood (2016-02-13 06:38:45)
>> >> Hi Mike,
>> >>
>> >> Seems your reply got lost in my mailbox and I didn't notice it before
>> >> Stephen replied on the cover letter. Sorry about that.
>> >>
>> >> On 18 August 2015 at 02:26, Michael Turquette <mturquette@baylibre.com> wrote:
>> >> > Quoting Joachim Eastwood (2015-08-13 13:43:11)
>> >> >> On 11 August 2015 at 22:41, Michael Turquette <mturquette@baylibre.com> wrote:
>> >> >> > Hi Joachim,
>> >> >> >
>> >> >> > Quoting Joachim Eastwood (2015-07-11 14:48:26)
>> >> >> >> +static void __init lpc18xx_creg_clk_init(struct device_node *np)
>> >> >> >> +{
>> >> >> >> +       const char *clk_32khz_parent;
>> >> >> >> +       struct regmap *syscon;
>> >> >> >> +
>> >> >> >> +       syscon = syscon_node_to_regmap(np->parent);
>> >> >> >> +       if (IS_ERR(syscon)) {
>> >> >> >> +               pr_err("%s: syscon lookup failed\n", __func__);
>> >> >> >> +               return;
>> >> >> >> +       }
>> >> >> >> +
>> >> >> >> +       clk_32khz_parent = of_clk_get_parent_name(np, 0);
>> >> >> >> +
>> >> >> >> +       clk_creg[CREG_CLK_32KHZ] =
>> >> >> >> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_32KHZ],
>> >> >> >> +                                     &clk_32khz_parent, syscon);
>> >> >> >> +
>> >> >> >> +       clk_creg[CREG_CLK_1KHZ] =
>> >> >> >> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_1KHZ],
>> >> >> >> +                                     &clk_creg_clocks[CREG_CLK_32KHZ].name,
>> >> >> >> +                                     syscon);
>> >> >> >> +
>> >> >> >> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_base_data);
>> >> >> >> +}
>> >> >> >> +CLK_OF_DECLARE(lpc18xx_creg_clk, "nxp,lpc1850-creg-clk", lpc18xx_creg_clk_init);
>> >> >> >
>> >> >> > I'll ask the same question that Stephen asked in your CCU/CGU driver
>> >> >> > series: is it necessary to use CLK_OF_DECLARE here or can you use the
>> >> >> > platform device model?
>> >> >>
>> >> >> The 32 kHz clock from the CREG block is a clock parent to the CGU
>> >> >> block so it's possible that it will required early. This is all
>> >> >> depends on how the boot loader initially configures the CGU.
>> >> >>
>> >> >> Currently in the DTS for lpc18xx cgu it has:
>> >> >> clocks = <&xtal>, <&xtal32>, <...>;
>> >> >> xtal32 is just a temporary placeholder until the CREG clock is in place.
>> >> >
>> >> > Well that seems wrong. Is it just a matter of probe order where you try
>> >> > to probe the cgu driver before the creg driver?
>> >>
>> >> The ideal probe order for the clk drivers on the lpc18xx platform
>> >> would be; creg-clk, cgu and ccu.
>> >> If the 32k clk is used by any of timers we need creg-clk to enable the
>> >> 32k clock and determine the rate.
>> >>
>> >> Note that the cgu and ccu driver is using CLK_OF_DECLARE now.
>> >>
>> >>
>> >> I have tired to create an overview of the lpc18xx clock system here:
>> >> https://github.com/manabian/linux-lpc/wiki/LPC18xx-LPC43xx-clocks
>> >
>> > That's great, thanks a lot for the link and the nice documentation.
>> >
>> > It's been a while since I've looked at this thread. Do any of the
>> > creg-clk, cgu or ccu clock drivers need to use CLK_OF_DECLARE? If they
>> > were platform_drivers then you could use -EPROBE_DEFER to solve your
>> > ordering issue.
>>
>> The clock for the clocksource/timer
>> (drivers/clocksource/time-lpc32xx.c) comes from cgu/ccu and can also
>> come from creg-clk. So afaik they must use CLK_OF_DECLARE. Or is there
>> something I am missing?
>
> No, you're not missing anything. What I want is for clock provider
> drivers to actually be real Linux device drivers. Right now the drivers
> that only call CLK_OF_DECLARE are essentially just initcall hacks, and
> this causes problems down the road when you decide you want your clk
> provider driver to have suspend/resume ops, etc. Also I feel that having
> proper drivers will be important as runtime pm and the generic power
> domains stuff matures.
>
>> Isn't true that most SoC system clock drivers must use CLK_OF_DECLARE
>> because the system timer require clocks early? I thought this was the
>> whole point.
>
> On ARMv8, mandatory use of architected timers removes the need for the
> clk framework to be involved with timer init, so it's definitely not
> true for all platforms.
>
> On QCOM's 32-bit platforms they have an always-on clock with a known
> fixed rate, so they can either put the fixed-rate clock in DT, or even
> just put the frequency as a property into the timer node with no need to
> involve the clk framework (which is what they do today). That is also a
> bit hacky, but it is why you won't find CLK_OF_DECLARE in
> drivers/clk/qcom and all of their drivers are proper platform_drivers.
>
>>
>> Since it is possible that the 32k clock from creg-clk can be use as a
>> parent clock for the timer doesn't this mean it also must use
>> CLK_OF_DECLARE?
>
> Right, if your 32k clock is a fixed-clock, and if it is provided on the
> board (e.g. external extal -> lpc timer) then you could just put the
> fixed-rate clock into DT (which uses CLK_OF_DECLARE) and reference that
> from your timer node. The rest of the clocks could be registered later
> through a platform_driver.
>
> Sounds like your timer clocking scheme is more complicated than that
> however.
>
>> If it wasn't possible for creg-clk to be used as a parent clock for
>> the timer it could have been a platform device.
>>
>>
>> The lpc18xx clock configuration that require creg-clk early would be:
>> 32k - > PLL0 -> BASE_M3/M4_CLK -> CLK_M3/M4_TIMER0. See second figure
>> on the webpage. Note that this is probably not a common configuration,
>> but it is a valid one. (PLL0 accepts input down to 14 kHz)
>
> I was just discussing this with Stephen and we're both curious to know
> if the same "nxp,lpc1850-creg-clk" compatible string can be used with
> CLK_OF_DECLARE for registering the bare minimum early clks, and also
> with a platform_driver using a different table of clocks for late
> registration.
>
> The compat string could be the same, and the driver would have different
> tables/setup functions to keep from re-registering the same clocks
> twice.

creg-clk is quite simple with only two clocks and only one of them may
be needed during boot.

> I know that nobody likes to be the guinea pig for this type of stuff,
> but the lack of participation in the Linux driver model for clk drivers
> needs to curbed. Do you think the above proposed scheme could work for
> your clock provider drivers?

For creg-clk it would probably work.

cgu would need to register most of clocks early since it needs to
support whatever setup the bootloader throws at it. The only clocks
that could be taken out is the base clocks (clk_onecell_data
clk_base_data) except for one of them. But splitting this table would
be a bad idea as hw clk numbers are used as indexes for easy look up.

Come to think of it; isn't splitting the clock table between a early
init and platform driver going become a problem?
At least the lookup in the driver or framework would become more complex(?)
And won't you confuse the lookup?
If the early driver register one clock table with
of_clk_add_provider() and then sometime later the platform driver
register another clock table, both using the same of_node. How is that
suppose to work?

ccu has only 4 clocks needed early; CLK_CPU_TIMERx with x = 0..3.


Note that I don't have much time to spare on lpc18xx right now so I
might be a bit slow if you want me to implement and test stuff.


regards,
Joachim Eastwood

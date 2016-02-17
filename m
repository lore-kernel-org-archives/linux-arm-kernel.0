From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 17 Feb 2016 19:24:12 +0100
Subject: [PATCH 1/2] clk: add lpc18xx creg clk driver
In-Reply-To: <20160217005629.2278.90197@quark.deferred.io>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
 <1436651307-24098-2-git-send-email-manabian@gmail.com>
 <20150811204127.31346.16729@quantum>
 <CAGhQ9VwZaM_iWTkQYVTuTiyb6gCG2y6s8WFVySCHt7YHE1qbcA@mail.gmail.com>
 <20150818002604.31346.18322@quantum>
 <CAGhQ9VzOYbHsFZQxM8823OiWpGB6vLEwX8LfvjC=DnL1iqK_qQ@mail.gmail.com>
 <20160217005629.2278.90197@quark.deferred.io>
Message-ID: <CAGhQ9VzB_WgB8b4_c3Z17W+K2MC7Fq7SD9zEvZUN_UJVGDZ3Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2016 at 01:56, Michael Turquette <mturquette@baylibre.com> wrote:
> Quoting Joachim Eastwood (2016-02-13 06:38:45)
>> Hi Mike,
>>
>> Seems your reply got lost in my mailbox and I didn't notice it before
>> Stephen replied on the cover letter. Sorry about that.
>>
>> On 18 August 2015 at 02:26, Michael Turquette <mturquette@baylibre.com> wrote:
>> > Quoting Joachim Eastwood (2015-08-13 13:43:11)
>> >> On 11 August 2015 at 22:41, Michael Turquette <mturquette@baylibre.com> wrote:
>> >> > Hi Joachim,
>> >> >
>> >> > Quoting Joachim Eastwood (2015-07-11 14:48:26)
>> >> >> +static void __init lpc18xx_creg_clk_init(struct device_node *np)
>> >> >> +{
>> >> >> +       const char *clk_32khz_parent;
>> >> >> +       struct regmap *syscon;
>> >> >> +
>> >> >> +       syscon = syscon_node_to_regmap(np->parent);
>> >> >> +       if (IS_ERR(syscon)) {
>> >> >> +               pr_err("%s: syscon lookup failed\n", __func__);
>> >> >> +               return;
>> >> >> +       }
>> >> >> +
>> >> >> +       clk_32khz_parent = of_clk_get_parent_name(np, 0);
>> >> >> +
>> >> >> +       clk_creg[CREG_CLK_32KHZ] =
>> >> >> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_32KHZ],
>> >> >> +                                     &clk_32khz_parent, syscon);
>> >> >> +
>> >> >> +       clk_creg[CREG_CLK_1KHZ] =
>> >> >> +               clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_1KHZ],
>> >> >> +                                     &clk_creg_clocks[CREG_CLK_32KHZ].name,
>> >> >> +                                     syscon);
>> >> >> +
>> >> >> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_base_data);
>> >> >> +}
>> >> >> +CLK_OF_DECLARE(lpc18xx_creg_clk, "nxp,lpc1850-creg-clk", lpc18xx_creg_clk_init);
>> >> >
>> >> > I'll ask the same question that Stephen asked in your CCU/CGU driver
>> >> > series: is it necessary to use CLK_OF_DECLARE here or can you use the
>> >> > platform device model?
>> >>
>> >> The 32 kHz clock from the CREG block is a clock parent to the CGU
>> >> block so it's possible that it will required early. This is all
>> >> depends on how the boot loader initially configures the CGU.
>> >>
>> >> Currently in the DTS for lpc18xx cgu it has:
>> >> clocks = <&xtal>, <&xtal32>, <...>;
>> >> xtal32 is just a temporary placeholder until the CREG clock is in place.
>> >
>> > Well that seems wrong. Is it just a matter of probe order where you try
>> > to probe the cgu driver before the creg driver?
>>
>> The ideal probe order for the clk drivers on the lpc18xx platform
>> would be; creg-clk, cgu and ccu.
>> If the 32k clk is used by any of timers we need creg-clk to enable the
>> 32k clock and determine the rate.
>>
>> Note that the cgu and ccu driver is using CLK_OF_DECLARE now.
>>
>>
>> I have tired to create an overview of the lpc18xx clock system here:
>> https://github.com/manabian/linux-lpc/wiki/LPC18xx-LPC43xx-clocks
>
> That's great, thanks a lot for the link and the nice documentation.
>
> It's been a while since I've looked at this thread. Do any of the
> creg-clk, cgu or ccu clock drivers need to use CLK_OF_DECLARE? If they
> were platform_drivers then you could use -EPROBE_DEFER to solve your
> ordering issue.

The clock for the clocksource/timer
(drivers/clocksource/time-lpc32xx.c) comes from cgu/ccu and can also
come from creg-clk. So afaik they must use CLK_OF_DECLARE. Or is there
something I am missing?
Isn't true that most SoC system clock drivers must use CLK_OF_DECLARE
because the system timer require clocks early? I thought this was the
whole point.

Since it is possible that the 32k clock from creg-clk can be use as a
parent clock for the timer doesn't this mean it also must use
CLK_OF_DECLARE?
If it wasn't possible for creg-clk to be used as a parent clock for
the timer it could have been a platform device.


The lpc18xx clock configuration that require creg-clk early would be:
32k - > PLL0 -> BASE_M3/M4_CLK -> CLK_M3/M4_TIMER0. See second figure
on the webpage. Note that this is probably not a common configuration,
but it is a valid one. (PLL0 accepts input down to 14 kHz)


regards,
Joachim Eastwood

From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 5 Mar 2015 16:58:48 +0800
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150305074207.GC11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
Message-ID: <CALx668UH+p5GShJBEOE+HkYH_LEVDdfS8oiQh1GLDVWFh0HYSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 15:42, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> +Cc Viresh Kumar
>
> Viresh, this is the patch for the underlying clocks for the Mediatek
> cpufreq driver.
>
> On Thu, Mar 05, 2015 at 10:43:21AM +0800, Pi-Cheng Chen wrote:
>> Hi Sascha,
>>
>> On 4 March 2015 at 19:21, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Wed, Mar 04, 2015 at 06:49:11PM +0800, pi-cheng.chen wrote:
>> >> This patch adds CPU mux clocks which are used by Mediatek cpufreq driver
>> >> for intermediate clock source switching. This patch is based on Mediatek
>> >> clock driver patches[1].
>> >>
>> >> [1] http://thread.gmane.org/gmane.linux.kernel/1892436
>> >>
>> >> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> >> ---
>> >> +static long clk_cpumux_determine_rate(struct clk_hw *hw, unsigned long rate,
>> >> +                                   unsigned long min_rate,
>> >> +                                   unsigned long max_rate,
>> >> +                                   unsigned long *best_parent_rate,
>> >> +                                   struct clk_hw **best_parent_p)
>> >> +{
>> >> +     struct clk *clk = hw->clk, *parent;
>> >> +     unsigned long parent_rate;
>> >> +     int i;
>> >> +
>> >> +     for (i = MAINPLL_INDEX; i >= ARMPLL_INDEX; i--) {
>> >> +             parent = clk_get_parent_by_index(clk, i);
>> >> +             if (!parent)
>> >> +                     return 0;
>> >> +
>> >> +             if (i == MAINPLL_INDEX) {
>> >> +                     parent_rate = __clk_get_rate(parent);
>> >> +                     if (parent_rate == rate)
>> >> +                             break;
>> >> +             }
>> >> +
>> >> +             parent_rate = __clk_round_rate(parent, rate);
>> >> +     }
>> >> +
>> >> +     *best_parent_rate = parent_rate;
>> >> +     *best_parent_p = __clk_get_hw(parent);
>> >> +     return parent_rate;
>> >> +}
>> >
>> > Why this determine_rate hook? If you want to switch the clock to some
>> > intermediate parent I would assume you do this explicitly by setting the
>> > parent and not implicitly by setting a rate.
>> >
>>
>> I use determine_rate hook here because I am using generic cpufreq-dt
>> driver and I want to make clock switching transparent to cpufreq-dt.
>> I.e. when I am trying to switch the clock from ARMPLL to MAINPLL, I
>> call clk_set_rate() with the rate of MAINPLL, and determine_rate will
>> select MAINPLL as the new parent.
>
> We have clk_set_parent for changing the parent and clk_set_rate to
> change the rate. Use the former for changing the parent and the latter
> for changing the rate. What you are interested in is changing the
> parent, so use clk_set_parent for this and not abuse a side effect
> of clk_set_rate.
>
> My suggestion is to take another approach. Implement clk_set_rate for
> these muxes and in the set_rate hook:
>
> - switch mux to intermediate PLL parent
> - call clk_set_rate() for the real parent PLL
> - switch mux back to real parent PLL
>
> This way the things happening behind the scenes are completely transparent
> to the cpufreq driver and you can use cpufreq-dt as is without changes.

Hi,

Yes. But the frequency of intermediate PLL parent is different from the original
frequency and the frequency after changed of original PLL clock in most cases.
If the frequency of intermediate PLL parent is higher than the
original frequency,
then we have to scale up the voltage first before switch mux to intermediate PLL
parent. I am not sure this could be properly handled if I implement it
in the way
you suggested. For now, I put the mux switching logic in the determine_rate
hook so that the voltage scaling could be handled by target_intermediate hook
of cpufreq-dt which I am also working on[1].

[1] http://marc.info/?l=linux-kernel&m=142545898313351&w=2

Best Regards,
Pi-Cheng

>
> Sascha
>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 7 Sep 2012 15:26:21 +0200
Subject: [PATCH] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <20120907124050.GN26709@S2101-09.ap.freescale.net>
References: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
 <CAPDyKFoV5d2pdxVj=9ERubs7_3g1zVJQ08Uo8JXD7yogp0wHgA@mail.gmail.com>
 <20120907124050.GN26709@S2101-09.ap.freescale.net>
Message-ID: <CAPDyKFrWGKP+jNcti939-ARp_Q8ugLUrdSn9pb59v24nH=D36A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2012 14:40, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Sep 07, 2012 at 01:59:40PM +0200, Ulf Hansson wrote:
>> Hi Shawn and Mike,
>>
>> In general I am in favor of this patch, but I also see some
>> corresponding problems to resolve. Please correct me if I am wrong.
>>
>> I suppose most machines is relying on that it enough to only take care
>> of the notification by using "cpufreq_notify_transition" from their
>> cpufreq drivers. Thus those have to make sure the updates for smp_twd
>> clock is supported from within the cpufreq driver I suppose.
>>
>> In other words the cpufreq drivers needs to do clk_get of "smp_twd"
>> clock and then do a set_rate on it when it's has changed, to trigger a
>> rate change notification. Is this what you also have in mind or do you
>> have any other idea of how this should work?
>>
> Here is how it works on imx6q.
>
> 1) There are clks arm and twd defined in imx6q clock tree.  And twd
>    is registered to clock framework as one child of arm clk with a fixed
>    divider 2.
>
>         /*                                    name         parent_name     mult div */
>         clk[twd]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
>
> 2) Register lookup "cpu0" and "smp_twd" for cpufreq and smp_twd drivers
>    respectively.
>
>         clk_register_clkdev(clk[twd], NULL, "smp_twd");
>         clk_register_clkdev(clk[arm], NULL, "cpu0");
>
> That's it.  The clock framework will just handle all the work nicely.
> When cpufreq driver scales arm clk, the framework will propagate the
> rate change to twd clk automatically.  And once twd clk rate changes,
> smp_twd will get the notification.
>

That's a nice solution!
This won't work for ux500 that simple though. Maybe I might be able to
use some kind of clock "parent" thing though, let's see. Thanks for
the information!

Kind regards
Ulf Hansson

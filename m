From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 10 Sep 2012 16:57:56 +0530
Subject: [PATCH] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <CAPDyKFoxcHaHoZtS_JhVgw=jDegN1-5kYp6xLLsNJ2USGMHZAg@mail.gmail.com>
References: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
 <CAPDyKFoV5d2pdxVj=9ERubs7_3g1zVJQ08Uo8JXD7yogp0wHgA@mail.gmail.com>
 <20120907124050.GN26709@S2101-09.ap.freescale.net>
 <CAPDyKFrWGKP+jNcti939-ARp_Q8ugLUrdSn9pb59v24nH=D36A@mail.gmail.com>
 <20120907215927.20289.29648@nucleus>
 <CAPDyKFoxcHaHoZtS_JhVgw=jDegN1-5kYp6xLLsNJ2USGMHZAg@mail.gmail.com>
Message-ID: <CAMQu2gzFDoJ0da=0dTM=Y7rSC=kGJ4nqxsjGc01PvbUx2PQ22g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 4:52 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 7 September 2012 23:59, Mike Turquette <mturquette@linaro.org> wrote:
>> Quoting Ulf Hansson (2012-09-07 06:26:21)
>>> On 7 September 2012 14:40, Shawn Guo <shawn.guo@linaro.org> wrote:
>>> > On Fri, Sep 07, 2012 at 01:59:40PM +0200, Ulf Hansson wrote:
>>> >> Hi Shawn and Mike,
>>> >>
>>> >> In general I am in favor of this patch, but I also see some
>>> >> corresponding problems to resolve. Please correct me if I am wrong.
>>> >>
>>> >> I suppose most machines is relying on that it enough to only take care
>>> >> of the notification by using "cpufreq_notify_transition" from their
>>> >> cpufreq drivers. Thus those have to make sure the updates for smp_twd
>>> >> clock is supported from within the cpufreq driver I suppose.
>>> >>
>>> >> In other words the cpufreq drivers needs to do clk_get of "smp_twd"
>>> >> clock and then do a set_rate on it when it's has changed, to trigger a
>>> >> rate change notification. Is this what you also have in mind or do you
>>> >> have any other idea of how this should work?
>>> >>
>>> > Here is how it works on imx6q.
>>> >
>>> > 1) There are clks arm and twd defined in imx6q clock tree.  And twd
>>> >    is registered to clock framework as one child of arm clk with a fixed
>>> >    divider 2.
>>> >
>>> >         /*                                    name         parent_name     mult div */
>>> >         clk[twd]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
>>> >
>>> > 2) Register lookup "cpu0" and "smp_twd" for cpufreq and smp_twd drivers
>>> >    respectively.
>>> >
>>> >         clk_register_clkdev(clk[twd], NULL, "smp_twd");
>>> >         clk_register_clkdev(clk[arm], NULL, "cpu0");
>>> >
>>> > That's it.  The clock framework will just handle all the work nicely.
>>> > When cpufreq driver scales arm clk, the framework will propagate the
>>> > rate change to twd clk automatically.  And once twd clk rate changes,
>>> > smp_twd will get the notification.
>>> >
>>>
>>> That's a nice solution!
>>> This won't work for ux500 that simple though. Maybe I might be able to
>>> use some kind of clock "parent" thing though, let's see. Thanks for
>>> the information!
>>
>> Hi Ulf,
>>
>> Why won't this work for ux500?
>>
>
> The value for smp_twd clock freq is not directly connected to the CPU
> freq clock, I believe. I will dig into the details to see what we can
> do to make the most easiest solution.
> Using a "parent" solution is definitely to prefer, so let's see.
>
It is connected to the CPU clock wih a fixed divider in between on
A9 based SoCs. This divider is different across SoC's as seen from
various patches done for the CPUFREQ TWD update.

if you look at OMAP TWD clock node, it's parent is CPU
clock node with fixed divider of 2.

Regards
Santosh

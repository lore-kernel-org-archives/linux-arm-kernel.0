From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 18:12:16 -0700
Subject: [PATCH RFC 0/7] support clk setting during kernel early boot
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160702011216.GR27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29, Dong Aisheng wrote:
> Recently several people met the kernel complaining
> "bad: scheduling from the idle thread!" issue which caused by
> sleeping during kernel early booting phase by calling clk
> APIs like clk_prepare_enable.
> 
> See:
> https://lkml.org/lkml/fancy/2016/1/29/695
> https://lkml.org/lkml/2016/6/10/779
> http://www.spinics.net/lists/linux-clk/msg08635.html

That last one was another bug that happened to trigger this
problem mistakenly. I doubt critical clks are an issue (more
below).

> 
> The calling sequence simply could be like:
> start_kernel
>   ->time_init
>     ->of_clk_init
>       ->clk_core_prepare
>         ->clk_pllv3_prepare
>           ->usleep_range
>             ->dequeue_task_idle
> 
> This issue is mainly caused during time_init, the irq is still
> not enabled and scheduler is still not ready, thus there's no way
> to allow sleep at that time.
> 
> However, there're many exist platforms calling clk_prepare_enable/
> clk_get_rate/clk_set_parent at that time in CLK_OF_DECLARE init
> function.
> e.g
> drivers/clk/imx/clk-{soc}.c
> drivers/clk/rockchip/clk-rk3188.c
> drivers/clk/ti/clk-44xx.c
> ...
> 
> And irqchip and clock source is also initialized before it which
> may requires to do clk settings.
> 
> Furthermore, current clk framework also supports critical clocks
> flagged by CLK_IS_CRITICAL which will be prepared and
> enabled during clk_register by clk core, that is also happened
> quite early in of_clk_init usually.
> 
> And clk framework also supports assign default clk rate and parent for
> each registered clk provider which also happens early in of_clk_init.
> (see of_clk_set_defaults())
> 
> Above are all possible cases which may cause sleeping during kernel
> early booting.

How many of these cases are really happening and causing problems
though?

> 
> So it seems we'd like to have the requirement to make kernel support
> calling clk APIs during kernel early boot without sleep.

I wonder if the problem is more that the framework doesn't know
the hardware state of on/off when it initializes? So we call the
clk_ops prepare/enable functions when we really shouldn't be
doing that at all because the clk is already prepared/enabled.
Presumably for critical clks, we shouldn't go and touch any
hardware to turn them on, because by definition they're critical
and should already be on anyway.

> 
> Since many of them is actually mostly implemented unsleepable already,
> e.g. recalc_rate, recalc_accuracy, get/set_phase
> but due to the definition allows them sleep, we may still have to add
> xxx_hw and xxx_done for them.
> Not sure if any better idea to avoid adding so many new callbacks.
> 
> 5) The most important issue may be callbacks (round_rate and determine_rate)
> which may recursively call its parent.
> For this case, we may not be able to convert it to xx_hw type.
> e.g. drivers/clk/clk-divider.c
> .round_rate
> -> clk_divider_round_rate
>    -> clk_hw_round_rate(clk_hw_get_parent(hw), rate) if CLK_SET_RATE_PARENT
> 
> clk_hw_round_rate is sleepable in theory.
> Thus we may not convert .round_rate to .round_rate_hw since we can't
> predict whether it's parent round_rate is sleepable or not.
> 
> This issue may cause us unable to convert the common clk-divider and clk-mux
> which could be a potential issue since clk_set_rate will indirectly call
> .round_rate and .determinte_rate which may results in possible sleep.
> 
> Any good ideas for this issue?
> 
> 6) Not sure your guys's option on calling clk_prepare which acqures a mutex
> when irq is disalbed.
> Ideally we probably may should not call mutex_lock with irq disabled.
> But seems we may can't avoid and during booting, it seems still safe to
> call it.
> 

It seems fine to call mutex lock during of_clk_init(). At least
from what I can tell we're saved here because there's only one
task during of_clk_init() time so we're not able to be blocked by
any other task and fall into the mutex slowpath.

The problem seems to be entering the scheduler directly from
usleep_range() called from clk ops because that effectively
becomes a scheduler call. Given that of_clk_init() is mostly for
clk drivers to register clks for their timers and interrupt
controllers, we should be able to avoid making any clk_ops calls
besides recalculating rates and checking if clks are enabled or
not. All other clks should be registered and configured from
device drivers later on when the scheduler is running.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

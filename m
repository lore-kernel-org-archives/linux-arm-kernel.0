From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 24 Jul 2014 10:52:51 -0700
Subject: [PATCHv3 3/7] clk: mvebu: extend clk-cpu for dynamic frequency
 scaling
In-Reply-To: <20140724083325.0c578091@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140723235358.6419.26311@quantum>
 <20140724083325.0c578091@free-electrons.com>
Message-ID: <20140724175251.3823.74667@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thomas Petazzoni (2014-07-23 23:33:25)
> Hello,
> 
> (Not sure why this e-mail comes with me as the From:, but anyway.)
> 
> On Wed, 23 Jul 2014 16:53:58 -0700, Thomas Petazzoni wrote:
> 
> > +static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
> > +                           unsigned long parent_rate)
> > +{
> > +       if (__clk_is_enabled(hwclk->clk))
> > +               return clk_cpu_on_set_rate(hwclk, rate, parent_rate);
> > +       else
> > +               return clk_cpu_off_set_rate(hwclk, rate, parent_rate);
> > 
> > This is racy. You don't hold the clk_enable lock so it could be enable
> > between the conditional check and executing clk_cpu_on_set_rate.
> 
> Right.
> 
> > How do you ensure that secondary CPU clocks are not enabled/disabled
> > when changing rates?
> 
> In practice, this currently cannot happen: we enable the secondary CPU
> clocks before starting the secondary CPUs, and we never ever disable or
> re-enable again those clocks. So with the present code, I believe there
> is no problem. Even when we do CPU hotplug, we don't turn off the CPU
> clocks, simply because they cannot be turned off: the enable/disable
> state is only used here as an indication so that the clock driver knows
> which frequency change strategy it should apply.
> 
> But you're anyway right, I'll send a followup patch adding the lock.
> Would that be OK for you?

Sounds good. Can you also fix up the changelog in patch #2? After that
I am happy with this series. I guess Jason will take it in and send it
for his PR?

Thanks,
Mike

> 
> Thanks,
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

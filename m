From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Mar 2013 20:31:42 -0700
Subject: [PATCH 1/1] clk: Add notifier support in clk_prepare/clk_unprepare
In-Reply-To: <1363748149.8815.16.camel@bilhuang-vm1>
References: <1363699712-8124-1-git-send-email-bilhuang@nvidia.com>
 <20130319170140.8663.93388@quantum> <1363748149.8815.16.camel@bilhuang-vm1>
Message-ID: <20130320033142.11073.30097@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bill Huang (2013-03-19 19:55:49)
> On Wed, 2013-03-20 at 01:01 +0800, Mike Turquette wrote:
> > Quoting Bill Huang (2013-03-19 06:28:32)
> > > Add notifier calls in clk_prepare and clk_unprepare so drivers which are
> > > interested in knowing that clk_prepare/unprepare call can act accordingly.
> > > 
> > > The existing "clk_set_rate" notifier is not enough for normal DVFS
> > > inplementation since clock might be enabled/disabled at runtime. Adding
> > > these notifiers is useful on DVFS core which take clk_prepare as a hint
> > > on that the notified clock might be enabled later so it can raise voltage
> > > to a safe level before enabling the clock, and take clk_unprepare as a
> > > hint that the clock has been disabled and is safe to lower the voltage.
> > > 
> > > The added notifier events are:
> > > 
> > > PRE_CLK_PREPARE
> > > POST_CLK_PREPARE
> > > ABORT_CLK_PREPARE
> > > PRE_CLK_UNPREPARE
> > > POST_CLK_UNPREPARE
> > > 
> > > Signed-off-by: Bill Huang <bilhuang@nvidia.com>
> > 
> > I'm still not sure about this approach.  Based on feedback I got from
> > Linaro Connect I am not convinced that scaling voltage through clk
> > rate-change notifiers is the right way to go.  As I understand it this
> > patch only exists for that single purpose, so if the voltage-notifier
> > idea gets dropped then I will not take this patch in.
> > 
> Thanks Mike, actually we won't use your "clk: notifier handler for
> dynamic voltage scaling" patch instead we are trying to port our DVFS
> into Non-CPU DVFS framework "devfreq" which will need to hook those
> notifiers, without the clock notifiers been extended the framework is
> useless for us since we cannot do polling due to the fact that polling
> is not in real time. If it ended up extending the notifiers cannot
> happen then the only choice for us I think would be giving up "devfreq"
> and implement them in Tegra's "clk_hw".

I'm familiar with the devfreq framework.  Can you explain further how
you plan to use devfreq with the clock notifiers?  What does the call
graph look like?

Thanks,
Mike

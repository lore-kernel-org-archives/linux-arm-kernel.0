From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 03 Mar 2013 23:25:19 -0800
Subject: [PATCH 2/5] clk: notifier handler for dynamic voltage scaling
In-Reply-To: <20130303132749.GA5887@richard-laptop>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
 <1362026969-11457-3-git-send-email-mturquette@linaro.org>
 <1362130891.19498.12.camel@bilhuang-vm1>
 <20130301182234.6210.63879@quantum> <20130301204832.6210.40653@quantum>
 <1362192954.2407.26.camel@bilhuang-vm1>
 <20130302082216.GA4581@richard-laptop> <20130303105424.6210.1196@quantum>
 <20130303132749.GA5887@richard-laptop>
Message-ID: <20130304072519.6210.97088@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Richard Zhao (2013-03-03 05:27:52)
> Hi Mike,
> 
> On Sun, Mar 03, 2013 at 02:54:24AM -0800, Mike Turquette wrote:
> > Quoting Richard Zhao (2013-03-02 00:22:19)
> > > On Fri, Mar 01, 2013 at 06:55:54PM -0800, Bill Huang wrote:
> > > > On Sat, 2013-03-02 at 04:48 +0800, Mike Turquette wrote:
> > > > > Quoting Mike Turquette (2013-03-01 10:22:34)
> > > > > > Quoting Bill Huang (2013-03-01 01:41:31)
> > > > > > > On Thu, 2013-02-28 at 12:49 +0800, Mike Turquette wrote:
> > > > > > > > Dynamic voltage and frequency scaling (dvfs) is a common power saving
> > > > > > > > technique in many of today's modern processors.  This patch introduces a
> > > > > > > > common clk rate-change notifier handler which scales voltage
> > > > > > > > appropriately whenever clk_set_rate is called on an affected clock.
> > > > > > > 
> > > > > > > I really think clk_enable and clk_disable should also be triggering
> > > > > > > notifier call and DVFS should act accordingly since there are cases
> > > > > > > drivers won't set clock rate but instead disable its clock directly, do
> > > > > > > you agree?
> > > > > > > > 
> > > > > > 
> > > > > > Hi Bill,
> > > > > > 
> > > > > > I'll think about this.  Perhaps a better solution would be to adapt
> > > > > > these drivers to runtime PM.  Then a call to runtime_pm_put() would
> > > > > > result in a call to clk_disable(...) and regulator_set_voltage(...).
> > > > > > 
> > > > > > There is no performance-based equivalent to runtime PM, which is one
> > > > > > reason why clk_set_rate is a likely entry point into dvfs.  But for
> > > > > > operations that have nice api's like runtime PM it would be better to
> > > > > > use those interfaces and not overload the clk.h api unnecessarily.
> > > > > > 
> > > > > 
> > > > > Bill,
> > > > > 
> > > > > I wasn't thinking at all when I wrote this.  Trying to rush to the
> > > > > airport I guess...
> > > > > 
> > > > > clk_enable() and clk_disable() must not sleep and all operations are
> > > > > done under a spinlock.  So this rules out most use of notifiers.  It is
> > > > > expected for some drivers to very aggressively enable/disable clocks in
> > > > > interrupt handlers so scaling voltage as a function of clk_{en|dis}able
> > > > > calls is also likely out of the question.
> > > > 
> > > > Yeah for those existing drivers to call enable/disable clocks in
> > > > interrupt have ruled out this, I didn't think through when I was asking.
> > > > > 
> > > > > Some platforms have chosen to implement voltage scaling in their
> > > > > .prepare callbacks.  I personally do not like this and still prefer
> > > > > drivers be adapted to runtime pm and let those callbacks handle voltage
> > > > > scaling along with clock handling.
> > > Voltage scaling in clock notifiers seems similar. Clock and regulater
> > > embedded code into each other will cause things complicated.
> > 
> > Hi Richard,
> > 
> > Sorry, I do not follow the above statement.  Can you clarify what you
> > mean?
> As we have agreement that a operating point may have multiple clocks
> and regulators, this patch is impossible to support multi clocks. And
> it might mislead dvfs implementer to use clock notifier. It may be good
> to have unified api like dvfs_set_opp(opp), or drivers can handle clocks
> and regulators theirselves which is more flexible. What do you think?
> 

Yes, there is a long-standing question whether clk_set_rate is
sufficient to cover dvfs needs or if a new api is required.  There are
many possible solutions.

One solution is to use clk_set_rate and use the rate-change notifiers to
call clk_set_rate on the other required clocks.  This is graceful from
the perspective of the driver since the driver author only has to think
about directly managing the clock(s) for that device and the rest is
managed automagically.  It is more complicated for the platform
integrator that must make sure the automagical stuff is set up
correctly.  This might be considered a more "distributed" approach.

Another solution would be a new api which calls clk_set_rate
individually on the affected clocks (e.g. a functional clk, an async
bridge child clock, and some other related non-child clock).  This is
less complicated for the platform integrator and represents a more
"centralized" approach.  It is less graceful for the device driver
author who must learn a new api and decide whether to call the new api
or to call clk_set_rate.

A hybrid solution might be to set a flag on a clock (e.g.
CLK_SET_RATE_DVFS) which tells the clk framework that this clock is
special and clk_set_rate should call dvfs_set_opp(), where
dvfs_set_opp() is never exposed to drivers directly.

None of the above solutions are related to your point about scaling
voltage from clk_set_rate.  Voltage may still be scaled from the clock
rate-change notifier despite the method chose to scale groups of clocks.

Regards,
Mike

> Thanks
> Richard

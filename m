From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 01 Mar 2013 10:22:34 -0800
Subject: [PATCH 2/5] clk: notifier handler for dynamic voltage scaling
In-Reply-To: <1362130891.19498.12.camel@bilhuang-vm1>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
 <1362026969-11457-3-git-send-email-mturquette@linaro.org>
 <1362130891.19498.12.camel@bilhuang-vm1>
Message-ID: <20130301182234.6210.63879@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Bill Huang (2013-03-01 01:41:31)
> On Thu, 2013-02-28 at 12:49 +0800, Mike Turquette wrote:
> > Dynamic voltage and frequency scaling (dvfs) is a common power saving
> > technique in many of today's modern processors.  This patch introduces a
> > common clk rate-change notifier handler which scales voltage
> > appropriately whenever clk_set_rate is called on an affected clock.
> 
> I really think clk_enable and clk_disable should also be triggering
> notifier call and DVFS should act accordingly since there are cases
> drivers won't set clock rate but instead disable its clock directly, do
> you agree?
> > 

Hi Bill,

I'll think about this.  Perhaps a better solution would be to adapt
these drivers to runtime PM.  Then a call to runtime_pm_put() would
result in a call to clk_disable(...) and regulator_set_voltage(...).

There is no performance-based equivalent to runtime PM, which is one
reason why clk_set_rate is a likely entry point into dvfs.  But for
operations that have nice api's like runtime PM it would be better to
use those interfaces and not overload the clk.h api unnecessarily.

> > There are three prerequisites to using this feature:
> > 
> > 1) the affected clocks must be using the common clk framework
> > 2) voltage must be scaled using the regulator framework
> > 3) clock frequency and regulator voltage values must be paired via the
> > OPP library
> 
> Just a note, Tegra Core won't meet prerequisite #3 since each regulator
> voltage values is associated with clocks driving those many sub-HW
> blocks in it.

This patch isn't the one and only way to perform dvfs.  It is just a
helper function for registering notifier handlers for systems that meet
the above three requirements.  Even if you do not use the OPP library
there is no reason why you could not register your own rate-change
notifier handler to implement dvfs using whatever lookup-table you use
today.

And patches are welcome to extend the usefulness of this helper.  I'd
like as many people to benefit from this mechanism as possible.

At some point we should think hard about DT bindings for these operating
points...

Regards,
Mike

From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 4 May 2012 16:08:20 -0700
Subject: common clock framework
In-Reply-To: <20120504082110.GB16535@pengutronix.de>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
Message-ID: <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 1:21 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, May 03, 2012 at 07:02:07PM -0700, Chao Xie wrote:
>> Hi,
>> The common clock driver in drivers/clk/ has been integrated into mainline. In fact, I still have some questions to the driver.
>> 1. Why need big lock: enable_lock and prepare_lock?
>> ? ?Using these locks means that the clock enable and prepare operation cannot re-entered.
>
> This has been discussed at length on the list. Short answer is that it's
> not trivial to properly lock the clock tree (or parts thereof) if we have
> individual clock locks. The possibility of having a lock per tree has
> been discussed if the single lock approach turns out to be unsufficient.
> This may be added later.

I think it is worth discussing improvements to the locking scheme.
More on that below.

snip

>> 3. how to handle voltage changes in clock framework? ?When some
>> clock's rate is changed, the voltage for the component that using the
>> clock may need changed too. So where to add the voltage change
>> sequence?
>
> Clocks have notifiers attached to them. You can hook yourself into a pre
> rate change (increasing the voltage here) and into a post rate change
> (decreasing the voltage here).
> That said, we are not there yet. Once the clock framework has settled
> and is actually used in SoCs I'm sure somebody will come up with some
> driver which can be passed a freq <-> voltage table for a given
> regulator clock pair.

We are very close.  I have been hacking on this in a private branch
and have converted OMAP's CPUfreq driver over to using *only* the the
clock framework for DVFS.

Good news: it works!  The CPUfreq driver's .target callback does the
normal rate validation and table lookup to get a good rate for the
CPU, then it simply calls clk_set_rate.  The pre- and post-rate-change
notifiers are then fired off.  I have added notifier handlers to the
OMAP regulator drivers which use a look-up-table (soon to be converted
to the OPP library) to determine voltage and they simply call
regulator_set_voltage either before or after the clock rate changes,
depending on scaling direction.

Bad news: lockdep gets cranky about possible deadlocks due to holding
prepare_lock and then trying to hold it again in a rate-change
notifier handler (from OMAP's regulator code).  Specifically
clk_set_rate holds prepare_lock, and then the i2c message sent to the
PMIC to raise voltage calls clk_prepare as part of the standard
messaging sequence.  This is clearly a candidate for a deadlock.

Having clk_set_rate and clk_prepare both hold the same prepare_lock
mutex seems suboptimal, but it is easy.  Having reentrant accesses to
the clock tree is going to be hard...  I've spent some time thinking
of ways to solve this, but I would appreciate suggestions.  I suspect
the exact same case I'm describing above will affect many SoCs.

Regards,
Mike

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Feb 2011 11:54:49 +0100
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <201102011711.31258.jeremy.kerr@canonical.com>
References: <201102011711.31258.jeremy.kerr@canonical.com>
Message-ID: <20110201105449.GY1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jeremy,

On Tue, Feb 01, 2011 at 05:11:29PM +0800, Jeremy Kerr wrote:
> > I suggested that clk_prepare() be callable only from non-atomic contexts,
> > and do whatever's required to ensure that the clock is available.  That
> > may end up enabling the clock as a result.
> 
> I think that clk_prepare/clk_unprepare looks like the most promising solution, 
> so will try to get some preliminary patches done. Here's what I'm planning:
> 
> -----
> 
> The changes to the API are essentially:
> 
> 1) Document clk_enable/clk_disable as callable from atomic contexts, and
>    so clock implementations must not sleep within this function.
> 
> 2) For clock implementations that may sleep to turn on a clock, we add a
>    new pair of functions to the clock API: clk_prepare and clk_unprepare.
> 
>    These will provide hooks for the clock implmentation to do any sleepable
>    work (eg, wait for PLLs to settle) in preparation for a later clk_enable.
> 
>    For the most common clock implemntation cases (where clocks can be enabled 
>    atomically), these functions will be a no-op, and all of the enable/disable
>    work can be done in clk_enable/clk_disable.
> 
>    For implementations where clocks require blocking on enable/disable, most
>    of the work will be done in clk_prepare/clk_unprepare. The clk_enable
>    and clk_disable functions may be no-ops.
> 
> For drivers, this means that clk_prepare must be called (and have returned) 
> before calling clk_enable.
> 
> == Enable/Prepare counts ==
> 
> I intend to do the enable and prepare "counting" in the core clock API, 
> meaning that that the clk_ops callbacks will only invoked on the first 
> prepare/enable and the last unprepare/disable.
> 
> == Concurrency ==
> 
> Splitting the prepare and enable stages introduces the concurrency 
> requirements:
> 
> 1) clk_enable must not return before the clock is outputting a valid clock 
>    signal.
> 
> 2) clk_prepare must not return before the clock is fully prepared (ie, it is 
>    safe to call clk_enable).
> 
> It is not possible for clk_enable to wait for the clock to be prepared, 
> because that would require synchronisation with clk_prepare, which may then 
> require blocking. Therefore:
> 
> 3) The clock consumer *must* respect the proper ordering of clk_prepare and 
>    clk_enable. For example, drivers that call clk_enable during an interrupt 
>    must ensure that the interrupt handler will not be invoked until 
>    clk_prepare has returned.
> 
> == Other considerations ==
> 
> The time that a clock spends "prepared" is a superset of the the time that a 
> clock spends "enabled". Therefore, clocks that are switched on during 
> clk_prepare (ie, non-atomic clocks) will be running for a larger amount of 
> time. In some cases, this can be mitigated by moving some of the final 
> (atomic) switching functionality to the clk_enable function.
> 
> == Implementation ==
> 
> Basically:
> 
> struct clk {
> 	const struct clk_ops *ops
> 	int                  enable_count;
> 	spinlock_t           enable_lock;
> 	int                  prepare_count;
> 	struct mutex         prepare_lock;
> };
> 
> int clk_enable(struct clk *clk)
> {
> 	int ret = 0;
> 
> 	spin_lock(&clk->enable_lock);
> 	if (!clk->enable_count)
> 		ret = clk->ops->enable(clk);
> 
> 	if (!ret)
> 		clk->enable_count++;
> 	spin_unlock(&clk->enable_lock);
> 
> 	return ret;
> }
> 
> int clk_prepare(struct clk *clk)
> {
> 	int ret = 0;
> 
> 	mutex_lock(&clk->prepare_lock);
> 	if (!clk->prepare_count)
> 		ret = clk->ops->prepare(clk);
> 
> 	if (!ret)
> 		clk->prepare_count++;
> 	mutex_unlock(&clk->prepare_lock);
> 
> 	return ret;
> }
> 
> -----
> 
> Comments welcome, code coming soon.
Do you plan to handle the case that clk_enable is called while prepare
isn't completed (considering the special case "not called at all")?
Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?

Alternatively don't force the sleep in clk_prepare (e.g. by protecting
prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
before calling clk->ops->enable?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

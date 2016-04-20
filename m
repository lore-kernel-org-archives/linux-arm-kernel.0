From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 20 Apr 2016 09:23:54 -0700
Subject: [PATCH] drivers/perf: arm-pmu: fix RCU usage on resume from idle
 states
In-Reply-To: <20160420134116.GA8537@red-moon>
References: <1461085689-2893-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160419172320.GD4509@arm.com> <7hr3e1b77r.fsf@baylibre.com>
 <20160420134116.GA8537@red-moon>
Message-ID: <20160420162354.GB3539@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 02:41:16PM +0100, Lorenzo Pieralisi wrote:
> [+ Paul, Nico]
> 
> On Tue, Apr 19, 2016 at 02:48:40PM -0700, Kevin Hilman wrote:
> > Will Deacon <will.deacon@arm.com> writes:
> > 
> > > Hi Lorenzo,
> > >
> > > On Tue, Apr 19, 2016 at 06:08:09PM +0100, Lorenzo Pieralisi wrote:
> > >> Commit da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
> > >> added code in the arm perf infrastructure that allows the kernel to
> > >> save/restore perf counters whenever the CPU enters a low-power idle
> > >> state. The kernel saves/restores the counters for each active event
> > >> through the armpmu_{stop/start} ARM pmu API, so that the idle state
> > >> enter/exit power cycle is emulated through pmu start/stop operations
> > >> for each event in use.
> > >> 
> > >> However, calling armpmu_start() for each active event on power up
> > >> executes code that requires RCU locking (perf_event_update_userpage())
> > >> to be functional, so, given that the core may call the CPU_PM notifiers
> > >> while running the idle thread in an quiescent RCU state this is not
> > >> allowed as detected through the following splat when kernel is run with
> > >> CONFIG_PROVE_LOCKING enabled:
> > >> 
> > >> [   49.293286]
> > >> [   49.294761] ===============================
> > >> [   49.298895] [ INFO: suspicious RCU usage. ]
> > >> [   49.303031] 4.6.0-rc3+ #421 Not tainted
> > >> [   49.306821] -------------------------------
> > >> [   49.310956] include/linux/rcupdate.h:872 rcu_read_lock() used
> > >> illegally while idle!
> > >> [   49.318530]
> > >> [   49.318530] other info that might help us debug this:
> > >> [   49.318530]
> > >> [   49.326451]
> > >> [   49.326451] RCU used illegally from idle CPU!
> > >> [   49.326451] rcu_scheduler_active = 1, debug_locks = 0
> > >> [   49.337209] RCU used illegally from extended quiescent state!
> > >> [   49.342892] 2 locks held by swapper/2/0:
> > >> [   49.346768]  #0:  (cpu_pm_notifier_lock){......}, at:
> > >> [<ffffff8008163c28>] cpu_pm_exit+0x18/0x80
> > >> [   49.355492]  #1:  (rcu_read_lock){......}, at: [<ffffff800816dc38>]
> > >> perf_event_update_userpage+0x0/0x260
> > >> 
> > >> This patch refactors the perf CPU_PM notifiers to add a boolean
> > >> flag to the function updating the counters event period, so that the
> > >> userpage update can be skipped when resuming from low-power whilst
> > >> keeping correct save/restore functionality for the running events.
> > >> 
> > >> As a side effect the kernel, while resuming from low-power with
> > >> perf events enabled, runs with a userspace view of active counters that
> > >> is not up-to-date with the kernel one, but since the core power down is
> > >> not really a PMU event start/stop this can be considered acceptable and
> > >> the userspace event snapshot will update the user view of counters
> > >> on subsequent perf event updates requested by either the perf API
> > >> or event counters overflow-triggered interrupts.
> > >> 
> > >> Fixes: da4e4f18afe0 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
> > >> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >> Reported-by: James Morse <james.morse@arm.com>
> > >> Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > >> Cc: Will Deacon <will.deacon@arm.com>
> > >> Cc: Kevin Hilman <khilman@baylibre.com>
> > >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> > >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >> Cc: Mark Rutland <mark.rutland@arm.com>
> > >> ---
> > >>  drivers/perf/arm_pmu.c | 26 +++++++++++++++++++++-----
> > >>  1 file changed, 21 insertions(+), 5 deletions(-)
> > >
> > > This is horrible, but I think it's the best we can do without completely
> > > redesigning the way in which we save/restore the PMU state. We should do
> > > that, but not for 4.6!
> > >
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Maybe RCU_NONIDLE() will help here?
> 
> Thanks for chiming in.
> 
> CPU_PM notifiers are called from process context (which is not necessarily
> the idle thread) with IRQs disabled from:
> 
> - CPUidle drivers state enter calls
> - syscore callbacks (ie suspend2RAM - suspend thread)
> - bL switcher
> - MCPM loopback
> 
> The questions I have are:
> 
> - Is it safe to wrap a call (in this case armpmu_start()) with RCU_NONIDLE
>   if the core is not actually executing the idle thread ? The function
>   requiring rcu locks/dereferences is perf_event_update_userpage().

Yes it is.

> - What are RCU_NONIDLE side-effects (ie what can be actually called from
>   within an RCU_NONIDLE wrapper ?)

There are a few restrictions:

1.	Code within RCU_NONIDLE() cannot block.  Then again, neither
	can the idle task.  ;-)

2.	RCU_NONIDLE() can be nested, but not indefinitely.  Then again,
	given that the limit even on a 32-bit system is something like
	a million, I bet you hit compiler or stack-size limits long
	before you overflow RCU_NONIDLE()'s counter.

3.	You can neither branch into the middle of RCU_NONIDLE()'s code
	nor branch out from the middle of RCU_NONIDLE()'s code.
	Calling functions is just fine, but things like this are not:

		RCU_NONIDLE({
			do_something();
			goto bad_idea;	/* BUG!!! */
			do_something_else();});
		do_yet_a_third_thing();
	bad_idea:

	Branching -within- the RCU_NONIDLE() code is just fine.

Yes, and I am adding this information to RCU_NONIDLE()'s header
comment, apologies for its not being there to begin with!
(See below for patches.)

> It would be nice if we can use it instead of merging this patch, I need
> more insights into RCU_NONIDLE usage though before proceeding.

Please let me know if any of the above restrictions cause you a problem.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index e7e24b3e86e2..ece410f40436 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2391,6 +2391,41 @@ and <tt>RCU_NONIDLE()</tt> on the other while inspecting
 idle-loop code.
 Steven Rostedt supplied <tt>_rcuidle</tt> event tracing,
 which is used quite heavily in the idle loop.
+However, there are some restrictions on the code placed within
+<tt>RCU_NONIDLE()</tt>:
+
+<ol>
+<li>	Blocking is prohibited.
+	In practice, this is not a serious restriction given that idle
+	tasks are prohibited from blocking to begin with.
+<li>	Although nesting <tt>RCU_NONIDLE()</tt> is permited, they cannot
+	nest indefinitely deeply.
+	However, given that they can be nested on the order of a million
+	deep, even on 32-bit systems, this should not be a serious
+	restriction.
+	This nesting limit would probably be reached long after the
+	compiler OOMed or the stack overflowed.
+<li>	Any code path that enters <tt>RCU_NONIDLE()</tt> must sequence
+	out of that same <tt>RCU_NONIDLE()</tt>.
+	For example, the following is grossly illegal:
+
+	<blockquote>
+	<pre>
+ 1     RCU_NONIDLE({
+ 2       do_something();
+ 3       goto bad_idea;  /* BUG!!! */
+ 4       do_something_else();});
+ 5   bad_idea:
+	</pre>
+	</blockquote>
+
+	<p>
+	It is just as illegal to transfer control into the middle of
+	<tt>RCU_NONIDLE()</tt>'s argument.
+	Yes, in theory, you could transfer in as long as you also
+	transferred out, but in practice you could also expect to get sharply
+	worded review comments.
+</ol>
 
 <p>
 It is similarly socially unacceptable to interrupt an
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5f1533e3d032..c61b6b9506e7 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -379,12 +379,13 @@ static inline void rcu_init_nohz(void)
  * in the inner idle loop.
  *
  * This macro provides the way out:  RCU_NONIDLE(do_something_with_RCU())
- * will tell RCU that it needs to pay attending, invoke its argument
- * (in this example, a call to the do_something_with_RCU() function),
+ * will tell RCU that it needs to pay attention, invoke its argument
+ * (in this example, calling the do_something_with_RCU() function),
  * and then tell RCU to go back to ignoring this CPU.  It is permissible
- * to nest RCU_NONIDLE() wrappers, but the nesting level is currently
- * quite limited.  If deeper nesting is required, it will be necessary
- * to adjust DYNTICK_TASK_NESTING_VALUE accordingly.
+ * to nest RCU_NONIDLE() wrappers, but not indefinitely (but the limit is
+ * on the order of a million or so, even on 32-bit systems).  It is
+ * not legal to block within RCU_NONIDLE(), nor is it permissible to
+ * transfer control either into or out of RCU_NONIDLE()'s statement.
  */
 #define RCU_NONIDLE(a) \
 	do { \

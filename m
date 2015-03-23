From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 23 Mar 2015 09:56:40 -0700
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150323153742.GF5718@linux.vnet.ibm.com>
References: <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
 <20150225170011.GC8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502251257410.25484@knanqh.ubzr>
 <alpine.LFD.2.11.1502251427580.25484@knanqh.ubzr>
 <20150226010505.GU15405@linux.vnet.ibm.com>
 <20150322233057.GA17605@linux.vnet.ibm.com>
 <20150323125545.GP8656@n2100.arm.linux.org.uk>
 <20150323132133.GD5718@linux.vnet.ibm.com>
 <20150323140041.GQ8656@n2100.arm.linux.org.uk>
 <20150323153742.GF5718@linux.vnet.ibm.com>
Message-ID: <20150323165640.GA3431@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 08:37:42AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 23, 2015 at 02:00:41PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 23, 2015 at 06:21:33AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 23, 2015 at 12:55:45PM +0000, Russell King - ARM Linux wrote:
> > > > What if the cpu_hotplug_state for the CPU changes between reading it
> > > > testing its value, and then writing it, or do we guarantee that it
> > > > can't change other than by this function here?  If it can't change,
> > > > then what's the point of using atomic_t for this?
> > > 
> > > It indeed cannot change -here-, but there are other situations where
> > > more than one CPU can be attempting to change it at the same time.
> > > The reason that it cannot change here is that the variable has the
> > > value that indicates that the previous offline completed within the
> > > timeout period, so there are no outstanding writes.
> > > 
> > > When going offline, the outgoing CPU might take so long leaving that
> > > the surviving CPU times out, thus both CPUs write to the variable at
> > > the same time, which by itself requires atomics.  If this seems
> > > unlikely, consider virtualized environments where the hypervisor
> > > might preempt the guest OS.
> > 
> > If two CPUs write using atomic_set() to the same location, what value do
> > you end up with?  It's just the same as if two CPUs write normally to the
> > same location.
> 
> If that happens when using these functions, that is a usage error.
> 
> > The only way it can be different is if you use atomic_cmpxchg(), or
> > cmpxchg() so you can atomically test that the original value is what's
> > expected prior to writing it.
> > 
> > To illustrate this (I'll abbreviate the per-cpu state):
> > 
> > 	CPU0					CPU1
> > 	oldstate = atomic_read(state);
> > 	if (oldstate == CPU_DEAD) /* it isn't */
> > 	atomic_cmpxchg(state, oldstate, CPU_BROKEN)
> > 						atomic_xchg(state, CPU_DEAD)
> > 
> > 	/* succeeds */
> > 	!= old_state /* fails */
> > 	... so doesn't loop
> > 	cpu_wait_death() returns false (failed)
> > 
> > Here, we report that the CPU failed to go offline, but the state is set
> > to CPU_DEAD.  If it had been slightly earlier, CPU0 would have updated
> > it to CPU_DEAD_POST.
> 
> Indeed.  Which is precisely why cpu_check_up_prepare() returns an error
> after that timeout occurs.  This allows the arch code to decide what to
> do, which might be to reset the CPU in some way.  Or to simply error
> out the attempt to online the CPU.
> 
> > If we instead got rid of this atomic stuff, and looked at the code
> > without atomic_* stuff confusing the picture, we'd probably have seen
> > that.  This is why, whenever I see atomic_read() and atomic_set(), I'm
> > very suspicious that the code is correct; virtually every time I've
> > seen this pattern, the code has always had some problem.  I utterly
> > hate code which uses these functions.
> 
> They do have their uses, including this case.
> 
> > So, I'd suggest getting rid of atomic_read() and atomic_set() here
> > converting atomic_cmpxchg() to a plain cmpxchg(), and replacing that
> > atomic_xchg() with a similar call to cmpxchg() so that a broken CPU
> > doesn't confusingly end up being reported as broken yet getting a
> > CPU_DEAD state.
> 
> And exactly how would that help?  You have all the same issues with this
> transformed version of the code.  You just have READ_ONCE() instead of
> atomic_read() and WRITE_ONCE() instead of atomic_set().  Or you have
> bare accesses that the compiler might well be able to optimize into
> nonsensical code.  Again, how does this help?
> 
> > After all, we know that a CPU going down _should_ be online before it
> > goes down - if it isn't online, how can it be executing code. :)
> 
> That is indeed one scenario.
> 
> Another scenario is that the CPU failed to go down promptly during a
> previous offline operation, and the arch-specific code chose to ignore
> that error when the CPU was next brought online.  In this case, at the
> next offline, this code would se CPU_DEAD_FROZEN or CPU_BROKEN instead
> of CPU_ONLINE.  And there are architectures that do just this.

And if you want to avoid the possibility of atomic_set() racing with
atomic_xchg() and atomic_cmpxchg() when using these functions, what you do
is either (1) refuse to online a CPU when cpu_check_up_prepare() returns
an error or (2) have some way to reset the CPU when cpu_check_up_prepare()
returns an error.

Please see below for an up-to-date version of this patch.

							Thanx, Paul

------------------------------------------------------------------------

    smpboot: Add common code for notification from dying CPU
    
    RCU ignores offlined CPUs, so they cannot safely run RCU read-side code.
    (They -can- use SRCU, but not RCU.)  This means that any use of RCU
    during or after the call to arch_cpu_idle_dead().  Unfortunately,
    commit 2ed53c0d6cc99 added a complete() call, which will contain RCU
    read-side critical sections if there is a task waiting to be awakened.
    
    Which, as it turns out, there almost never is.  In my qemu/KVM testing,
    the to-be-awakened task is not yet asleep more than 99.5% of the time.
    In current mainline, failure is even harder to reproduce, requiring a
    virtualized environment that delays the outgoing CPU by at least three
    jiffies between the time it exits its stop_machine() task at CPU_DYING
    time and the time it calls arch_cpu_idle_dead() from the idle loop.
    However, this problem really can occur, especially in virtualized
    environments, and therefore really does need to be fixed
    
    This suggests moving back to the polling loop, but using a much shorter
    wait, with gentle exponential backoff instead of the old 100-millisecond
    wait.  Most of the time, the loop will exit without waiting at all,
    and almost all of the remaining uses will wait only five microseconds.
    If the outgoing CPU is preempted, a loop will wait one jiffy, then
    increase the wait by a factor of 11/10ths, rounding up.  As before, there
    is a five-second timeout.
    
    This commit therefore provides common-code infrastructure to do the
    dying-to-surviving CPU handoff in a safe manner.  This code also
    provides an indication at CPU-online of whether the CPU to be onlined
    previously timed out on offline.  The new cpu_check_up_prepare() function
    returns -EBUSY if this CPU previously took more than five seconds to
    go offline, or -EAGAIN if it has not yet managed to go offline.  The
    rationale for -EAGAIN is that it might still be preempted, so an additional
    wait might well find it correctly offlined.  Architecture-specific code
    can decide how to handle these conditions.  Systems in which CPUs take
    themselves completely offline might respond to an -EBUSY return as if
    it was a zero (success) return.  Systems in which the surviving CPU must
    take some action might take it at this time, or might simply mark the
    other CPU as unusable.
    
    Note that architectures that take the easy way out and simply pass the
    -EBUSY and -EAGAIN upwards will change the sysfs API.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: <linux-api@vger.kernel.org>
    Cc: <linux-arch@vger.kernel.org>
    [ paulmck: Fixed state machine for architectures that don't check earlier
      CPU-hotplug results as suggested by James Hogan. ]

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 4260e8594bd7..4744ef915acd 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -95,6 +95,8 @@ enum {
 					* Called on the new cpu, just before
 					* enabling interrupts. Must not sleep,
 					* must not fail */
+#define CPU_BROKEN		0x000C /* CPU (unsigned)v did not die properly,
+					* perhaps due to preemption. */
 
 /* Used for CPU hotplug events occurring while tasks are frozen due to a suspend
  * operation in progress
@@ -271,4 +273,14 @@ void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void arch_cpu_idle_dead(void);
 
+DECLARE_PER_CPU(bool, cpu_dead_idle);
+
+int cpu_report_state(int cpu);
+int cpu_check_up_prepare(int cpu);
+void cpu_set_state_online(int cpu);
+#ifdef CONFIG_HOTPLUG_CPU
+bool cpu_wait_death(unsigned int cpu, int seconds);
+bool cpu_report_death(void);
+#endif /* #ifdef CONFIG_HOTPLUG_CPU */
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 40190f28db35..c697f73d82d6 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -4,6 +4,7 @@
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/smp.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -314,3 +315,158 @@ void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread)
 	put_online_cpus();
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
+
+static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
+
+/*
+ * Called to poll specified CPU's state, for example, when waiting for
+ * a CPU to come online.
+ */
+int cpu_report_state(int cpu)
+{
+	return atomic_read(&per_cpu(cpu_hotplug_state, cpu));
+}
+
+/*
+ * If CPU has died properly, set its state to CPU_UP_PREPARE and
+ * return success.  Otherwise, return -EBUSY if the CPU died after
+ * cpu_wait_death() timed out.  And yet otherwise again, return -EAGAIN
+ * if cpu_wait_death() timed out and the CPU still hasn't gotten around
+ * to dying.  In the latter two cases, the CPU might not be set up
+ * properly, but it is up to the arch-specific code to decide.
+ * Finally, -EIO indicates an unanticipated problem.
+ *
+ * Note that it is permissible to omit this call entirely, as is
+ * done in architectures that do no CPU-hotplug error checking.
+ */
+int cpu_check_up_prepare(int cpu)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
+		return 0;
+	}
+
+	switch (atomic_read(&per_cpu(cpu_hotplug_state, cpu))) {
+
+	case CPU_POST_DEAD:
+
+		/* The CPU died properly, so just start it up again. */
+		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
+		return 0;
+
+	case CPU_DEAD_FROZEN:
+
+		/*
+		 * Timeout during CPU death, so let caller know.
+		 * The outgoing CPU completed its processing, but after
+		 * cpu_wait_death() timed out and reported the error. The
+		 * caller is free to proceed, in which case the state
+		 * will be reset properly by cpu_set_state_online().
+		 * Proceeding despite this -EBUSY return makes sense
+		 * for systems where the outgoing CPUs take themselves
+		 * offline, with no post-death manipulation required from
+		 * a surviving CPU.
+		 */
+		return -EBUSY;
+
+	case CPU_BROKEN:
+
+		/*
+		 * The most likely reason we got here is that there was
+		 * a timeout during CPU death, and the outgoing CPU never
+		 * did complete its processing.  This could happen on
+		 * a virtualized system if the outgoing VCPU gets preempted
+		 * for more than five seconds, and the user attempts to
+		 * immediately online that same CPU.  Trying again later
+		 * might return -EBUSY above, hence -EAGAIN.
+		 */
+		return -EAGAIN;
+
+	default:
+
+		/* Should not happen.  Famous last words. */
+		return -EIO;
+	}
+}
+
+/*
+ * Mark the specified CPU online.
+ *
+ * Note that it is permissible to omit this call entirely, as is
+ * done in architectures that do no CPU-hotplug error checking.
+ */
+void cpu_set_state_online(int cpu)
+{
+	(void)atomic_xchg(&per_cpu(cpu_hotplug_state, cpu), CPU_ONLINE);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+/*
+ * Wait for the specified CPU to exit the idle loop and die.
+ */
+bool cpu_wait_death(unsigned int cpu, int seconds)
+{
+	int jf_left = seconds * HZ;
+	int oldstate;
+	bool ret = true;
+	int sleep_jf = 1;
+
+	might_sleep();
+
+	/* The outgoing CPU will normally get done quite quickly. */
+	if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
+		goto update_state;
+	udelay(5);
+
+	/* But if the outgoing CPU dawdles, wait increasingly long times. */
+	while (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) != CPU_DEAD) {
+		schedule_timeout_uninterruptible(sleep_jf);
+		jf_left -= sleep_jf;
+		if (jf_left <= 0)
+			break;
+		sleep_jf = DIV_ROUND_UP(sleep_jf * 11, 10);
+	}
+update_state:
+	oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
+	if (oldstate == CPU_DEAD) {
+		/* Outgoing CPU died normally, update state. */
+		smp_mb(); /* atomic_read() before update. */
+		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_POST_DEAD);
+	} else {
+		/* Outgoing CPU still hasn't died, set state accordingly. */
+		if (atomic_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
+				   oldstate, CPU_BROKEN) != oldstate)
+			goto update_state;
+		ret = false;
+	}
+	return ret;
+}
+
+/*
+ * Called by the outgoing CPU to report its successful death.  Return
+ * false if this report follows the surviving CPU's timing out.
+ *
+ * A separate "CPU_DEAD_FROZEN" is used when the surviving CPU
+ * timed out.  This approach allows architectures to omit calls to
+ * cpu_check_up_prepare() and cpu_set_state_online() without defeating
+ * the next cpu_wait_death()'s polling loop.
+ */
+bool cpu_report_death(void)
+{
+	int oldstate;
+	int newstate;
+	int cpu = smp_processor_id();
+
+	do {
+		oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
+		if (oldstate != CPU_BROKEN)
+			newstate = CPU_DEAD;
+		else
+			newstate = CPU_DEAD_FROZEN;
+	} while (atomic_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
+				oldstate, newstate) != oldstate);
+	return newstate == CPU_DEAD;
+}
+
+#endif /* #ifdef CONFIG_HOTPLUG_CPU */

From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 12 Dec 2017 08:49:00 -0800
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171210213930.GL7829@linux.vnet.ibm.com>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
Message-ID: <20171212164900.GA6673@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 10, 2017 at 01:39:30PM -0800, Paul E. McKenney wrote:
> On Sun, Dec 10, 2017 at 07:34:39PM +0000, Russell King - ARM Linux wrote:
> > On Sun, Dec 10, 2017 at 11:07:27AM -0800, Paul E. McKenney wrote:
> > > On Sun, Dec 10, 2017 at 12:00:12PM +0000, Russell King - ARM Linux wrote:
> > > > +Paul
> > > > 
> > > > Annoyingly, it looks like calling "complete()" from a dying CPU is
> > > > triggering the RCU usage warning.  From what I remember, this is an
> > > > old problem, and we still have no better solution for this other than
> > > > to persist with the warning.
> > > 
> > > I thought that this issue was resolved with tglx's use of IPIs from
> > > the outgoing CPU.  Or is this due to an additional complete() from the
> > > ARM code?  If so, could it also use tglx's IPI trick?
> > 
> > I don't think it was tglx's IPI trick, I've had code sitting in my tree
> > for a while for it, but it has its own set of problems which are not
> > resolvable:
> > 
> > 1. it needs more IPIs than we have available on all platforms
> 
> OK, I will ask the stupid question...  Is it possible to multiplex
> the IPIs, for example, by using smp_call_function_single()?

On the perhaps unlikely off-chance that it is both useful and welcome,
the (untested, probably does not even build) patch below illustrates the
use of smp_call_function_single().  This is based on the patch Russell
sent -- for all I know, it might well be that there are other places
needing similar changes.

But something to try out for anyone wishing to do so.

							Thanx, Paul

------------------------------------------------------------------------

commit c579a1494ccbc7ebf5548115571a2988ea1a1fe5
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Dec 11 09:40:58 2017 -0800

    ARM: CPU hotplug: Delegate complete() to surviving CPU
    
    The ARM implementation of arch_cpu_idle_dead() invokes complete(), but
    does so after RCU has stopped watching the outgoing CPU, which results
    in lockdep complaints because complete() invokes functions containing RCU
    readers.  This patch therefore uses Thomas Gleixner's trick of delegating
    the complete() call to a surviving CPU via smp_call_function_single().
    
    This patch is untested, and probably does not even build.

    Reported-by: Peng Fan <van.freenix@gmail.com>
    Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b4fbf00ee4ad..75f85e20aafa 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -267,6 +267,14 @@ void __cpu_die(unsigned int cpu)
 }
 
 /*
+ * Invoke complete() on behalf of the outgoing CPU.
+ */
+static void arch_cpu_idle_dead_complete(void *arg)
+{
+	complete(&cpu_died);
+}
+
+/*
  * Called from the idle thread for the CPU which has been shutdown.
  *
  * Note that we disable IRQs here, but do not re-enable them
@@ -293,9 +301,11 @@ void arch_cpu_idle_dead(void)
 	/*
 	 * Tell __cpu_die() that this CPU is now safe to dispose of.  Once
 	 * this returns, power and/or clocks can be removed at any point
-	 * from this CPU and its cache by platform_cpu_kill().
+	 * from this CPU and its cache by platform_cpu_kill().  We cannot
+	 * call complete() this late, so we delegate it to an online CPU.
 	 */
-	complete(&cpu_died);
+	smp_call_function_single(cpumask_first(cpu_online_mask),
+				 arch_cpu_idle_dead_complete, NULL, 0);
 
 	/*
 	 * Ensure that the cache lines associated with that completion are

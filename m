From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 15 Dec 2017 10:23:40 -0800
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171215155218.GB7829@linux.vnet.ibm.com>
References: <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
 <20171213091245.GH10595@n2100.armlinux.org.uk>
 <20171215063817.GX7829@linux.vnet.ibm.com>
 <CAOMZO5Cte467YdvOvg_teuKdP435nFd0_t1j6Mxtax43GqMqYw@mail.gmail.com>
 <20171215155218.GB7829@linux.vnet.ibm.com>
Message-ID: <20171215182340.GA30443@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 07:52:18AM -0800, Paul E. McKenney wrote:
> On Fri, Dec 15, 2017 at 11:16:43AM -0200, Fabio Estevam wrote:
> > Hi Paul,
> > 
> > On Fri, Dec 15, 2017 at 4:38 AM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > For your amusement, I have a patch below that takes a paranoid view of
> > > the possible answers to these questions.  This patch is untested and
> > > probably does not even build.  Plus its polling loop is quite naive.
> > 
> > I tried to build it, but if fails to link:
> > 
> >   LD      vmlinux.o
> >   MODPOST vmlinux.o
> > arch/arm/kernel/smp.o: In function `__cpu_die':
> > smp.c:(.text+0x44c): undefined reference to `__bad_xchg'
> > Makefile:1024: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> 
> OK, I will need to make a better choice of atomic operation.
> 
> Thank you for testing this!

How about this one, also untested etc.?

								Thanx, Paul

------------------------------------------------------------------------

commit 66c038bfa64ff75e0fcdf6756f6225d4253f5a81
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Dec 11 09:40:58 2017 -0800

    ARM: CPU hotplug: Delegate complete() to surviving CPU
    
    The ARM implementation of arch_cpu_idle_dead() invokes complete(), but
    does so after RCU has stopped watching the outgoing CPU, which results
    in lockdep complaints because complete() invokes functions containing RCU
    readers.  In addition, if the outgoing CPU really were to consume several
    seconds of its five-second allotted time, multiple RCU updates could
    complete, possibly giving the outgoing CPU an inconsistent view of the
    scheduler data structures on which complete() relies.
    
    This (untested, probably does not build) commit avoids this problem by
    polling the outgoing CPU.  The polling strategy in this prototype patch
    is quite naive, with one jiffy between each poll and without any sort
    of adaptive spin phase.  The key point is that the polling CPU uses
    atomic_dec_and_test(), which evicts the flag from the outgoing CPU's
    cache.  The outgoing CPU simply does an atomic_set() of the value 1 which
    causes the next atomic_dec_and_test() to return true, and which also
    minimizes opportunities for other data to get pulled into the outgoing
    CPU's cache.  This pulling of values from the outgoing CPU's cache is
    important because the outgoing CPU might be unceremoniously powered off
    before it has time to execute any code after the atomic_set().
    
    Underflow is avoided because there can be at most 5,000 invocations of
    atomic_dec_and_test() for a given offline operation, and the counter is
    set back to zero each time.
    
    Reported-by: Peng Fan <van.freenix@gmail.com>
    Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
    Cc: Michal Hocko <mhocko@suse.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Fabio Estevam <fabio.estevam@nxp.com>
    Cc: <linux-arm-kernel@lists.infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b4fbf00ee4ad..2fcffccf26ab 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -241,7 +241,7 @@ int __cpu_disable(void)
 	return 0;
 }
 
-static DECLARE_COMPLETION(cpu_died);
+static atomic_t cpu_died;
 
 /*
  * called on the thread which is asking for a CPU to be shutdown -
@@ -249,7 +249,17 @@ static DECLARE_COMPLETION(cpu_died);
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+	unsigned long deadline = jiffies + msecs_to_jiffies(5000);
+	char ret;
+
+	while (time_before(jiffies, deadline)) {
+		ret = atomic_dec_and_test(&cpu_died);
+		if (ret)
+			break;
+		schedule_timeout_interruptible(1);
+	}
+	atomic_set(&cpu_died, 0);
+	if (!ret) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -295,7 +305,7 @@ void arch_cpu_idle_dead(void)
 	 * this returns, power and/or clocks can be removed at any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
-	complete(&cpu_died);
+	atomic_set(&cpu_died, 1);
 
 	/*
 	 * Ensure that the cache lines associated with that completion are

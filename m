From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 Feb 2015 15:16:59 -0500 (EST)
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <alpine.LFD.2.11.1502251257410.25484@knanqh.ubzr>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150225125610.GY8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
 <20150225170011.GC8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502251257410.25484@knanqh.ubzr>
Message-ID: <alpine.LFD.2.11.1502251427580.25484@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015, Nicolas Pitre wrote:

> On Wed, 25 Feb 2015, Russell King - ARM Linux wrote:
> 
> > We could just use the spin-and-poll solution instead of an IPI, but
> > I really don't like that - when you see the complexity needed to
> > re-initialise it each time, it quickly becomes very yucky because
> > there is no well defined order between __cpu_die() and __cpu_kill()
> > being called by the two respective CPUs.
> > 
> > The last patch I saw doing that had multiple bits to indicate success
> > and timeout, and rather a lot of complexity to recover from failures,
> > and reinitialise state for a second CPU going down.
> 
> What about a per CPU state?  That would at least avoid the need to 
> serialize things across CPUs.  If only one CPU may write its state, that 
> should eliminate the need for any kind of locking.

Something like the following?  If according to $subject it is the 
complete() usage that has problems, then this replacement certainly has 
it removed while keeping things simple.  And I doubt CPU hotplug is 
performance critical so a simple polling is certainly good enough.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 86ef244c5a..f253f79a34 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -213,7 +213,7 @@ int __cpu_disable(void)
 	return 0;
 }
 
-static DECLARE_COMPLETION(cpu_died);
+static struct cpumask dead_cpus;
 
 /*
  * called on the thread which is asking for a CPU to be shutdown -
@@ -221,7 +221,14 @@ static DECLARE_COMPLETION(cpu_died);
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+	int i;
+
+	for (i = 5 * HZ; i > 0; i -= 10) {
+		if (cpumask_test_cpu(cpu, &dead_cpus))
+			break;
+		schedule_timeout_uninterruptible(10);
+	}
+	if (i <= 0) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -267,12 +274,12 @@ void __ref cpu_die(void)
 	 * this returns, power and/or clocks can be removed@any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
-	complete(&cpu_died);
+	cpumask_set_cpu(cpu, &dead_cpus);
 
 	/*
-	 * Ensure that the cache lines associated with that completion are
+	 * Ensure that the cache line associated with that dead_cpus update is
 	 * written out.  This covers the case where _this_ CPU is doing the
-	 * powering down, to ensure that the completion is visible to the
+	 * powering down, to ensure that the update is visible to the
 	 * CPU waiting for this one.
 	 */
 	flush_cache_louis();
@@ -349,6 +356,8 @@ asmlinkage void secondary_start_kernel(void)
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
+	cpumask_clear_cpu(cpu, &dead_cpus);
+
 	cpu_init();
 
 	pr_debug("CPU%u: Booted secondary processor\n", cpu);

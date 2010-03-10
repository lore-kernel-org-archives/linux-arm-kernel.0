From: jason.wessel@windriver.com (Jason Wessel)
Date: Wed, 10 Mar 2010 16:06:07 -0600
Subject: [Kgdb-bugreport] [PATCH] ARM: change definition of cpu_relax()
	for ARM11MPCore
In-Reply-To: <001001cabfb2$4a75d2c0$df617840$@deacon@arm.com>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>	<20100309162202.GB17251@n2100.arm.linux.org.uk>	<000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>	<20100309164926.GC17251@n2100.arm.linux.org.uk>
	<001001cabfb2$4a75d2c0$df617840$@deacon@arm.com>
Message-ID: <4B9817CF.2050807@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:

>> Clearly, kgdb is using atomic_set()/atomic_read() in a way which does not
>> match this documentation - it's certainly missing the barriers as required
>> by the above quoted paragraphs.
>>
>> Let me repeat: atomic_set() and atomic_read() are NOT atomic.  There's
>> nothing atomic about them.  All they do is provide a pair of accessors
>> to the underlying value in the atomic type.  They are no different to
>> declaring a volatile int and reading/writing it directly.


Clearly the docs state this.

> 
> Indeed. I'm not familiar enough with KGDB internals to dive in and look at all the
> potential barrier conflicts, so I'll submit a patch that addresses the one that's
> bitten me so far. Maybe it will motivate somebody else to take a closer look!
> 


Do you think you can try the patch below?

It seems we might not need to change to using the atomic_add_return(0,...) because using the atomic_inc() and atomic_dec() will end up using the memory barriers.

I would certainly rather fix kgdb vs mucking with the internals of cpu_relax().


Jason.

--- a/kernel/kgdb.c
+++ b/kernel/kgdb.c
@@ -580,14 +580,13 @@ static void kgdb_wait(struct pt_regs *re
 	 * Make sure the above info reaches the primary CPU before
 	 * our cpu_in_kgdb[] flag setting does:
 	 */
-	smp_wmb();
-	atomic_set(&cpu_in_kgdb[cpu], 1);
+	atomic_inc(&cpu_in_kgdb[cpu]);
 
 	/* Disable any cpu specific hw breakpoints */
 	kgdb_disable_hw_debug(regs);
 
 	/* Wait till primary CPU is done with debugging */
-	while (atomic_read(&passive_cpu_wait[cpu]))
+	while (atomic_add_return(0, &passive_cpu_wait[cpu]))
 		cpu_relax();
 
 	kgdb_info[cpu].debuggerinfo = NULL;
@@ -598,7 +597,7 @@ static void kgdb_wait(struct pt_regs *re
 		arch_kgdb_ops.correct_hw_break();
 
 	/* Signal the primary CPU that we are done: */
-	atomic_set(&cpu_in_kgdb[cpu], 0);
+	atomic_dec(&cpu_in_kgdb[cpu]);
 	touch_softlockup_watchdog_sync();
 	clocksource_touch_watchdog();
 	local_irq_restore(flags);
@@ -1493,7 +1492,7 @@ acquirelock:
 	 * spin_lock code is good enough as a barrier so we don't
 	 * need one here:
 	 */
-	atomic_set(&cpu_in_kgdb[ks->cpu], 1);
+	atomic_inc(&cpu_in_kgdb[ks->cpu]);
 
 #ifdef CONFIG_SMP
 	/* Signal the other CPUs to enter kgdb_wait() */
@@ -1505,7 +1504,7 @@ acquirelock:
 	 * Wait for the other CPUs to be notified and be waiting for us:
 	 */
 	for_each_online_cpu(i) {
-		while (!atomic_read(&cpu_in_kgdb[i]))
+		while (!atomic_add_return(0, &cpu_in_kgdb[i]))
 			cpu_relax();
 	}
 
@@ -1528,7 +1527,7 @@ acquirelock:
 
 	kgdb_info[ks->cpu].debuggerinfo = NULL;
 	kgdb_info[ks->cpu].task = NULL;
-	atomic_set(&cpu_in_kgdb[ks->cpu], 0);
+	atomic_dec(&cpu_in_kgdb[ks->cpu]);
 
 	if (!kgdb_single_step) {
 		for (i = NR_CPUS-1; i >= 0; i--)
@@ -1538,7 +1537,7 @@ acquirelock:
 		 * from the debugger.
 		 */
 		for_each_online_cpu(i) {
-			while (atomic_read(&cpu_in_kgdb[i]))
+			while (atomic_add_return(0, &cpu_in_kgdb[i]))
 				cpu_relax();
 		}
 	}
@@ -1742,11 +1741,11 @@ EXPORT_SYMBOL_GPL(kgdb_unregister_io_mod
  */
 void kgdb_breakpoint(void)
 {
-	atomic_set(&kgdb_setting_breakpoint, 1);
+	atomic_inc(&kgdb_setting_breakpoint);
 	wmb(); /* Sync point before breakpoint */
 	arch_kgdb_breakpoint();
 	wmb(); /* Sync point after breakpoint */
-	atomic_set(&kgdb_setting_breakpoint, 0);
+	atomic_dec(&kgdb_setting_breakpoint);
 }
 EXPORT_SYMBOL_GPL(kgdb_breakpoint);
 

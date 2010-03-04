From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Mar 2010 17:28:11 -0000
Subject: [kGDB]Cannot compile KGDB on ARM SMP
In-Reply-To: <4B8EF272.1090007@windriver.com>
References: <8cad0aa1003020107g3aae0875n1da8c442d9909f96@mail.gmail.com>
	<4B8EF272.1090007@windriver.com>
Message-ID: <001e01cabbc0$109a67f0$31cf37d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> No one has yet to submit a patch which implements the proper way to
> interrupt the slave CPUs and get them to call the kgdb_nmicallback(), as
> well as to run the kgdb test suite on the SMP device.

I've done the obvious thing with this patch:

diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index ba8ccfe..a5b846b 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -9,6 +9,7 @@
  * Authors:  George Davis <davis_g@mvista.com>
  *           Deepak Saxena <dsaxena@plexity.net>
  */
+#include <linux/irq.h>
 #include <linux/kgdb.h>
 #include <asm/traps.h>
 
@@ -158,6 +159,18 @@ static struct undef_hook kgdb_compiled_brkpt_hook = {
        .fn                     = kgdb_compiled_brk_fn
 };
 
+static void kgdb_call_nmi_hook(void *ignored)
+{
+       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
+}
+
+void kgdb_roundup_cpus(unsigned long flags)
+{
+       local_irq_enable();
+       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
+       local_irq_disable();
+}
+
 /**
  *     kgdb_arch_init - Perform any architecture specific initalization.
  *

This is all well and good and solves the compilation issue. However, in an
SMP environment [quad-core ARM 11MPCore] the testsuite very quickly deadlocks:

rv-pb11mpcore:~# echo kgdbts=V1 > /sys/module/kgdbts/parameters/kgdbts
[   62.787343] kgdb: Registered I/O driver kgdbts.
[   62.801176] kgdbts:RUN plant and detach test
[   62.814748] kgdbts:RUN sw breakpoint test
[   62.828126] kgdbts:RUN bad memory access test
[   62.841687] kgdbts:RUN singlestep test 1000 iterations
[   62.859816] kgdbts:RUN singlestep [0/1000]
[   63.132699] kgdbts:RUN singlestep [100/1000]
[   63.406217] kgdbts:RUN singlestep [200/1000]
[   63.679694] kgdbts:RUN singlestep [300/1000]

<machine completely unresponsive>

I took a quick look at the code in kernel/kgdb.c and adding the following
memory barrier appears to resolve the issue:

diff --git a/kernel/kgdb.c b/kernel/kgdb.c
index 761fdd2..1308381 100644
--- a/kernel/kgdb.c
+++ b/kernel/kgdb.c
@@ -1537,6 +1537,7 @@ acquirelock:
                 * Wait till all the CPUs have quit
                 * from the debugger.
                 */
+               smp_wmb();
                for_each_online_cpu(i) {
                        while (atomic_read(&cpu_in_kgdb[i]))
                                cpu_relax();

There may be more that are missing, but I'm not familiar enough with KGDB
internals to know what's going on.

I can submit this as a patch if you'd like, but I'd value some feedback
first. Adding random memory barriers isn't a great solution!

Cheers,

Will

From: zhanzhenbo@gmail.com (steve.zhan)
Date: Tue, 18 Sep 2012 16:20:58 +0800
Subject: ARM: smp: why don't eliminate warning "Unknown IPI message 0x1"?
In-Reply-To: <CAKvkGKfjShpdTagsHAhyMr3rHfUQc4qpZjW9wMdht4N36Pk5rA@mail.gmail.com>
References: <CAKvkGKfjShpdTagsHAhyMr3rHfUQc4qpZjW9wMdht4N36Pk5rA@mail.gmail.com>
Message-ID: <CAKvkGKcm=pYkcqsESK_XPqJL09bde2+tHheUJwBDjPXLTn=vGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below is the whole of the patch.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ea73045..8605400 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
+#include <linux/threads.h>

 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -495,11 +496,28 @@ asmlinkage void __exception_irq_entry do_IPI(int
ipinr, struct pt_regs *regs)
        handle_IPI(ipinr, regs);
 }

+static int ipi_wakeup_nr[NR_CPUS];
+
+void smp_send_wakeup_ipi_begin(unsigned int cpu, unsigned int irq)
+{
+       ipi_wakeup_nr[cpu] = irq + 1;
+       gic_raise_softirq(cpumask_of(cpu),irq);
+}
+
+void smp_send_wakeup_ipi_end(unsigned int cpu, unsigned int irq)
+{
+       BUG_ON(ipi_wakeup_nr[cpu] != irq + 1);
+       ipi_wakeup_nr[cpu] = 0;
+}
+
 void handle_IPI(int ipinr, struct pt_regs *regs)
 {
        unsigned int cpu = smp_processor_id();
        struct pt_regs *old_regs = set_irq_regs(regs);

+       if (ipi_wakeup_nr[cpu] == ipinr + 1)
+               goto Exit;
+
        if (ipinr >= IPI_TIMER && ipinr < IPI_TIMER + NR_IPI)
                __inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_TIMER]);

@@ -537,6 +555,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
                       cpu, ipinr);
                break;
        }
+Exit:
        set_irq_regs(old_regs);
 }

diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index db0117e..ecc6add 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -127,7 +127,7 @@ int __cpuinit boot_secondary(unsigned int cpu,
struct task_struct *idle)
         * the boot monitor to read the system wide flags register,
         * and branch to the address found there.
         */
-       gic_raise_softirq(cpumask_of(cpu), 1);
+       smp_send_wakeup_ipi_begin(cpu, 0);

        timeout = jiffies + (1 * HZ);
        while (time_before(jiffies, timeout)) {
@@ -137,6 +137,7 @@ int __cpuinit boot_secondary(unsigned int cpu,
struct task_struct *idle)

                udelay(10);
        }
+       smp_send_wakeup_ipi_end(cpu, 0);

        /*
         * now the secondary core is starting up let it run its


2012/9/18, ??? <zhanzhenbo@gmail.com>:
> Russell King want people to move to SGI0 for this, so that we can have
> SGI1-N
> as the proper IPIs, but now we can't do this, maybe we must wait for
> so many years.
> But, Do you think we can use a another way to resolve this problem,
> because this warning message will oftenly appeare in products.
>
> We can't assume the fixed IPI number that can wakeup secondary cores.
> "I'd much rather see platforms deciding whether they need to use SGI1
> or whether they can switch to SGI0 instead."
>
> Just give one ugly idea. I have modify this for example in msm platform.
> Pls check the attached git diff patch Or below lines and give your
> suggestions
>


-- 
Steve Zhan

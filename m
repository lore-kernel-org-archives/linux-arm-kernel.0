From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 21 Mar 2017 16:34:53 +0900
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <20170317162421.GK5940@leverpostej>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
 <20170317153358.GI5940@leverpostej>
 <1489765628.17202.59.camel@infradead.org>
 <20170317162421.GK5940@leverpostej>
Message-ID: <20170321073452.GA17298@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 04:24:21PM +0000, Mark Rutland wrote:
> On Fri, Mar 17, 2017 at 03:47:08PM +0000, David Woodhouse wrote:
> > On Fri, 2017-03-17 at 15:33 +0000, Mark Rutland wrote:
> > No, in this case the CPUs *were* offlined correctly, or at least "as
> > designed", by smp_send_crash_stop(). And if that hadn't worked, as
> > verified by *its* synchronisation method based on the atomic_t
> > waiting_for_crash_ipi, then *it* would have complained for itself:
> > 
> > 	if (atomic_read(&waiting_for_crash_ipi) > 0)
> > 		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> > 			???cpumask_pr_args(cpu_online_mask));
> > 
> > It's just that smp_send_crash_stop() (or more specifically
> > ipi_cpu_crash_stop()) doesn't touch the online cpu mask. Unlike the
> > ARM32 equivalent function machien_crash_nonpanic_core(), which does.
> > 
> > It wasn't clear if that was *intentional*, to allow the original
> > contents of the online mask before the crash to be seen in the
> > resulting vmcore... or purely an accident.?

Yes, it is intentional. I removed 'offline' code in my v14 (2016/3/4).
As you assumed, I'd expect 'online' status of all CPUs to be kept
unchanged in the core dump.

If you can agree, I would like to modify this disputed warning code to:

===8<===
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index cea009f2657d..55f08c5acfad 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -149,6 +149,7 @@ static inline void cpu_panic_kernel(void)
 bool cpus_are_stuck_in_kernel(void);
 
 extern void smp_send_crash_stop(void);
+extern bool smp_crash_stop_failed(void);
 
 #endif /* ifndef __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 68b96ea13b4c..29e1cf8cca95 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -146,12 +146,15 @@ void machine_kexec(struct kimage *kimage)
 {
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
+	bool in_kexec_crash = (kimage == kexec_crash_image);
+	bool stuck_cpus = cpus_are_stuck_in_kernel();
 
 	/*
 	 * New cpus may have become stuck_in_kernel after we loaded the image.
 	 */
-	BUG_ON((cpus_are_stuck_in_kernel() || (num_online_cpus() > 1)) &&
-			!WARN_ON(kimage == kexec_crash_image));
+	BUG_ON(!in_kexec_crash && (stuck_cpus || (num_online_cpus() > 1)));
+	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
+		"Some CPUs may be stale, kdump will be unreliable.\n");
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a7e2921143c4..8016914591d2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -833,7 +833,7 @@ static void ipi_cpu_stop(unsigned int cpu)
 }
 
 #ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi;
+static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 #endif
 
 static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
@@ -990,7 +990,12 @@ void smp_send_crash_stop(void)
 
 	if (atomic_read(&waiting_for_crash_ipi) > 0)
 		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(cpu_online_mask));
+			   cpumask_pr_args(&mask));
+}
+
+bool smp_crash_stop_failed(void)
+{
+	return (atomic_read(&waiting_for_crash_ipi) > 0);
 }
 #endif
===>8===



In case of failure in offlining, this can generate such a message like:

    SMP: stopping secondary CPUs
    SMP: failed to stop secondary CPUs 0,2-7
    Starting crashdump kernel...
    Some CPUs may be stale, kdump will be unreliable.
    ------------[ cut here ]------------
    WARNING: CPU: 1 PID: 1141 at /home/akashi/arm/armv8/linaro/linux-aarch64/arch/arm64/kernel/machine_kexec.c:157 machine_kexec+0x44/0x280


> Looking at this, there's a larger mess.
> 
> The waiting_for_crash_ipi dance only tells us if CPUs have taken the
> IPI, not wether they've been offlined (i.e. actually left the kernel).
> We need something closer to the usual cpu_{disable,die,kill} dance,
> clearing online as appropriate.

First, I don't think there is no sure way to confirm whether CPUs
successfully left the kernel.
Even if we do something like this in ipi_cpu_crash_stop():
    atomic_dec(&waiting_for_crash_ipi);
    cpu_die(cpu);
    atomic_inc(&waiting_for_crash_ipi);
there is no guarantee that we reach the second update_cpu_boot_status()
in failure of cpu_die().

Second, while "graceful" cpu shutdown would be fine, the basic idea
in kdump design, I believe, is that we should do minimum things needed
and tear down all the cpus as quickly as possible in order not only to make
the reboot more successful but also to retain the kernel state (memory contents)
as close as to the moment at the panic. (The latter is arguable.)

That said, I will appreciate you if you have any suggestions
regarding what be added for safer shutdown here.


Thanks,
-Takahiro AKASHI

> If CPUs haven't left the kernel, we still need to warn about that.
> 
> > FWIW if I trigger a crash on CPU 1 my kdump (still 4.9.8+v32) doesn't work.
> > I end up booting the kdump kernel on CPU#1 and then it gets distinctly unhappy...
> > 
> > [????0.000000] Booting Linux on physical CPU 0x1
> > ...
> > [????0.017125] Detected PIPT I-cache on CPU1
> > [????0.017138] GICv3: CPU1: found redistributor 0 region 0:0x00000000f0280000
> > [????0.017147] CPU1: Booted secondary processor [411fd073]
> > [????0.017339] Detected PIPT I-cache on CPU2
> > [????0.017347] GICv3: CPU2: found redistributor 2 region 0:0x00000000f02c0000
> > [????0.017354] CPU2: Booted secondary processor [411fd073]
> > [????0.017537] Detected PIPT I-cache on CPU3
> > [????0.017545] GICv3: CPU3: found redistributor 3 region 0:0x00000000f02e0000
> > [????0.017551] CPU3: Booted secondary processor [411fd073]
> > [????0.017576] Brought up 4 CPUs
> > [????0.017587] SMP: Total of 4 processors activated.
> > ...
> > [???31.745809] INFO: rcu_sched detected stalls on CPUs/tasks:
> > [???31.751299]?	1-...: (30 GPs behind) idle=c90/0/0 softirq=0/0 fqs=0?
> > [???31.757557]?	2-...: (30 GPs behind) idle=608/0/0 softirq=0/0 fqs=0?
> > [???31.763814]?	3-...: (30 GPs behind) idle=604/0/0 softirq=0/0 fqs=0?
> > [???31.770069]?	(detected by 0, t=5252 jiffies, g=-270, c=-271, q=0)
> > [???31.776161] Task dump for CPU 1:
> > [???31.779381] swapper/1???????R??running task????????0?????0??????1 0x00000080
> > [???31.786446] Task dump for CPU 2:
> > [???31.789666] swapper/2???????R??running task????????0?????0??????1 0x00000080
> > [???31.796725] Task dump for CPU 3:
> > [???31.799945] swapper/3???????R??running task????????0?????0??????1 0x00000080
> > 
> > Is some of that platform-specific?
> 
> That sounds like timer interrupts aren't being taken.
> 
> Given that the CPUs have come up, my suspicion would be that the GIC's
> been left in some odd state, that the kdump kernel hasn't managed to
> recover from.
> 
> Marc may have an idea.
> 
> Thanks,
> Mark.

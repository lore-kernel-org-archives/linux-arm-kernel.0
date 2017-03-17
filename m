From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 17 Mar 2017 15:47:08 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <20170317153358.GI5940@leverpostej>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
 <20170317153358.GI5940@leverpostej>
Message-ID: <1489765628.17202.59.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 15:33 +0000, Mark Rutland wrote:
> 
> We can certainly log a better message, e.g.
> ????????
> ????????bool kdump = (image == kexec_crash_image);
> ????????bool stuck_cpus = cpus_are_stuck_in_kernel() ||
> ????????????????????????? num_online_cpus() > 1;
> 
> ????????BUG_ON(stuck_cpus && !kdump);
> ????????WARN(stuck_cpus, "Unable to offline CPUs, kdump will be unreliable.\n");

No, in this case the CPUs *were* offlined correctly, or at least "as
designed", by smp_send_crash_stop(). And if that hadn't worked, as
verified by *its* synchronisation method based on the atomic_t
waiting_for_crash_ipi, then *it* would have complained for itself:

	if (atomic_read(&waiting_for_crash_ipi) > 0)
		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
			???cpumask_pr_args(cpu_online_mask));

It's just that smp_send_crash_stop() (or more specifically
ipi_cpu_crash_stop()) doesn't touch the online cpu mask. Unlike the
ARM32 equivalent function machien_crash_nonpanic_core(), which does.

It wasn't clear if that was *intentional*, to allow the original
contents of the online mask before the crash to be seen in the
resulting vmcore... or purely an accident.?

FWIW if I trigger a crash on CPU 1 my kdump (still 4.9.8+v32) doesn't work.
I end up booting the kdump kernel on CPU#1 and then it gets distinctly unhappy...

[????0.000000] Booting Linux on physical CPU 0x1
...
[????0.017125] Detected PIPT I-cache on CPU1
[????0.017138] GICv3: CPU1: found redistributor 0 region 0:0x00000000f0280000
[????0.017147] CPU1: Booted secondary processor [411fd073]
[????0.017339] Detected PIPT I-cache on CPU2
[????0.017347] GICv3: CPU2: found redistributor 2 region 0:0x00000000f02c0000
[????0.017354] CPU2: Booted secondary processor [411fd073]
[????0.017537] Detected PIPT I-cache on CPU3
[????0.017545] GICv3: CPU3: found redistributor 3 region 0:0x00000000f02e0000
[????0.017551] CPU3: Booted secondary processor [411fd073]
[????0.017576] Brought up 4 CPUs
[????0.017587] SMP: Total of 4 processors activated.
...
[???31.745809] INFO: rcu_sched detected stalls on CPUs/tasks:
[???31.751299]?	1-...: (30 GPs behind) idle=c90/0/0 softirq=0/0 fqs=0?
[???31.757557]?	2-...: (30 GPs behind) idle=608/0/0 softirq=0/0 fqs=0?
[???31.763814]?	3-...: (30 GPs behind) idle=604/0/0 softirq=0/0 fqs=0?
[???31.770069]?	(detected by 0, t=5252 jiffies, g=-270, c=-271, q=0)
[???31.776161] Task dump for CPU 1:
[???31.779381] swapper/1???????R??running task????????0?????0??????1 0x00000080
[???31.786446] Task dump for CPU 2:
[???31.789666] swapper/2???????R??running task????????0?????0??????1 0x00000080
[???31.796725] Task dump for CPU 3:
[???31.799945] swapper/3???????R??running task????????0?????0??????1 0x00000080

Is some of that platform-specific?

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 701c085..41d238e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -129,7 +129,7 @@ static struct sysrq_key_op sysrq_unraw_op = {
?#define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
?#endif /* CONFIG_VT */
?
-static void sysrq_handle_crash(int key)
+static void do_sysrq_handle_crash(int key)
?{
?	char *killer = NULL;
?
@@ -143,6 +143,12 @@ static void sysrq_handle_crash(int key)
?	wmb();
?	*killer = 1;
?}
+
+static void sysrq_handle_crash(int key)
+{
+	smp_call_on_cpu(1, (void *)do_sysrq_handle_crash, 0, 1);
+}
+
?static struct sysrq_key_op sysrq_crash_op = {
?	.handler	= sysrq_handle_crash,
?	.help_msg	= "crash(c)",
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/07272be7/attachment-0001.bin>

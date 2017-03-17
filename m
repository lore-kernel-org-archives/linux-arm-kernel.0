From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Mar 2017 17:10:26 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <e75aaa3f-0d87-2523-d7d7-cef56e5bd480@arm.com>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org> <20170317153358.GI5940@leverpostej>
 <1489765628.17202.59.camel@infradead.org> <20170317162421.GK5940@leverpostej>
 <e75aaa3f-0d87-2523-d7d7-cef56e5bd480@arm.com>
Message-ID: <372d44fe-2d78-596a-55c6-307cb36d60a2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 16:59, Marc Zyngier wrote:
> On 17/03/17 16:24, Mark Rutland wrote:
>> On Fri, Mar 17, 2017 at 03:47:08PM +0000, David Woodhouse wrote:
>>> On Fri, 2017-03-17 at 15:33 +0000, Mark Rutland wrote:
>>> No, in this case the CPUs *were* offlined correctly, or at least "as
>>> designed", by smp_send_crash_stop(). And if that hadn't worked, as
>>> verified by *its* synchronisation method based on the atomic_t
>>> waiting_for_crash_ipi, then *it* would have complained for itself:
>>>
>>> 	if (atomic_read(&waiting_for_crash_ipi) > 0)
>>> 		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
>>> 			   cpumask_pr_args(cpu_online_mask));
>>>
>>> It's just that smp_send_crash_stop() (or more specifically
>>> ipi_cpu_crash_stop()) doesn't touch the online cpu mask. Unlike the
>>> ARM32 equivalent function machien_crash_nonpanic_core(), which does.
>>>
>>> It wasn't clear if that was *intentional*, to allow the original
>>> contents of the online mask before the crash to be seen in the
>>> resulting vmcore... or purely an accident. 
>>
>> Looking at this, there's a larger mess.
>>
>> The waiting_for_crash_ipi dance only tells us if CPUs have taken the
>> IPI, not wether they've been offlined (i.e. actually left the kernel).
>> We need something closer to the usual cpu_{disable,die,kill} dance,
>> clearing online as appropriate.
>>
>> If CPUs haven't left the kernel, we still need to warn about that.
>>
>>> FWIW if I trigger a crash on CPU 1 my kdump (still 4.9.8+v32) doesn't work.
>>> I end up booting the kdump kernel on CPU#1 and then it gets distinctly unhappy...
>>>
>>> [    0.000000] Booting Linux on physical CPU 0x1
>>> ...
>>> [    0.017125] Detected PIPT I-cache on CPU1
>>> [    0.017138] GICv3: CPU1: found redistributor 0 region 0:0x00000000f0280000
>>> [    0.017147] CPU1: Booted secondary processor [411fd073]
>>> [    0.017339] Detected PIPT I-cache on CPU2
>>> [    0.017347] GICv3: CPU2: found redistributor 2 region 0:0x00000000f02c0000
>>> [    0.017354] CPU2: Booted secondary processor [411fd073]
>>> [    0.017537] Detected PIPT I-cache on CPU3
>>> [    0.017545] GICv3: CPU3: found redistributor 3 region 0:0x00000000f02e0000
>>> [    0.017551] CPU3: Booted secondary processor [411fd073]
>>> [    0.017576] Brought up 4 CPUs
>>> [    0.017587] SMP: Total of 4 processors activated.
>>> ...
>>> [   31.745809] INFO: rcu_sched detected stalls on CPUs/tasks:
>>> [   31.751299] 	1-...: (30 GPs behind) idle=c90/0/0 softirq=0/0 fqs=0 
>>> [   31.757557] 	2-...: (30 GPs behind) idle=608/0/0 softirq=0/0 fqs=0 
>>> [   31.763814] 	3-...: (30 GPs behind) idle=604/0/0 softirq=0/0 fqs=0 
>>> [   31.770069] 	(detected by 0, t=5252 jiffies, g=-270, c=-271, q=0)
>>> [   31.776161] Task dump for CPU 1:
>>> [   31.779381] swapper/1       R  running task        0     0      1 0x00000080
>>> [   31.786446] Task dump for CPU 2:
>>> [   31.789666] swapper/2       R  running task        0     0      1 0x00000080
>>> [   31.796725] Task dump for CPU 3:
>>> [   31.799945] swapper/3       R  running task        0     0      1 0x00000080
>>>
>>> Is some of that platform-specific?
>>
>> That sounds like timer interrupts aren't being taken.
>>
>> Given that the CPUs have come up, my suspicion would be that the GIC's
>> been left in some odd state, that the kdump kernel hasn't managed to
>> recover from.
>>
>> Marc may have an idea.
> 
> I thought kdump was UP only? Anyway, this doesn't look too good.
> 
> It would be interesting to find out whether we're still taking
> interrupts. Also, being able to reproduce this on mainline would be useful.
> 
> I wonder if we don't have a bug when booting on something other than
> CPU#0, possibly on a GICv3 platform... I'll give it a go.

Went ahead and tried a couple of kexecs with various CPUs disabled in
order to force kexec not to boot on CPU#0, and the VM did boot just fine.

So I'd really appreciate a mainline reproducer.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

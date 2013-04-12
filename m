From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 15:14:54 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <516812E8.6040103@linaro.org>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com> <516812E8.6040103@linaro.org>
Message-ID: <516816DE.20501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/13 14:58, Andre Przywara wrote:
> On 04/12/2013 03:24 PM, Marc Zyngier wrote:
>> On 12/04/13 14:04, Andre Przywara wrote:
>>> kvm_target_cpus() checks the compatibility of the used CPU with
>>> KVM, which is currently limited to ARM Cortex-A15 cores.
>>> However by calling it only once on any random CPU it assumes that
>>> all cores are the same, which is not true for big.LITTLE parts.
>>>
>>> After doing about 40 boots on a TC-2 core tile, I found it running
>>> in all but one case on one of the A7 cores (which correctly denied
>>> KVM initialization). On the 39th boot however the code ran on
>>> an A15, leading to a hang after returning success:
>>>
>>> ...
>>> TCP: reno registered
>>> UDP hash table entries: 512 (order: 2, 16384 bytes)
>>> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>>> NET: Registered protocol family 1
>>> kvm_target_cpu() on CPU #1, part is c0f0
>>>   ... (pause for a while) ...
>>> INFO: rcu_sched self-detected stall on CPUINFO: rcu_sched detected stalls on CPU
>>> s/tasks: { 1} (detected by 0, t=6002 jiffies, g=4294966999, c=4294966998, q=15)
>>> Task dump for CPU 1:
>>> swapper/0       R running      0     1      0 0x00000002
>>>
>>> So iterate over every CPU to correctly determine the capability of
>>> the system to run the current KVM implementation.
>>> In case a big.LITTLE configuration is the reason for denial, give
>>> the user a hint how to get it running anyway (maxcpus= on the kernel
>>> command line).
>>>
>>> Please push this still into 3.9.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>>
>> [...]
>>
>> Nak. The fact that one of the CPUs seem to hang is a sure sign that
>> something is severely broken, and you definitely want to fix that issue,
>> instead of blindly ignoring it.
> 
> In general I agree, but we should fix it quickly for 3.9, as it can 
> cause a kernel hang.

Fixing it, certainly. As you have a BL system up and running, maybe you
could start by finding out what is this CPU doing, and how it ended up
there?

>> Additionally, it seems you're just papering over the issue. You should
>> be able to exclude the A7 processors, but not completely deny KVM from
>> running on the hardware.
> 
> Is there an easy way to prevent VCPUs from running on not-supported 
> cores? Something like an kvm_cpu_mask?

Probably.

> What would be the wisest hook to utilize for this?

The scheduler has sched_[gs]etaffinity(). if you're allowed to call
these though...

	M.
-- 
Jazz is not dead. It just smells funny...

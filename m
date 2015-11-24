From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Tue, 24 Nov 2015 18:28:08 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <56547CC1.6000009@dev.rtsoft.ru>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
 <5653099A.7020604@dev.rtsoft.ru> <56530AE6.2060407@dev.rtsoft.ru>
 <20151123130424.GQ8644@n2100.arm.linux.org.uk>
 <5654799E.5080903@dev.rtsoft.ru> <56547CC1.6000009@dev.rtsoft.ru>
Message-ID: <56548208.1030402@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

24.11.2015 18:05, Nikita Yushchenko ?????:
>> I'm still trying to understand what is going on, and my printk()s show
>> that this is not entirely true.
>>
>> When smp_init() is entered on mainline om imx6s, cpu_possible_mask and
>> cpu_present_mask both contain two cpus. These get initialized in
>> arm_dt_init_cpu_maps() and stay unmodified since then.
>>
>> But cpu_online() returns 1 for cpu0 and 0 from cpu1 - thus it is
>> cpu_online() check, not possible_mask or present_mask, that prevents
>> cpu1 initialization attempt.
> 
> Sorry was too quick to type.
> 
> cpu_online(0) is true and cpu_online(1) is false.
> It is natural, since cpu0 is already running.
> Thus cpu_up(1) is entered!

... and then code executes into __cpu_up() from arch/arm/kernel/smp.c,
and stops via

	if (!smp_ops.smp_boot_secondary)
		return -ENOSYS;


(smp_ops zeroed due to SMP_ON_UP, as far as I understand).


In linux-imx 3.14.28 based tree, there is no such check in __cpu_up,
thus boot_secondary() is called

int boot_secondary(unsigned int cpu, struct task_struct *idle)
{
	if (smp_ops.smp_boot_secondary)
		return smp_ops.smp_boot_secondary(cpu, idle);
	return -ENOSYS;
}


at this point zeroed smp_ops plays, -ENOSYS (-38) is returned, and
pr_err() in __cpu_up() prints the message that caused the entire analysis.


So conclusion is that
- behaviour of mainline and linux-imx tres is almost the same, there is
attempt to bring up non-existing cpu 1, difference is only in where
zeroed smp_ops is detected and if error is logged or not.

Not sure that my proposed patch was correct, it fixes imx6s case but can
have bad effect on other arm targets. But I think that something needs
to be done to make cpu masks correct in SMP_ON_UP case.

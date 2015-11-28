From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Sat, 28 Nov 2015 14:13:29 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <20151124153305.GD8644@n2100.arm.linux.org.uk>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
 <5653099A.7020604@dev.rtsoft.ru> <56530AE6.2060407@dev.rtsoft.ru>
 <20151123130424.GQ8644@n2100.arm.linux.org.uk>
 <5654799E.5080903@dev.rtsoft.ru>
 <20151124153305.GD8644@n2100.arm.linux.org.uk>
Message-ID: <56598C59.4070307@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Not sure I understand logic behind this. With the current code,
>> resulting cpu_possible_mask depends on CONFIG_SMP_ON_UP:
>> - if it is set, cpu_possible_mask contains (0 1), as initialized in
>> arm_dt_init_cpu_maps()
>> - if it is not set, cpu_possible_mask contains (0), since
>> imx_smp_init_cpus() removes 1 from there.
> 
> Right, adding debug to arch/arm/kernel/setup.c, just before the
> "if (is_smp())" shows:
> 
> is_smp() 0 possible 3 present 1 online 1
> 
> which is totally wrong: if is_smp() is false, we should not be setting
> up any possible CPUs.  See a patch below to fix that.
> 
> However, this doesn't matter much, because the code in setup.c won't
> initialise the SMP operations struct ...

But cpu start code is not the only place in the kernel that uses cpu_present_mask.

Are you sure that running with invalid cpu_present_mask has no side effects?

> Here's the patch to fix the DT code, which should not be setting
> present CPUs when is_smp() is false.

I see that this fixes the issue as well.

But I still don't understand rationale behind all these is_smp() checks.
This makes init sequence different with and without CONFIG_SMP_ON_UP.
Isn't kernel intended to run ok without CONFIG_SMP_ON_UP?

And if yes - then why not run the same init sequence in both cases?

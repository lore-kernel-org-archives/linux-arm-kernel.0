From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 11:05:23 -0600
Subject: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
In-Reply-To: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
References: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <51F2AC53.3070607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2013 11:41 PM, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> In case of normal kexec kernel load, all cpu's are offlined
> before calling machine_kexec() under kernel_kexec() function.

I'm not sure that's true, unless perhaps you have CONFIG_KEXEC_JUMP enabled?

> But in case crash panic cpus are relaxed in
> machine_crash_nonpanic_core() SMP function but not offlined.
> 
> When crash kernel is loaded with kexec and on panic trigger
> machine_kexec() checks for number of cpus online.
> If more than one cpu is online machine_kexec() fails to load
> with below error
> 
> kexec: error: multiple CPUs still online
> 
> In machine_crash_nonpanic_core() SMP function, offline CPU
> before cpu_relax

> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c

> @@ -73,6 +73,7 @@ void machine_crash_nonpanic_core(void *unused)
>  	crash_save_cpu(&regs, smp_processor_id());
>  	flush_cache_all();
>  
> +	set_cpu_online(smp_processor_id(), false);

I'm not familiar with that API, but it looks like it's just setting the
*current* CPU offline. That sounds problematic for two reasons:

1) Setting the current CPU offline sounds like a bad idea; after all,
code is still running on it. Presumably you want to offline all other CPUs.

2) On a dual-CPU system, I guess this will leave a single CPU marked
online, and hence satisfy the test in machine_kexec(). However, on a
quad-core system, won't this just reduce the online CPU count from 4 to
3 and hence the test in machine_kexec() will still fail?

Can't you call disable_nonboot_cpus() from machine_crash_nonpanic_core()
just like machine_shutdown() does?

From: james.morse@arm.com (James Morse)
Date: Fri, 11 Aug 2017 18:02:54 +0100
Subject: [PATCHv2] arm64:kexec: have own crash_smp_send_stop() for crash
 dump for nonpanic cores
In-Reply-To: <1502082623-23952-1-git-send-email-hoeun.ryu@gmail.com>
References: <1502082623-23952-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <598DE33E.6050606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoeun,

On 07/08/17 06:09, Hoeun Ryu wrote:
>  Commit 0ee5941 : (x86/panic: replace smp_send_stop() with kdump friendly
> version in panic path) introduced crash_smp_send_stop() which is a weak
> function and can be overriden by architecture codes to fix the side effect

(overridden)


> caused by commit f06e515 : (kernel/panic.c: add "crash_kexec_post_
> notifiers" option).
> 
>  ARM64 architecture uses the weak version function and the problem is that
> the weak function simply calls smp_send_stop() which makes other CPUs
> offline and takes away the chance to save crash information for nonpanic
> CPUs in machine_crash_shutdown() when crash_kexec_post_notifiers kernel
> option is enabled.
> 
>  Calling smp_send_crash_stop() in machine_crash_shutdown() is useless
> because all nonpanic CPUs are already offline by smp_send_stop() in this
> case and smp_send_crash_stop() only works against online CPUs.


>  The result is that /proc/vmcore is not available with the error messages;
> "Warning: Zero PT_NOTE entries found", "Kdump: vmcore not initialized".

When I tried this I got one of these warnings for each secondary CPU, but the
vmcore file was still available. When I ran 'crash' on the vmcore it reported:
> CPUS: 6 [OFFLINE: 5]

Did I miss as step to reproduce this? If not, can we change this paragraph to
say something like:
> The result is that secondary CPUs registers are not saved by crash_save_cpu()
> and the vmcore file misreports these CPUs as being offline.


>  crash_smp_send_stop() is implemented to fix this problem by replacing the
> exising smp_send_crash_stop() and adding a check for multiple calling to

(existing)


> the function. The function (strong symbol version) saves crash information
> for nonpanic CPUs and machine_crash_shutdown() tries to save crash
> information for nonpanic CPUs only when crash_kexec_post_notifiers kernel
> option is disabled.
> 
> * crash_kexec_post_notifiers : false
> 
>   panic()
>     __crash_kexec()
>       machine_crash_shutdown()
>         crash_smp_send_stop()    <= save crash dump for nonpanic cores
> 
> * crash_kexec_post_notifiers : true
> 
>   panic()
>     crash_smp_send_stop()        <= save crash dump for nonpanic cores
>     __crash_kexec()
>       machine_crash_shutdown()
>         crash_smp_send_stop()    <= just return.


> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index dc66e6e..73d8f5e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -977,11 +977,21 @@ void smp_send_stop(void)
>  }
>  
>  #ifdef CONFIG_KEXEC_CORE
> -void smp_send_crash_stop(void)
> +void crash_smp_send_stop(void)
>  {
> +	static int cpus_stopped;
>  	cpumask_t mask;
>  	unsigned long timeout;
>  
> +	/*
> +	 * This function can be called twice in panic path, but obviously
> +	 * we execute this only once.
> +	 */
> +	if (cpus_stopped)
> +		return;
> +
> +	cpus_stopped = 1;
> +

This cpus_stopped=1 can't happen on multiple CPUs at the same time as any second
call is guaranteed to be on the same CPU, both are behind panic()s
'atomic_cmpxchg()'.


Other than my '/proc/vmcore is not available' question above, this looks fine to me:
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>


Thanks!

James

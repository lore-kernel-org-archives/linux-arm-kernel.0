From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 22 Nov 2010 09:24:20 +0200
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <20101122072420.GC14080@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 11:08:30AM +0100, Per Fransson wrote:
> When kexec is used to start a crash kernel the other cores
> are notified. These non-crashing cores will save their state
> in the crash notes and then do nothing.
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> ---
>  arch/arm/kernel/machine_kexec.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 3a8fd51..56683db 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -23,6 +23,8 @@ extern unsigned long kexec_indirection_page;
>  extern unsigned long kexec_mach_type;
>  extern unsigned long kexec_boot_atags;
>  
> +static atomic_t waiting_for_crash_ipi;
> +
>  /*
>   * Provide a dummy crash_notes definition while crash dump arrives to arm.
>   * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
> @@ -37,8 +39,34 @@ void machine_kexec_cleanup(struct kimage *image)
>  {
>  }
>  
> +void machine_crash_nonpanic_core(void *unused)
> +{
> +	struct pt_regs regs;
> +
> +	crash_setup_regs(&regs, NULL);
> +	printk(KERN_EMERG "CPU %u will stop doing anything useful since another CPU has crashed\n",
> +	       smp_processor_id());
> +	crash_save_cpu(&regs, smp_processor_id());
> +	flush_cache_all();
> +
> +	atomic_dec(&waiting_for_crash_ipi);
> +	while (1)
> +		cpu_relax();
> +}
> +
>  void machine_crash_shutdown(struct pt_regs *regs)
>  {
> +	unsigned long msecs;
> +
> +	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> +
> +	local_irq_enable();

I wonder whether it is good idea to enable interrupts here? What
if we came here from an interrupt handler with interrupts already
disabled?

I guess you did this because smp_call_function() needs to have
interrupts enabled, right?

As we still need to make sure that all the secondary CPUs are
stopped, should we do just something like:

	smp_send_stop();

and then in ipi_cpu_stop() we check whether oops_in_progress is set
and save the cpu state before entering that never-ending loop?

Regards,
MW

> +	smp_call_function(machine_crash_nonpanic_core, NULL, false);
> +	msecs = 1000; /* Wait at most a second for the other cpus to stop */
> +	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
> +		mdelay(1);
> +		msecs--;
> +	}
>  	local_irq_disable();
>  	crash_save_cpu(regs, smp_processor_id());
>  
> -- 
> 1.7.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

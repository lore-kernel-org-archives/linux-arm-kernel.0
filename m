From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Nov 2010 22:06:12 -0600
Subject: [PATCH v2] Add call to non-crashing cores through IPI
In-Reply-To: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <20101126040612.GA6598@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a couple of nitpicks below. It's also common to prefix the patch
subject with the subsystem (i.e. "ARM: kexec: ...")


-Olof

On Wed, Nov 24, 2010 at 09:28:28AM +0100, Per Fransson wrote:
> v2 changes:
> * the interrupts of the calling core are no longer disabled
>   before performing the IPI
> ---
> 
> When kexec is used to start a crash kernel the other cores
> are notified. These non-crashing cores will save their state
> in the crash notes and then do nothing.
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> ---
>  arch/arm/kernel/machine_kexec.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 3a8fd51..57a7f2f 100644
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
> @@ -37,9 +39,34 @@ void machine_kexec_cleanup(struct kimage *image)
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

No other architecture has verbose output like this. Maybe lower it to
KERN_DEBUG if you feel it's needed on a production kernel?

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

Int should be enough here? Not that it makes a difference on ARM, but
anyway. :)

> +
>  	local_irq_disable();
> +
> +	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> +	smp_call_function(machine_crash_nonpanic_core, NULL, false);
> +	msecs = 1000; /* Wait at most a second for the other cpus to stop */
> +	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
> +		mdelay(1);
> +		msecs--;
> +	}

If anything, logging here if not all cpus were stopped would be more
useful.

>  	crash_save_cpu(regs, smp_processor_id());
>  
>  	printk(KERN_INFO "Loading crashdump kernel...\n");

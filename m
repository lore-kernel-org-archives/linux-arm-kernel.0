From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 02 Feb 2011 17:22:36 -0500 (EST)
Subject: [PATCH v2 1/3] add machine-specific hook to machine_kexec
In-Reply-To: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
References: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
Message-ID: <alpine.LFD.2.00.1102021720070.8212@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Feb 2011, Eric Cooper wrote:

> Provide the option to call a machine-specific function
> before kexec'ing a new kernel.
> 
> Signed-off-by: Eric Cooper <ecc@cmu.edu>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Russell: if you agree I can carry this in the kirkwood git tree as the 
following kirkwood specific patches depend on this.




> ---
>  arch/arm/kernel/machine_kexec.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 30ead13..e59bbd4 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -75,6 +75,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
>  	printk(KERN_INFO "Loading crashdump kernel...\n");
>  }
>  
> +/*
> + * Function pointer to optional machine-specific reinitialization
> + */
> +void (*kexec_reinit)(void);
> +
>  void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list;
> @@ -104,6 +109,8 @@ void machine_kexec(struct kimage *image)
>  			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
>  	printk(KERN_INFO "Bye!\n");
>  
> +	if (kexec_reinit)
> +		kexec_reinit();
>  	local_irq_disable();
>  	local_fiq_disable();
>  	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
> -- 
> 1.7.2.3
> 

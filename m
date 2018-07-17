From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jul 2018 11:06:28 +0100
Subject: [PATCH] arm64: fix kernel panic on serror exception caused by
 user process
In-Reply-To: <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
References: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
 <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
Message-ID: <20180717100628.s5emikyc6orira2q@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 03:01:21PM +0530, Hari Vyas wrote:
> On executing simple user level "devmem 0x0" command, kernel panics.
> As 0x0 address is mostly not matched to any valid memory so exception
> is expected and raised which results in unconditional kernel panic
> by serror handler.

Having access to /dev/mem means that userspace can bring down the system
in any number of ways.

Why did userspace do this, and why do you think this shouldn't be fatal?

> This is happening after newly introduced serror handling framework
> change which panics kernel on any any serror without checking
> processor mode.`

This is the expected behaviour. The processor mode is not relevant,
because Serror is asynchronous -- so we cannot attribute it to userspace
instructions.

> Kernel panic is fixed by checking processor mode in serror handler.
> On kernel mode, normal kernel panic action is taken and system halts.
> On user mode, only user process is killed and further panic action is
> not initiated.

This is not safe.

For example, an Serror could result from the kernel page tables being
programmed to point at device memory. A TLB walk for TTBR1 made while
userspace was executing could result in an SError, and killing userspace
alone is insufficient to contain the error.

Thanks,
Mark.

> 
> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
> ---
>  arch/arm64/kernel/traps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index d399d45..c7cbad7 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -729,6 +729,13 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>  
>  asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>  {
> +	if (user_mode(regs)) {
> +		pr_crit("UserMode SError Exception on CPU%d, code 0x%08x %s\n",
> +			smp_processor_id(), esr, esr_get_class_string(esr));
> +		die("Oops - user mode ", regs, 0);
> +		return;
> +        }
> +
>  	nmi_enter();
>  
>  	/* non-RAS errors are not containable */
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

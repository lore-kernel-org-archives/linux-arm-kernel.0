From: james.morse@arm.com (James Morse)
Date: Mon, 08 Jan 2018 12:16:28 +0000
Subject: [PATCH v2 07/11] arm64: Add skeleton to harden the branch
 predictor against aliasing attacks
In-Reply-To: <1515157961-20963-8-git-send-email-will.deacon@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-8-git-send-email-will.deacon@arm.com>
Message-ID: <5A53611C.5030003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Marc,

On 05/01/18 13:12, Will Deacon wrote:
> Aliasing attacks against CPU branch predictors can allow an attacker to
> redirect speculative control flow on some CPUs and potentially divulge
> information from one context to another.
>
> This patch adds initial skeleton code behind a new Kconfig option to
> enable implementation-specific mitigations against these attacks for
> CPUs that are affected.

[...]

> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 6f7bdb89817f..6dd83d75b82a 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -41,6 +41,43 @@ static inline bool arm64_kernel_unmapped_at_el0(void)

> +static inline struct bp_hardening_data *arm64_get_bp_hardening_data(void)
> +{
> +	return this_cpu_ptr(&bp_hardening_data);
> +}
> +
> +static inline void arm64_apply_bp_hardening(void)
> +{
> +	struct bp_hardening_data *d;
> +
> +	if (!cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR))
> +		return;
> +
> +	d = arm64_get_bp_hardening_data();
> +	if (d->fn)
> +		d->fn();
> +}

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 22168cd0dde7..5203b6040cb6 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -318,6 +318,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  		lsb = PAGE_SHIFT;
>  	si.si_addr_lsb = lsb;
>  
> +	arm64_apply_bp_hardening();

Due to the this_cpu_ptr() call:

| BUG: using smp_processor_id() in preemptible [00000000] code: print_my_pa/2093
| caller is debug_smp_processor_id+0x1c/0x24
| CPU: 0 PID: 2093 Comm: print_my_pa Tainted: G        W
4.15.0-rc3-00044-g7f0aaec94f27-dirty #8950
| Call trace:
|  dump_backtrace+0x0/0x164
|  show_stack+0x14/0x1c
|  dump_stack+0xa4/0xdc
|  check_preemption_disabled+0xfc/0x100
|  debug_smp_processor_id+0x1c/0x24
|  __do_user_fault+0xcc/0x180
|  do_page_fault+0x14c/0x364
|  do_translation_fault+0x40/0x48
|  do_mem_abort+0x40/0xb8
|  el0_da+0x20/0x24

Make it a TIF flag?

(Seen with arm64's kpti-base tag and this series)


>  	force_sig_info(sig, &si, tsk);
>  }


Thanks,

James

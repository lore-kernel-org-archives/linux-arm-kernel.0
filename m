From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Apr 2018 14:48:32 +0100
Subject: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
In-Reply-To: <20180401111108.mudkiewzn33sifvk@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180327102116.GA2464@arm.com>
 <20180401111108.mudkiewzn33sifvk@yury-thinkpad>
Message-ID: <20180403134832.2cdae64uwuot6ryz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On Sun, Apr 01, 2018 at 02:11:08PM +0300, Yury Norov wrote:
> +/*
> + * Flush I-cache if CPU is in extended quiescent state
> + */

This comment is misleading. An ISB doesn't touch the I-cache; it forces
a context synchronization event.

> +	.macro	isb_if_eqs
> +#ifndef CONFIG_TINY_RCU
> +	bl	rcu_is_watching
> +	tst	w0, #0xff
> +	b.ne	1f

The TST+B.NE can be a CBNZ:

	bl	rcu_is_watching
	cbnz	x0, 1f
	isb
1:

> +	/* Pairs with aarch64_insn_patch_text for EQS CPUs. */
> +	isb
> +1:
> +#endif
> +	.endm
> +
>  el0_sync_invalid:
>  	inv_entry 0, BAD_SYNC
>  ENDPROC(el0_sync_invalid)
> @@ -840,8 +861,10 @@ el0_svc:
>  	mov	wsc_nr, #__NR_syscalls
>  el0_svc_naked:					// compat entry point
>  	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
> +	isb_if_eqs
>  	enable_dbg_and_irq
> -	ct_user_exit 1
> +	ct_user_exit

I don't think this is safe. here we issue the ISB *before* exiting a
quiesecent state, so I think we can race with another CPU that calls
kick_all_active_cpus_sync, e.g.

	CPU0				CPU1

	ISB
					patch_some_text()
					kick_all_active_cpus_sync()
	ct_user_exit

	// not synchronized!
	use_of_patched_text()

... and therefore the ISB has no effect, which could be disasterous.

I believe we need the ISB *after* we transition into a non-quiescent
state, so that we can't possibly miss a context synchronization event.

Thanks,
Mark.

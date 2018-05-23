From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 23 May 2018 11:31:31 +0100
Subject: [PATCH v3] arm64: fault: Don't leak data in ESR context for user
 fault on kernel VA
In-Reply-To: <20180522161120.12798-1-peter.maydell@linaro.org>
References: <20180522161120.12798-1-peter.maydell@linaro.org>
Message-ID: <20180523103131.GI13470@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 05:11:20PM +0100, Peter Maydell wrote:
> If userspace faults on a kernel address, handing them the raw ESR
> value on the sigframe as part of the delivered signal can leak data

Nit: on -> in
(not worth it unless you respin the patch though).

> useful to attackers who are using information about the underlying hardware
> fault type (e.g. translation vs permission) as a mechanism to defeat KASLR.
> 
> However there are also legitimate uses for the information provided
> in the ESR -- notably the GCC and LLVM sanitizers use this to report
> whether wild pointer accesses by the application are reads or writes
> (since a wild write is a more serious bug than a wild read), so we
> don't want to drop the ESR information entirely.
> 
> For faulting addresses in the kernel, sanitize the ESR. We choose
> to present userspace with the illusion that there is nothing mapped
> in the kernel's part of the address space at all, by reporting all
> faults as level 0 translation faults taken to EL1.

Did the discussion about faultin on user addresses go anywhere?

i.e., we tell userspace which page table level a fault occurred
at, and other things that are really none of userspace's business to
know.

This is not obviously a problem, but still a bit odd.  It could be
addressed separately.

> These fields are safe to pass through to userspace as they depend
> only on the instruction that userspace used to provoke the fault:
>  EC IL (always)
>  ISV CM WNR (for all data aborts)
> All the other fields in ESR except DFSC are architecturally RES0
> for an L0 translation fault taken to EL1, so can be zeroed out
> without confusing userspace.
> 
> The illusion is not entirely perfect, as there is a tiny wrinkle
> where we will report an alignment fault that was not due to the memory
> type (for instance a LDREX to an unaligned address) as a translation
> fault, whereas if you do this on real unmapped memory the alignment
> fault takes precedence. This is not likely to trip anybody up in
> practice, as the only users we know of for the ESR information who
> care about the behaviour for kernel addresses only really want to
> know about the WnR bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Modulo the above (which may be out of scope anyway)

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

> ---
> This patch is an alternative proposal to Will's patch
> https://patchwork.kernel.org/patch/10258781/
> which simply removed the ESR record entirely for kernel addresses.
> 
> Changes v1->v2:
>  * rebased on master
>  * commit message tweak
>  * DABT_CUR and IABT_CUR moved to "can't happen" default case
>  * explicitly clear the bits which are RES0 if ISV == 0
>  * comment text tweaks
> Changes v2->v3:
>  * remove the support for reporting ESRs with ISV == 1 (this
>    can't happen, and we probably don't want to tell userspace
>    that the exception was taken to EL2 if in some hypothetical
>    future that becomes possible)
>  * rebased on 4.17-rc6
> ---
>  arch/arm64/mm/fault.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 4165485e8b6e..2af3dd89bcdb 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -293,6 +293,57 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  static void __do_user_fault(struct siginfo *info, unsigned int esr)
>  {
>  	current->thread.fault_address = (unsigned long)info->si_addr;
> +
> +	/*
> +	 * If the faulting address is in the kernel, we must sanitize the ESR.
> +	 * From userspace's point of view, kernel-only mappings don't exist
> +	 * at all, so we report them as level 0 translation faults.
> +	 * (This is not quite the way that "no mapping there at all" behaves:
> +	 * an alignment fault not caused by the memory type would take
> +	 * precedence over translation fault for a real access to empty
> +	 * space. Unfortunately we can't easily distinguish "alignment fault
> +	 * not caused by memory type" from "alignment fault caused by memory
> +	 * type", so we ignore this wrinkle and just return the translation
> +	 * fault.)
> +	 */
> +	if (current->thread.fault_address >= TASK_SIZE) {
> +		switch (ESR_ELx_EC(esr)) {
> +		case ESR_ELx_EC_DABT_LOW:
> +			/*
> +			 * These bits provide only information about the
> +			 * faulting instruction, which userspace knows already.
> +			 * We explicitly clear bits which are architecturally
> +			 * RES0 in case they are given meanings in future.
> +			 * We always report the ESR as if the fault was taken
> +			 * to EL1 and so ISV and the bits in ISS[23:14] are
> +			 * clear. (In fact it always will be a fault to EL1.)
> +			 */
> +			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL |
> +				ESR_ELx_CM | ESR_ELx_WNR;
> +			esr |= ESR_ELx_FSC_FAULT;
> +			break;
> +		case ESR_ELx_EC_IABT_LOW:
> +			/*
> +			 * Claim a level 0 translation fault.
> +			 * All other bits are architecturally RES0 for faults
> +			 * reported with that DFSC value, so we clear them.
> +			 */
> +			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL;
> +			esr |= ESR_ELx_FSC_FAULT;
> +			break;
> +		default:
> +			/*
> +			 * This should never happen (entry.S only brings us
> +			 * into this code for insn and data aborts from a lower
> +			 * exception level). Fail safe by not providing an ESR
> +			 * context record at all.
> +			 */
> +			WARN(1, "ESR 0x%x is not DABT or IABT from EL0\n", esr);
> +			esr = 0;
> +			break;
> +		}
> +	}
> +
>  	current->thread.fault_code = esr;
>  	arm64_force_sig_info(info, esr_to_fault_info(esr)->name, current);
>  }
> -- 
> 2.17.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

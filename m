From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 May 2018 14:38:26 +0100
Subject: [RFC PATCH v2] arm64: fault: Don't leak data in ESR context for
 user fault on kernel VA
In-Reply-To: <20180419154833.27727-1-peter.maydell@linaro.org>
References: <20180419154833.27727-1-peter.maydell@linaro.org>
Message-ID: <20180522133826.GE26955@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Sorry for the delay in getting to this! Comments inline.

On Thu, Apr 19, 2018 at 04:48:33PM +0100, Peter Maydell wrote:
> If userspace faults on a kernel address, handing them the raw ESR
> value on the sigframe as part of the delivered signal can leak data
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
> faults as level 0 translation faults.
> 
> These fields are safe to pass through to userspace as they depend
> only on the instruction that userspace used to provoke the fault:
>  EC IL (always)
>  ISV CM WNR (for all data aborts)
>  SAS SSE SRT SF AR (for data aborts when ISV is 1)
> All the other fields in ESR except DFSC are architecturally RES0
> for an L0 translation fault, so can be zeroed out without confusing
> userspace.
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
> ---
> This RFC patch is an alternative proposal to Will's patch
> https://patchwork.kernel.org/patch/10258781/
> which simply removed the ESR record entirely for kernel addresses.
> 
> Changes v1->v2:
>  * rebased on master
>  * commit message tweak
>  * DABT_CUR and IABT_CUR moved to "can't happen" default case
>  * explicitly clear the bits which are RES0 if ISV == 0
>  * comment text tweaks
> ---
>  arch/arm64/mm/fault.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 4165485e8b6e..8fa78fa01a4a 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -293,6 +293,61 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
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
> +			 */
> +			if (esr & ESR_ELx_ISV)
> +				esr &= ESR_ELx_EC_MASK | ESR_ELx_IL |
> +					ESR_ELx_ISV | ESR_ELx_SAS |
> +					ESR_ELx_SSE | ESR_ELx_SRT_MASK |
> +					ESR_ELx_SF | ESR_ELx_AR | ESR_ELx_CM |
> +					ESR_ELx_WNR;

Reading through the ARM ARM, it seems to say that ISV is always 0 for
faults reported in ESR_EL1, which implies we can drop ISV, SAS, SSE, SRT,
SF and AR from this list and actually drop the conditional altogether.

Will

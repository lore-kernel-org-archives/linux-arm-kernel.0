From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 Jun 2017 16:23:20 +0100
Subject: [PATCH 1/3] arm64: ptrace: Fix VFP register dumping in compat
 coredumps
In-Reply-To: <1498057264-12211-1-git-send-email-Dave.Martin@arm.com>
References: <1498057010-12028-1-git-send-email-Dave.Martin@arm.com>
 <1498057264-12211-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170621152320.GG24558@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 04:00:42PM +0100, Dave Martin wrote:
> Currently, VFP registers are omitted from coredumps for compat
> processes, due to a bug in the REGSET_COMPAT_VFP regset
> implementation.
> 
> compat_vfp_get() needs to transfer non-contiguous data from
> thread_struct.fpsimd_state, and uses put_user() to handle the
> offending trailing word (FPSCR).  This fails when copying to a
> kernel address (i.e., kbuf && !ubuf), which is what happens when
> dumping core.  As a result, the ELF coredump core code silently
> omits the NT_ARM_VFP note from the dump.
> 
> It would be possible to work around this with additional special
> case code for the put_user(), but since user_regset_copyout() is
> explcltly designed to handle this scenario it is cleaner to port

Nit: explicitly

> the put_user() to a user_regset_copyout() call, which this patch
> does.

Given, 32-bit arm also uses user_regset_copyout(), it seems like the
all-round right thing to do.

> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/ptrace.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index c142459..0e5aaec 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -894,7 +894,7 @@ static int compat_vfp_get(struct task_struct *target,
>  {
>  	struct user_fpsimd_state *uregs;
>  	compat_ulong_t fpscr;
> -	int ret;
> +	int ret, vregs_end_pos;
>  
>  	uregs = &target->thread.fpsimd_state.user_fpsimd;
>  
> @@ -902,13 +902,16 @@ static int compat_vfp_get(struct task_struct *target,
>  	 * The VFP registers are packed into the fpsimd_state, so they all sit
>  	 * nicely together for us. We just need to create the fpscr separately.
>  	 */
> -	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
> -				  VFP_STATE_SIZE - sizeof(compat_ulong_t));
> +	vregs_end_pos = VFP_STATE_SIZE - sizeof(compat_ulong_t);
> +	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs,
> +				  0, vregs_end_pos);
>  
>  	if (count && !ret) {
>  		fpscr = (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
>  			(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
> -		ret = put_user(fpscr, (compat_ulong_t *)ubuf);
> +
> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fpscr,
> +					  vregs_end_pos, VFP_STATE_SIZE);
>  	}

It's a shame compat_user_vfp is defined in signal32.c, otherwise we
could've used offsetof(struct compat-user_vfp, fpscr) here (and also for
the fpregs), mirroring the structure of 32-bit's vfp_get().

Otherwise, this looks sane to me.

Thanks,
Mark

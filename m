From: monstr@monstr.eu (Michal Simek)
Date: Mon, 07 Apr 2014 11:39:20 +0200
Subject: [PATCH 1/3] arm64: Provide read/write fault information in compat
 signal handlers
In-Reply-To: <1396822746-26241-2-git-send-email-catalin.marinas@arm.com>
References: <1396822746-26241-1-git-send-email-catalin.marinas@arm.com>
 <1396822746-26241-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <53427248.4000406@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 12:19 AM, Catalin Marinas wrote:
> For AArch32, bit 11 (WnR) of the FSR/ESR register is set when the fault
> was caused by a write access and applications like Qemu rely on such
> information being provided in sigcontext. This patch introduces the
> ESR_EL1 tracking for the arm64 kernel faults and sets bit 11 accordingly
> in compat sigcontext.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/processor.h | 1 +
>  arch/arm64/kernel/signal32.c       | 4 +++-
>  arch/arm64/kernel/traps.c          | 7 +++++--
>  arch/arm64/mm/fault.c              | 3 ++-
>  4 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 45b20cd6cbca..34de2a8f7d93 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -79,6 +79,7 @@ struct thread_struct {
>  	unsigned long		tp_value;
>  	struct fpsimd_state	fpsimd_state;
>  	unsigned long		fault_address;	/* fault info */
> +	unsigned long		fault_code;	/* ESR_EL1 value */
>  	struct debug_info	debug;		/* debugging */
>  };
>  
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index b3fc9f5ec6d3..e4f0c0b0ca3a 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -500,7 +500,9 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
>  	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
>  
>  	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
> -	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.error_code, err);
> +	/* compat tasks expect bit 11 as WnR status bit */
> +	__put_user_error((current->thread.fault_code & (1 << 6)) << 5,


Isn't it better to use macros for these magic values?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/7499cd9b/attachment.sig>

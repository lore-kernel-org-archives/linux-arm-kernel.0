From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Nov 2018 23:33:03 +0000
Subject: [PATCH] arm: always update thread_info->syscall
In-Reply-To: <20181126225335.10477-1-rafael.tinoco@linaro.org>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
Message-ID: <20181126233303.GZ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
> Right now, only way for task->thread_info->syscall to be updated is if
> if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
> (similar to what has_syscall_work() checks for arm64).
> 
> This means that "->syscall" will only be updated if we are tracing the
> syscalls through ptrace, for example. This is NOT the same behavior as
> arm64, when pt_regs->syscallno is updated in the beginning of svc0
> handler for *every* syscall entry.

So when was it decided that the syscall number will always be required
(we need it to know how far back this has to be backported).

> This patch fixes the issue since this behavior is needed for
> /proc/<pid>/syscall 1st argument to be correctly updated.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3783
> Cc: <stable@vger.kernel.org> # v4.4 v4.9 v4.14 v4.19
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  arch/arm/kernel/asm-offsets.c  | 1 +
>  arch/arm/kernel/entry-common.S | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 3968d6c22455..bfe68a98e1c6 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -64,6 +64,7 @@ int main(void)
>    DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
>    DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
>    DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
> +  DEFINE(TI_SYSCALL,		offsetof(struct thread_info, syscall));
>  #ifdef CONFIG_VFP
>    DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
>  #ifdef CONFIG_SMP
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 0465d65d23de..557e2add4e83 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -257,6 +257,8 @@ local_restart:
>  	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
>  	bne	__sys_trace
>  
> +	str	r7, [tsk, #TI_SYSCALL]		@ update thread_info->syscall

"scno" is the systemcall number, not "r7".

> +
>  	invoke_syscall tbl, scno, r10, __ret_fast_syscall
>  
>  	add	r1, sp, #S_OFF
> -- 
> 2.20.0.rc1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

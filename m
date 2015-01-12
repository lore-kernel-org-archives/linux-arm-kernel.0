From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Jan 2015 18:39:55 +0000
Subject: [PATCH 1/2] ARM: entry-common: fix forgotten set of
 thread_info->syscall
In-Reply-To: <1420986751-30364-2-git-send-email-r.peniaev@gmail.com>
References: <1420986751-30364-1-git-send-email-r.peniaev@gmail.com>
 <1420986751-30364-2-git-send-email-r.peniaev@gmail.com>
Message-ID: <20150112183955.GO13360@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 02:32:30PM +0000, Roman Pen wrote:
> thread_info->syscall is used only for ptrace, but syscall number
> is also used by syscall_get_nr and returned to userspace by the
> following proc file access:
> 
>  $ cat /proc/self/syscall
>  0 0x3 0xbe928bd8 0x1000 0x0 0xac9e0 0x3 0xbe928bb4 0xb6f5dfbc
>  ^
> The first number is the syscall number, currently it is zero.
> Patch fixes this:
> 
>  $ cat /proc/self/syscall
>  3 0x3 0xbefc7bd8 0x1000 0x0 0xac9e0 0x3 0xbefc7bb4 0xb6e82fbc
>  ^
> Right, read syscall

Yes, it seems that despite requiring CONFIG_HAVE_ARCH_TRACEHOOK,
the /proc code requires syscall_get_nr to work regardless of
TIF_SYSCALL_TRACE.

> Signed-off-by: Roman Pen <r.peniaev@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/kernel/asm-offsets.c  | 1 +
>  arch/arm/kernel/entry-common.S | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 2d2d608..6911bad 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -70,6 +70,7 @@ int main(void)
>    DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
>    DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
>    DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
> +  DEFINE(TI_SYSCALL,		offsetof(struct thread_info, syscall));
>    DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
>    DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
>    DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index f8ccc21..89452ff 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -189,6 +189,7 @@ ENTRY(vector_swi)
>  #endif
>  
>  local_restart:
> +	str scno, [tsk, #TI_SYSCALL]		@ set syscall number
>  	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
>  	stmdb	sp!, {r4, r5}			@ push fifth and sixth args

Do we definitely want to update scno on syscall restarting?

Will

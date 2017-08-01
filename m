From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Aug 2017 12:36:47 +0100
Subject: [PATCH 1/2] arm64: syscallno is secretly an int, make it official
In-Reply-To: <1500381724-19003-2-git-send-email-Dave.Martin@arm.com>
References: <1500381724-19003-1-git-send-email-Dave.Martin@arm.com>
 <1500381724-19003-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170801113647.GF8702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 01:41:43PM +0100, Dave Martin wrote:
> The upper 32 bits of the syscallno field in struct pt_regs are handled
> inconsistently, being sometimes zero extended and sometimes
> sign-extended.  The reason for this appears to be that they are not
> intentionally significant at all.
> 
> Currently, the only place I can find where those bits are
> significant is in calling trace_sys_enter(), which may be
> unintentional: for example, if a compat tracer attempts to cancel a
> syscall by passing -1 to (COMPAT_)PTRACE_SET_SYSCALL at the
> syscall-enter-stop, it will be traced as syscall 4294967295
> rather than -1 as might be expected (and as occurs for a native
> tracer doing the same thing).  Elsewhere, reads of syscallno cast
> it to an int or truncate it.
> 
> There's also a conspicuous amount of code and casting to bodge
> around the fact that although semantically an int, syscallno is
> stored as a u64.
> 
> Let's not pretend any more.
> 
> In order to preserve the stp x instruction that stores the syscall
> number in entry.S, this patch special-cases the layout of struct
> pt_regs for big endian so that the newly 32-bit syscallno field
> maps onto the low bits of the stored value.  This is not beautiful,
> but benchmarking of the getpid syscall on Juno suggests indicates a
> minor slowdown if the stp is split into an stp x and stp w.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/processor.h |  2 +-
>  arch/arm64/include/asm/ptrace.h    |  9 ++++++++-
>  arch/arm64/kernel/entry.S          | 34 +++++++++++++++++-----------------
>  arch/arm64/kernel/ptrace.c         |  2 +-
>  arch/arm64/kernel/signal.c         |  6 +++---
>  arch/arm64/kernel/signal32.c       |  2 +-
>  arch/arm64/kernel/traps.c          |  2 +-
>  7 files changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 64c9e78..379def1 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -112,7 +112,7 @@ void tls_preserve_current_state(void);
>  static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
>  {
>  	memset(regs, 0, sizeof(*regs));
> -	regs->syscallno = ~0UL;
> +	regs->syscallno = ~0;
>  	regs->pc = pc;
>  }
>  
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 11403fd..21c87dc 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -116,7 +116,14 @@ struct pt_regs {
>  		};
>  	};
>  	u64 orig_x0;
> -	u64 syscallno;
> +#ifdef __AARCH64EB__
> +	u32 unused2;
> +	s32 syscallno;
> +#else
> +	s32 syscallno;
> +	u32 unused2;
> +#endif
> +
>  	u64 orig_addr_limit;
>  	u64 unused;	// maintain 16 byte alignment

This isn't a UAPI struct, so we could juggle these about a bit to put all
the unused padding at the end.

Other than that, this looks good:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

From: osandov@osandov.com (Omar Sandoval)
Date: Wed, 30 Jul 2014 00:20:11 -0700
Subject: [PATCH] ARM/ARM64: don't enter kgdb when userspace executes a
 kgdb break instruction.
In-Reply-To: <20140730071245.GA8954@mew.web-pass.com>
References: <20140730071245.GA8954@mew.web-pass.com>
Message-ID: <20140730072011.GA11145@mew.web-pass.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 12:12:45AM -0700, Omar Sandoval wrote:
> The kgdb breakpoint hooks (kgdb_brk_fn and kgdb_compiled_brk_fn) should only be
> entered when a kgdb break instruction is executed from the kernel. Otherwise,
> if kgdb is enabled, a userspace program can cause the kernel to drop into the
> debugger by executing either KGDB_BREAKINST or KGDB_COMPILED_BREAK on ARM, or
> brk #KGDB_{DYN,COMPILED}_DGB_BRK_IMM on ARM64.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> ---
> The following program reproduces the fixed problem on ARM:
> .globl _start
> _start:
> 	udf	#65006	@ KGDB_BREAKINST
> 
> And on ARM64:
> .globl _start
> _start:
>         brk     #0x400	@ KGDB_DYN_DGB_BRK_IMM
> 
>  arch/arm/kernel/kgdb.c                  | 4 ++++
>  arch/arm64/include/asm/debug-monitors.h | 4 +++-
>  arch/arm64/kernel/debug-monitors.c      | 3 ++-
>  arch/arm64/kernel/kgdb.c                | 4 ++++
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index 778c2f7..a74b53c 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -160,12 +160,16 @@ static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int instr)
>  static struct undef_hook kgdb_brkpt_hook = {
>  	.instr_mask		= 0xffffffff,
>  	.instr_val		= KGDB_BREAKINST,
> +	.cpsr_mask		= MODE_MASK,
> +	.cpsr_val		= SVC_MODE,
>  	.fn			= kgdb_brk_fn
>  };
>  
>  static struct undef_hook kgdb_compiled_brkpt_hook = {
>  	.instr_mask		= 0xffffffff,
>  	.instr_val		= KGDB_COMPILED_BREAK,
> +	.cpsr_mask		= MODE_MASK,
> +	.cpsr_val		= SVC_MODE,
>  	.fn			= kgdb_compiled_brk_fn
>  };
>  
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 6e9b5b3..e1d27ce 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -105,8 +105,10 @@ void unregister_step_hook(struct step_hook *hook);
>  
>  struct break_hook {
>  	struct list_head node;
> -	u32 esr_val;
>  	u32 esr_mask;
> +	u32 esr_val;
> +	u64 pstate_mask;
> +	u64 pstate_val;
>  	int (*fn)(struct pt_regs *regs, unsigned int esr);
>  };
>  
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index a7fb874..594fac4 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -303,7 +303,8 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
>  
>  	read_lock(&break_hook_lock);
>  	list_for_each_entry(hook, &break_hook, node)
> -		if ((esr & hook->esr_mask) == hook->esr_val)
> +		if ((esr & hook->esr_mask) == hook->esr_val &&
> +		    (regs->pstate & hook->pstate_mask) == hook->pstate_val)
>  			fn = hook->fn;
>  	read_unlock(&break_hook_lock);
>  
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 75c9cf1..80eb035 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -236,12 +236,16 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
>  static struct break_hook kgdb_brkpt_hook = {
>  	.esr_mask	= 0xffffffff,
>  	.esr_val	= DBG_ESR_VAL_BRK(KGDB_DYN_DGB_BRK_IMM),
> +	.pstate_mask	= PSR_MODE_MASK,
> +	.pstate_val	= PSR_MODE_EL1h,
>  	.fn		= kgdb_brk_fn
>  };
>  
>  static struct break_hook kgdb_compiled_brkpt_hook = {
>  	.esr_mask	= 0xffffffff,
>  	.esr_val	= DBG_ESR_VAL_BRK(KDBG_COMPILED_DBG_BRK_IMM),
> +	.pstate_mask	= PSR_MODE_MASK,
> +	.pstate_val	= PSR_MODE_EL1h,
>  	.fn		= kgdb_compiled_brk_fn
>  };
>  
> -- 
> 2.0.3
> 

-- 
Hi, all,

Resubmitting this from a couple of weeks ago, also fixing the same problem in
ARM64. Could I get some feedback or an ack on this? Otherwise, please apply it.

Thanks!
Omar

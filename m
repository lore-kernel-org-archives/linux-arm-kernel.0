From: osandov@osandov.com (Omar Sandoval)
Date: Sat, 19 Jul 2014 22:56:43 -0700
Subject: [PATCH] ARM: Don't oops when userspace executes kgdb break
 instructions.
In-Reply-To: <20140718225049.GA11937@mew.guest.dropbox.com>
References: <20140718225049.GA11937@mew.guest.dropbox.com>
Message-ID: <20140720055643.GA8413@mew.web-pass.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 03:51:31PM -0700, Omar Sandoval wrote:
> Don't break into kgdb when userspace executes the kernel break instructions
> (KGDB_BREAKINST and KGDB_COMPILED_BREAK). The kernel will oops in
> kgdb_handle_exception.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> ---
> The following program will immediately cause a kernel oops:
> .globl _start
> _start:
> 	udf	#65006	@ KGDB_BREAKINST
> 
>  arch/arm/kernel/kgdb.c | 4 ++++
>  1 file changed, 4 insertions(+)
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
> -- 
> 2.0.1

-- 

Following up/clarifying this. This only happens when the kernel is compiled
with CONFIG_KGDB. When a userspace program executes KGDB_BREAKINST or
KGDB_COMPILED_BREAK, the undef_hook for kgdb catches it. The reason in kdb_stub
defaults to KDB_REASON_OOPS, so the bug manifests itself as an oops caused by
userspace (a better description for the patch would be "Don't enter KGDB when
userspace executes kgdb break instructions"). This means that a buggy/malicious
program can take down the system just by executing an instruction.

ARM64 might have the same issue, but I don't have a board to test that on.

I verified that breaking normally (e.g., with kgdbwait or through
/proc/sysrq-trigger) still works.
?
Omar

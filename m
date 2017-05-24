From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 May 2017 11:09:49 +0100
Subject: [PATCH v2 2/2] arm64: Add dump_backtrace() in show_regs
In-Reply-To: <1494294817-29187-2-git-send-email-wangkefeng.wang@huawei.com>
References: <20170508145535.GF5480@leverpostej>
 <1494294817-29187-1-git-send-email-wangkefeng.wang@huawei.com>
 <1494294817-29187-2-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20170524100949.GA24574@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 09, 2017 at 09:53:37AM +0800, Kefeng Wang wrote:
> Generic code expects show_regs() to dump the stack, but arm64's
> show_regs() does not. This makes it hard to debug softlockups and
> other issues that result in show_regs() being called.
> 
> This patch updates arm64's show_regs() to dump the stack, as common
> code expects.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/stacktrace.h | 1 +
>  arch/arm64/kernel/process.c         | 1 +
>  arch/arm64/kernel/traps.c           | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 801a16db..5b6eafc 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -30,5 +30,6 @@ struct stackframe {
>  extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
>  extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>  			    int (*fn)(struct stackframe *, void *), void *data);
> +extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk);
>  
>  #endif	/* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index ae2a835..af1ea25 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -210,6 +210,7 @@ void __show_regs(struct pt_regs *regs)
>  void show_regs(struct pt_regs * regs)
>  {
>  	__show_regs(regs);
> +	dump_backtrace(regs, NULL);
>  }
>  
>  static void tls_thread_flush(void)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index d4d6ae0..368c3c8 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -140,7 +140,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  	}
>  }
>  
> -static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> +void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  {
>  	struct stackframe frame;
>  	unsigned long irq_stack_ptr;

I just realised that we'll need one additional fixup:

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0805b44..f452fcc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -728,8 +728,6 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
                break;
 
        case BUG_TRAP_TYPE_WARN:
-               /* Ideally, report_bug() should backtrace for us... but no. */
-               dump_backtrace(regs, NULL);
                break;
 
        default:

... since report_bug() will call show_regs(), and dump the stack itself
now.

With that change, these patches will also fix *_ONCE() traps spewing
backtraces every time they're invoked, which was a side-effect of
commit:

  19d436268dde9538 ("debug: Add _ONCE() logic to report_bug()")

Would you mind folding that into a v3?

Thanks,
Mark.

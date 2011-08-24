From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Aug 2011 14:57:48 -0400 (EDT)
Subject: [PATCH 2/2] process: change from __backtrace to dump_stack_regs
	in show_regs
In-Reply-To: <1314206507-6487-3-git-send-email-lauraa@codeaurora.org>
References: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
	<1314206507-6487-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1108241434140.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Aug 2011, Laura Abbott wrote:

> Currently, show_regs calls __backtrace which does
> nothing if CONIFG_FRAME_POINTER is not set. Switch to

s/CONIFG/CONFIG/

> dump_stack_regs to show the backtrace from a given
> set of registers.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm/kernel/process.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 1a347f4..6f11213 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -319,7 +319,7 @@ void show_regs(struct pt_regs * regs)
>  	printk("\n");
>  	printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
>  	__show_regs(regs);
> -	__backtrace();
> +	dump_stack_regs(regs);

This is not equivalent.  A call to __backtrace() will display a call 
trace leading to this show_regs().  Given that you defined 
dump_stack_regs(regs) as dump_backtrace(regs, NULL), the trace will 
instead contain calls leading up to the point where those regs were 
saved.

A better way to achieve what you want would be:

- remove the __backtrace entry point from lib/backtrace.S

- define __backtrace() in kernel/traps.c as a call to 
  dump_backtrace(NULL, NULL) which will have the same effect as the
  assembly code for __backtrace().

- realize that dump_stack() is already doing exactly that, therefore...

- use dump_stack() in show_regs() which is the only caller of 
  __backtrace and get rid of __backtrace entirely.

Obviously the above can be collapsed in one patch.


Nicolas

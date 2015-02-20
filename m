From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Feb 2015 10:57:43 +0000
Subject: [PATCH] arm64: fix pt_regs location in Exception stack dump
In-Reply-To: <1424411928-1122-1-git-send-email-hc.yen@mediatek.com>
References: <1424411928-1122-1-git-send-email-hc.yen@mediatek.com>
Message-ID: <20150220105743.GD31692@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Feb 20, 2015 at 05:58:48AM +0000, HC Yen wrote:
> In __exception_irq_entry functions, they could allocate some space on
> stack before pt_regs. Here is the prologue of gic_handle_irq():

I don't think this is specific to __exception_irq_entry functions -- it
looks to me like unwind_frame is making assumptions about the prologue
that aren't enforced by the PCS.

In which case, the 'frame->sp = fp + 0x10' is really bogus. We're probably
better off just doing 'frame->sp = fp' and adding a comment that the
frame record can live anywhere in the stack frame. That doesn't solve your
backtrace case, but at least it stops us pretending that adding 16 buys
us anything.

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 1ef2940..a564429 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -90,12 +90,12 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>  	set_fs(fs);
>  }
>  
> -static void dump_backtrace_entry(unsigned long where, unsigned long stack)
> +static void dump_backtrace_entry(unsigned long where, unsigned long frame)
>  {
>  	print_ip_sym(where);
>  	if (in_exception_text(where))
> -		dump_mem("", "Exception stack", stack,
> -			 stack + sizeof(struct pt_regs));
> +		dump_mem("", "Exception stack",
> +			 frame - sizeof(struct pt_regs), frame);
>  }
>  
>  static void dump_instr(const char *lvl, struct pt_regs *regs)
> @@ -164,7 +164,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  		ret = unwind_frame(&frame);
>  		if (ret < 0)
>  			break;
> -		dump_backtrace_entry(where, frame.sp);
> +		dump_backtrace_entry(where, frame.fp);

I'm afraid I'm not following this. What guarantees that frame.fp points
to the end of the pt_regs structure on an exception?

Will

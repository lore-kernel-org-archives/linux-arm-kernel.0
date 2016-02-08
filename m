From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Mon, 8 Feb 2016 11:51:01 +0300
Subject: [PATCH] arm64: disable kasan when accessing frame->fp in
 unwind_frame
In-Reply-To: <1454713487-5239-1-git-send-email-yang.shi@linaro.org>
References: <1454713487-5239-1-git-send-email-yang.shi@linaro.org>
Message-ID: <56B856F5.5080606@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/06/2016 02:04 AM, Yang Shi wrote:
>  
>  #include <asm/irq.h>
>  #include <asm/stacktrace.h>
> @@ -64,7 +65,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  		return -EINVAL;
>  
>  	frame->sp = fp + 0x10;
> +	kasan_disable_current();
>  	frame->fp = *(unsigned long *)(fp);

It would be better to use READ_ONCE_NOCHECK() here.
See f7d27c35ddff7 ("x86/mm, kasan: Silence KASAN warnings in get_wchan()") which solves the same problem for x86.

> +	kasan_enable_current();
>  	frame->pc = *(unsigned long *)(fp + 8);

Why you left frame->pc out of scope? This line could trigger kasan as well.

>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 

From: yang.shi@linaro.org (Shi, Yang)
Date: Mon, 8 Feb 2016 09:12:21 -0800
Subject: [PATCH] arm64: disable kasan when accessing frame->fp in
 unwind_frame
In-Reply-To: <56B856F5.5080606@virtuozzo.com>
References: <1454713487-5239-1-git-send-email-yang.shi@linaro.org>
 <56B856F5.5080606@virtuozzo.com>
Message-ID: <56B8CC75.1000508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/8/2016 12:51 AM, Andrey Ryabinin wrote:
>
>
> On 02/06/2016 02:04 AM, Yang Shi wrote:
>>
>>   #include <asm/irq.h>
>>   #include <asm/stacktrace.h>
>> @@ -64,7 +65,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>>   		return -EINVAL;
>>
>>   	frame->sp = fp + 0x10;
>> +	kasan_disable_current();
>>   	frame->fp = *(unsigned long *)(fp);
>
> It would be better to use READ_ONCE_NOCHECK() here.
> See f7d27c35ddff7 ("x86/mm, kasan: Silence KASAN warnings in get_wchan()") which solves the same problem for x86.

Thanks for the suggestion, I'm going to try it soon.

>
>> +	kasan_enable_current();
>>   	frame->pc = *(unsigned long *)(fp + 8);
>
> Why you left frame->pc out of scope? This line could trigger kasan as well.

Actually, it was not reported as frequently as the first one. In my 
first a couple of boot test, it was not triggered before I came up with 
the patch. The first one is triggered every time.

It will be fixed in v2 too.

Thanks,
Yang

>
>>
>>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>

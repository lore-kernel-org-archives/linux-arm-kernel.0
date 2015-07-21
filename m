From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 21 Jul 2015 23:34:21 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <55AE1E5F.6060407@linaro.org>
References: <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
 <20150717104144.6588b2f7@gandalf.local.home>
 <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
 <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
 <20150720162004.GL9908@arm.com> <55AD89FE.1010706@linaro.org>
 <55AE1E5F.6060407@linaro.org>
Message-ID: <39628AC3-A593-4E48-89A5-D95F22734009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 21, 2015, at 7:26 PM, AKASHI Takahiro wrote:
> On 07/21/2015 08:53 AM, AKASHI Takahiro wrote:
>> Hi
>> 
>> So i don't have to repost my patch here. Please use the original
>> commit log message[1/3] as is.
>> But please keep in mind that there is still an issue that I mentioned
>> in the cover letter; 'Size' field is inaccurate.
>>  <reported size> = <its own dynamic local variables>
>>                         + <child's local variables>
>> and
>>  <real size> = <reported size> + <its local variables>
>>                                - <child's local variables>
>> where "dynamic" means, for example, a variable allocated like the below:
>>   int foo(int num) {
>>     int array[num];
>>     ...
>>   }
>> (See more details in my ascii art.)
>> 
>> Such usage is seldom seen in the kernel, and <reported size> is
>> likely equal to <child's local variables>. In other words, we will
>> see one-line *displacement* in most cases.
> 
> Well, I have a quick fix now, but it looks ugly.

AFAIU, stack_max_size would be more accurate if a separate stack
is introduced for interrupt context. However, it might be unnecessary
at this point due to complexity.

> In addition, I found another issue; With function_graph tracer,
> the output is like:
> # cat /sys/kernel/tracing/stack_trace
>        Depth    Size   Location    (78 entries)
>        -----    ----   --------
>  0)     6184      32   update_min_vruntime+0x14/0x74
>  1)     6152      48   update_curr+0x6c/0x150
>  2)     6104     128   enqueue_task_fair+0x2f4/0xb9c
>  3)     5976      48   enqueue_task+0x48/0x90
>  ...
> 18)     5160     112   hrtimer_interrupt+0xa0/0x214
> 19)     5048      32   arch_timer_handler_phys+0x38/0x48
> 20)     5016       0   ftrace_graph_caller+0x2c/0x30
> 21)     5016      64   ftrace_graph_caller+0x2c/0x30
> 22)     4952      32   ftrace_graph_caller+0x2c/0x30
> 23)     4920      64   ftrace_graph_caller+0x2c/0x30
>  ...
> 
> Since, with function_graph tracer, we modify LR register in a stack frame
> when we enter into a function, we have to manage such special cases
> in save_stack_trace() or check_stack() as x86 does in
> print_ftrace_graph_addr().

I should have run it with function_graph. The issue is reproduced easily
on my environment. I don't see other issues yet when enabling other tracers.

Best Regards
Jungseok Lee

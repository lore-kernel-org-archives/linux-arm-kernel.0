From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 15 Jul 2015 20:41:34 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150714225105.6c1e4f15@gandalf.local.home>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>	<1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>	<DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>	<20150714093154.4d73e551@gandalf.local.home>	<55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
Message-ID: <55A646EE.6030402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve,

On 07/15/2015 11:51 AM, Steven Rostedt wrote:
> On Wed, 15 Jul 2015 09:20:42 +0900
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>
>> On 07/14/2015 10:31 PM, Steven Rostedt wrote:
>>> On Tue, 14 Jul 2015 21:47:10 +0900
>>> Jungseok Lee <jungseoklee85@gmail.com> wrote:
>>>
>>>> Is the below example an unexpected result?
>>>> Entry 17 and 18 are ftrace_call and ftrace_ops_no_ops, respectively.
>>
>> [snip]
>>
>>> Note, function tracing does not disable interrupts. This looks to be
>>> that an interrupt came in while __aloc_skb() was being traced.
>>
>> Yeah, I think so, too. But if my insight is correct, it's not __alloc_skb()
>> but one of functions that it calls. As I said in the commit log message
>> of patch[1/3], the exact traced function will not be listed by

not patch[1/3], but patch[3/3]

>> save_stack_trace() because we don't create a stack frame at mcount().
>> I think this is a flaw in the current implementation (on x86).
>>
>> what do you think, Steve?
>>
>
> mcount (well ftrace_call actually) does indeed create a stack frame for
> itself *and* for what called it. At least on x86_64. See mcount_64.S.
>
> With -pg -mfentry, it creates a stack frame. Without -mfentry, mcount
> is called after the current function's frame is made so we don't need
> to do much.

Thank you for the explanation. But what I don't really understand here
is why we need to add the "current function" to the stack dump list
returned by save_stack_trace():

In check_stack(),
 >        /*
 >         * Add the passed in ip from the function tracer.
 >         * Searching for this on the stack will skip over
 >         * most of the overhead from the stack tracer itself.
 >         */
 >        stack_dump_trace[0] = ip;
 >        max_stack_trace.nr_entries++;

I think that "ip" here is the "return address for func" in your
ascii art, and it should be already in the list if a frame is made
by mcount (or func_call).

In fact, stack tracer on arm64 works OK even without the patch[3/3]
if the code quoted above is commented out.
Even on x86, the code is conditional and not activated if the kernel
is compiled without -mfentry before the following commit:
     commit 4df297129f62 ("tracing: Remove most or all of stack tracer stack size from stack_max_size")

So what do I misunderstand here?

Thanks,
-Takahiro AKASHI

> Here's what the -mfentry version does:
>
> 	pushq %rbp
> 	pushq 8*2(%rsp)  /* this is the parent pointer */
> 	pushq %rbp
> 	movq %rsp, %rbp
> 	pushq 8*3(%rsp)   /* Return address to ftrace_call */
> 	pushq %rbp
> 	movq %rsp, %rbp
>
>
> Thus the stack looks like this:
>
>                                           <---+
> 	|                              |     |
> 	+------------------------------+     |
> 	| return address for func      |     |
> 	| return address for func_call |     |
> 	| original %rbp                |     |
> 	+------------------------------+     |
> 	| return address for func      |     |
> 	| ptr to parent frame (%rbp)   | ----+
>   	+------------------------------| <-----+
> 	| return address for func_call |       |
>          | ptr to next frame (%rbp)     | ------+
> 	+------------------------------+ <---+
>                                               |
>                                               |
>   Current %rbp points to func_call frame -----+
>
>   The first box isn't used as a frame, but is used by ftrace_call to save
>   information to restore everything properly.
>
> Thus, __alloc_skb() is what is currently being traced.
>
>
> -- Steve
>

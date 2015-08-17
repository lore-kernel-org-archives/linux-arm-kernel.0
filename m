From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 18 Aug 2015 00:29:55 +0900
Subject: [RFC v2 0/4] arm64: ftrace: fix incorrect output from stack tracer
In-Reply-To: <55D16831.5080605@linaro.org>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
 <50B298B0-1978-471B-BCE7-BC433E9993C1@gmail.com>
 <55D16831.5080605@linaro.org>
Message-ID: <33817404-EDFB-45D0-9535-E23474C9B56F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aug 17, 2015, at 1:50 PM, AKASHI Takahiro wrote:
> Hi

Hi Akashi,

> On 08/11/2015 11:52 PM, Jungseok Lee wrote:
>> On Aug 4, 2015, at 4:44 PM, AKASHI Takahiro wrote:
>> 
>> Hi Akashi,
>> 
>>> See the following threads [1],[2] for the background.
>>> 
>>> With this patch series, I'm trying to fix several problems I noticed
>>> with stack tracer on arm64. But it is rather experimental, and there still
>>> remained are several issues.
>>> 
>>> Patch #1 modifies ftrace framework so that we can provide arm64-specific
>>> stack tracer later.
>>> (Well, I know there is some room for further refactoring, but this is
>>> just a prototype code.)
>>> Patch #2 implements this arch_check_stack() using unwind_stackframe() to
>>> traverse stack frames and identify a stack index for each traced function.
>>> Patch #3 addresses an issue that stack tracer doesn't work well in
>>> conjuction with function graph tracer.
>>> Patch #4 addresses an issue that unwind_stackframe() misses a function
>>> that is the one when an exception happens by setting up a stack frame
>>> for exception handler.
>>> 
>>> See below for the result with those patches.
>>> Issues include:
>>> a) Size of gic_handle_irq() is 48 (#13), but should be 64.
>>> b) We cannot identify a location of function which is being returned
>>>   and hooked temporarily by return_to_handler() (#18)
>>> c) A meaningless entry (#62) as well as a bogus size for the first
>>>   function, el0_svc (#61)
>>> d) Size doesn't contain a function's "dynamically allocated local
>>>   variables," if any, but instead is sumed up in child's size.
>>>   (See details in [3].)
>>> 
>>> I'm afraid that we cannot fix issue b) unless we can do *atomically*
>>> push/pop a return adress in current->ret_stack[], increment/decrement
>>> current->curr_ret_stack and restore lr register.
>>> 
>>> We will be able to fix issue d) once we know all the locations in
>>> the list, including b).
>>> 
>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
>>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355920.html
>>> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358034.html
>> 
>> I hope I'm not too late..
> 
> I was on vacation last week.
> 
>> This series looks written on top of the hunk in the end of this reply.
>> 
>> I've strongly agreed with your opinion as digging out this issue. We need to analyse
>> the first instruction of each function, "stp x29, x30, [sp, #val]!", in order to
>> solve this problem clearly.
> 
> As far as I notice, the following is not the only prologue:
>  stp  x29,x30, [sp,#-xx]!
>  mov  x29,sp
> but some functions may have another one like:
>  sub  sp, sp, #xx
>  stp  x29,x30, [sp, #16]
>  add  x29,sp, #16
> Even worse, I see some variant, for example in trace_graph_entry(),
>  adrp x2, 0x...
>  stp  x29,x30,[sp,#-xx]!
>  add  x4, x2, #..
>  mov  x29,x30
> 
> So parsing the function prologue perfectly is a bit more complicated than imagined.
> I'm now asking some gcc guy for more information.

I've also observed the last two variants as playing with kallsyms to parse function
prologues. The work is accompanied by a pretty expensive computational overhead which
might be unnecessary originally. IMHO, one of PCS's objectives is to handle this kind
of work gracefully. Isn't it?

It is a great approach to talk with gcc guys. It looks inevitable that a complex decoding
logic is needed without it.

I have two drafts on this issue.

1) AARCH64 PCS
I borrow the ascii art from your description :)
If the stack frame is constructed as follows, it would be possible to record
an accurate stack size without decoding store-pair instruction or its variants.
Additionally, a code, frame->sp = fp + 0x10, is correct except exceptions.

    +-------+
    |       |
    |       |
    +-------+
    |       |
    | func-1's dynamic variable
    |       |
    +-------+
    |       |
    | func-1's local variable
    |       |
fp1 +-------+
    |  fp0  |
    +-------+
    |  lr0  |
sp1 +-------+ <------ func-1's stackframe
    |       |
    | func-0's dynamic variable
    |       |
    +-------+
    |       |
    | func-0's local variable
    |       |
    +-------+
    |       |
    +-------+ top

However, it's a pretty big challenge to update PCS..

2) v1 approach + function graph fix.
I use a stack tracer to check max stack size and its context. It would
be perfect if it shows an accurate size of every entry, but it would be
enough to find dominant entries in real practice,@least in my case.
(I agree caller's dynamic + callee's local is technically unacceptable.)
The same approach could be applied to exception. It would be no issue
anymore if someone try to introduce a separate IRQ stack like x86.

Best Regards
Jungseok Lee

From: alex.shi@linaro.org (Alex Shi)
Date: Fri, 24 Nov 2017 23:09:30 +0800
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171121132001.GH31757@n2100.armlinux.org.uk>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
Message-ID: <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> [   53.302718] softirqs last  enabled at (11474): [<c034c5d0>] __do_softirq+0x280/0x5ac
>> [   53.310494] softirqs last disabled at (11433): [<c034cc98>] irq_exit+0xf4/0x158
>> [   53.317837] CPU: 0 PID: 1691 Comm: ftracetest Not tainted 4.9.55-dirty #1
>> [   53.324652] Hardware name: Generic DRA74X (Flattened Device Tree)
>> [   53.330857] [<c03114d8>] (unwind_backtrace) from [<c030cb18>] (show_stack+0x10/0x14)
>> [   53.338644] [<c030cb18>] (show_stack) from [<c067e604>] (dump_stack+0xa4/0xd0)
>> [   53.345908] [<c067e604>] (dump_stack) from [<c0373808>] (___might_sleep+0x1ac/0x2a0)
>> [   53.353694] [<c0373808>] (___might_sleep) from [<c0d60ec8>] (do_page_fault+0x25c/0x428)
>> [   53.361739] [<c0d60ec8>] (do_page_fault) from [<c03013e8>] (do_PrefetchAbort+0x38/0x9c)
>> [   53.369780] [<c03013e8>] (do_PrefetchAbort) from [<c0d605a8>] (__pabt_svc+0x68/0xa0)
>> [   53.377557] Exception stack(0xec6fbfa8 to 0xec6fbff0)
>> [   53.382629] bfa0:                   00000001 00000001 ffffffff 00000000 0010ac68 00000007
>> [   53.390845] bfc0: 00000001 0000003f 00000009 0000000c fffffffa be9d27a4 000e31fc ec6fbff8
>> [   53.399055] bfe0: b6e6d49c b6e6d49c 40070093 ffffffff
>> [   53.404137] [<c0d605a8>] (__pabt_svc) from [<b6e6d49c>] (0xb6e6d49c)
> 
> It also doesn't help that the backtrace stops at this point, and it looks
> very strange:
> 
> 1. the value of PC looks like it's outside of the module space.
> 2. the CPSR indicates that the CPU was in SVC mode in the parent context
>    with IRQs disabled.
> 3. We're right at the top of the kernel stack, which suggests no further
>    stack frames above this.
> 
> We should never be in SVC mode without further stack frames on the kernel
> stack.
> 
> We don't seem to have overflowed the kernel stack, as the thread info
> seems correct - and it would also be unlikely that the saved SP value
> would end in ff8 in the exception stack frame.

Hi Russell,

Sorry for response late!
Is this SP was stained by sth? As my understand, SP should be times of
32bits. But why stack print out correct with a incorrect SP?

> 
> I suspect something nasty is going on in the ftrace code, causing some
> stacked state corruption, which then leads to us returning from a
> kernel exception with state that leaves the CPU in SVC mode with
> IRQs disabled, and with a LR & PC value of 0xb6e6d49c - a page that
> doesn't exist.  That the leads to a prefetch abort, and this error.
> 
> In other words, the real problem is that something has gone wrong in
> the ftrace code... what that is, I've no idea.
> 

Full agree with your analysis. Is it possible to stain PC value with
heavy stress on thermal or sth else? the ARM64 board run well with
ftracetest of LTP.

Thanks a lot!
Alex

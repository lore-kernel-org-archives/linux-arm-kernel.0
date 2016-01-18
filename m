From: wangnan0@huawei.com (Wangnan (F))
Date: Mon, 18 Jan 2016 19:39:06 +0800
Subject: [PATCH v2] arm64: Store breakpoint single step state into pstate
In-Reply-To: <20160112170650.GI15737@arm.com>
References: <1450860731-194418-1-git-send-email-wangnan0@huawei.com>
 <1450921362-198371-1-git-send-email-wangnan0@huawei.com>
 <20160104165535.GI1616@arm.com> <568B4F47.5080307@huawei.com>
 <20160112170650.GI15737@arm.com>
Message-ID: <569CCEDA.6040103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/13 1:06, Will Deacon wrote:
> On Tue, Jan 05, 2016 at 01:06:15PM +0800, Wangnan (F) wrote:
>> On 2016/1/5 0:55, Will Deacon wrote:
>>> The problem seems to be that we take the debug exception before the
>>> breakpointed instruction has been executed and call perf_bp_event at
>>> that moment, so when we single-step the faulting instruction we actually
>>> step into the SIGIO handler and end up getting stuck.
>>>
>>> Your fix doesn't really address this afaict, in that you don't (can't?)
>>> handle:
>>>
>>>    * A longjmp out of a signal handler
>>>    * A watchpoint and a breakpoint that fire on the same instruction
>>>    * User-controlled single-step from a signal handler that enables a
>>>      breakpoint explicitly
>>>    * Nested signals
>> Please have a look at [1], which I improve test__bp_signal() to
>> check bullet 2 and 4 you mentioned above. Seems my fix is correct.
>>
>> [1] http://lkml.kernel.org/g/1451969880-14877-1-git-send-email-wangnan0 at huawei.com
> I'm still really uneasy about this change. Pairing up the signal delivery
> with the sigreturn to keep track of the debug state is extremely fragile
> and I'm not keen on adding this logic there. I also think we need to
> track the address that the breakpoint is originally taken on so that we
> can only perform the extra sigreturn work if we're returning to the same
> instruction. Furthermore, I wouldn't want to do this for signals other
> than those generated directly by a breakpoint.
>
> An alternative would be to postpone the signal delivery until after the
> stepping has been taken care of, but that's a change in ABI and I worry
> we'll break somebody relying on the current behaviour.
>
> What exactly does x86 do? I couldn't figure it out from the code.

Actually x86 does similar thing as what this patch does.

RF bit in x86_64's eflags prohibit debug exception raises. It is set by
x86_64's debug handler to avoid recursion. x86_64 need setting this bit
in breakpoint handler because it needs to jump back to original
instruction and single-step on it, similar to ARM64.

The RF bit in eflags records a state that the process shouldn't generate
debug exception. It is part of the state of a process, and should be saved
and cleared if transfers to signal handler.

This patch does the same thing: create two bits in pstate to indicate
the states that 'a process should not raises watchpoint/breakpoint 
exceptions',
maintains them in kernel, cleans them for signal handler and save them 
in signal
frame.

Thank you.

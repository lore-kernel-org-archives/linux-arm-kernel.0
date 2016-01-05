From: wangnan0@huawei.com (Wangnan (F))
Date: Tue, 5 Jan 2016 09:41:26 +0800
Subject: [PATCH v2] arm64: Store breakpoint single step state into pstate
In-Reply-To: <20160104165535.GI1616@arm.com>
References: <1450860731-194418-1-git-send-email-wangnan0@huawei.com>
 <1450921362-198371-1-git-send-email-wangnan0@huawei.com>
 <20160104165535.GI1616@arm.com>
Message-ID: <568B1F46.8050206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/5 0:55, Will Deacon wrote:
> Hello,
>
> On Thu, Dec 24, 2015 at 01:42:42AM +0000, Wang Nan wrote:
>> Two 'perf test' fail on arm64:
>>
>>   # perf test overflow
>>   17: Test breakpoint overflow signal handler                  : FAILED!
>>   18: Test breakpoint overflow sampling                        : FAILED!
>>
>> When breakpoint raises, after perf_bp_event, breakpoint_handler()
>> temporary disables breakpoint and enables single step. Then in
>> single_step_handler(), reenable breakpoint. Without doing this
>> the breakpoint would be triggered again.
>>
>> However, if there's a pending signal and it have signal handler,
>> control would be transfer to signal handler, so single step handler
>> would be applied to the first instruction of signal handler. After
>> the handler return, the instruction triggered the breakpoint would be
>> executed again. At this time the breakpoint is enabled, so the
>> breakpoint is triggered again.
> Whilst I appreciate that you're just trying to get those tests passing
> on arm64, I really don't think its a good idea for us to try and emulate
> the x86 debug semantics here. This doesn't happen for ptrace, and I think
> we're likely to break more than we fix if we try to do it for perf too.
>
> The problem seems to be that we take the debug exception before the
> breakpointed instruction has been executed and call perf_bp_event at
> that moment, so when we single-step the faulting instruction we actually
> step into the SIGIO handler and end up getting stuck.

Understand.

> Your fix doesn't really address this afaict,

I don't think so. After applying my patch, the entry of signal handler won't
be single-stepped. Please have a look at signal_toggle_single_step(): when
signal arises, single step handler is turned off, so signal handler won't
be stepped.

I thing the following 4 cases you mentioned should not causes error in 
theory:

>   in that you don't (can't?)
> handle:
>
>    * A longjmp out of a signal handler

The signal frame is dropped so stepping is omitted.

>    * A watchpoint and a breakpoint that fire on the same instruction

Watchpoints and breakpoints are controlled separatly. In this case it would
generated twp nested signals. I will try this.

>    * User-controlled single-step from a signal handler that enables a
>      breakpoint explicitly

debug_info->suspended_step controls this.

>    * Nested signals

I think nested signals can be dealt correctly because we save state in 
signal frame.

However I'll try the above cases you mentioned above.

Thank you.

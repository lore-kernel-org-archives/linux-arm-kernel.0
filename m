From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Wed, 15 Aug 2012 13:21:35 -0700
Subject: [PATCH v2] ARM: support syscall tracing
In-Reply-To: <502BFA08.6010708@mentor.com>
References: <502BBCCC.1020006@mentor.com>
 <20120815162157.GJ29448@mudshark.cambridge.arm.com>
 <502BD544.70903@mentor.com>
 <20120815172731.GL29448@mudshark.cambridge.arm.com>
 <502BFA08.6010708@mentor.com>
Message-ID: <502C04CF.2080409@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wade Farnsworth wrote:
> Will Deacon wrote:
>> On Wed, Aug 15, 2012 at 05:58:44PM +0100, Wade Farnsworth wrote:
>>> We need to set current_thread_info()->syscall, since it's used in the
>>> call to syscall_get_nr() in perf_syscall_{enter,exit}.
>>
>> Damn. I think that also means we have a bug, given that the SYSCALL_TRACE
>> code can set this to -1, which gets used as an index into a bitmap by the
>> looks of it. Considering that we have to pass the syscall number to
>> trace_sys_enter anyway, it also seems broken.
>>
>
> I agree. Looking at the other architectures, it seems the analogous
> function to ptrace_syscall_trace can return -1 under certain
> circumstances, but the original syscall value should be passed onto
> trace_sys_enter and returned from syscall_get_nr(). So, I'm thinking
> that we should modify our behavior accordingly. What this means for us
> is that we never store -1 in the thread_info syscall field, and then
> pass that into trace_sys_enter instead of the ptrace_syscall_trace
> return value. Do you see any problems with this approach?
>

Hmm, on closer inspection it looks that perf_syscall_enter is broken. 
ftrace_syscall_enter correctly returns if result of a syscall_get_nr is 
negative.  The perf version omits the check for negative values. 
Furthermore, the value of syscall_get_nr() should be -1 if it's not 
called when not in a syscall.  So storing the -1 in the thread_info 
syscall field is not necessarily wrong.  Still, I think the value we 
pass into trace_sys_enter should be the actual syscall number, i.e. the 
value of scno.

>>> What about moving the setting of ->syscall to
>>> syscall_trace_{enter,exit}? That would preserve ptrace_syscall_trace()
>>> for the TIF_SYSCALL_TRACE case only, but ensure that the field is set
>>> the TRACEPOINT case as well. Thoughts?
>>
>> I'd be tempted to set the thing unconditionally before checking the
>> thread
>> flag at the top of ptrace_syscall_trace. This hangs off the slowpath
>> anyway
>> and it makes everything a lot more readable.
>>
>
> OK, I'll make that change.
>
> Wade

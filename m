From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Wed, 15 Aug 2012 12:35:36 -0700
Subject: [PATCH v2] ARM: support syscall tracing
In-Reply-To: <20120815172731.GL29448@mudshark.cambridge.arm.com>
References: <502BBCCC.1020006@mentor.com>
 <20120815162157.GJ29448@mudshark.cambridge.arm.com>
 <502BD544.70903@mentor.com>
 <20120815172731.GL29448@mudshark.cambridge.arm.com>
Message-ID: <502BFA08.6010708@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> On Wed, Aug 15, 2012 at 05:58:44PM +0100, Wade Farnsworth wrote:
>> We need to set current_thread_info()->syscall, since it's used in the
>> call to syscall_get_nr() in perf_syscall_{enter,exit}.
>
> Damn. I think that also means we have a bug, given that the SYSCALL_TRACE
> code can set this to -1, which gets used as an index into a bitmap by the
> looks of it. Considering that we have to pass the syscall number to
> trace_sys_enter anyway, it also seems broken.
>

I agree.  Looking at the other architectures, it seems the analogous 
function to ptrace_syscall_trace can return -1 under certain 
circumstances, but the original syscall value should be passed onto 
trace_sys_enter and returned from syscall_get_nr().  So, I'm thinking 
that we should modify our behavior accordingly.  What this means for us 
is that we never store -1 in the thread_info syscall field, and then 
pass that into trace_sys_enter instead of the ptrace_syscall_trace 
return value. Do you see any problems with this approach?

>> What about moving the setting of ->syscall to
>> syscall_trace_{enter,exit}?  That would preserve ptrace_syscall_trace()
>> for the TIF_SYSCALL_TRACE case only, but ensure that the field is set
>> the TRACEPOINT case as well.  Thoughts?
>
> I'd be tempted to set the thing unconditionally before checking the thread
> flag at the top of ptrace_syscall_trace. This hangs off the slowpath anyway
> and it makes everything a lot more readable.
>

OK, I'll make that change.

Wade

From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Aug 2012 18:27:31 +0100
Subject: [PATCH v2] ARM: support syscall tracing
In-Reply-To: <502BD544.70903@mentor.com>
References: <502BBCCC.1020006@mentor.com>
 <20120815162157.GJ29448@mudshark.cambridge.arm.com>
 <502BD544.70903@mentor.com>
Message-ID: <20120815172731.GL29448@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 05:58:44PM +0100, Wade Farnsworth wrote:
> We need to set current_thread_info()->syscall, since it's used in the 
> call to syscall_get_nr() in perf_syscall_{enter,exit}.

Damn. I think that also means we have a bug, given that the SYSCALL_TRACE
code can set this to -1, which gets used as an index into a bitmap by the
looks of it. Considering that we have to pass the syscall number to
trace_sys_enter anyway, it also seems broken.

> What about moving the setting of ->syscall to 
> syscall_trace_{enter,exit}?  That would preserve ptrace_syscall_trace() 
> for the TIF_SYSCALL_TRACE case only, but ensure that the field is set 
> the TRACEPOINT case as well.  Thoughts?

I'd be tempted to set the thing unconditionally before checking the thread
flag at the top of ptrace_syscall_trace. This hangs off the slowpath anyway
and it makes everything a lot more readable.

Will

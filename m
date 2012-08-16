From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Aug 2012 10:54:31 +0100
Subject: [PATCH v2] ARM: support syscall tracing
In-Reply-To: <502C04CF.2080409@mentor.com>
References: <502BBCCC.1020006@mentor.com>
 <20120815162157.GJ29448@mudshark.cambridge.arm.com>
 <502BD544.70903@mentor.com>
 <20120815172731.GL29448@mudshark.cambridge.arm.com>
 <502BFA08.6010708@mentor.com> <502C04CF.2080409@mentor.com>
Message-ID: <20120816095431.GE31784@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 09:21:35PM +0100, Wade Farnsworth wrote:
> Wade Farnsworth wrote:
> > Will Deacon wrote:
> >> On Wed, Aug 15, 2012 at 05:58:44PM +0100, Wade Farnsworth wrote:
> >>> We need to set current_thread_info()->syscall, since it's used in the
> >>> call to syscall_get_nr() in perf_syscall_{enter,exit}.
> >>
> >> Damn. I think that also means we have a bug, given that the SYSCALL_TRACE
> >> code can set this to -1, which gets used as an index into a bitmap by the
> >> looks of it. Considering that we have to pass the syscall number to
> >> trace_sys_enter anyway, it also seems broken.
> >>
> >
> > I agree. Looking at the other architectures, it seems the analogous
> > function to ptrace_syscall_trace can return -1 under certain
> > circumstances, but the original syscall value should be passed onto
> > trace_sys_enter and returned from syscall_get_nr(). So, I'm thinking
> > that we should modify our behavior accordingly. What this means for us
> > is that we never store -1 in the thread_info syscall field, and then
> > pass that into trace_sys_enter instead of the ptrace_syscall_trace
> > return value. Do you see any problems with this approach?
> >
> 
> Hmm, on closer inspection it looks that perf_syscall_enter is broken. 
> ftrace_syscall_enter correctly returns if result of a syscall_get_nr is 
> negative.  The perf version omits the check for negative values. 

Yes, that's what I was getting at with the -1 bitmap index. Something like
this should fix it though:


diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 96fc733..bbff120 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -506,13 +506,13 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
        int size;
 
        syscall_nr = syscall_get_nr(current, regs);
-       if (!test_bit(syscall_nr, enabled_perf_enter_syscalls))
-               return;
-
        sys_data = syscall_nr_to_meta(syscall_nr);
        if (!sys_data)
                return;
 
+       if (!test_bit(syscall_nr, enabled_perf_enter_syscalls))
+               return;
+
        /* get the size after alignment with the u32 buffer size field */
        size = sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
        size = ALIGN(size + sizeof(u32), sizeof(u64));


If you're happy with that, I can post to LKML and see what people say.

Will

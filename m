From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 3 Nov 2014 12:58:35 -0500
Subject: [PATCH] tracing/syscalls: ignore numbers outside NR_syscalls'
 range
In-Reply-To: <5457B673.1000409@mentor.com>
References: <1414620418-29472-1-git-send-email-rabin@rab.in>
 <20141030082606.GA7945@infradead.org>
 <20141030101808.GO27405@n2100.arm.linux.org.uk>
 <20141030071039.37633bf5@gandalf.local.home>
 <20141030111441.GP27405@n2100.arm.linux.org.uk>
 <20141030073028.284c468c@gandalf.local.home>
 <20141030113523.GQ27405@n2100.arm.linux.org.uk>
 <5457B673.1000409@mentor.com>
Message-ID: <20141103125835.0be67cc1@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Nov 2014 11:08:03 -0600
Nathan Lynch <Nathan_Lynch@mentor.com> wrote:


> > Or do we just ignore the high "special" ARM syscalls and treat them (from
> > the tracing point of view) as non-syscalls, avoiding the allocation of
> > something around 1.2MB for the syscall bitmap.  I really don't know, I
> > don't use any of this tracing stuff, so it isn't something I care about.
> > 
> > Maybe those who do use the facility should have an input here?
> 
> I checked strace and it knows about ARM's high syscalls.  I wouldn't
> want to go from casually using strace to digging deeper with ftrace only
> to get the impression that syscalls are disappearing.

I agree, but currently the syscall tracing does not support different
mappings, and if there's a group of calls outside of NR_syscalls range,
they will currently be ignored.

The fix may be to restructure how syscall tracing works. But for now,
the only answer we have is to just ignore them. x86 has the same issue
with compat calls (i386 syscalls on x86_64 kernels).

-- Steve

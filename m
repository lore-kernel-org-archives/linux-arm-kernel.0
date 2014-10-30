From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Oct 2014 11:35:23 +0000
Subject: [PATCH] tracing/syscalls: ignore numbers outside NR_syscalls'
 range
In-Reply-To: <20141030073028.284c468c@gandalf.local.home>
References: <1414620418-29472-1-git-send-email-rabin@rab.in>
 <20141030082606.GA7945@infradead.org>
 <20141030101808.GO27405@n2100.arm.linux.org.uk>
 <20141030071039.37633bf5@gandalf.local.home>
 <20141030111441.GP27405@n2100.arm.linux.org.uk>
 <20141030073028.284c468c@gandalf.local.home>
Message-ID: <20141030113523.GQ27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 07:30:28AM -0400, Steven Rostedt wrote:
> On Thu, 30 Oct 2014 11:14:41 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> 
> > We have always had syscall number range of 0x900000 or so.  The tracing
> > design does not expect that.  Therefore, the tracing design did not take
> > account of ARM when it was created.  Therefore, it's up to the tracing
> > people to decide how to properly fit their ill-designed subsystem into
> > one of the popular and well-established kernel architectures - or at
> > least suggest a way to work around this issue.
> > 
> 
> 
> Fine, lets define a MAX_SYSCALL_NR that is by default NR_syscalls, but
> an architecture can override it.
> 
> In trace_syscalls.c, where the checks are done, have this:
> 
> #ifndef MAX_SYSCALL_NR
> # define MAX_SYSCALL_NR NR_syscalls
> #endif
> 
> change all the checks to test against MAX_SYSCALL_NR instead of
> NR_syscalls.
> 
> Then in arch/arm/include/asm/syscall.h have:
> 
> #define MAX_SYSCALL_NR 0xa00000
> 
> or whatever would be the highest syscall number for ARM.

Or do we just ignore the high "special" ARM syscalls and treat them (from
the tracing point of view) as non-syscalls, avoiding the allocation of
something around 1.2MB for the syscall bitmap.  I really don't know, I
don't use any of this tracing stuff, so it isn't something I care about.

Maybe those who do use the facility should have an input here?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

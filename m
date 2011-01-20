From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jan 2011 09:23:17 -0000
Subject: [RFC][PATCH] ARM: ptrace: remove single-step emulation code
In-Reply-To: <87vd1kblax.fsf@lechat.rtp-net.org>
References: <1295449635-4292-1-git-send-email-will.deacon@arm.com>	<20110119151915.GG31652@n2100.arm.linux.org.uk>	<000501cbb7ee$cdccc680$69665380$@deacon@arm.com>
	<87vd1kblax.fsf@lechat.rtp-net.org>
Message-ID: <000001cbb883$ac70a0c0$0551e240$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

> > strace works fine with this patch applied and, looking at the
> > sources, it doesn't use the SINGLESTEP request. As for ltrace,
> > it *does* use SINGLESTEP but it can use PTRACE_SYSCALL instead
> > (indeed, it does this for sparc, ia64 and mips). ltrace doesn't
> > have code for checking the ptrace return value so I'd say it's
> > their bug.
> 
> afair, the current way to prevent SINGLESTEP usage in ltrace is to
> modify some #ifdef. So, while I agree that not checking ptrace return
> value is not nice, it has nothing to do with SINGLESTEP removal as this
> call will not get compiled in. What matters is rather to know if things
> are still working once the #ifdef are changed and if they're not,
> finding if it's a bug in ltrace or kernel.

Not true. A PTRACE_SINGLESTEP request will simply return -EIO. Userspace
programs should check the return value anyway because it could fail and
then handle the failure gracefully (in the case of ltrace, by trying a
PTRACE_SYSCALL request). This also means that ltrace is currently broken
on Thumb, where PTRACE_SINGLESTEP will return an error code.

Will

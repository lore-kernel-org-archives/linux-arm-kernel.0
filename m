From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 10:00:41 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <20120221083612.GG22562@n2100.arm.linux.org.uk>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
 <20120220194634.GK26840@n2100.arm.linux.org.uk>
 <201202210124.23028.paul@codesourcery.com>
 <20120221083612.GG22562@n2100.arm.linux.org.uk>
Message-ID: <20120221100041.GA19696@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 08:36:12AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 21, 2012 at 01:24:22AM +0000, Paul Brook wrote:
> > I suspect I submitted the original patch.  I don't remember the details, but 
> > it definitely worked at the time.   IIRC some other targets (m68k?) used an 
> > even less palatable hack.
> 
> I don't believe that - looking at the history in git, since it was merged
> the code has been:
> 
> static int ptrace_read_user(struct task_struct *tsk, unsigned long off,
>                             unsigned long __user *ret)
> {
>         unsigned long tmp;
> 
>         if (off & 3 || off >= sizeof(struct user))
>                 return -EIO;
> 
>         tmp = 0;
>         if (off == PT_TEXT_ADDR)
>                 tmp = tsk->mm->start_code;
>         else if (off == PT_DATA_ADDR)
>                 tmp = tsk->mm->start_data;
>         else if (off == PT_TEXT_END_ADDR)
>                 tmp = tsk->mm->end_code;
>         else if (off < sizeof(struct pt_regs))
>                 tmp = get_user_reg(tsk, off >> 2);
> 
> And since PT_TEXT_ADDR is 0x10000, this will fail with -EIO.  So, there's
> no way this could have been used successfully in the last 2.5 years.

Agreed, it does seem that this would always have failed, however a quick look
at GDB also suggests that it would at least try to access these guys on an
MMU-less system.

> Maybe no one uses a debugger for uclinux programs?

I confess to finding this by inspection rather than a debugging failure.

Will

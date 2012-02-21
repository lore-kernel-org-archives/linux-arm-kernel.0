From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2012 08:36:12 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <201202210124.23028.paul@codesourcery.com>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
 <20120220194634.GK26840@n2100.arm.linux.org.uk>
 <201202210124.23028.paul@codesourcery.com>
Message-ID: <20120221083612.GG22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 01:24:22AM +0000, Paul Brook wrote:
> > On Mon, Feb 20, 2012 at 06:37:09PM +0000, Will Deacon wrote:
> > > Commit 68b7f715 ("nommu: ptrace support") added definitions for
> > > PT_TEXT_ADDR and friends, as well as adding ptrace support for reading
> > > from these magic offsets.
> > > 
> > > Unfortunately, this has probably never worked, since ptrace_read_user
> > > predicates reading on off < sizeof(struct user), returning -EOI
> > > otherwise.
> > > 
> > > This patch moves the offset size check until after we have tried to
> > > match it against either a magic value or an offset into pt_regs.
> > 
> > Does this actually get used?  The fact that it's been broken from day one
> > and no one's raised the issue in 2.5 years suggests that it's dead code.
> 
> I suspect I submitted the original patch.  I don't remember the details, but 
> it definitely worked at the time.   IIRC some other targets (m68k?) used an 
> even less palatable hack.

I don't believe that - looking at the history in git, since it was merged
the code has been:

static int ptrace_read_user(struct task_struct *tsk, unsigned long off,
                            unsigned long __user *ret)
{
        unsigned long tmp;

        if (off & 3 || off >= sizeof(struct user))
                return -EIO;

        tmp = 0;
        if (off == PT_TEXT_ADDR)
                tmp = tsk->mm->start_code;
        else if (off == PT_DATA_ADDR)
                tmp = tsk->mm->start_data;
        else if (off == PT_TEXT_END_ADDR)
                tmp = tsk->mm->end_code;
        else if (off < sizeof(struct pt_regs))
                tmp = get_user_reg(tsk, off >> 2);

And since PT_TEXT_ADDR is 0x10000, this will fail with -EIO.  So, there's
no way this could have been used successfully in the last 2.5 years.

Maybe no one uses a debugger for uclinux programs?

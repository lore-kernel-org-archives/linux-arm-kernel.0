From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 29 Jul 2014 18:54:16 +0200
Subject: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
In-Reply-To: <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
References: <cover.1405992946.git.luto@amacapital.net>
 <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
 <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
Message-ID: <20140729165416.GA967@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Andy Lutomirski wrote:
>
> On Mon, Jul 28, 2014 at 10:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > Hi Andy,
> >
> > I am really sorry for delay.
> >
> > This is on top of the recent change from Kees, right? Could me remind me
> > where can I found the tree this series based on? So that I could actually
> > apply these changes...
>
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>
> The first four patches are already applied there.

Thanks!

> > If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
> > But we should always call user_exit() unconditionally?
>
> Damnit.  I read that every function called by user_exit, and none of
> them give any indication of why they're needed for traced syscalls but
> not for untraced syscalls.  On a second look, it seems that TIF_NOHZ
> controls it.

Yes, just to trigger the slow path, I guess.

> I'll update the code to call user_exit iff TIF_NOHZ is
> set.

Or perhaps it would be better to not add another user of this (strange) flag
and just call user_exit() unconditionally(). But, yes, you need to use
from "work = flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ)" then.

> > And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
> > actually cleared on a 32bit kernel if we step over sysenter insn?
>
> I don't follow.  If TIF_SINGLESTEP, then phase1 will return a nonzero
> value,

Ah yes, thanks, I missed this.

Oleg.

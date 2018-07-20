From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jul 2018 07:26:10 +0100
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
Message-ID: <20180720062609.2haxhf23zyouoxmh@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 07:42:50PM +0530, Hari Vyas wrote:
> On Thu, Jul 19, 2018 at 4:09 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jul 19, 2018 at 03:47:46PM +0530, Hari Vyas wrote:
> >> On Thu, Jul 19, 2018 at 3:31 PM, Sergey Senozhatsky
> >> <sergey.senozhatsky.work@gmail.com> wrote:
> >> > On (07/19/18 15:18), Hari Vyas wrote:
> >> > [..]
> >> >
> >> > Not so sure about the patch, sorry.
> >> >
> >> Mentioned concern in cover letter and commit message. Console loglevel
> >> remains maximum after process die which
> >> needs to be restored.
> >> >> @@ -211,6 +211,8 @@ void die(const char *str, struct pt_regs *regs, int err)
> >> >>
> >> >>       bust_spinlocks(0);
> >> >>       add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> >> >> +
> >> >> +     restore_console_loglevel();
> >> >>       oops_exit();
> >> >
> >> > This is *probably* the only place where you can roll-back the
> >> > loglevel, but you restore console loglevel too early - a trap
> >> > can panic() the system, we need to preserve the console verbose
> >> > mode which we set at the start of the trap.
> >> >
> >> console loglevel is indirectly sets to verbose in oops_enter() so
> >> better to restore before oops_exit().
> >> More from ARM maintainers.
> >
> > If we've hit die(), something has already gone very wrong within the
> > kernel (not userspace), and we're likely to see subsequent issues
> > anyway.
> >
> > Rolling back the console loglevel might throw away infromation on
> > subsequent failures, which isn't ideal, so leaving it as-is is probably
> > fine.
> >
> This die() is called from so many places i.e. entry.S shows so many ways i.e
> el1_sync_invalid,irq,fiq_invalid,error_invalid.

Indeed, but *none* of these should fire unless something has gone wrong already.

> This concern was identified in 4.14 kernel and was easy to produce.

Under what circumstances do you see die() being called?

Can you provide a backtrace?

Thanks,
Mark.

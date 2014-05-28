From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 May 2014 19:49:10 +0100
Subject: [PATCH v5 2/2] arm64: enable context tracking
In-Reply-To: <7hegzd99tw.fsf@paris.lan>
References: <1401130573-7443-1-git-send-email-larry.bassel@linaro.org>
 <1401130573-7443-3-git-send-email-larry.bassel@linaro.org>
 <20140528114438.GF15222@arm.com> <7hegzd99tw.fsf@paris.lan>
Message-ID: <20140528184910.GC20523@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 04:55:39PM +0100, Kevin Hilman wrote:
> Hi Will,

Hey Kevin,

> Will Deacon <will.deacon@arm.com> writes:
> > Apologies if we've discussed this before (it rings a bell), but why are we
> > penalising the fast syscall path with this? Shouldn't TIF_NOHZ contribute to
> > out _TIF_WORK_MASK, then we could do the tracking on the syscall slow path?
> 
> I'll answer here since Larry inherited this design decision from me.
> 
> I considered (and even implemented) forcing the slow syscall path
> based on TIF_NOHZ but decided (perhaps wrongly) not to.  I guess the
> choice is between:
> 
> - forcing the overhead of syscall tracing path on all
>   TIF_NOHZ processes
> 
> - forcing the (much smaller) ct_user_exit overhead on all syscalls,
>   (including the fast syscall path)
> 
> I had decided that the former was better, but as I write this, I'm
> thinking that the NOHZ tasks should probably eat the extra overhead
> since we expect their interactions with the kernel to be minimal anyways
> (part of the goal of full NOHZ.)
> 
> Ultimately, I'm OK with either way and have the other version ready.

I was just going by the comment in kernel/context_tracking.c:

 * The context tracking uses the syscall slow path to implement its user-kernel
 * boundaries probes on syscalls. This way it doesn't impact the syscall fast
 * path on CPUs that don't do context tracking.

which doesn't match what the current patch does. It also makes it sounds
like context tracking is really a per-CPU thing, but I've never knowingly
used it before.

I think putting this on the slowpath is inline with the expectations in the
core code.

> > I think that would tidy up your mov into x19 too.
> 
> That's correct.  If we force the syscall_trace path, the ct_user_enter
> wouldn't have to do any context save/restore.

That would be nice.

> > Also -- how do you track ret_from_fork in the child with these patches?
> 
> Not sure I follow the question, but ret_from_fork calls
> ret_to_user, which calls kernel_exit, which calls ct_user_enter.

Sorry, I got myself in a muddle. I noticed that x19 is live in ret_from_fork
so made a mental note to check that is ok (I think it is) but then concluded
incorrectly that you don't trace there.

Will

From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Feb 2016 16:01:27 +0000
Subject: [PATCH] arm64: Rework valid_user_regs
In-Reply-To: <20160210144324.GL1052@arm.com>
References: <1455041501-30018-1-git-send-email-mark.rutland@arm.com>
 <20160210115853.GG1052@arm.com> <20160210123110.GD2632@leverpostej>
 <CAFEAcA-3mgxu6hNSOLhFMmfzB705xyZTyfa5eiRWX6MOnYMVvQ@mail.gmail.com>
 <20160210144324.GL1052@arm.com>
Message-ID: <20160210160127.GE2632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 02:43:24PM +0000, Will Deacon wrote:
> On Wed, Feb 10, 2016 at 02:23:29PM +0000, Peter Maydell wrote:
> > On 10 February 2016 at 12:31, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Wed, Feb 10, 2016 at 11:58:53AM +0000, Will Deacon wrote:
> > >> I think we should err on the side of caution and nuke SS and IL for both
> > >> native and compat too, although that seems a odds with the PSR_s mask.
> > >> I wonder how relevant those PSR groups are in ARMv8...
> > >
> > > Ok.
> > 
> > If you nuke SS does that have any side effects in the case
> > of (for instance) interactions between ptrace single step
> > and ptrace syscall tracing? (ie do we ever end up in a situation
> > where the ptracer can read a PSR for the debuggee which has
> > SS set? if so then it should be able to write back the PSR
> > it has just read without any bits being unset.)
> 
> I don't think so -- the signal dispatch logic "fast-forwards" the stepping
> state machine so that we step into the signal handler, therefore the SS
> bit should always be clear on entry afaict.

That handles entry, but what about exit?

Is there are a guarantee that we won't call user_enable_single_step() if
the return path is traced?

Mark.

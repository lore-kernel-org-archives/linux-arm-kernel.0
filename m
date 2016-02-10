From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 16:36:15 +0000
Subject: [PATCH] arm64: Rework valid_user_regs
In-Reply-To: <20160210160550.GF2632@leverpostej>
References: <1455041501-30018-1-git-send-email-mark.rutland@arm.com>
 <20160210115853.GG1052@arm.com> <20160210123110.GD2632@leverpostej>
 <CAFEAcA-3mgxu6hNSOLhFMmfzB705xyZTyfa5eiRWX6MOnYMVvQ@mail.gmail.com>
 <20160210144324.GL1052@arm.com> <20160210160127.GE2632@leverpostej>
 <20160210160420.GQ1052@arm.com> <20160210160550.GF2632@leverpostej>
Message-ID: <20160210163615.GR1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 04:05:50PM +0000, Mark Rutland wrote:
> On Wed, Feb 10, 2016 at 04:04:21PM +0000, Will Deacon wrote:
> > On Wed, Feb 10, 2016 at 04:01:27PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 10, 2016 at 02:43:24PM +0000, Will Deacon wrote:
> > > > On Wed, Feb 10, 2016 at 02:23:29PM +0000, Peter Maydell wrote:
> > > > > On 10 February 2016 at 12:31, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > On Wed, Feb 10, 2016 at 11:58:53AM +0000, Will Deacon wrote:
> > > > > >> I think we should err on the side of caution and nuke SS and IL for both
> > > > > >> native and compat too, although that seems a odds with the PSR_s mask.
> > > > > >> I wonder how relevant those PSR groups are in ARMv8...
> > > > > >
> > > > > > Ok.
> > > > > 
> > > > > If you nuke SS does that have any side effects in the case
> > > > > of (for instance) interactions between ptrace single step
> > > > > and ptrace syscall tracing? (ie do we ever end up in a situation
> > > > > where the ptracer can read a PSR for the debuggee which has
> > > > > SS set? if so then it should be able to write back the PSR
> > > > > it has just read without any bits being unset.)
> > > > 
> > > > I don't think so -- the signal dispatch logic "fast-forwards" the stepping
> > > > state machine so that we step into the signal handler, therefore the SS
> > > > bit should always be clear on entry afaict.
> > > 
> > > That handles entry, but what about exit?
> > > 
> > > Is there are a guarantee that we won't call user_enable_single_step() if
> > > the return path is traced?
> > 
> > Why would that be a problem? I think I'm missing your point...
> 
> We would nuke the SS bit if the tracing happens after
> user_enable_single_step, if the tracer fiddled with pstate at all. So
> you wouldn't get the single stepping you expected.
> 
> Maybe I'm missing some reason this is prevented by construction.

Ok, for some reason I thought this was all about signal handling, but I
now see Peter was referring to general ptrace register manipulation.

In which case, we could force SS to zero if TIF_SINGLESTEP is not set
on the tracee, otherwise letting it be set. Ultimately, MDSCR_EL1.SS
prevents PSTATE.SS from taking effect if !TIF_SINGLESTEP, but it's
worth cleaning this up imo.

Will

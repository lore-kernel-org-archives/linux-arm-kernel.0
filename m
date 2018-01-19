From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 Jan 2018 12:05:27 +0000
Subject: [PATCH 08/11] signal/arm: Document conflicts with SI_USER and
 SIGFPE
In-Reply-To: <20180115174947.GH17719@n2100.armlinux.org.uk>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-8-ebiederm@xmission.com>
 <20180115174947.GH17719@n2100.armlinux.org.uk>
Message-ID: <20180119120525.GN22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 05:49:47PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 11, 2018 at 06:59:37PM -0600, Eric W. Biederman wrote:
> > Setting si_code to 0 results in a userspace seeing an si_code of 0.
> > This is the same si_code as SI_USER.  Posix and common sense requires
> > that SI_USER not be a signal specific si_code.  As such this use of 0
> > for the si_code is a pretty horribly broken ABI.
> > 
> > Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
> > value of __SI_KILL and now sees a value of SIL_KILL with the result
> > that uid and pid fields are copied and which might copying the si_addr
> > field by accident but certainly not by design.  Making this a very
> > flakey implementation.
> > 
> > Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
> > appropriate fields will be reliably copied.
> 
> So what do you suggest when none of the SIGFPE FPE_xxx codes match the
> condition that "we don't know what happened" ?  Raise a SIGKILL instead
> maybe?  We will have dumped the VFP state into the kernel log at this
> point, things are pretty much fscked.
> 
> It's probably an impossible condition unless the hardware has failed,
> no one has knowingly reported getting such a dump in their kernel log,
> so it's something that could very likely be changed in some way
> without anyone noticing.

Relating to this, what's your view on how to clean up the si_code zeros
in fsr-2level.c and fsr-3level.c?

Due to the historical evolution of the fault codes I'm less
confident of getting these right than for arm64.

Many are things that shouldn't happen and likely indicate a kernel bug
or system failure if they do, so at least some of the
{ do_bad, SIGxxx, 0, ... } entries can probably be changed to
{ do_bad, SIGKILL, SI_KERNEL, ... } with no ill effects.  But there
are many fault codes whose meaning has changed over time.

Cheers
---Dave

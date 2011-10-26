From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Oct 2011 08:11:59 +0100
Subject: [PATCH] Shrink thread_info a bit
In-Reply-To: <20111025144110.GA2043@localhost.localdomain>
References: <20111024124818.GA17693@n2100.arm.linux.org.uk>
	<20111024131853.GA4250@mudshark.cambridge.arm.com>
	<20111025144110.GA2043@localhost.localdomain>
Message-ID: <20111026071159.GA9165@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Tue, Oct 25, 2011 at 03:41:11PM +0100, Dave Martin wrote:
> On Mon, Oct 24, 2011 at 02:18:53PM +0100, Will Deacon wrote:
> > 
> > Can we also shrink the contents of fp_state when AEABI && !OABI_COMPAT?
> 
> Is this the right config combination to indicate that the FPA ABI will
> not be supported?  I'm assuming so, since that's the condition which
> currently disallows CONFIG_NWFPE.
> 
> I'm not saying it's not ... I'm just unsure.

Well, we basically just want to check whether or not we might have OABI
executables in userspace so I think this is the right way of doing that.
I toyed with doing something like !CONFIG_VFP but that doesn't help with the
compat stuff.

> Note that the FPA state (35 words) is not that much smaller than the
> iwmmxt state (38 words), so not much space would be saved by shrinking
> that union.

Right, but the IWMMXT part of the union is already predicated on
CONFIG_IWMMXT so the goal is to have an empty union for the common case
(EABI and no IWMMXT).

> I wonder whether fpstate can go away completely on platforms which have
> neither fpa nor iwmmxt however.  That would be a more significant saving.
> Is it used for anything else?

That's kind of the idea, but I was just going to leave it empty.

> > It's slightly more involved as ptrace and core-dumping would need some
> > similar treatment. We probably need to keep the union kicking around
> > though, since the iwmmxt state is held in there.
> 
> We would need some sensible error return from the ptrace calls to access
> the FPA registers.  PTRACE_GETREGSET (not currently working on ARM since
> the relevant generic code is #ifdef'd on CONFIG_HAVE_ARCH_TRACEHOOK for
> some reason) returns -EINVAL when requesting a regset that isn't there.
> 
> Fixing coredumps should be relatively easy -- I think we just need to
> change arm_regsets[] in arch/arm/kernel/ptrace.c appropriately.

Russell also pointed out that we need to hack some assembly code for this to
work, but I can't say I've looked into it yet.

Will

From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 May 2016 11:16:46 +0100
Subject: [PATCH] arm64: do not enforce strict 16 byte alignment to stack
 pointer
In-Reply-To: <20160512092545.GC11226@e104818-lin.cambridge.arm.com>
References: <1462985814-16146-1-git-send-email-colin.king@canonical.com>
 <20160512092545.GC11226@e104818-lin.cambridge.arm.com>
Message-ID: <20160512101645.GB25355@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Jacob]

On Thu, May 12, 2016 at 10:25:45AM +0100, Catalin Marinas wrote:
> On Wed, May 11, 2016 at 05:56:54PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > copy_thread should not be enforcing 16 byte aligment and returning
> > -EINVAL. Other architectures trap misaligned stack access with SIGBUS
> > so arm64 should follow this convention, so remove the strict enforcement
> > check.
> > 
> > For example, currently clone(2) fails with -EINVAL when passing
> > a misaligned stack and this gives little clue to what is wrong. Instead,
> > it is arguable that a SIGBUS on the fist access to a misaligned stack
> > allows one to figure out that it is a misaligned stack issue rather
> > than trying to figure out why an unconventional (and undocumented)
> > -EINVAL is being returned.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  arch/arm64/kernel/process.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 5655f756..8414971 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -258,9 +258,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
> >  		if (stack_start) {
> >  			if (is_compat_thread(task_thread_info(p)))
> >  				childregs->compat_sp = stack_start;
> > -			/* 16-byte aligned stack mandatory on AArch64 */
> > -			else if (stack_start & 15)
> > -				return -EINVAL;
> >  			else
> >  				childregs->sp = stack_start;
> >  		}
> 
> As we discussed on the linux-man list, I don't expect this change to
> break existing working user apps since they pass an aligned stack
> already. I really doubt anyone relies on the -EINVAL here.
> 
> That said, I don't think we should add a cc stable (which you haven't
> anyway), at least we have a point in time where this change was made. As
> the patch stands:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

As far as today's mainline is concerned, this looks fine to me. However,
there is one nagging issue in that the JavaScript guys have started asking
us to relax the strict alignment altogether (there is a bit in the SCTLR
register for this). I'm not at all keen on doing this per-process, since
context-switching the SCTLR is likely to be slow, so if we were to allow
this relaxation it would probably be in the form of a global /sysfs knob
or the like. That would then mean that you wouldn't get -EINVAL *or*
SIGBUS for a misaligned stack passed to clone().

I think in that case, the options are either (a) return -EINVAL when
strict alignment checking is disabled or (b) do nothing and let users
debug their broken programs.

None of this is a blocker for the patch (which I plan to apply), but
food for thought.

Will

From: matt@console-pimps.org (Matt Fleming)
Date: Sat, 9 Oct 2010 11:32:43 +0100
Subject: [PATCH 5/7] ARM: oprofile: Move non-ARM code into separate
	init/exit
In-Reply-To: <20101009012647.GM13563@erda.amd.com>
References: <cover.1286584677.git.matt@console-pimps.org>
	<0de9eda11dbfe9c21348da07b57f04f35cd9effc.1286584677.git.matt@console-pimps.org>
	<20101009012647.GM13563@erda.amd.com>
Message-ID: <20101009103242.GA17466@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 03:26:47AM +0200, Robert Richter wrote:
> On 08.10.10 20:46:20, Matt Fleming wrote:
> > In preparation for moving the majority of this oprofile code into an
> > architecture-neutral place separate the architecture-independent code
> > into oprofile_perf_init() and oprofile_perf_exit().
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > Tested-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/oprofile/common.c |   27 +++++++++++++++++++--------
> >  1 files changed, 19 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> > index fd6e323..8718311 100644
> > --- a/arch/arm/oprofile/common.c
> > +++ b/arch/arm/oprofile/common.c
> > @@ -349,7 +349,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
> >  		tail = user_backtrace(tail);
> >  }
> >  
> > -int __init oprofile_arch_init(struct oprofile_operations *ops)
> > +int __init oprofile_perf_init(struct oprofile_operations *ops)
> >  {
> >  	int cpu, ret = 0;
> >  
> > @@ -387,12 +387,11 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
> >  		}
> >  	}
> >  
> > -	ops->backtrace		= arm_backtrace;
> > -	ops->create_files	= op_arm_create_files;
> > -	ops->setup		= op_arm_setup;
> > -	ops->start		= op_arm_start;
> > -	ops->stop		= op_arm_stop;
> > -	ops->shutdown		= op_arm_stop;
> > +	ops->create_files	= oprofile_perf_create_files;
> > +	ops->setup		= oprofile_perf_setup;
> > +	ops->start		= oprofile_perf_start;
> > +	ops->stop		= oprofile_perf_stop;
> > +	ops->shutdown		= oprofile_perf_stop;
> 
> There is a compile breakage caused by patch #4. Will move the renames
> to patch #4 when applying the patch.

Sorry, I don't know how this happened. These renames were originally in
patch #4 but seem to have moved into #5 when I was reshuffling stuff.

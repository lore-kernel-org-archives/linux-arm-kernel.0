From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 May 2018 12:32:51 +0100
Subject: [PATCH v4 2/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <20180524170713.GY13470@e103592.cambridge.arm.com>
References: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
 <1527097616-25214-3-git-send-email-Dave.Martin@arm.com>
 <20180524124918.GG8689@arm.com>
 <20180524155516.GW13470@e103592.cambridge.arm.com>
 <20180524165045.GP8689@arm.com>
 <20180524170713.GY13470@e103592.cambridge.arm.com>
Message-ID: <20180525113251.GB3255@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 06:07:13PM +0100, Dave Martin wrote:
> On Thu, May 24, 2018 at 05:50:48PM +0100, Will Deacon wrote:
> > On Thu, May 24, 2018 at 04:55:17PM +0100, Dave Martin wrote:
> > > On Thu, May 24, 2018 at 01:49:21PM +0100, Will Deacon wrote:
> > > > On Wed, May 23, 2018 at 06:46:56PM +0100, Dave Martin wrote:
> > > > > @@ -936,3 +949,28 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
> > > > >  		thread_flags = READ_ONCE(current_thread_info()->flags);
> > > > >  	} while (thread_flags & _TIF_WORK_MASK);
> > > > >  }
> > > > > +
> > > > > +unsigned long __ro_after_init signal_minsigstksz;
> > > > > +
> > > > > +/*
> > > > > + * Determine the stack space required for guaranteed signal devliery.
> > > > > + * This function is used to populate AT_MINSIGSTKSZ at process startup.
> > > > > + * cpufeatures setup is assumed to be complete.
> > > > > + */
> > > > > +void __init minsigstksz_setup(void)
> > > > > +{
> > > > > +	struct rt_sigframe_user_layout user;
> > > > > +
> > > > > +	init_user_layout(&user);
> > > > > +
> > > > > +	/*
> > > > > +	 * If this fails, SIGFRAME_MAXSZ needs to be enlarged.  It won't
> > > > > +	 * be big enough, but it's our best guess:
> > > > > +	 */
> > > > > +	if (WARN_ON(setup_sigframe_layout(&user, true)))
> > > > > +		signal_minsigstksz = SIGFRAME_MAXSZ;
> > > > 
> > > > Can we not leave signal_minsigstksz as zero in this case?
> > > 
> > > I prefer to distinguish the "kernel went wrong" case (where we just omit
> > > AT_MINSIGSTKSZ for backwards compatibilty) from the "sigframe too
> > > large" case.
> > 
> > Hmm, so I'm confused as to the distinction here. Wouldn't an allocation
> > failure in setup_sigframe_layout be indicative of "kernel went wrong"?
> > 
> > To put it another way, if we could determine the maximum sigframe size
> > at build time, surely we'd fail the build if SIGFRAME_MAXSZ wasn't big
> > enough? In that case, detecting this at runtime is also pretty bad (hence
> 
> Yup

Good, I was starting to worry I was missing something!

> > the WARN_ON) and I think we should drop the aux entry rather than provide
> > a value that is known to be incorrect.
> 
> Telling userspace the signal frame size is not optional: by omitting
> AT_MINSIGSTKSZ we implicitly tell userspace than MINSIGSTKSZ
> is sufficient.  But in this case we not only know that this is false, we
> know that SIGFRAME_MAXSZ is not sufficient either.  But we also know
> that SIGFRAME_MAXSZ is a closer estimate to the true requirement, because
> it's the larger value.
> 
> This falls under the heading of "being no more wrong than necessary".

I think I just prefer distinguishing between "AT_MINSIGSTKSZ isn't
present, I'll assume MINSIGSTKSZ is sufficient but it might not be" and
"AT_MINSIGSTKSZ is present, I know that it's sufficient".

> Either way, this is trying to paper over a kernel bug, by telling
> userspace something "sensible".  This may not be a sensible course
> of action...
> 
> So if you feel strongly I'm happy to not distinguish the two cases and
> just WARN() in minsigstksz_setup() as at present.

Yes, please.

Will

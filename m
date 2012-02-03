From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Feb 2012 11:58:50 +0000
Subject: [PATCH v3 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <20120203111209.GA2098@linaro.org>
References: <1328104992-8016-1-git-send-email-will.deacon@arm.com>
 <1328104992-8016-3-git-send-email-will.deacon@arm.com>
 <20120203111209.GA2098@linaro.org>
Message-ID: <20120203115850.GD15431@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thanks for looking at this.

On Fri, Feb 03, 2012 at 11:12:09AM +0000, Dave Martin wrote:
> On Wed, Feb 01, 2012 at 02:03:12PM +0000, Will Deacon wrote:
> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 3e35e35..49cf328 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -562,6 +562,21 @@ int vfp_preserve_user_hwstate(struct user_vfp __user *ufp,
> >  
> >  	if (err)
> >  		return -EFAULT;
> > +
> > +	/* Ensure that VFP is disabled. */
> > +	vfp_flush_hwstate(thread);
> > +
> > +	/*
> > +	 * As per the PCS, clear the length and stride bits before entry
> > +	 * to the signal handler.
> > +	 */
> > +	hwstate->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
> > +
> > +	/*
> > +	 * Disable VFP in the hwstate so that we can detect if it was
> > +	 * used by the signal handler.
> > +	 */
> > +	hwstate->fpexc &= ~FPEXC_EN;
> >  	return 0;
> >  }
> 
> ^ 
> These additions are nothing to do with preserving the VFP state.
> Instead, they set up a clean signal frame, under the assumption that the
> interrupted thread's state has already been preserved.
> 
> Would this be more cleanly factored out as a separate function,
> something like vfp_setup_sigframe(), so:
> 
> setup_sigframe() {
> 	/* ... */
> 
> 	vfp_preserve_user_hwstate();
> 	vfp_setup_sigframe();
> }
> 
> ...?

The whole reason for moving this code out of signal.c was to avoid polluting
that file with VFP-related code. I don't want to turn the problem on its
head and end up with signal-related code in vfpmodule.c (so yes, I'll fix those
comments :). setup_sigframe certainly sounds out of place here.

> Alternatively, if this is an abstraction too far, and the "preserve" and
> "setup sigframe" actions will never make sense independently of each
> other, you could just rename the function to something clearer, like
> vfp_user_preserve_setup_sigframe().

Indeed, this comes down to my inability to think of a decent function name.
I'd like to avoid the _sigframe bit, so I'll have a think about some better
terminology. I could try running a competition.

Expect a v4 when inspiration strikes.

Will

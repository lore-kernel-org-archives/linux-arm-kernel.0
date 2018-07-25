From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 17:37:26 +0100
Subject: [PATCH 1/2] signal: Introduce COMPAT_SIGMINSTKSZ for use in
 compat_sys_sigaltstack
In-Reply-To: <20180725155427.GR4240@e103592.cambridge.arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
 <1532526312-26993-2-git-send-email-will.deacon@arm.com>
 <20180725155427.GR4240@e103592.cambridge.arm.com>
Message-ID: <20180725163726.GE6866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 04:54:27PM +0100, Dave Martin wrote:
> On Wed, Jul 25, 2018 at 02:45:11PM +0100, Will Deacon wrote:
> > @@ -3476,7 +3478,8 @@ int restore_altstack(const stack_t __user *uss)
> >  	stack_t new;
> >  	if (copy_from_user(&new, uss, sizeof(stack_t)))
> >  		return -EFAULT;
> > -	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer());
> > +	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
> > +			     MINSIGSTKSZ);
> 
> Why can't this fail?
> 
> If this fails here we silently go wrong, but...
> 
> >  	/* squash all but EFAULT for now */
> >  	return 0;
> >  }
> > @@ -3510,7 +3513,8 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
> >  		uss.ss_size = uss32.ss_size;
> >  	}
> >  	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss,
> > -			     compat_user_stack_pointer());
> > +			     compat_user_stack_pointer(),
> > +			     COMPAT_MINSIGSTKSZ);
> 
> If this fails on arm64, we seem to SEGV (see compat_sys_rt_sigreturn()).
> 
> This patch doesn't introduce this inconsistency, this might be a good
> opportunity to clean it up.

I don't think there's an inconsistency here -- both restore_altstack and
compat_restore_altstack suppress all non--EFAULT errors (remember that uoss
is NULL in both cases, so the copy_from_user() immediately before the
do_sigaltstack() call for the native path is all we care about). I think the
behaviour is: on a sigreturn, if you set the altstack to be an unmapped
address then you get a SEGV, otherwise if you make it invalid in some other
way (e.g. too small) then it's ignored and the old altstack remains intact.

Will

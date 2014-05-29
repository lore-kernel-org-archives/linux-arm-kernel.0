From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 May 2014 18:52:36 +0100
Subject: [PATCH v5 1/2] arm64: adjust el0_sync so that a function can be
 called
In-Reply-To: <20140528193542.GD7953@ubuette>
References: <1401130573-7443-1-git-send-email-larry.bassel@linaro.org>
 <1401130573-7443-2-git-send-email-larry.bassel@linaro.org>
 <20140528112738.GE15222@arm.com> <20140528193542.GD7953@ubuette>
Message-ID: <20140529175236.GA24270@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 08:35:51PM +0100, Larry Bassel wrote:
> On 28 May 14 12:27, Will Deacon wrote:
> > On Mon, May 26, 2014 at 07:56:12PM +0100, Larry Bassel wrote:
> > > To implement the context tracker properly on arm64,
> > > a function call needs to be made after debugging and
> > > interrupts are turned on, but before the lr is changed
> > > to point to ret_to_user(). If the function call
> > > is made after the lr is changed the function will not
> > > return to the correct place.
> > > 
> > > For similar reasons, defer the setting of x0 so that
> > > it doesn't need to be saved around the function call
> > > (save far_el1 in x26 temporarily instead).
> > > 
> > > Signed-off-by: Larry Bassel <larry.bassel@linaro.org>
> > 
> > [...]
> > 
> > 
> > Why have you added this mov instruction?
> 
> I believe (please correct me if I'm wrong) that it is necessary.
> Here is why:
> 
> > > @@ -476,23 +481,27 @@ el0_undef:
> > >  	// enable interrupts before calling the main handler
> > >  	enable_dbg_and_irq
> > >  	mov	x0, sp
> > > +	adr	lr, ret_to_user
> > >  	b	do_undefinstr
> > >  el0_dbg:
> > >  	/*
> > >  	 * Debug exception handling
> > >  	 */
> > >  	tbnz	x24, #0, el0_inv		// EL0 only
> > > -	mrs	x0, far_el1
> > > +	mrs	x26, far_el1
> 
> needed because do_debug_exception may clobber x0, so save far_el1
> in x26 (as other parts of this patch do)

Actually, do_debug_exception consumes the FAR as its first parameter, so you
don't need to put this in x26 afaict.

> > > +	mov	x0, x26
> 
> needed because far_el1 is expected to be in x0 here
> 
> > >  	mov	x1, x25
> > >  	mov	x2, sp
> > >  	bl	do_debug_exception
> > >  	enable_dbg
> 
> [call to ct_user_exit will go here in the next patch, this may re-clobber x0]
> 
> > > +	mov	x0, x26
> 
> needed because far_el1 is expected to be in x0 here

Is it? ret_to_user doesn't care. Does ct_user_exit use the FAR? I don't
think it does...

Will

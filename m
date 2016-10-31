From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 31 Oct 2016 10:26:31 -0600
Subject: [PATCH] [ARM] Fix stack alignment when processing backtraces
In-Reply-To: <20161031085126.GT1041@n2100.armlinux.org.uk>
References: <20161018170510.GA12248@obsidianresearch.com>
 <20161031085126.GT1041@n2100.armlinux.org.uk>
Message-ID: <20161031162631.GB28817@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 08:51:26AM +0000, Russell King - ARM Linux wrote:

> > -.Ldumpstm:	stmfd	sp!, {instr, reg, stack, r7, lr}
> > +	        /* Must maintain 8 byte stack alignment */
> > +.Ldumpstm:	stmfd	sp!, {r3, instr, reg, stack, r7, lr}
> >  		mov	stack, r0
> >  		mov	instr, r1
> >  		mov	reg, #10
> > @@ -140,7 +141,7 @@ ENDPROC(c_backtrace)
> >  		teq	r7, #0
> >  		adrne	r0, .Lcr
> >  		blne	printk
> > -		ldmfd	sp!, {instr, reg, stack, r7, pc}
> > +		ldmfd	sp!, {r3, instr, reg, stack, r7, pc}
> 
> I'd prefer r8 to get used rather than r3, as it makes it look like
> r3 is somehow required to be preserved when that's not the case.
> Makes the code slightly more difficult to understand.

Sure, I will change that and send it to your tracker.

Thanks,
Jason

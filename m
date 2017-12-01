From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 18:00:49 +0000
Subject: [PATCH v2 12/18] arm64: entry: Explicitly pass exception level
 to kernel_ventry macro
In-Reply-To: <20171201175144.GD8826@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-13-git-send-email-will.deacon@arm.com>
 <20171201115836.jaxzbjsnpnuau56s@lakrids.cambridge.arm.com>
 <20171201175144.GD8826@arm.com>
Message-ID: <20171201180049.ojgu56r5jo4ezupv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 05:51:44PM +0000, Will Deacon wrote:
> On Fri, Dec 01, 2017 at 11:58:36AM +0000, Mark Rutland wrote:
> > On Thu, Nov 30, 2017 at 04:39:40PM +0000, Will Deacon wrote:

> > > +	.macro kernel_ventry, el, label, regsize = 64

> > > +	b	el\()\el\()_\label

> > > -	kernel_ventry	el1_sync_invalid		// Synchronous EL1t

> > > +	kernel_ventry	1, sync_invalid			// Synchronous EL1t

> > Using the el paramter to build the branch name has the unfortunate
> > property of obscuring the branch name. For example, that makes it
> > difficult to jump around the entry asm with ctags, which is somewhat
> > painful.
> > 
> > Could we leave the full branch name in place, e.g.
> > 
> > 	kernel_ventry	1, el1_sync_invalid		// Synchronous EL1t
> > 	kernel_ventry	1, el1_irq_invalid		// IRQ EL1t
> > 	kernel_ventry	1, el1_fiq_invalid		// FIQ EL1t
> > 	kernel_ventry	1, el1_error_invalid		// Error EL1t
> > 
> > ... or have separate kernel_ventry and user_ventry macros that
> > implicitly encoded the source EL, also leaving the label name as-is.
> 
> The downside of doing that is that it makes it possible to say things like:
> 
> 	kernel_ventry	0, el1_sync
> 
> which I don't want to be expressible.
> 
> Given that ctags already chokes on lots of entry.S (for example, any macro
> that is defined outside of the file) *and* that you can easily search for
> things like el1_sync_invalid within the file, I'm inclined to leave this
> patch as-is, but I'll note your objection and buy you a pint.

I guess I'll live with it, then. ;)

Assuming I can't twist your arm, feel free to take my Reviewed-by here
too.

Thanks,
Mark.

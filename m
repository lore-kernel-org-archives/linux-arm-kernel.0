From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 17:11:49 +0100
Subject: [RFC PATCH] ARM hibernation / suspend-to-disk support code
In-Reply-To: <20110523111631.GD3769@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<20110520180510.GE7445@n2100.arm.linux.org.uk>
	<20110523100132.GC2370@arm.com>
	<20110523101220.GH17672@n2100.arm.linux.org.uk>
	<20110523111631.GD3769@arm.com>
Message-ID: <20110523161149.GB15138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 12:16:31PM +0100, Dave Martin wrote:
> On Mon, May 23, 2011 at 11:12:20AM +0100, Russell King - ARM Linux wrote:
> > On Mon, May 23, 2011 at 11:01:32AM +0100, Dave Martin wrote:
> > > On Fri, May 20, 2011 at 07:05:10PM +0100, Russell King - ARM Linux wrote:
> > > > Out of the list you mention above, the only thing which isn't saved are the
> > > > FIQ registers, and that's a problem for S2RAM too, and should be done by
> > > > arch/arm/kernel/fiq.c hooking into the suspend paths.
> > > 
> > > The alternative view is that the driver using FIQ owns the state in the FIQ
> > > mode registers and is therefore responsible for saving and restoring it
> > > across suspend/resume.  If so, then any additional globally implemented
> > > state save/restore of the FIQ mode state is unnecessary.
> > 
> > This seems to be most sensible - if the FIQ is being used as a software-DMA,
> > then the hardware side of that needs to be cleanly shutdown (eg, waiting for
> > the DMA to complete before proceeding) to ensure no loss of data.  That
> > can't happen from within the FIQ code.
> 
> OK.  Frank suggested putting comments to this effect in <asm/fiq.h>.
> 
> I think something along these lines might be appropriate:
> 
> /*
>  * The FIQ mode registers are not magically preserved across suspend/resume.
>  *
>  * Drivers which require these registers to be preserved across power
>  * management operations must implement appropriate suspend/resume handlers
>  * to save and restore them.
>  */
> 
> Is the header file a good place for this, or is there some other better
> place to put it?

I tend to suggest that the header file is the right place, because that's
where the interface is defined.  Other people argue that its more likely
to be seen in the implementation (fiq.c).  So I'm tempted to say both,
but lets go with fiq.h for the time being.

> That argument may apply to a ton of state in the Secure World, not just
> the FIQ registers

It very much does, and I know OMAP has some kind of SMC call to handle
this.

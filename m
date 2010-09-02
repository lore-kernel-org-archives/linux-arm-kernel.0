From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 13:18:38 +0100
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902115206.GK25559@gw.healthdatacare.com>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
	<20100902115206.GK25559@gw.healthdatacare.com>
Message-ID: <20100902121838.GB26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 02:52:06PM +0300, Mika Westerberg wrote:
> On Thu, Sep 02, 2010 at 11:39:57AM +0100, Russell King - ARM Linux wrote:
> > 
> > Well, as the current v6 and v7 cpu_reset() code is broken, it's hardly
> > surprising that it doesn't work.  It needs to be something like this
> > (I haven't tested it yet.)
> 
> Thanks.
> 
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 6a8506d..3542ee0 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -63,6 +63,16 @@ ENDPROC(cpu_v7_proc_fin)
> >   */
> >  	.align	5
> >  ENTRY(cpu_v7_reset)
> > +	mov	ip, #0
> > +	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
> 
> I guess this is not anymore supported in ARMv7, it causes undefined
> instruction trap.
> 
> > +	dsb
> > +#ifdef CONFIG_MMU
> > +	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
> > +#endif
> > +	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
> > +	bic	ip, ip, #0x000f			@ ............wcam
> > +	bic	ip, ip, #0x1100			@ ...i...s........
> > +	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
> >  	mov	pc, r0
> >  ENDPROC(cpu_v7_reset)
> 
> I tested this patch without that cache invalidate instruction + dsb
> and it still hangs. Exactly the same code works perfectly when it is run
> via 1:1 mapping.

Where are you ultimately jumping to?

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 31 Oct 2017 15:28:11 -0400 (EDT)
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
 <20171002020618.23924-4-nicolas.pitre@linaro.org>
 <PS1PR06MB1162212F37C8BA7EE367FE828A5E0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1710311211540.21665@knanqh.ubzr>
 <80bc8c16-321a-43ea-6cbb-257dbeee485b@arm.com>
 <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
 <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1710311527280.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Oct 2017, Chris Brandt wrote:

> On Tuesday, October 31, 2017, Nicolas Pitre wrote:
> > On Tue, 31 Oct 2017, Russell King - ARM Linux wrote:
> > > On Tue, Oct 31, 2017 at 02:15:14PM -0400, Nicolas Pitre wrote:
> > > > On Tue, 31 Oct 2017, Russell King - ARM Linux wrote:
> > > > > So a printch('\n') produces "\n\r" on the UART.  If we're fixing
> > > > > printascii() to emit "\r\n" instead of "\n\r" for a '\n', then
> > > > > printch() should have the same fix, and should not truncate to
> > > > > just '\n'.
> > > >
> > > > OK... That's easy to achieve, but is it desirable?
> > >
> > > Yes - remember, these are supposed to be usable from assembly,
> > > and we really don't want to have the complexity of:
> > >
> > > 	mov	r0, #'\r'
> > > 	bl	printch
> > > 	mov	r0, #'\n'
> > > 	bl	printch
> > >
> > > each time we want to begin a new line.
> > 
> > Fine with me.
> > 
> > diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> > index ea9646cc2a..01d746efff 100644
> > --- a/arch/arm/kernel/debug.S
> > +++ b/arch/arm/kernel/debug.S
> > @@ -79,25 +79,28 @@ hexbuf:		.space 16
> > 
> >  ENTRY(printascii)
> >  		addruart_current r3, r1, r2
> > -		b	2f
> > -1:		waituart r2, r3
> > -		senduart r1, r3
> > -		busyuart r2, r3
> > -		teq	r1, #'\n'
> > -		moveq	r1, #'\r'
> > -		beq	1b
> > -2:		teq	r0, #0
> > +1:		teq	r0, #0
> >  		ldrneb	r1, [r0], #1
> >  		teqne	r1, #0
> > -		bne	1b
> > -		ret	lr
> > +		reteq	lr
> > +2:		teq     r1, #'\n'
> > +		bne	3f
> > +		mov	r1, '\r'
> > +		waituart r2, r3
> > +		senduart r1, r3
> > +		busyuart r2, r3
> > +		mov	r1, '\n'
> > +3:		waituart r2, r3
> > +		senduart r1, r3
> > +		busyuart r2, r3
> > +		b	1b
> >  ENDPROC(printascii)
> > 
> >  ENTRY(printch)
> >  		addruart_current r3, r1, r2
> >  		mov	r1, r0
> >  		mov	r0, #0
> > -		b	1b
> > +		b	2b
> >  ENDPROC(printch)
> > 
> >  #ifdef CONFIG_MMU
> 
> 
> This patch worked for me.
> I get my carriage returns again.

Good!  Queued as patch #8717.


Nicolas

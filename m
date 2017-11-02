From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 1 Nov 2017 23:59:18 -0400 (EDT)
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <20171102000945.GT9463@n2100.armlinux.org.uk>
References: <nycvar.YSQ.7.76.1710311211540.21665@knanqh.ubzr>
 <80bc8c16-321a-43ea-6cbb-257dbeee485b@arm.com>
 <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
 <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Nov 2017, Russell King - ARM Linux wrote:

> On Tue, Oct 31, 2017 at 07:12:32PM +0000, Chris Brandt wrote:
> > On Tuesday, October 31, 2017, Nicolas Pitre wrote:
> > > On Tue, 31 Oct 2017, Russell King - ARM Linux wrote:
> > > > On Tue, Oct 31, 2017 at 02:15:14PM -0400, Nicolas Pitre wrote:
> > > > > On Tue, 31 Oct 2017, Russell King - ARM Linux wrote:
> > > > > > So a printch('\n') produces "\n\r" on the UART.  If we're fixing
> > > > > > printascii() to emit "\r\n" instead of "\n\r" for a '\n', then
> > > > > > printch() should have the same fix, and should not truncate to
> > > > > > just '\n'.
> > > > >
> > > > > OK... That's easy to achieve, but is it desirable?
> > > >
> > > > Yes - remember, these are supposed to be usable from assembly,
> > > > and we really don't want to have the complexity of:
> > > >
> > > > 	mov	r0, #'\r'
> > > > 	bl	printch
> > > > 	mov	r0, #'\n'
> > > > 	bl	printch
> > > >
> > > > each time we want to begin a new line.
> > > 
> > > Fine with me.
> > > 
> > > diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> > > index ea9646cc2a..01d746efff 100644
> > > --- a/arch/arm/kernel/debug.S
> > > +++ b/arch/arm/kernel/debug.S
> > > @@ -79,25 +79,28 @@ hexbuf:		.space 16
> > > 
> > >  ENTRY(printascii)
> > >  		addruart_current r3, r1, r2
> > > -		b	2f
> > > -1:		waituart r2, r3
> > > -		senduart r1, r3
> > > -		busyuart r2, r3
> > > -		teq	r1, #'\n'
> > > -		moveq	r1, #'\r'
> > > -		beq	1b
> > > -2:		teq	r0, #0
> > > +1:		teq	r0, #0
> > >  		ldrneb	r1, [r0], #1
> > >  		teqne	r1, #0
> > > -		bne	1b
> > > -		ret	lr
> > > +		reteq	lr
> > > +2:		teq     r1, #'\n'
> > > +		bne	3f
> > > +		mov	r1, '\r'
> > > +		waituart r2, r3
> > > +		senduart r1, r3
> > > +		busyuart r2, r3
> > > +		mov	r1, '\n'
> > > +3:		waituart r2, r3
> > > +		senduart r1, r3
> > > +		busyuart r2, r3
> > > +		b	1b
> > >  ENDPROC(printascii)
> > > 
> > >  ENTRY(printch)
> > >  		addruart_current r3, r1, r2
> > >  		mov	r1, r0
> > >  		mov	r0, #0
> > > -		b	1b
> > > +		b	2b
> > >  ENDPROC(printch)
> > > 
> > >  #ifdef CONFIG_MMU
> > 
> > 
> > This patch worked for me.
> > I get my carriage returns again.
> 
> Sorry, but no.  This is crap.
> 
> The kernelci.org test resulting from the tree I pushed out this evening
> with both of the patches in is very unhappy:
> 
>      42  arch/arm/kernel/debug.S:98: Error: immediate expression requires a # prefix -- `mov r1,10'
>      42  arch/arm/kernel/debug.S:94: Error: immediate expression requires a # prefix -- `mov r1,13'
> 
> I can't believe that anyone actually build-tested this patch as it
> stands - maybe, Chris, you just think you did but you ended up
> testing something else?  Or maybe your binutils is broken because
> it now accepts constants without the preceding '#' ?

Well... I don't know what happened with Chris' testing either.

I *thought* I build tested it, but my .config had 
CONFIG_DEBUG_SEMIHOSTING=y.

Oh well...


Nicolas

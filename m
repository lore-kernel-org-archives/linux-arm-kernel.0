From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 13:31:42 +0100
Subject: [PATCH] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <20100731120827.GA12662@pengutronix.de>
References: <1280518523-5526-1-git-send-email-rabin@rab.in>
	<20100730205756.GA28316@pengutronix.de>
	<20100731090445.GA23886@n2100.arm.linux.org.uk>
	<20100731120827.GA12662@pengutronix.de>
Message-ID: <20100731123142.GA27064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 02:08:27PM +0200, Uwe Kleine-K?nig wrote:
> On Sat, Jul 31, 2010 at 10:04:45AM +0100, Russell King - ARM Linux wrote:
> > It doesn't matter.  The point is that you deleted an entry from the
> > table which the ldmia/ldmia+ldr loads from and didn't adjust the
> > resulting code properly.
> Yes, got that.
> > 
> > - ARM(          ldmia   r0, {r1, r2, r3, r5, r6, r11, ip, sp})
> > + ARM(          ldmia   r0, {r1, r2, r3, r5, r6, r11, ip})
> >   THUMB(                ldmia   r0, {r1, r2, r3, r5, r6, r11, ip}       )
> > - THUMB(                ldr     sp, [r0, #32]                           )
> > +               ldr     sp, [r0, #28]
> We can simpify this further to just
> 
> 	@ Thumb code doesn't allow sp to be in the list, for ARM it's
> 	@ deprecated, so use a seperate ldr for it.
> 	ldmia   r0, {r1, r2, r3, r5, r6, r11, ip}
> 	ldr     sp, [r0, #32]

No, you mean #28.

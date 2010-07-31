From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 31 Jul 2010 14:08:27 +0200
Subject: [PATCH] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <20100731090445.GA23886@n2100.arm.linux.org.uk>
References: <1280518523-5526-1-git-send-email-rabin@rab.in>
	<20100730205756.GA28316@pengutronix.de>
	<20100731090445.GA23886@n2100.arm.linux.org.uk>
Message-ID: <20100731120827.GA12662@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 10:04:45AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 30, 2010 at 10:57:56PM +0200, Uwe Kleine-K?nig wrote:
> > On Sat, Jul 31, 2010 at 01:05:23AM +0530, Rabin Vincent wrote:
> > > "ARM: Auto calculate ZRELADDR and provide option for exceptions" broke the
> > > Thumb-2 decompressor because it removed an entry in the LC0 table but didn't
> > > adjust the offset the Thumb-2 code uses to load the SP from that table.
> > > 
> > > Fix it, and also change the ARM code to use the separate SP-load since
> > > ARM instructions that include the SP in the LDM register list are
> > > deprecated.
> > I only found:
> > 
> > 	LDM{<cond>}<addressing_mode> <Rn>{!}, <registers>
> > 	...
> > 	If the base register <Rn> is specified in <registers>, and base
> > 	register write-back is specified,
> > 	the final value of <Rn> is UNPREDICTABLE.
> > 
> > Are you really sure about this?  Where do you know it from?
> 
> It doesn't matter.  The point is that you deleted an entry from the
> table which the ldmia/ldmia+ldr loads from and didn't adjust the
> resulting code properly.
Yes, got that.
> 
> - ARM(          ldmia   r0, {r1, r2, r3, r5, r6, r11, ip, sp})
> + ARM(          ldmia   r0, {r1, r2, r3, r5, r6, r11, ip})
>   THUMB(                ldmia   r0, {r1, r2, r3, r5, r6, r11, ip}       )
> - THUMB(                ldr     sp, [r0, #32]                           )
> +               ldr     sp, [r0, #28]
We can simpify this further to just

	@ Thumb code doesn't allow sp to be in the list, for ARM it's
	@ deprecated, so use a seperate ldr for it.
	ldmia   r0, {r1, r2, r3, r5, r6, r11, ip}
	ldr     sp, [r0, #32]

> In case you're wondering, it's this part, found in the "Instruction
> details" section of "A8.6.53 LDM / LDMIA / LDMFD":
> 
> "The SP can be in the list in ARM code, but not in Thumb code. However,
> ARM instructions that include the SP in the list are deprecated."
OK, I didn't have the v7 ARMARM.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

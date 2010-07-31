From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 10:04:45 +0100
Subject: [PATCH] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <20100730205756.GA28316@pengutronix.de>
References: <1280518523-5526-1-git-send-email-rabin@rab.in>
	<20100730205756.GA28316@pengutronix.de>
Message-ID: <20100731090445.GA23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 10:57:56PM +0200, Uwe Kleine-K?nig wrote:
> On Sat, Jul 31, 2010 at 01:05:23AM +0530, Rabin Vincent wrote:
> > "ARM: Auto calculate ZRELADDR and provide option for exceptions" broke the
> > Thumb-2 decompressor because it removed an entry in the LC0 table but didn't
> > adjust the offset the Thumb-2 code uses to load the SP from that table.
> > 
> > Fix it, and also change the ARM code to use the separate SP-load since
> > ARM instructions that include the SP in the LDM register list are
> > deprecated.
> I only found:
> 
> 	LDM{<cond>}<addressing_mode> <Rn>{!}, <registers>
> 	...
> 	If the base register <Rn> is specified in <registers>, and base
> 	register write-back is specified,
> 	the final value of <Rn> is UNPREDICTABLE.
> 
> Are you really sure about this?  Where do you know it from?

It doesn't matter.  The point is that you deleted an entry from the
table which the ldmia/ldmia+ldr loads from and didn't adjust the
resulting code properly.

- ARM(          ldmia   r0, {r1, r2, r3, r5, r6, r11, ip, sp})
+ ARM(          ldmia   r0, {r1, r2, r3, r5, r6, r11, ip})
  THUMB(                ldmia   r0, {r1, r2, r3, r5, r6, r11, ip}       )
- THUMB(                ldr     sp, [r0, #32]                           )
+               ldr     sp, [r0, #28]

In case you're wondering, it's this part, found in the "Instruction
details" section of "A8.6.53 LDM / LDMIA / LDMFD":

"The SP can be in the list in ARM code, but not in Thumb code. However,
ARM instructions that include the SP in the list are deprecated."

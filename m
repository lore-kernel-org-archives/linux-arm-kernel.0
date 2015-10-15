From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 09:17:47 +0100
Subject: [PATCH V2] ARM: BCM5301X: Implement SMP support
In-Reply-To: <561D85BF.30305@hauke-m.de>
References: <1424385148-15026-1-git-send-email-zajec5@gmail.com>
 <1427030415-31721-1-git-send-email-zajec5@gmail.com>
 <20150326120026.GF8656@n2100.arm.linux.org.uk>
 <561D85BF.30305@hauke-m.de>
Message-ID: <20151015081747.GW32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 12:29:19AM +0200, Hauke Mehrtens wrote:
> Hi,
> 
> I tested this patch on my device now.
> 
> What does the loader do before Linux gets started on the second CPU and
> what is ensured?
> 
> On 03/26/2015 01:00 PM, Russell King - ARM Linux wrote:
> > On Sun, Mar 22, 2015 at 02:20:15PM +0100, Rafa? Mi?ecki wrote:
> >> +/*
> >> + * BCM5301X specific entry point for secondary CPUs.
> >> + */
> >> +ENTRY(bcm5301x_secondary_startup)
> >> +	mrc	p15, 0, r0, c0, c0, 5
> >> +	and	r0, r0, #15
> >> +	adr	r4, 1f
> >> +	ldmia	r4, {r5, r6}
> >> +	sub	r4, r4, r5
> >> +	add	r6, r6, r4
> >> +pen:	ldr	r7, [r6]
> >> +	cmp	r7, r0
> >> +	bne	pen
> >> +
> >> +	/*
> >> +	 * In case L1 cache has unpredictable contents at power-up
> >> +	 * clean its contents without flushing.
> >> +	 */
> >> +	bl      v7_invalidate_l1
> >> +
> >> +	mov	r0, #0
> >> +	mcr	p15, 0, r0, c7, c5, 0	/* Invalidate icache */
> >> +	dsb
> >> +	isb
> > 
> > So if your I-cache contains unpredictable contents, how do you execute
> > the code to this point?  Shouldn't the I-cache invalidate be the very
> > first instruction you execute followed by the dsb and isb (oh, and iirc
> > it ignores the value in the register).
> > 
> > In the case where a CPU has unpredictable contents at power up, the
> > ARM ARM requires that an implementation specific sequence is followed
> > to initialise the caches.  I doubt that such a sequence includes testing
> > a pen value.

Things have changed in this area: ARMv7 CPU support now conforms with
other Linux CPU support, and we invalidate the caches prior to enabling
them.

However, I still come back to the point I said above, which you have not
addressed.  If the L1 cache contains unpredictable contents at power up,
how can you guarnatee that any code the CPU executes _is read by the CPU_
rather than the random contents of the L1 cache.

This isn't about the pen stuff.  It's about whether you can execute any
code reliably at this point.

There are several possibilities that the ARM ARM allows:
* the caches are reset at CPU reset and contain no valid or dirty lines
* the caches are not reset at CPU reset, but are not searched until
  the enable bits are set
* the caches are not reset at CPU reset, but are searched

The last case is the "special" case that requires a implementation
specific code to initialise them safely - but anyone implementing that
would be really silly to do so, so I doubt this is what you have.

So, I'd just get rid of that unnecessary cache flushing, especially as
I've said above, the ARMv7 CPU entry has been fixed to invalidate caches,
rather than flush dirty data (hence potentially random data in the second
case above) out to memory.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

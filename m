From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jan 2010 20:19:43 +0000
Subject: cache flushing for armv3 in zImage
In-Reply-To: <20100126192045.GA17642@pengutronix.de>
References: <20100126192045.GA17642@pengutronix.de>
Message-ID: <20100126201943.GA29871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 08:20:46PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> I currently look into arch/arm/boot/compressed/head.S and wonder about
> some cache functions:
> 
>  - __armv3_mpu_cache_flush does:
> 	mov     r1, #0
> 	mcr     p15, 0, r0, c7, c0, 0   @ invalidate whole cache v3
> 	mov     pc, lr
> 
>    why is r1 set to zero?  I assume the register used in the mcr
>    instruction should be zero, but this uses r0, not r1.

The mcr should be using r1 - r0 must be preserved.

>  - ARMv5TEJ uses __armv4_mmu_cache_flush not __armv5tej_mmu_cache_flush?

I don't believe every ARMv5TEJ CPU supports the "test,clean,invalidate
D cache" instruction; you may notice only a very small subset of ARMv5
implementations use __armv5tej_mmu_cache_flush, and I suspect that it
was originally mis-named.

>  - __armv5tej_mmu_cache_flush calls
> 	mcr     p15, 0, r0, c7, c5, 0   @ flush I cache
> 	mcr     p15, 0, r0, c7, c10, 4  @ drain WB
>    without asserting that r0 is zero.  ARM DDI 0198E (i.e. ARM926EJ-S
>    TRM) specifies the register should be zero.  (I'm not sure this is
>    the right document.)

Over the years, the requirement for the register passed to 'mcr' has
varied between "should be zero" to "doesn't care" depending on the
document you read.  As a result, I no longer attach much belief to
statements requiring the register passed to cache flushing functions
to be zero.

Indeed, in real tests, it doesn't seem to make any difference on any
CPU I've come across.

>  - __armv7_mmu_cache_flush corrupts r10, but this is not listed as
>    corrupted register in the comment describing cache_clean_flush.

r10 can be listed as being corrupted.

>    As __armv7_mmu_cache_off calls __armv7_mmu_cache_flush there r10 is
>    corrupted, too which isn't explicitly allowed according to the
>    comment of cache_off either.

Ditto.  As the only place where cache_off is called is:

call_kernel:    bl      cache_clean_flush
                bl      cache_off

any registers which cache_clean_flush can corrupt can also be corrupted
by cache_off, so lets make the two lists of corrupted registers identical.

>  - __armv4_mpu_cache_on corrupts r0
>    __armv3_mpu_cache_on ditto

Allowed.

>  - __armv3_mpu_cache_on has:
> 
> 	mrc     p15, 0, r0, c1, c0, 0   @ read control reg
> 	                                @ .... .... .... WC.M
> 	orr     r0, r0, #0x000d         @ .... .... .... 11.1
> 	mov     r0, #0
> 	mcr     p15, 0, r0, c1, c0, 0   @ write control reg
> 
>    assuming that reading control reg and writing a recently read value
>    has no side effects all four instructions can go away.

Nice catch - no idea what the right thing is here, the ARM uclinux people
seem to have vanished from the planet.

ARMv3 MMU does not allow reading the control register, and I'd be surprised
if ARMv3 MPU allows it either.  I'd suggest leaving this as is until
someone who knows this hardware decides to fix.

>  - __armv3_mpu_cache_on does "invalidate whole cache v3" twice?

No idea - uclinux magic I assume.

>  - the comment that r9 holds the run-time address of "start" on entry of
>    cache_on is wrong I think.  If the zImage isn't relocated r9 isn't
>    touched until cacheon is called.

Comment should be removed.

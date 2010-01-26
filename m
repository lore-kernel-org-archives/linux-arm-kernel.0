From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Jan 2010 20:20:46 +0100
Subject: cache flushing for armv3 in zImage
Message-ID: <20100126192045.GA17642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I currently look into arch/arm/boot/compressed/head.S and wonder about
some cache functions:

 - __armv3_mpu_cache_flush does:
	mov     r1, #0
	mcr     p15, 0, r0, c7, c0, 0   @ invalidate whole cache v3
	mov     pc, lr

   why is r1 set to zero?  I assume the register used in the mcr
   instruction should be zero, but this uses r0, not r1.

 - ARMv5TEJ uses __armv4_mmu_cache_flush not __armv5tej_mmu_cache_flush?

 - __armv5tej_mmu_cache_flush calls
	mcr     p15, 0, r0, c7, c5, 0   @ flush I cache
	mcr     p15, 0, r0, c7, c10, 4  @ drain WB
   without asserting that r0 is zero.  ARM DDI 0198E (i.e. ARM926EJ-S
   TRM) specifies the register should be zero.  (I'm not sure this is
   the right document.)
   Ditto for __armv4_mmu_cache_flush.  I assume both should first zero
   r1 and then use r1 in the mcr instructions?
   Ditto __armv3_mpu_cache_on:
	mcr     p15, 0, r0, c7, c0, 0
   while r0 holds a value read by
	mrc     p15, 0, r0, c1, c0, 0 

 - __armv7_mmu_cache_flush corrupts r10, but this is not listed as
   corrupted register in the comment describing cache_clean_flush.
   As __armv7_mmu_cache_off calls __armv7_mmu_cache_flush there r10 is
   corrupted, too which isn't explicitly allowed according to the
   comment of cache_off either.

 - __armv4_mpu_cache_on corrupts r0
   __armv3_mpu_cache_on ditto

 - __armv3_mpu_cache_on has:

	mrc     p15, 0, r0, c1, c0, 0   @ read control reg
	                                @ .... .... .... WC.M
	orr     r0, r0, #0x000d         @ .... .... .... 11.1
	mov     r0, #0
	mcr     p15, 0, r0, c1, c0, 0   @ write control reg

   assuming that reading control reg and writing a recently read value
   has no side effects all four instructions can go away.

 - __armv3_mpu_cache_on does "invalidate whole cache v3" twice?

 - the comment that r9 holds the run-time address of "start" on entry of
   cache_on is wrong I think.  If the zImage isn't relocated r9 isn't
   touched until cacheon is called.
   (r9 is used in __setup_mmu and then holds something that should be
   the start of RAM.  (The actual value is 

	(zreladdr - 0x4000) & ~0x3ffff

   .))

Any thoughts on how to address these points?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

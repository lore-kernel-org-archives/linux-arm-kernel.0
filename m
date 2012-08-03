From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Aug 2012 11:04:52 +0200
Subject: kernel entry for thumb2-only cpus
Message-ID: <20120803090452.GE2626@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

in both arch/arm/kernel/head.S and arch/arm/kernel/head-nommu.S we have

	.arm
 THUMB( adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
 THUMB( bx      r9              )       @ If this is a Thumb-2 kernel,
 THUMB( .thumb                  )       @ switch to Thumb now.
 THUMB(1:                       )

as first instructions at the entry point. This is a problem for
thumb2-only cpus (e.g. Cortex-M3).

Up to now I commented out the first three lines for the Cortex-M3 port.
What should we do about that. There are two possibilities I see:

 a) introduce a kconfig symbol for thumb2-only builds and #ifdef the
    first three lines out if it is given.
 b) expect the bootloader to directly jump to the label 1.

The downside of a) is that a boot loader on a cpu that is capable to
execute the tradtional instructions would need to detect if the switch
to thumb is there or not and react accordingly. (In fact it needs to
distringuish three cases:

 - traditional kernel
 - thumb2 kernel with ARM entry
 - thumb2 kernel without ARM entry

.) So I think b) is the more sensible option in the long run.

What do you think?

If so I'd expand the comment with this expectation.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

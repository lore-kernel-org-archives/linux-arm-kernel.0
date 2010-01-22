From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 22 Jan 2010 12:58:31 +0100
Subject: make PHYS_OFFSET determined at run time (unfinished)
In-Reply-To: <20100119083803.GA17904@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
Message-ID: <20100122115831.GA8377@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

just a short status report:  The code seems to work OK if PHYS_OFFSET is
determined correctly.

The problem is when it does not.  Currently I place arch/arm/boot/Image
at 0xa1008000[1] with PHYS_OFFSET being 0xa0000000.  Then
arch/arm/boot/head.S guesses PHYS_OFFSET to be 0xa1000000 resulting
__va(bank->start) of my only bank to be 0xbf000000.  And so this bank is
discarded by sanity_check_meminfo as 0xbf000000 overlaps the vmalloc
region.

So how to proceed?  These possiblities come to (my) mind:

 - parse the atag list to better guess phys_offset
   (both zImage and Image would need to do that)
 - require that zImage and Image are placed such that the guess is done
   right (which is stupid for zImage as then the decompressor needs to
   move the decompressed image)
 - require the bootloader to pass phys_offset (r3?)
 - make the ram mapping non-linear
 - don't discard the whole bank, only the addresses overlaping the
   vmalloc region

Anything else?  Preferences?  Thoughts?

Best regards
Uwe

[1] I think the same happens with zImage placed at 0xa1008000

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

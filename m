From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 30 Jan 2010 22:02:31 +0100
Subject: change boot requirements [Was: make PHYS_OFFSET determined at
	run time (unfinished)]
In-Reply-To: <4B5DF1C9.6090102@bluewatersys.com>
References: <20100119083803.GA17904@pengutronix.de>
	<20100122115831.GA8377@pengutronix.de>
	<20100125173201.GA14834@pengutronix.de>
	<4B5DF1C9.6090102@bluewatersys.com>
Message-ID: <20100130210231.GC16345@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 26, 2010 at 08:32:25AM +1300, Ryan Mallon wrote:
> Uwe Kleine-K?nig wrote:
> > On Fri, Jan 22, 2010 at 12:58:31PM +0100, Uwe Kleine-K?nig wrote:
> >> just a short status report:  The code seems to work OK if PHYS_OFFSET is
> >> determined correctly.
> >>
> >> The problem is when it does not.  Currently I place arch/arm/boot/Image
> >> at 0xa1008000[1] with PHYS_OFFSET being 0xa0000000.  Then
> >> arch/arm/boot/head.S guesses PHYS_OFFSET to be 0xa1000000 resulting
> >> __va(bank->start) of my only bank to be 0xbf000000.  And so this bank is
> >> discarded by sanity_check_meminfo as 0xbf000000 overlaps the vmalloc
> >> region.
> >>
> >> So how to proceed?  These possiblities come to (my) mind:
> >>
> >>  - parse the atag list to better guess phys_offset
> >>    (both zImage and Image would need to do that)
> >>  - require that zImage and Image are placed such that the guess is done
> >>    right (which is stupid for zImage as then the decompressor needs to
> >>    move the decompressed image)
> >>  - require the bootloader to pass phys_offset (r3?)
> >>  - make the ram mapping non-linear
> >>  - don't discard the whole bank, only the addresses overlaping the
> >>    vmalloc region
> >>
> >> Anything else?  Preferences?  Thoughts?
> > I'd like to go forward here and if I don't hear anything here I'll start
> > requiring that the bootloader sets r3=PHYS_OFFSET as this seems the most
> > robust solution to me.
It works now for me.  

zImage expects to get PHYS_OFFSET passed in r3.  It doesn't hurt at all
if the value is wrong if RUNTIME_PHYS_OFFSET is off.  If it's on it is
used if the value is 128MiB-aligned.  If not sp & 0xf8000000 is used.
This should work for most machines.

There is no machine support included yet, but adding it for your machine
should be easy.  Just select RUNTIME_PHYS_OFFSET and remove the
definition of PHYS_OFFSET from <mach/memory.h>.

The whole series is available via git, see below, and I will send the
patches not yet send in reply to this mail.

Best regards
Uwe

The following changes since commit 499a2673713c85734a54c37dd90b4b729de399c4:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git arm/booting

Uwe Kleine-K?nig (9):
      zImage: fix comments for cache_on, cache_off and cache_clean_flush
      zImage: some comments for __armv3_mpu_cache_on
      zImage: __armv3_mpu_cache_flush: respect should-be-zero specification
      zImage: annotate debug functions about corrupted registers
      zImage: don't define unused symbol initrd_phys
      arm: deprecate support for old way to pass kernel parameters
      zImage: don't hard code the stack size twice
      uImage: require passing a LOADADDR when building with RUNTIME_PHYSOFFSET
      Allow PHYS_OFFSET to be runtime determined

 Documentation/arm/Booting         |    1 +
 arch/arm/Kconfig                  |    9 ++++
 arch/arm/boot/Makefile            |    6 ++-
 arch/arm/boot/compressed/Makefile |   10 ++---
 arch/arm/boot/compressed/head.S   |   76 +++++++++++++++++++++++++++++++++----
 arch/arm/include/asm/memory.h     |    5 ++
 arch/arm/kernel/Makefile          |    4 +-
 arch/arm/kernel/compat.c          |    7 ---
 arch/arm/kernel/compat.h          |    2 -
 arch/arm/kernel/head.S            |   31 +++++++++++----
 arch/arm/kernel/setup.c           |   21 ++++++++++-
 11 files changed, 138 insertions(+), 34 deletions(-)

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 May 2012 20:25:47 -0400 (EDT)
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205152135.26759.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515173909.383a0d8a@skate> <201205151626.49173.arnd@arndb.de>
 <201205152135.26759.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1205152021210.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012, Arnd Bergmann wrote:

> On Tuesday 15 May 2012, Arnd Bergmann wrote:
> 
> > Another way would be to reorganize those directories upfront:
> > 
> > plat-orion -> mach-orion
> > mach-*/*.c -> mach/orion/*/*.c
> > mach-*/include/mach/* -> mach-orion/include/mach/*.h
> > 
> > and then go from there. The differences between the headers are fairly
> > small already, so that should be manageable.
> 
> Actually we could do a trivial move of all files into one directory at any
> time, e.g. at the end of the merge window, to minimize conflicts with
> other patches.
> 
> This is a semi-automated move of all plat-orion based machines into
> a single mach-orion directory, and we could of course add the new stuff
> in there as well. I've specifically tried to keep this move simple,
> even if that means a lot of the easy cleanups for code that are mostly
> identical are not done here. Cleanups after this could come one at
> a time to reduce this duplication and simplify the platform.
> 
> Obvious next steps are to merge the various Makefile and Kconfig files
> as well as all the headers, and to actually allow building stuff together.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>

The problematic Armada naming issue simply goes away.


>  arch/arm/mach-dove/Makefile.boot                 |    3 --
>  arch/arm/mach-dove/include/mach/gpio.h           |    9 -------
>  arch/arm/mach-dove/include/mach/hardware.h       |   19 ----------------
>  arch/arm/mach-kirkwood/include/mach/gpio.h       |    9 -------
>  arch/arm/mach-kirkwood/include/mach/hardware.h   |   14 ------------
>  arch/arm/mach-kirkwood/include/mach/timex.h      |   10 --------
>  arch/arm/mach-mv78xx0/Makefile.boot              |    3 --
>  arch/arm/mach-mv78xx0/include/mach/gpio.h        |    9 -------
>  arch/arm/mach-mv78xx0/include/mach/hardware.h    |   14 ------------
>  arch/arm/mach-mv78xx0/include/mach/timex.h       |    9 -------
>  arch/arm/mach-orion5x/Makefile.boot              |    3 --
>  arch/arm/mach-orion5x/include/mach/gpio.h        |    9 -------
>  arch/arm/mach-orion5x/include/mach/hardware.h    |   14 ------------
>  arch/arm/mach-orion5x/include/mach/timex.h       |   11 ---------
>  arch/arm/plat-orion/Makefile                     |   10 --------
>  b/arch/arm/Kconfig                               |    8 -------
>  b/arch/arm/Makefile                              |    9 +++----
>  b/arch/arm/mach-orion/Kconfig                    |    7 ++++++
>  b/arch/arm/mach-orion/Makefile                   |   26 +++++++++++++++++++++++
>  b/arch/arm/mach-orion/Makefile.dove              |    2 -
>  b/arch/arm/mach-orion/Makefile.kirkwood          |    2 -
>  b/arch/arm/mach-orion/Makefile.mv78xx0           |    2 -
>  b/arch/arm/mach-orion/Makefile.orion5x           |    2 -
>  b/arch/arm/mach-orion/addr-map-dove.c            |    4 +--
>  b/arch/arm/mach-orion/addr-map-kirkwood.c        |    4 +--
>  b/arch/arm/mach-orion/addr-map-mv78xx0.c         |    4 +--
>  b/arch/arm/mach-orion/addr-map-orion5x.c         |    4 +--
>  b/arch/arm/mach-orion/addr-map.c                 |    2 -
>  b/arch/arm/mach-orion/board-dnskw.c              |    4 +--
>  b/arch/arm/mach-orion/board-dreamplug.c          |    6 ++---
>  b/arch/arm/mach-orion/board-dt.c                 |    2 -
>  b/arch/arm/mach-orion/board-ib62x0.c             |    4 +--
>  b/arch/arm/mach-orion/board-iconnect.c           |    4 +--
>  b/arch/arm/mach-orion/buffalo-wxl-setup.c        |    4 +--
>  b/arch/arm/mach-orion/cm-a510.c                  |    2 -
>  b/arch/arm/mach-orion/common.c                   |    6 ++---
>  b/arch/arm/mach-orion/d2net-setup.c              |    4 +--
>  b/arch/arm/mach-orion/d2net_v2-setup.c           |    4 +--
>  b/arch/arm/mach-orion/db78x00-bp-setup.c         |    2 -
>  b/arch/arm/mach-orion/db88f5281-setup.c          |    6 ++---
>  b/arch/arm/mach-orion/db88f6281-bp-setup.c       |    6 ++---
>  b/arch/arm/mach-orion/dns323-setup.c             |    4 +--
>  b/arch/arm/mach-orion/dockstar-setup.c           |    6 ++---
>  b/arch/arm/mach-orion/dove-db-setup.c            |    2 -
>  b/arch/arm/mach-orion/dove.c                     |   10 ++++----
>  b/arch/arm/mach-orion/edmini_v2-setup.c          |    4 +--
>  b/arch/arm/mach-orion/guruplug-setup.c           |    6 ++---
>  b/arch/arm/mach-orion/include/mach/bridge-regs.h |   12 ++++++++++
>  b/arch/arm/mach-orion/include/mach/debug-macro.S |   12 ++++++++++
>  b/arch/arm/mach-orion/include/mach/entry-macro.S |   12 ++++++++++
>  b/arch/arm/mach-orion/include/mach/hardware.h    |   12 ++++++++++
>  b/arch/arm/mach-orion/include/mach/io.h          |   12 ++++++++++
>  b/arch/arm/mach-orion/include/mach/irqs.h        |   12 ++++++++++
>  b/arch/arm/mach-orion/include/mach/uncompress.h  |   12 ++++++++++
>  b/arch/arm/mach-orion/irq-dove.c                 |    4 +--
>  b/arch/arm/mach-orion/irq-kirkwood.c             |    4 +--
>  b/arch/arm/mach-orion/irq-mv78xx0.c              |    4 +--
>  b/arch/arm/mach-orion/irq-orion5x.c              |    4 +--
>  b/arch/arm/mach-orion/irq.c                      |    2 -
>  b/arch/arm/mach-orion/kirkwood.c                 |   18 +++++++--------
>  b/arch/arm/mach-orion/kurobox_pro-setup.c        |    6 ++---
>  b/arch/arm/mach-orion/lacie_v2-common.c          |    4 +--
>  b/arch/arm/mach-orion/ls-chl-setup.c             |    4 +--
>  b/arch/arm/mach-orion/ls_hgl-setup.c             |    4 +--
>  b/arch/arm/mach-orion/lsmini-setup.c             |    4 +--
>  b/arch/arm/mach-orion/mpp-dove.c                 |    4 +--
>  b/arch/arm/mach-orion/mpp-kirkwood.c             |    6 ++---
>  b/arch/arm/mach-orion/mpp-mv78xx0.c              |    6 ++---
>  b/arch/arm/mach-orion/mpp-orion5x.c              |    6 ++---
>  b/arch/arm/mach-orion/mpp.c                      |    2 -
>  b/arch/arm/mach-orion/mss2-setup.c               |    4 +--
>  b/arch/arm/mach-orion/mv2120-setup.c             |    4 +--
>  b/arch/arm/mach-orion/mv78xx0.c                  |   14 ++++++------
>  b/arch/arm/mach-orion/mv88f6281gtw_ge-setup.c    |    4 +--
>  b/arch/arm/mach-orion/net2big-setup.c            |    4 +--
>  b/arch/arm/mach-orion/netspace_v2-setup.c        |    4 +--
>  b/arch/arm/mach-orion/netxbig_v2-setup.c         |    4 +--
>  b/arch/arm/mach-orion/openrd-setup.c             |    6 ++---
>  b/arch/arm/mach-orion/orion5x.c                  |   12 +++++-----
>  b/arch/arm/mach-orion/pci-orion5x.c              |    6 ++---
>  b/arch/arm/mach-orion/pcie-dove.c                |    6 ++---
>  b/arch/arm/mach-orion/pcie-kirkwood.c            |    6 ++---
>  b/arch/arm/mach-orion/pcie-mv78xx0.c             |    6 ++---
>  b/arch/arm/mach-orion/pcie.c                     |    4 +--
>  b/arch/arm/mach-orion/rd78x00-masa-setup.c       |    2 -
>  b/arch/arm/mach-orion/rd88f5181l-fxo-setup.c     |    4 +--
>  b/arch/arm/mach-orion/rd88f5181l-ge-setup.c      |    4 +--
>  b/arch/arm/mach-orion/rd88f5182-setup.c          |    4 +--
>  b/arch/arm/mach-orion/rd88f6183ap-ge-setup.c     |    2 -
>  b/arch/arm/mach-orion/rd88f6192-nas-setup.c      |    2 -
>  b/arch/arm/mach-orion/rd88f6281-setup.c          |    6 ++---
>  b/arch/arm/mach-orion/sheevaplug-setup.c         |    6 ++---
>  b/arch/arm/mach-orion/t5325-setup.c              |    4 +--
>  b/arch/arm/mach-orion/terastation_pro2-setup.c   |    4 +--
>  b/arch/arm/mach-orion/ts209-setup.c              |    4 +--
>  b/arch/arm/mach-orion/ts219-setup.c              |    4 +--
>  b/arch/arm/mach-orion/ts409-setup.c              |    4 +--
>  b/arch/arm/mach-orion/ts41x-setup.c              |    6 ++---
>  b/arch/arm/mach-orion/ts78xx-setup.c             |    4 +--
>  b/arch/arm/mach-orion/tsx09-common.c             |    2 -
>  b/arch/arm/mach-orion/tsx1x-common.c             |    2 -
>  b/arch/arm/mach-orion/wnr854t-setup.c            |    4 +--
>  b/arch/arm/mach-orion/wrt350n-v2-setup.c         |    4 +--
>  b/arch/arm/mm/cache-feroceon-l2.c                |    2 -
>  b/drivers/dma/mv_xor.c                           |    2 -
>  b/drivers/mmc/host/mvsdio.c                      |    2 -
>  b/drivers/mtd/nand/orion_nand.c                  |    2 -
>  b/drivers/usb/host/ehci-orion.c                  |    2 -
>  b/drivers/watchdog/orion_wdt.c                   |    2 -
>  b/sound/soc/kirkwood/kirkwood-i2s.c              |    2 -
>  b/sound/soc/kirkwood/kirkwood-openrd.c           |    2 -
>  b/sound/soc/kirkwood/kirkwood-t5325.c            |    2 -
>  112 files changed, 306 insertions(+), 342 deletions(-)

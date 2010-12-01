From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Dec 2010 12:14:48 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
	<AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
Message-ID: <20101201111448.GF6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 08:27:21PM -0200, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Mon, Nov 29, 2010 at 7:24 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> ....
> >> I also generated the SDMA firmware (sdma-imx51-to1.bin) via your sdma
> >> tool and placed it under /lib/firmware, but the result is the same
> >> with or without a valid firmware: when request_firmware is called the
> >> following crash happens:
> >
> > I tried to reproduce this today. Instead of crashing my kernel simply
> > hangs. This seems to be because request_firmware waits till the firmware
> > appears which never happens. I remember a crash like this though, I
> > think it has something to do with the firmware related kconfig options.
> > I hope to find a time slot later this week to track this down.
> 
> Could you please share your .config?
> 
> I would like to compare what may be causing the different behaviours
> we are seeing.

It seems the reason for the crash is that firmware_class registers in
fs_initcall whereas the sdma driver uses it at subsys_initcall time.
Solution is to either use module_init in the sdma driver or
subsys_initcall in drivers/base/firmware_class.c.

When given a firmware it works, when no firmware is given the kernel
locks for some time because it waits for the firmware to appear which
never happens. We should probably use request_firmware_nowait in the
sdma driver.

I put together a branch with sdma sound working on the babbage and
mx35-3ds boards using mx3_defconfig/mx51_defconfig from this branch.
The branch works with and without firmware with the mentioned wait time
when the firmware is not available.

BTW I changed the SDMA firmware repository to name the i.MX51 firmware
*to3.bin instead of to1, because that's what it actually is.

Sound support is a story with many frameworks and a lot of board
specifics involved, but I hope we manage to sort this out for i.MX soon.
Sorry for the inconvenience.

It would be great if someone steps forward and mainlines this sgtl5000
codec driver, that's currently the main showstopper for sound support on
the Freescale boards.

Sascha


The following changes since commit 72083646528d4887b920deb71b37e09bc7d227bb:

  Un-inline get_pipe_info() helper function (2010-11-28 16:27:19 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-sdma-sound-mx353ds-mx51_babbage

Sascha Hauer (22):
      ASoC: i.MX31ads: initialize only on correct machine
      dmaengine i.MX SDMA: Allow to run without firmware
      ARM i.MX SDMA: Add ROM script addresses to platform_data
      ASoC i.MX DMA: add forgotten dma burstsize settings
      drivers/base: move firmware_class_init to subsys_initcall
      ARM i.MX3: add dma request defines
      ARM i.MX3: add dma request resources to ssi/sdhc devices
      imx-pcm-fiq: We can support mono
      ASoC: i.MX: we can do mono
      ASoC: Add bluetooth codec support
      ASoC: Add mc13783 codec support (multicomponent fixes untested)
      ASoC: Add sgtl5000 codec support
      ASoC: Add sound support for i.MX baords based on the sgtl5000 codec
      ASoC: Add phyCORE mc13783 audio support (multicomponent fixes untested)
      ARM i.MX pcm038: Add sound support
      ARM i.MX pcm037: Add sound support
      ARM i.MX35 3stack: Add sound support
      wip: ASoC: imx-ssi: Fix occasional AC97 reset failure
      mxcmmc: use new dma api
      ARM MX51 babbage: Add sound support
      update mx51_defconfig (with sound for i.MX51 babbage)
      update mx3_defconfig (with sound for i.MX35 3ds)

Uwe Kleine-K?nig (2):
      ARM: imx: microoptimize ssi fiq handler
      ASoC: imx-ssi: instrument register accesses

 arch/arm/configs/mx3_defconfig               |   67 ++-
 arch/arm/configs/mx51_defconfig              |   61 ++-
 arch/arm/mach-imx/mach-pcm038.c              |   24 +-
 arch/arm/mach-mx3/clock-imx35.c              |    5 +
 arch/arm/mach-mx3/devices.c                  |    8 +
 arch/arm/mach-mx3/mach-mx35_3ds.c            |   51 ++
 arch/arm/mach-mx3/mach-pcm037.c              |   67 ++
 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c       |   40 ++
 arch/arm/plat-mxc/devices/platform-imx-dma.c |  104 +++-
 arch/arm/plat-mxc/include/mach/mx31.h        |   13 +
 arch/arm/plat-mxc/include/mach/mx35.h        |   25 +
 arch/arm/plat-mxc/include/mach/mx3x.h        |   29 +
 arch/arm/plat-mxc/include/mach/sdma.h        |   46 ++
 arch/arm/plat-mxc/ssi-fiq.S                  |   10 +-
 drivers/base/firmware_class.c                |    2 +-
 drivers/dma/imx-sdma.c                       |  174 +++---
 drivers/mmc/host/mxcmmc.c                    |  172 +++--
 sound/soc/codecs/Kconfig                     |   11 +
 sound/soc/codecs/Makefile                    |    6 +
 sound/soc/codecs/bluetooth.c                 |  156 +++++
 sound/soc/codecs/mc13783.c                   |  656 ++++++++++++++++++
 sound/soc/codecs/mc13783.h                   |   29 +
 sound/soc/codecs/sgtl5000.c                  |  953 ++++++++++++++++++++++++++
 sound/soc/codecs/sgtl5000.h                  |  396 +++++++++++
 sound/soc/imx/Kconfig                        |   24 +
 sound/soc/imx/Makefile                       |    4 +
 sound/soc/imx/imx-pcm-dma-mx2.c              |    5 +
 sound/soc/imx/imx-pcm-fiq.c                  |    2 +-
 sound/soc/imx/imx-sgtl5000.c                 |  287 ++++++++
 sound/soc/imx/imx-ssi.c                      |  124 ++--
 sound/soc/imx/phycore-mc13783.c              |  152 ++++
 sound/soc/imx/wm1133-ev1.c                   |    4 +
 33 files changed, 3447 insertions(+), 261 deletions(-)
 create mode 100644 sound/soc/codecs/bluetooth.c
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/codecs/sgtl5000.c
 create mode 100644 sound/soc/codecs/sgtl5000.h
 create mode 100644 sound/soc/imx/imx-sgtl5000.c
 create mode 100644 sound/soc/imx/phycore-mc13783.c

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

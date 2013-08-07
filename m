From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:49 +0200
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
Message-ID: <1375889649-14638-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been working on teaching the mmp-pdma driver more functions and
porting tree-wide scattered pxa specific drivers over to dmaengine
implementations. I posted the first round of patches for mmp-pdma here:

  http://marc.info/?l=linux-arm-kernel&m=137587082530228


With the following patches applied, I can boot a PXA3xx board boot with
all DMA runtime information determined from DT, using pxa3xx-nand,
pxamci and audio components (cyclic DMA).

However, the transition is quite intrusive and spans across several
subsystem, and due to the nature of the current pxa DMA implementation,
it cannot be gap-less. All drivers currently request an exclusive
channel via code in arch/arm/plat-pxa/dma.c and then do direct register
modifications regarding their obtained channel. We can't allow this
with the mmp-pdma driver of course, and I also have no idea how to
provide sane stubs for the existing hooks which end up in dmaengine
calls.

Hence, all drivers have to be ported over in one series, and all these
changes should be merged by one pull request eventually in order to
prevent both build and functional breakage. Haojian's repository seems
most suitable for that, as he's the PXA maintainer.

What I currently got with respect to existing drivers is the following:

 * pxa3xx-nand:
     ported (with an amended and rebased patch from Zhangfei Gao)
     and successfully tested.

 * pxamci (mmc):
     ported and successfully tested

 * pxa-pcm-lib (audio) and pxa-ssp:
     ported and successfully tested

 * spi:
     Code to make this driver compatible with dmaengine was already
     provided by Mika Westerberg, so we can now just purge the legacy
     bits. I personally only compile-tested this one.

 * pxa-serial:
     #if0'ed legacy was removed that wouldn't even compile when
     enabled. This can be re-done at some point if anyone's interested.

 * pata-pxa:
     I ported the driver over which was simple and straight forward,
     but I lack hardware to actually test it. Maybe Marek Vasut, the
     original author can help here?

 * pxaficp_ir (IRDA):
     I also ported this driver, but I can't test it either. Someone
     with access to hardware would greatly help here with a quick test.

 * smsc911x:
     There are three(!) SMSC 911x driver in the tree right now, and two
     of them have code for PXA-DMA. I'm not sure which of these are
     actually actively used in DMA mode, but I blindly ported over the
     code and compile-tested it.

 * camera driver:
     I started the transition, but I'm not sure how much sense that
     makes without access to the hardware. I'd much appreciate if
     anyone could volunteer for this piece; I'll happily share what
     I got so far. Sascha, Sachin, Guennadi?


So, to summarize: pata-pxa, pxaficp_ir and smsc911x need testing,
and the camera driver still needs to be ported.


The transition path of my patch set is as follows:

 1. port over all the drivers individually, breaking them functionally
    because at runtime, they DMA channel allocation will fail. But they
    will compile.

 2. remove the init calls to the dma subsystem in both mach-pxa and
    mach-mmp (mach-mmp was only compile-tested) and instanciate the
    mmp-pdma device as regular platform_device.

 3. remove the old implementation including its header file that has
    served us so well for 12+ years. Sorry, Nicolas ;)

Regarding the procedure, my proposal is that many people give 
their Tested-by and Acked-by, I'll respin my series a couple of times
and eventually Haojian can take it.

Prerequisities:

  * Linux-3.11-rc4
  * Ezequiel Garcia's pxa3xx-patches:
	http://lists.infradead.org/pipermail/linux-mtd/2013-August/047862.html
  * My mmp-pdma patches:
	http://marc.info/?l=linux-arm-kernel&m=137587082530228

FWIW, the patches can also be found in this tree, but be aware that I
will rebase the commits frequently:

  https://github.com/zonque/linux/commits/pxa-dma



Thanks,
Daniel


Daniel Mack (19):
  mtd: pxa3xx-nand: use mmp_pdma_filter_fn and
    dma_request_slave_channel_compat
  ARM: pxa: ssp: add shortcut for &pdev->dev
  ARM: pxa: ssp: add DT bindings
  ARM: pxa: ssp: use devm_ functions
  tty: serial: pxa: remove old cruft
  spi: spi-pxa2xx: remove legacy PXA DMA bits
  mmc: host: pxamci: switch over to dmaengine use
  ata: pdata_pxa: migrate over to dmaengine usage
  net: irda: pxaficp_ir: switch to dmaengine
  net: smc91x.c: switch to generic buf-to-buf DMA offload
  net: smc911x.c: switch to dmaengine API
  ASoC: pxa: pxa-ssp: add DT bindings
  ASoC: pxa: use snd_dmaengine_dai_dma_data
  ASoC: pxa: pxa-ssp: set dma filter data from startup hook
  ASoC: pxa: add DT bindings for pxa2xx-pcm
  ASoC: pxa: pxa-pcm-lib: switch over to snd-soc-dmaengine-pcm
  ARM: pxa: register static mmp_pdma device
  ARM: mmp: register static mmp_pdma device
  ARM: pxa: remove old DMA implementation

Zhangfei Gao (1):
  mtd: pxa3xx-nand: replace pxa_request_dma with dmaengine

 .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    |  43 ++
 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     |   7 +
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt  |  15 +
 arch/arm/mach-mmp/mmp2.c                           |  11 +-
 arch/arm/mach-mmp/pxa168.c                         |  11 +-
 arch/arm/mach-mmp/pxa910.c                         |  11 +-
 arch/arm/mach-pxa/devices.c                        |  26 ++
 arch/arm/mach-pxa/devices.h                        |   1 +
 arch/arm/mach-pxa/include/mach/dma.h               |  21 -
 arch/arm/mach-pxa/pxa25x.c                         |   9 +-
 arch/arm/mach-pxa/pxa27x.c                         |   9 +-
 arch/arm/mach-pxa/pxa3xx.c                         |  11 +-
 arch/arm/plat-pxa/Makefile                         |   2 -
 arch/arm/plat-pxa/dma.c                            | 391 ----------------
 arch/arm/plat-pxa/include/plat/dma.h               |  85 ----
 arch/arm/plat-pxa/ssp.c                            | 144 +++---
 drivers/ata/pata_pxa.c                             | 172 +++-----
 drivers/mmc/host/pxamci.c                          | 188 ++++----
 drivers/mtd/nand/pxa3xx_nand.c                     | 130 +++---
 drivers/net/ethernet/smsc/smc911x.c                |  80 ++--
 drivers/net/ethernet/smsc/smc911x.h                |  83 ++--
 drivers/net/ethernet/smsc/smc91x.c                 |  40 +-
 drivers/net/ethernet/smsc/smc91x.h                 |  71 ++-
 drivers/net/irda/pxaficp_ir.c                      | 242 ++++++----
 drivers/spi/Kconfig                                |   9 +-
 drivers/spi/Makefile                               |   1 -
 drivers/spi/spi-pxa2xx-pxadma.c                    | 490 ---------------------
 drivers/spi/spi-pxa2xx.h                           |   6 +-
 drivers/tty/serial/pxa.c                           |  25 --
 include/linux/spi/pxa2xx_spi.h                     |   1 -
 include/sound/pxa2xx-lib.h                         |   8 -
 sound/arm/Kconfig                                  |   1 +
 sound/arm/pxa2xx-ac97.c                            |  26 +-
 sound/arm/pxa2xx-pcm-lib.c                         | 177 ++------
 sound/arm/pxa2xx-pcm.c                             |  15 +-
 sound/arm/pxa2xx-pcm.h                             |   9 +-
 sound/soc/pxa/mmp-pcm.c                            |   8 +-
 sound/soc/pxa/mmp-sspa.c                           |  11 +-
 sound/soc/pxa/pxa-ssp.c                            |  51 ++-
 sound/soc/pxa/pxa2xx-ac97.c                        |  67 +--
 sound/soc/pxa/pxa2xx-i2s.c                         |  28 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |  43 +-
 42 files changed, 921 insertions(+), 1858 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
 delete mode 100644 arch/arm/mach-pxa/include/mach/dma.h
 delete mode 100644 arch/arm/plat-pxa/dma.c
 delete mode 100644 arch/arm/plat-pxa/include/plat/dma.h
 delete mode 100644 drivers/spi/spi-pxa2xx-pxadma.c

-- 
1.8.3.1

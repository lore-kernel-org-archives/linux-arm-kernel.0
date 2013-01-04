From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  4 Jan 2013 11:47:05 -0700
Subject: [GIT PULL] ARM/...: timer and clock events cleanup,
 and remove struct sys_timer
Message-ID: <1357325225-28074-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains a number of cleanups and unifications to various
timer- clock-events- and ARM timer code. The main points are:

1) Convert arch_gettimeoffset to a pointer, so that architectures with
   multiple timer implementations can simply set this standard pointer
   rather than maintaining their own arch-specific pointers for the
   same purpose. Various architectures are converted to using this new
   feature.

2) Conversion of ARM timer implementations to use clock_event_devices's
   suspend/resume operations, rather than the ARM-specific sys_timer
   versions. Thus, the ARM code begins to use more common infra-structure
   rather than arch-specific code.

3) Removal of ARM's struct sys_timer completely, now that everything uses
   common code.

4) Introduction of drivers/clocksource/clksrc-of.c, which allows ARM clock
   source implementations to be moved into drivers/clocksource, with the
   need to add SoC-specific header files for each timer initialization
   function; instead, all enabled implementations are registered into a
   table which a single core function iterates over, and calls the
   relevant initialization functions based on device tree. At least the
   Tegra and BCM2835 clocksource implementations will use this feature in
   the 3.9 kernel cycle.

Note: The idea here is to get this series into arm-soc nice and early for
3.9, so that others can build branches on top of it. I've had it in
linux-next for a couple of days via the Tegra tree, without any apparent
issue.

----------------------------------------------------------------

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git swarren-for-3.9-arm-timer-rework

for you to fetch changes up to ae278a935f086775e8ae31a8ec9f7224ea25ea3c:

  clocksource: add common of_clksrc_init() function

----------------------------------------------------------------

Stephen Warren (12):
      cris: move usec/nsec conversion to do_slow_gettimeoffset
      time: convert arch_gettimeoffset to a pointer
      m68k: set arch_gettimeoffset directly
      ARM: set arch_gettimeoffset directly
      ARM: at91: convert timer suspend/resume to clock_event_device
      ARM: pxa: convert timer suspend/resume to clock_event_device
      ARM: sa1100: convert timer suspend/resume to clock_event_device
      ARM: ux500: convert timer suspend/resume to clock_event_device
      ARM: samsung: register syscore_ops for timer resume directly
      ARM: remove struct sys_timer suspend and resume fields
      ARM: delete struct sys_timer
      clocksource: add common of_clksrc_init() function

 arch/arm/include/asm/mach/arch.h               |    3 +-
 arch/arm/include/asm/mach/time.h               |   30 -------
 arch/arm/kernel/time.c                         |   53 +-----------
 arch/arm/mach-at91/at91rm9200_time.c           |    5 --
 arch/arm/mach-at91/at91sam926x_time.c          |   53 ++++++------
 arch/arm/mach-at91/at91x40_time.c              |   13 ++-
 arch/arm/mach-at91/board-1arm.c                |    2 +-
 arch/arm/mach-at91/board-afeb-9260v1.c         |    2 +-
 arch/arm/mach-at91/board-cam60.c               |    2 +-
 arch/arm/mach-at91/board-carmeva.c             |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c            |    2 +-
 arch/arm/mach-at91/board-cpuat91.c             |    2 +-
 arch/arm/mach-at91/board-csb337.c              |    2 +-
 arch/arm/mach-at91/board-csb637.c              |    2 +-
 arch/arm/mach-at91/board-dt.c                  |    2 +-
 arch/arm/mach-at91/board-eb01.c                |    2 +-
 arch/arm/mach-at91/board-eb9200.c              |    2 +-
 arch/arm/mach-at91/board-ecbat91.c             |    2 +-
 arch/arm/mach-at91/board-eco920.c              |    2 +-
 arch/arm/mach-at91/board-flexibity.c           |    2 +-
 arch/arm/mach-at91/board-foxg20.c              |    2 +-
 arch/arm/mach-at91/board-gsia18s.c             |    2 +-
 arch/arm/mach-at91/board-kafa.c                |    2 +-
 arch/arm/mach-at91/board-kb9202.c              |    2 +-
 arch/arm/mach-at91/board-neocore926.c          |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c        |    2 +-
 arch/arm/mach-at91/board-picotux200.c          |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c           |    2 +-
 arch/arm/mach-at91/board-rm9200dk.c            |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c            |    2 +-
 arch/arm/mach-at91/board-rsi-ews.c             |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c          |    2 +-
 arch/arm/mach-at91/board-sam9260ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9261ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9263ek.c           |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c           |    4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c            |    2 +-
 arch/arm/mach-at91/board-snapper9260.c         |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c           |    4 +-
 arch/arm/mach-at91/board-usb-a926x.c           |    6 +-
 arch/arm/mach-at91/board-yl-9200.c             |    2 +-
 arch/arm/mach-at91/generic.h                   |    7 +-
 arch/arm/mach-bcm/board_bcm.c                  |    6 +-
 arch/arm/mach-bcm2835/bcm2835.c                |    2 +-
 arch/arm/mach-clps711x/board-autcpu12.c        |    2 +-
 arch/arm/mach-clps711x/board-cdb89712.c        |    2 +-
 arch/arm/mach-clps711x/board-clep7312.c        |    2 +-
 arch/arm/mach-clps711x/board-edb7211.c         |    2 +-
 arch/arm/mach-clps711x/board-fortunet.c        |    2 +-
 arch/arm/mach-clps711x/board-p720t.c           |    2 +-
 arch/arm/mach-clps711x/common.c                |    6 +-
 arch/arm/mach-clps711x/common.h                |    4 +-
 arch/arm/mach-cns3xxx/cns3420vb.c              |    2 +-
 arch/arm/mach-cns3xxx/core.c                   |    6 +-
 arch/arm/mach-cns3xxx/core.h                   |    2 +-
 arch/arm/mach-davinci/board-da830-evm.c        |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c    |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c       |    4 +-
 arch/arm/mach-davinci/board-mityomapl138.c     |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c      |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c           |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    2 +-
 arch/arm/mach-davinci/da8xx-dt.c               |    2 +-
 arch/arm/mach-davinci/include/mach/common.h    |    4 +-
 arch/arm/mach-davinci/time.c                   |    7 +-
 arch/arm/mach-dove/cm-a510.c                   |    2 +-
 arch/arm/mach-dove/common.c                    |    8 +-
 arch/arm/mach-dove/common.h                    |    2 +-
 arch/arm/mach-dove/dove-db-setup.c             |    2 +-
 arch/arm/mach-ebsa110/core.c                   |   15 ++--
 arch/arm/mach-ep93xx/adssphere.c               |    2 +-
 arch/arm/mach-ep93xx/core.c                    |   35 ++++----
 arch/arm/mach-ep93xx/edb93xx.c                 |   16 ++--
 arch/arm/mach-ep93xx/gesbc9312.c               |    2 +-
 arch/arm/mach-ep93xx/include/mach/platform.h   |    2 +-
 arch/arm/mach-ep93xx/micro9.c                  |    8 +-
 arch/arm/mach-ep93xx/simone.c                  |    2 +-
 arch/arm/mach-ep93xx/snappercl15.c             |    2 +-
 arch/arm/mach-ep93xx/ts72xx.c                  |    2 +-
 arch/arm/mach-ep93xx/vision_ep9307.c           |    2 +-
 arch/arm/mach-exynos/common.h                  |    2 +-
 arch/arm/mach-exynos/mach-armlex4210.c         |    2 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c         |    2 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    2 +-
 arch/arm/mach-exynos/mach-nuri.c               |    2 +-
 arch/arm/mach-exynos/mach-origen.c             |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c           |    4 +-
 arch/arm/mach-exynos/mach-smdkv310.c           |    4 +-
 arch/arm/mach-exynos/mach-universal_c210.c     |    2 +-
 arch/arm/mach-exynos/mct.c                     |    6 +-
 arch/arm/mach-footbridge/cats-hw.c             |    2 +-
 arch/arm/mach-footbridge/common.h              |    4 +-
 arch/arm/mach-footbridge/dc21285-timer.c       |    6 +-
 arch/arm/mach-footbridge/ebsa285.c             |    2 +-
 arch/arm/mach-footbridge/isa-timer.c           |    6 +-
 arch/arm/mach-footbridge/netwinder-hw.c        |    2 +-
 arch/arm/mach-footbridge/personal.c            |    2 +-
 arch/arm/mach-gemini/board-nas4220b.c          |    6 +-
 arch/arm/mach-gemini/board-rut1xx.c            |    6 +-
 arch/arm/mach-gemini/board-wbd111.c            |    6 +-
 arch/arm/mach-gemini/board-wbd222.c            |    6 +-
 arch/arm/mach-h720x/common.c                   |    6 +-
 arch/arm/mach-h720x/common.h                   |    6 +-
 arch/arm/mach-h720x/cpu-h7201.c                |    9 +--
 arch/arm/mach-h720x/cpu-h7202.c                |    9 +--
 arch/arm/mach-h720x/h7201-eval.c               |    2 +-
 arch/arm/mach-h720x/h7202-eval.c               |    2 +-
 arch/arm/mach-highbank/highbank.c              |    6 +-
 arch/arm/mach-imx/imx25-dt.c                   |   11 +--
 arch/arm/mach-imx/imx27-dt.c                   |   16 ++--
 arch/arm/mach-imx/imx31-dt.c                   |   11 +--
 arch/arm/mach-imx/imx51-dt.c                   |   16 ++--
 arch/arm/mach-imx/mach-apf9328.c               |    6 +-
 arch/arm/mach-imx/mach-armadillo5x0.c          |    6 +-
 arch/arm/mach-imx/mach-bug.c                   |    6 +-
 arch/arm/mach-imx/mach-cpuimx27.c              |    6 +-
 arch/arm/mach-imx/mach-cpuimx35.c              |    6 +-
 arch/arm/mach-imx/mach-cpuimx51sd.c            |    6 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    6 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |    6 +-
 arch/arm/mach-imx/mach-imx27ipcam.c            |    6 +-
 arch/arm/mach-imx/mach-imx27lite.c             |    6 +-
 arch/arm/mach-imx/mach-imx53.c                 |   16 ++--
 arch/arm/mach-imx/mach-imx6q.c                 |    6 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c          |    6 +-
 arch/arm/mach-imx/mach-mx1ads.c                |    8 +-
 arch/arm/mach-imx/mach-mx21ads.c               |    6 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              |    6 +-
 arch/arm/mach-imx/mach-mx27_3ds.c              |    6 +-
 arch/arm/mach-imx/mach-mx27ads.c               |    6 +-
 arch/arm/mach-imx/mach-mx31_3ds.c              |    6 +-
 arch/arm/mach-imx/mach-mx31ads.c               |    6 +-
 arch/arm/mach-imx/mach-mx31lilly.c             |    6 +-
 arch/arm/mach-imx/mach-mx31lite.c              |    6 +-
 arch/arm/mach-imx/mach-mx31moboard.c           |    6 +-
 arch/arm/mach-imx/mach-mx35_3ds.c              |    6 +-
 arch/arm/mach-imx/mach-mx50_rdp.c              |    6 +-
 arch/arm/mach-imx/mach-mx51_3ds.c              |    6 +-
 arch/arm/mach-imx/mach-mx51_babbage.c          |    6 +-
 arch/arm/mach-imx/mach-mxt_td60.c              |    6 +-
 arch/arm/mach-imx/mach-pca100.c                |    6 +-
 arch/arm/mach-imx/mach-pcm037.c                |    6 +-
 arch/arm/mach-imx/mach-pcm038.c                |    6 +-
 arch/arm/mach-imx/mach-pcm043.c                |    6 +-
 arch/arm/mach-imx/mach-qong.c                  |    6 +-
 arch/arm/mach-imx/mach-scb9328.c               |    6 +-
 arch/arm/mach-imx/mach-vpr200.c                |    6 +-
 arch/arm/mach-integrator/integrator_ap.c       |   16 +---
 arch/arm/mach-integrator/integrator_cp.c       |   16 +---
 arch/arm/mach-iop13xx/iq81340mc.c              |    6 +-
 arch/arm/mach-iop13xx/iq81340sc.c              |    6 +-
 arch/arm/mach-iop32x/em7210.c                  |    6 +-
 arch/arm/mach-iop32x/glantank.c                |    6 +-
 arch/arm/mach-iop32x/iq31244.c                 |    8 +-
 arch/arm/mach-iop32x/iq80321.c                 |    6 +-
 arch/arm/mach-iop32x/n2100.c                   |    6 +-
 arch/arm/mach-iop33x/iq80331.c                 |    6 +-
 arch/arm/mach-iop33x/iq80332.c                 |    6 +-
 arch/arm/mach-ixp4xx/avila-setup.c             |    4 +-
 arch/arm/mach-ixp4xx/common.c                  |    4 -
 arch/arm/mach-ixp4xx/coyote-setup.c            |    4 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c           |    6 +-
 arch/arm/mach-ixp4xx/fsg-setup.c               |    2 +-
 arch/arm/mach-ixp4xx/gateway7001-setup.c       |    2 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c              |    2 +-
 arch/arm/mach-ixp4xx/gtwx5715-setup.c          |    2 +-
 arch/arm/mach-ixp4xx/include/mach/platform.h   |    3 -
 arch/arm/mach-ixp4xx/ixdp425-setup.c           |    8 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c           |    2 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c             |    6 +-
 arch/arm/mach-ixp4xx/omixp-setup.c             |    6 +-
 arch/arm/mach-ixp4xx/vulcan-setup.c            |    2 +-
 arch/arm/mach-ixp4xx/wg302v2-setup.c           |    2 +-
 arch/arm/mach-kirkwood/board-dt.c              |    2 +-
 arch/arm/mach-kirkwood/common.c                |    6 +-
 arch/arm/mach-kirkwood/common.h                |    2 +-
 arch/arm/mach-kirkwood/d2net_v2-setup.c        |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    2 +-
 arch/arm/mach-kirkwood/dockstar-setup.c        |    2 +-
 arch/arm/mach-kirkwood/guruplug-setup.c        |    2 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    6 +-
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    4 +-
 arch/arm/mach-kirkwood/openrd-setup.c          |    6 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |    2 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c      |    4 +-
 arch/arm/mach-kirkwood/t5325-setup.c           |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c           |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c           |    2 +-
 arch/arm/mach-ks8695/board-acs5k.c             |    2 +-
 arch/arm/mach-ks8695/board-dsm320.c            |    2 +-
 arch/arm/mach-ks8695/board-micrel.c            |    2 +-
 arch/arm/mach-ks8695/board-og.c                |   10 +--
 arch/arm/mach-ks8695/board-sg.c                |    6 +-
 arch/arm/mach-ks8695/generic.h                 |    2 +-
 arch/arm/mach-ks8695/time.c                    |    6 +-
 arch/arm/mach-lpc32xx/common.h                 |    2 +-
 arch/arm/mach-lpc32xx/phy3250.c                |    2 +-
 arch/arm/mach-lpc32xx/timer.c                  |    7 +-
 arch/arm/mach-mmp/aspenite.c                   |    4 +-
 arch/arm/mach-mmp/avengers_lite.c              |    2 +-
 arch/arm/mach-mmp/brownstone.c                 |    2 +-
 arch/arm/mach-mmp/common.h                     |    2 -
 arch/arm/mach-mmp/flint.c                      |    2 +-
 arch/arm/mach-mmp/gplugd.c                     |    2 +-
 arch/arm/mach-mmp/include/mach/mmp2.h          |    4 +-
 arch/arm/mach-mmp/include/mach/pxa168.h        |    4 +-
 arch/arm/mach-mmp/include/mach/pxa910.h        |    4 +-
 arch/arm/mach-mmp/jasper.c                     |    2 +-
 arch/arm/mach-mmp/mmp-dt.c                     |    8 +-
 arch/arm/mach-mmp/mmp2-dt.c                    |    6 +-
 arch/arm/mach-mmp/mmp2.c                       |    6 +-
 arch/arm/mach-mmp/pxa168.c                     |    6 +-
 arch/arm/mach-mmp/pxa910.c                     |    6 +-
 arch/arm/mach-mmp/tavorevb.c                   |    2 +-
 arch/arm/mach-mmp/teton_bga.c                  |    2 +-
 arch/arm/mach-mmp/ttc_dkb.c                    |    2 +-
 arch/arm/mach-msm/board-dt-8660.c              |    2 +-
 arch/arm/mach-msm/board-dt-8960.c              |    2 +-
 arch/arm/mach-msm/board-halibut.c              |    2 +-
 arch/arm/mach-msm/board-mahimahi.c             |    4 +-
 arch/arm/mach-msm/board-msm7x30.c              |    6 +-
 arch/arm/mach-msm/board-qsd8x50.c              |    4 +-
 arch/arm/mach-msm/board-sapphire.c             |    4 +-
 arch/arm/mach-msm/board-trout.c                |    2 +-
 arch/arm/mach-msm/common.h                     |    8 +-
 arch/arm/mach-msm/timer.c                      |   24 +-----
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c      |    2 +-
 arch/arm/mach-mv78xx0/common.c                 |    6 +-
 arch/arm/mach-mv78xx0/common.h                 |    2 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c       |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c     |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c            |    6 +-
 arch/arm/mach-mxs/mach-mxs.c                   |   12 +--
 arch/arm/mach-netx/generic.h                   |    3 +-
 arch/arm/mach-netx/nxdb500.c                   |    2 +-
 arch/arm/mach-netx/nxdkn.c                     |    2 +-
 arch/arm/mach-netx/nxeb500hmi.c                |    2 +-
 arch/arm/mach-netx/time.c                      |    6 +-
 arch/arm/mach-nomadik/board-nhk8815.c          |    6 +-
 arch/arm/mach-omap1/board-ams-delta.c          |    2 +-
 arch/arm/mach-omap1/board-fsample.c            |    2 +-
 arch/arm/mach-omap1/board-generic.c            |    2 +-
 arch/arm/mach-omap1/board-h2.c                 |    2 +-
 arch/arm/mach-omap1/board-h3.c                 |    2 +-
 arch/arm/mach-omap1/board-htcherald.c          |    2 +-
 arch/arm/mach-omap1/board-innovator.c          |    2 +-
 arch/arm/mach-omap1/board-nokia770.c           |    2 +-
 arch/arm/mach-omap1/board-osk.c                |    2 +-
 arch/arm/mach-omap1/board-palmte.c             |    2 +-
 arch/arm/mach-omap1/board-palmtt.c             |    2 +-
 arch/arm/mach-omap1/board-palmz71.c            |    2 +-
 arch/arm/mach-omap1/board-perseus2.c           |    2 +-
 arch/arm/mach-omap1/board-sx1.c                |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c          |    2 +-
 arch/arm/mach-omap1/common.h                   |    2 +-
 arch/arm/mach-omap1/time.c                     |    6 +-
 arch/arm/mach-omap2/board-2430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c            |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c        |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c            |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c             |    4 +-
 arch/arm/mach-omap2/board-cm-t3517.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c         |    2 +-
 arch/arm/mach-omap2/board-generic.c            |   14 ++--
 arch/arm/mach-omap2/board-h4.c                 |    2 +-
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-ldp.c                |    2 +-
 arch/arm/mach-omap2/board-n8x0.c               |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c        |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c           |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c         |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c       |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c       |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c         |    2 +-
 arch/arm/mach-omap2/board-overo.c              |    2 +-
 arch/arm/mach-omap2/board-rm680.c              |    4 +-
 arch/arm/mach-omap2/board-rx51.c               |    2 +-
 arch/arm/mach-omap2/board-ti8168evm.c          |    4 +-
 arch/arm/mach-omap2/board-zoom.c               |    4 +-
 arch/arm/mach-omap2/common.h                   |   14 ++--
 arch/arm/mach-omap2/timer.c                    |   22 ++---
 arch/arm/mach-orion5x/board-dt.c               |    2 +-
 arch/arm/mach-orion5x/common.c                 |    6 +-
 arch/arm/mach-orion5x/common.h                 |    2 +-
 arch/arm/mach-orion5x/d2net-setup.c            |    4 +-
 arch/arm/mach-orion5x/db88f5281-setup.c        |    2 +-
 arch/arm/mach-orion5x/dns323-setup.c           |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |    4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c           |    2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c           |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c           |    2 +-
 arch/arm/mach-orion5x/mss2-setup.c             |    2 +-
 arch/arm/mach-orion5x/mv2120-setup.c           |    2 +-
 arch/arm/mach-orion5x/net2big-setup.c          |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c        |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c |    2 +-
 arch/arm/mach-orion5x/ts209-setup.c            |    2 +-
 arch/arm/mach-orion5x/ts409-setup.c            |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c          |    2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    2 +-
 arch/arm/mach-picoxcell/common.c               |    2 +-
 arch/arm/mach-picoxcell/common.h               |    2 +-
 arch/arm/mach-prima2/common.c                  |    2 +-
 arch/arm/mach-prima2/common.h                  |    2 +-
 arch/arm/mach-prima2/timer.c                   |    8 +-
 arch/arm/mach-pxa/balloon3.c                   |    2 +-
 arch/arm/mach-pxa/capc7117.c                   |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c                    |    2 +-
 arch/arm/mach-pxa/cm-x300.c                    |    2 +-
 arch/arm/mach-pxa/colibri-pxa270.c             |    4 +-
 arch/arm/mach-pxa/colibri-pxa300.c             |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c             |    2 +-
 arch/arm/mach-pxa/corgi.c                      |    6 +-
 arch/arm/mach-pxa/csb726.c                     |    2 +-
 arch/arm/mach-pxa/em-x270.c                    |    4 +-
 arch/arm/mach-pxa/eseries.c                    |   12 +--
 arch/arm/mach-pxa/ezx.c                        |   12 +--
 arch/arm/mach-pxa/generic.h                    |    3 +-
 arch/arm/mach-pxa/gumstix.c                    |    2 +-
 arch/arm/mach-pxa/h5000.c                      |    2 +-
 arch/arm/mach-pxa/himalaya.c                   |    2 +-
 arch/arm/mach-pxa/hx4700.c                     |    2 +-
 arch/arm/mach-pxa/icontrol.c                   |    2 +-
 arch/arm/mach-pxa/idp.c                        |    2 +-
 arch/arm/mach-pxa/littleton.c                  |    2 +-
 arch/arm/mach-pxa/lpd270.c                     |    2 +-
 arch/arm/mach-pxa/lubbock.c                    |    2 +-
 arch/arm/mach-pxa/magician.c                   |    2 +-
 arch/arm/mach-pxa/mainstone.c                  |    2 +-
 arch/arm/mach-pxa/mioa701.c                    |    2 +-
 arch/arm/mach-pxa/mp900.c                      |    2 +-
 arch/arm/mach-pxa/palmld.c                     |    2 +-
 arch/arm/mach-pxa/palmt5.c                     |    2 +-
 arch/arm/mach-pxa/palmtc.c                     |    2 +-
 arch/arm/mach-pxa/palmte2.c                    |    2 +-
 arch/arm/mach-pxa/palmtreo.c                   |    4 +-
 arch/arm/mach-pxa/palmtx.c                     |    2 +-
 arch/arm/mach-pxa/palmz72.c                    |    2 +-
 arch/arm/mach-pxa/pcm027.c                     |    2 +-
 arch/arm/mach-pxa/poodle.c                     |    2 +-
 arch/arm/mach-pxa/pxa-dt.c                     |    2 +-
 arch/arm/mach-pxa/raumfeld.c                   |    6 +-
 arch/arm/mach-pxa/saar.c                       |    2 +-
 arch/arm/mach-pxa/spitz.c                      |    6 +-
 arch/arm/mach-pxa/stargate2.c                  |    4 +-
 arch/arm/mach-pxa/tavorevb.c                   |    2 +-
 arch/arm/mach-pxa/time.c                       |   80 +++++++++----------
 arch/arm/mach-pxa/tosa.c                       |    2 +-
 arch/arm/mach-pxa/trizeps4.c                   |    4 +-
 arch/arm/mach-pxa/viper.c                      |    2 +-
 arch/arm/mach-pxa/vpac270.c                    |    2 +-
 arch/arm/mach-pxa/xcep.c                       |    2 +-
 arch/arm/mach-pxa/z2.c                         |    2 +-
 arch/arm/mach-pxa/zeus.c                       |    2 +-
 arch/arm/mach-pxa/zylonite.c                   |    2 +-
 arch/arm/mach-realview/realview_eb.c           |    6 +-
 arch/arm/mach-realview/realview_pb1176.c       |    6 +-
 arch/arm/mach-realview/realview_pb11mp.c       |    6 +-
 arch/arm/mach-realview/realview_pba8.c         |    6 +-
 arch/arm/mach-realview/realview_pbx.c          |    6 +-
 arch/arm/mach-rpc/riscpc.c                     |    4 +-
 arch/arm/mach-rpc/time.c                       |   13 +--
 arch/arm/mach-s3c24xx/mach-amlm5900.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c         |    2 +-
 arch/arm/mach-s3c24xx/mach-bast.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c             |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c             |    2 +-
 arch/arm/mach-s3c24xx/mach-jive.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-n30.c               |    4 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-otom.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c          |    6 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c        |    2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c             |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c          |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c          |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c          |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c          |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c            |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c              |    2 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c          |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c          |    2 +-
 arch/arm/mach-s5pv210/mach-torbreck.c          |    2 +-
 arch/arm/mach-sa1100/assabet.c                 |    2 +-
 arch/arm/mach-sa1100/badge4.c                  |    2 +-
 arch/arm/mach-sa1100/cerf.c                    |    2 +-
 arch/arm/mach-sa1100/collie.c                  |    2 +-
 arch/arm/mach-sa1100/generic.h                 |    4 +-
 arch/arm/mach-sa1100/h3100.c                   |    2 +-
 arch/arm/mach-sa1100/h3600.c                   |    2 +-
 arch/arm/mach-sa1100/hackkit.c                 |    2 +-
 arch/arm/mach-sa1100/jornada720.c              |    2 +-
 arch/arm/mach-sa1100/lart.c                    |    2 +-
 arch/arm/mach-sa1100/nanoengine.c              |    2 +-
 arch/arm/mach-sa1100/pleb.c                    |    2 +-
 arch/arm/mach-sa1100/shannon.c                 |    2 +-
 arch/arm/mach-sa1100/simpad.c                  |    2 +-
 arch/arm/mach-sa1100/time.c                    |   72 ++++++++---------
 arch/arm/mach-shark/core.c                     |    6 +-
 arch/arm/mach-shmobile/board-ag5evm.c          |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |    2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    5 +-
 arch/arm/mach-shmobile/board-bonito.c          |    5 +-
 arch/arm/mach-shmobile/board-kota2.c           |    2 +-
 arch/arm/mach-shmobile/board-kzm9d.c           |    2 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c        |    2 +-
 arch/arm/mach-shmobile/board-marzen.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h   |    5 +-
 arch/arm/mach-shmobile/setup-emev2.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c         |   11 +--
 arch/arm/mach-shmobile/setup-r8a7779.c         |    5 +-
 arch/arm/mach-shmobile/setup-sh7372.c          |    7 +-
 arch/arm/mach-shmobile/setup-sh73a0.c          |    5 +-
 arch/arm/mach-shmobile/timer.c                 |    6 +-
 arch/arm/mach-socfpga/socfpga.c                |    2 +-
 arch/arm/mach-spear13xx/include/mach/generic.h |    2 +-
 arch/arm/mach-spear13xx/spear1310.c            |    2 +-
 arch/arm/mach-spear13xx/spear1340.c            |    2 +-
 arch/arm/mach-spear13xx/spear13xx.c            |    6 +-
 arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +-
 arch/arm/mach-spear3xx/spear300.c              |    2 +-
 arch/arm/mach-spear3xx/spear310.c              |    2 +-
 arch/arm/mach-spear3xx/spear320.c              |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c              |    6 +-
 arch/arm/mach-spear6xx/spear6xx.c              |    8 +-
 arch/arm/mach-tegra/board-dt-tegra20.c         |    2 +-
 arch/arm/mach-tegra/board-dt-tegra30.c         |    2 +-
 arch/arm/mach-tegra/board.h                    |    2 +-
 arch/arm/mach-tegra/timer.c                    |    6 +-
 arch/arm/mach-u300/core.c                      |    2 +-
 arch/arm/mach-u300/timer.c                     |   10 +--
 arch/arm/mach-u300/timer.h                     |    2 +-
 arch/arm/mach-ux500/board-mop500.c             |    8 +-
 arch/arm/mach-ux500/cpu-db8500.c               |    2 +-
 arch/arm/mach-ux500/include/mach/setup.h       |    3 +-
 arch/arm/mach-ux500/timer.c                    |   13 +--
 arch/arm/mach-versatile/core.c                 |    7 +-
 arch/arm/mach-versatile/core.h                 |    2 +-
 arch/arm/mach-versatile/versatile_ab.c         |    2 +-
 arch/arm/mach-versatile/versatile_dt.c         |    2 +-
 arch/arm/mach-versatile/versatile_pb.c         |    2 +-
 arch/arm/mach-vexpress/v2m.c                   |   12 +--
 arch/arm/mach-vt8500/vt8500.c                  |    6 +-
 arch/arm/mach-w90x900/mach-nuc910evb.c         |    2 +-
 arch/arm/mach-w90x900/mach-nuc950evb.c         |    2 +-
 arch/arm/mach-w90x900/mach-nuc960evb.c         |    2 +-
 arch/arm/mach-w90x900/nuc9xx.h                 |    3 +-
 arch/arm/mach-w90x900/time.c                   |    6 +-
 arch/arm/mach-zynq/common.c                    |    9 +--
 arch/arm/plat-samsung/include/plat/cpu.h       |    3 +-
 arch/arm/plat-samsung/include/plat/s5p-time.h  |    2 +-
 arch/arm/plat-samsung/s5p-time.c               |    6 +-
 arch/arm/plat-samsung/time.c                   |   20 ++---
 arch/blackfin/kernel/time.c                    |    6 +-
 arch/cris/arch-v10/kernel/time.c               |   10 ++-
 arch/cris/kernel/time.c                        |   11 ---
 arch/m32r/kernel/time.c                        |    4 +-
 arch/m68k/amiga/config.c                       |   10 +--
 arch/m68k/apollo/config.c                      |    9 +--
 arch/m68k/atari/config.c                       |    4 +-
 arch/m68k/atari/time.c                         |    6 +-
 arch/m68k/bvme6000/config.c                    |   10 +--
 arch/m68k/hp300/config.c                       |    2 +-
 arch/m68k/hp300/time.c                         |    4 +-
 arch/m68k/hp300/time.h                         |    2 +-
 arch/m68k/include/asm/machdep.h                |    2 +-
 arch/m68k/kernel/setup_mm.c                    |    1 -
 arch/m68k/kernel/time.c                        |   15 ++--
 arch/m68k/mac/config.c                         |    4 +-
 arch/m68k/mac/via.c                            |    4 +-
 arch/m68k/mvme147/config.c                     |    8 +-
 arch/m68k/mvme16x/config.c                     |    8 +-
 arch/m68k/q40/config.c                         |    8 +-
 arch/m68k/sun3/config.c                        |    4 +-
 arch/m68k/sun3/intersil.c                      |    4 +-
 arch/m68k/sun3x/config.c                       |    2 +-
 arch/m68k/sun3x/time.c                         |    2 +-
 arch/m68k/sun3x/time.h                         |    2 +-
 drivers/clocksource/Kconfig                    |    3 +
 drivers/clocksource/Makefile                   |    1 +
 drivers/clocksource/bcm2835_timer.c            |    6 +-
 drivers/clocksource/clksrc-of.c                |   35 ++++++++
 drivers/clocksource/dw_apb_timer_of.c          |    6 +-
 drivers/clocksource/nomadik-mtu.c              |   33 +++++---
 drivers/clocksource/sunxi_timer.c              |    6 +-
 include/asm-generic/vmlinux.lds.h              |    9 +++
 include/linux/bcm2835_timer.h                  |    2 +-
 include/linux/clocksource.h                    |    9 +++
 include/linux/dw_apb_timer.h                   |    2 +-
 include/linux/sunxi_timer.h                    |    2 +-
 include/linux/time.h                           |    4 +-
 kernel/time/timekeeping.c                      |   26 ++++--
 529 files changed, 937 insertions(+), 1508 deletions(-)
 create mode 100644 drivers/clocksource/clksrc-of.c

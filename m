From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Apr 2012 23:38:28 +0800
Subject: [PATCH 00/17] arch/arm/mach-* late_initcall cleanup
Message-ID: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to clean up those late_initcall in arch/arm/mach-*,
which will be a blocker for single kernel build for multiple platforms.
Even on single platform, for example imx, where we already have single
kernel image for imx3, imx5 and imx6 families, late_initcall does not
scale.  We have to detect soc type in the late_initcall to do soc
sepcific late initialization.

The first patch provides a machine specific late_initcall time hook,
and the rest of the series converts the existing late_initcall in
arch/arm/mach-* to use that hook.  It touches a lot of board files,
which makes me image how the world would be beatiful if some day all
these great number of board files get killed by DT support.

With this series, there are still a couple of late_initcall remaining
in arch/arm/mach-*, but those are used to register platform driver,
which are not the case concerning us here.

Regards,
Shawn

---
Shawn Guo (17):
      ARM: provide a late_initcall hook for platform initialization
      ARM: at91: use machine specific hook for late init
      ARM: davinci: use machine specific hook for late init
      ARM: ep93xx: use machine specific hook for late init
      ARM: exynos: use machine specific hook for late init
      ARM: imx: use machine specific hook for late init
      ARM: kirkwood: use machine specific hook for late init
      ARM: msm: use machine specific hook for late init
      ARM: omap1: use machine specific hook for late init
      ARM: omap2: use machine specific hook for late init
      ARM: pnx4008: use machine specific hook for late init
      ARM: prima2: use machine specific hook for late init
      ARM: s3c64xx: use machine specific hook for late init
      ARM: sa1100: use machine specific hook for late init
      ARM: shmobile: use machine specific hook for late init
      ARM: tegra: use machine specific hook for late init
      ARM: ux500: use machine specific hook for late init

 arch/arm/include/asm/mach/arch.h               |    1 +
 arch/arm/kernel/setup.c                        |    8 +++
 arch/arm/mach-at91/board-1arm.c                |    1 +
 arch/arm/mach-at91/board-afeb-9260v1.c         |    1 +
 arch/arm/mach-at91/board-cam60.c               |    1 +
 arch/arm/mach-at91/board-carmeva.c             |    1 +
 arch/arm/mach-at91/board-cpu9krea.c            |    1 +
 arch/arm/mach-at91/board-cpuat91.c             |    1 +
 arch/arm/mach-at91/board-csb337.c              |    1 +
 arch/arm/mach-at91/board-csb637.c              |    1 +
 arch/arm/mach-at91/board-dt.c                  |    1 +
 arch/arm/mach-at91/board-eb01.c                |    1 +
 arch/arm/mach-at91/board-eb9200.c              |    1 +
 arch/arm/mach-at91/board-ecbat91.c             |    1 +
 arch/arm/mach-at91/board-eco920.c              |    1 +
 arch/arm/mach-at91/board-flexibity.c           |    1 +
 arch/arm/mach-at91/board-foxg20.c              |    1 +
 arch/arm/mach-at91/board-gsia18s.c             |    1 +
 arch/arm/mach-at91/board-kafa.c                |    1 +
 arch/arm/mach-at91/board-kb9202.c              |    1 +
 arch/arm/mach-at91/board-neocore926.c          |    1 +
 arch/arm/mach-at91/board-pcontrol-g20.c        |    1 +
 arch/arm/mach-at91/board-picotux200.c          |    1 +
 arch/arm/mach-at91/board-qil-a9260.c           |    1 +
 arch/arm/mach-at91/board-rm9200dk.c            |    1 +
 arch/arm/mach-at91/board-rm9200ek.c            |    1 +
 arch/arm/mach-at91/board-rsi-ews.c             |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c          |    1 +
 arch/arm/mach-at91/board-sam9260ek.c           |    1 +
 arch/arm/mach-at91/board-sam9261ek.c           |    1 +
 arch/arm/mach-at91/board-sam9263ek.c           |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c           |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    1 +
 arch/arm/mach-at91/board-sam9rlek.c            |    1 +
 arch/arm/mach-at91/board-snapper9260.c         |    1 +
 arch/arm/mach-at91/board-stamp9g20.c           |    1 +
 arch/arm/mach-at91/board-usb-a926x.c           |    1 +
 arch/arm/mach-at91/board-yl-9200.c             |    1 +
 arch/arm/mach-at91/clock.c                     |    3 +-
 arch/arm/mach-at91/generic.h                   |    5 ++
 arch/arm/mach-at91/setup.c                     |    5 ++
 arch/arm/mach-davinci/board-da830-evm.c        |    1 +
 arch/arm/mach-davinci/board-da850-evm.c        |    1 +
 arch/arm/mach-davinci/board-dm355-evm.c        |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c    |    1 +
 arch/arm/mach-davinci/board-dm365-evm.c        |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c       |    1 +
 arch/arm/mach-davinci/board-dm646x-evm.c       |    1 +
 arch/arm/mach-davinci/board-mityomapl138.c     |    1 +
 arch/arm/mach-davinci/board-neuros-osd2.c      |    1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    1 +
 arch/arm/mach-davinci/board-sffsdr.c           |    1 +
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    1 +
 arch/arm/mach-davinci/clock.c                  |    3 +-
 arch/arm/mach-davinci/common.c                 |    7 +++
 arch/arm/mach-davinci/cpufreq.c                |    3 +-
 arch/arm/mach-davinci/include/mach/common.h    |   19 +++++++
 arch/arm/mach-davinci/pm.c                     |    3 +-
 arch/arm/mach-ep93xx/adssphere.c               |    1 +
 arch/arm/mach-ep93xx/core.c                    |    5 ++
 arch/arm/mach-ep93xx/crunch.c                  |    4 +-
 arch/arm/mach-ep93xx/gesbc9312.c               |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h   |    7 +++
 arch/arm/mach-ep93xx/micro9.c                  |    4 ++
 arch/arm/mach-ep93xx/simone.c                  |    1 +
 arch/arm/mach-ep93xx/snappercl15.c             |    1 +
 arch/arm/mach-ep93xx/ts72xx.c                  |    1 +
 arch/arm/mach-ep93xx/vision_ep9307.c           |    1 +
 arch/arm/mach-exynos/common.c                  |    5 ++
 arch/arm/mach-exynos/common.h                  |    7 +++
 arch/arm/mach-exynos/mach-armlex4210.c         |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c         |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    1 +
 arch/arm/mach-exynos/mach-nuri.c               |    1 +
 arch/arm/mach-exynos/mach-origen.c             |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c           |    1 +
 arch/arm/mach-exynos/mach-smdkv310.c           |    1 +
 arch/arm/mach-exynos/mach-universal_c210.c     |    1 +
 arch/arm/mach-exynos/pm_domains.c              |    3 +-
 arch/arm/mach-imx/cpu-imx5.c                   |    6 +--
 arch/arm/mach-imx/imx51-dt.c                   |    1 +
 arch/arm/mach-imx/mach-cpuimx51.c              |    1 +
 arch/arm/mach-imx/mach-cpuimx51sd.c            |    1 +
 arch/arm/mach-imx/mach-mx51_3ds.c              |    1 +
 arch/arm/mach-imx/mach-mx51_babbage.c          |    1 +
 arch/arm/mach-imx/mach-mx51_efikamx.c          |   42 +++++++++-------
 arch/arm/mach-imx/mach-mx51_efikasb.c          |   28 ++++++-----
 arch/arm/mach-imx/mach-pcm037.c                |    6 ++
 arch/arm/mach-imx/mach-pcm037_eet.c            |    6 +--
 arch/arm/mach-imx/mm-imx5.c                    |    5 ++
 arch/arm/mach-imx/pcm037.h                     |    6 ++
 arch/arm/mach-kirkwood/board-dt.c              |    1 +
 arch/arm/mach-kirkwood/common.c                |    6 ++-
 arch/arm/mach-kirkwood/common.h                |    1 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c        |    1 +
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    1 +
 arch/arm/mach-kirkwood/dockstar-setup.c        |    1 +
 arch/arm/mach-kirkwood/guruplug-setup.c        |    1 +
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    3 +
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    2 +
 arch/arm/mach-kirkwood/openrd-setup.c          |    3 +
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    1 +
 arch/arm/mach-kirkwood/rd88f6281-setup.c       |    1 +
 arch/arm/mach-kirkwood/sheevaplug-setup.c      |    2 +
 arch/arm/mach-kirkwood/t5325-setup.c           |    1 +
 arch/arm/mach-kirkwood/ts219-setup.c           |    1 +
 arch/arm/mach-kirkwood/ts41x-setup.c           |    1 +
 arch/arm/mach-msm/board-halibut.c              |    7 +++
 arch/arm/mach-msm/board-mahimahi.c             |    7 +++
 arch/arm/mach-msm/board-msm7x27.c              |   10 ++++
 arch/arm/mach-msm/board-msm7x30.c              |    9 +++
 arch/arm/mach-msm/board-msm8960.c              |    8 +++
 arch/arm/mach-msm/board-msm8x60.c              |   11 ++++
 arch/arm/mach-msm/board-qsd8x50.c              |    8 +++
 arch/arm/mach-msm/board-sapphire.c             |    7 +++
 arch/arm/mach-msm/board-trout.c                |    7 +++
 arch/arm/mach-msm/clock.c                      |    4 +-
 arch/arm/mach-msm/include/mach/board.h         |    7 +++
 arch/arm/mach-msm/smd_debug.c                  |    3 +-
 arch/arm/mach-omap1/board-ams-delta.c          |    8 +++-
 arch/arm/mach-omap1/board-fsample.c            |    1 +
 arch/arm/mach-omap1/board-generic.c            |    1 +
 arch/arm/mach-omap1/board-h2.c                 |    1 +
 arch/arm/mach-omap1/board-h3.c                 |    1 +
 arch/arm/mach-omap1/board-htcherald.c          |    1 +
 arch/arm/mach-omap1/board-innovator.c          |    1 +
 arch/arm/mach-omap1/board-nokia770.c           |    1 +
 arch/arm/mach-omap1/board-osk.c                |    1 +
 arch/arm/mach-omap1/board-palmte.c             |    1 +
 arch/arm/mach-omap1/board-palmtt.c             |    1 +
 arch/arm/mach-omap1/board-palmz71.c            |    1 +
 arch/arm/mach-omap1/board-perseus2.c           |    1 +
 arch/arm/mach-omap1/board-sx1.c                |    1 +
 arch/arm/mach-omap1/board-voiceblue.c          |    1 +
 arch/arm/mach-omap1/common.h                   |   10 ++++
 arch/arm/mach-omap1/io.c                       |    5 ++
 arch/arm/mach-omap1/serial.c                   |    3 +-
 arch/arm/mach-omap2/board-2430sdp.c            |    1 +
 arch/arm/mach-omap2/board-3430sdp.c            |    1 +
 arch/arm/mach-omap2/board-3630sdp.c            |    1 +
 arch/arm/mach-omap2/board-4430sdp.c            |    1 +
 arch/arm/mach-omap2/board-am3517crane.c        |    1 +
 arch/arm/mach-omap2/board-am3517evm.c          |    1 +
 arch/arm/mach-omap2/board-apollon.c            |    1 +
 arch/arm/mach-omap2/board-cm-t35.c             |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c           |    1 +
 arch/arm/mach-omap2/board-devkit8000.c         |    1 +
 arch/arm/mach-omap2/board-generic.c            |    1 +
 arch/arm/mach-omap2/board-h4.c                 |    1 +
 arch/arm/mach-omap2/board-igep0020.c           |    2 +
 arch/arm/mach-omap2/board-ldp.c                |    1 +
 arch/arm/mach-omap2/board-n8x0.c               |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c        |    1 +
 arch/arm/mach-omap2/board-omap3evm.c           |    1 +
 arch/arm/mach-omap2/board-omap3logic.c         |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c       |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c       |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c     |    1 +
 arch/arm/mach-omap2/board-omap4panda.c         |    1 +
 arch/arm/mach-omap2/board-overo.c              |    1 +
 arch/arm/mach-omap2/board-rm680.c              |    2 +
 arch/arm/mach-omap2/board-rx51.c               |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c          |    2 +
 arch/arm/mach-omap2/board-zoom.c               |    2 +
 arch/arm/mach-omap2/common.h                   |   47 ++++++++++++++++++
 arch/arm/mach-omap2/io.c                       |   63 ++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c                      |    3 +-
 arch/arm/mach-omap2/pm.c                       |    3 +-
 arch/arm/mach-omap2/pm24xx.c                   |   17 ++-----
 arch/arm/mach-omap2/pm34xx.c                   |    7 +--
 arch/arm/mach-omap2/pm44xx.c                   |    6 +--
 arch/arm/mach-pnx4008/core.c                   |   12 +++++
 arch/arm/mach-pnx4008/pm.c                     |    4 +-
 arch/arm/mach-prima2/common.h                  |    6 ++
 arch/arm/mach-prima2/pm.c                      |    3 +-
 arch/arm/mach-prima2/prima2.c                  |    6 ++
 arch/arm/mach-s3c64xx/common.c                 |    5 ++
 arch/arm/mach-s3c64xx/common.h                 |    7 +++
 arch/arm/mach-s3c64xx/mach-anw6410.c           |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c          |    1 +
 arch/arm/mach-s3c64xx/mach-hmt.c               |    1 +
 arch/arm/mach-s3c64xx/mach-mini6410.c          |    1 +
 arch/arm/mach-s3c64xx/mach-ncp.c               |    1 +
 arch/arm/mach-s3c64xx/mach-real6410.c          |    1 +
 arch/arm/mach-s3c64xx/mach-smartq5.c           |    1 +
 arch/arm/mach-s3c64xx/mach-smartq7.c           |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c          |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c          |    1 +
 arch/arm/mach-s3c64xx/pm.c                     |    3 +-
 arch/arm/mach-sa1100/assabet.c                 |    1 +
 arch/arm/mach-sa1100/badge4.c                  |    1 +
 arch/arm/mach-sa1100/cerf.c                    |    1 +
 arch/arm/mach-sa1100/collie.c                  |    1 +
 arch/arm/mach-sa1100/generic.c                 |    4 ++
 arch/arm/mach-sa1100/generic.h                 |    7 +++
 arch/arm/mach-sa1100/h3100.c                   |    1 +
 arch/arm/mach-sa1100/h3600.c                   |    1 +
 arch/arm/mach-sa1100/hackkit.c                 |    1 +
 arch/arm/mach-sa1100/jornada720.c              |    1 +
 arch/arm/mach-sa1100/lart.c                    |    1 +
 arch/arm/mach-sa1100/nanoengine.c              |    1 +
 arch/arm/mach-sa1100/pleb.c                    |    1 +
 arch/arm/mach-sa1100/pm.c                      |    4 +-
 arch/arm/mach-sa1100/shannon.c                 |    1 +
 arch/arm/mach-sa1100/simpad.c                  |    1 +
 arch/arm/mach-shmobile/Makefile                |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c          |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c          |    1 +
 arch/arm/mach-shmobile/board-bonito.c          |    1 +
 arch/arm/mach-shmobile/board-g3evm.c           |    1 +
 arch/arm/mach-shmobile/board-g4evm.c           |    1 +
 arch/arm/mach-shmobile/board-kota2.c           |    1 +
 arch/arm/mach-shmobile/board-mackerel.c        |    1 +
 arch/arm/mach-shmobile/board-marzen.c          |    1 +
 arch/arm/mach-shmobile/common.c                |   24 +++++++++
 arch/arm/mach-shmobile/cpuidle.c               |    3 +-
 arch/arm/mach-shmobile/include/mach/common.h   |   14 +++++
 arch/arm/mach-shmobile/suspend.c               |    3 +-
 arch/arm/mach-tegra/board-dt-tegra20.c         |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c         |    1 +
 arch/arm/mach-tegra/board-harmony.c            |    1 +
 arch/arm/mach-tegra/board-paz00.c              |    1 +
 arch/arm/mach-tegra/board-seaboard.c           |    3 +
 arch/arm/mach-tegra/board-trimslice.c          |    1 +
 arch/arm/mach-tegra/board.h                    |   16 ++++++
 arch/arm/mach-tegra/clock.c                    |    3 +-
 arch/arm/mach-tegra/common.c                   |    7 +++
 arch/arm/mach-tegra/pinmux.c                   |    3 +-
 arch/arm/mach-tegra/powergate.c                |    4 +-
 arch/arm/mach-ux500/board-mop500.c             |    4 ++
 arch/arm/mach-ux500/board-u5500.c              |    1 +
 arch/arm/mach-ux500/clock.c                    |    6 +--
 arch/arm/mach-ux500/clock.h                    |   12 +++++
 arch/arm/mach-ux500/cpu.c                      |    6 ++
 arch/arm/mach-ux500/include/mach/setup.h       |    1 +
 arch/arm/plat-mxc/include/mach/common.h        |    7 +++
 237 files changed, 695 insertions(+), 116 deletions(-)

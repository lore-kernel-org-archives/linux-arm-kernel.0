From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:19:41 +0800
Subject: [PATCH 00/20] ASoC: add imx-sgtl5000 machine driver working with
 fsl_ssi
Message-ID: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's the full series adding imx-sgtl5000 machine driver which works
with fsl_ssi driver on DT based imx platforms.
 - Patches 1 ~ 5: Convert audmux driver to a platform driver and move
   it into ASoC folder.
 - Patches 6 ~ 12: Merge ASoC imx and fsl folders.
 - Patches 13 ~17: Make fsl_ssi work for imx.
 - Patches 18 ~ 20: Add imx-sgtl5000 machine driver which supports
   DT only.

It's based on sound/for-next and tested on imx51-babbage board with
necessary platform/dts changes, which will be posted separately after
the ASoC changes get merged.

Regards,
Shawn

Richard Zhao (2):
      ARM: imx: convert audmux to a platform driver
      ASoC: fsl: add dt support for imx-audmux

Shawn Guo (18):
      ASoC: imx: move eukrea audmux call into ASoC machine driver
      ASoC: imx: move phycore audmux call into ASoC machine driver
      ARM: imx: merge audmux-v1 and audmux-v2
      ASoC: imx: move audmux driver into sound/soc/imx
      ASoC: imx: rename audmux prefix mxc to imx
      ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
      ASoC: imx: initialize dma_params burstsize just in imx-ssi
      ASoC: imx: separate imx-pcm bits from imx-ssi driver
      ASoC: imx: add an explicit Kconfig option for imx-ssi driver
      ASoC: fsl: separate SSI and DMA Kconfig options
      ASoC: imx: merge sound/soc/imx into sound/soc/fsl
      ASoC: fsl: create fsl_utils to accommodate the common functions
      ASoC: fsl: check property 'compatible' for the machine name
      ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
      ASoC: fsl: remove the fatal error checking on codec-handle
      ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
      ASoC: rename sgtl5000 device tree binding document
      ASoC: fsl: add imx-sgtl5000 machine driver

 .../bindings/sound/imx-audio-sgtl5000.txt          |   24 +++
 .../devicetree/bindings/sound/imx-audmux.txt       |   13 ++
 .../{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt}  |    0
 arch/arm/mach-imx/Kconfig                          |    6 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |   27 +--
 arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c       |    1 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |   24 +--
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |   24 +--
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    7 +
 arch/arm/mach-imx/mach-mx31ads.c                   |    6 +
 arch/arm/mach-imx/mach-pca100.c                    |   20 +--
 arch/arm/mach-imx/mach-pcm043.c                    |   20 +--
 arch/arm/plat-mxc/Kconfig                          |    6 -
 arch/arm/plat-mxc/Makefile                         |    2 -
 arch/arm/plat-mxc/audmux-v1.c                      |   64 ------
 arch/arm/plat-mxc/include/mach/audmux.h            |   60 ------
 sound/soc/Kconfig                                  |    1 -
 sound/soc/Makefile                                 |    1 -
 sound/soc/fsl/Kconfig                              |  124 +++++++++++-
 sound/soc/fsl/Makefile                             |   29 +++-
 sound/soc/{imx => fsl}/eukrea-tlv320.c             |   42 ++++-
 sound/soc/fsl/fsl_ssi.c                            |  146 ++++++++++----
 sound/soc/fsl/fsl_utils.c                          |  135 +++++++++++++
 sound/soc/fsl/fsl_utils.h                          |   27 +++
 .../audmux-v2.c => sound/soc/fsl/imx-audmux.c      |  185 +++++++++++++-----
 sound/soc/fsl/imx-audmux.h                         |   60 ++++++
 sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c           |    7 +-
 sound/soc/{imx => fsl}/imx-pcm-fiq.c               |    0
 sound/soc/fsl/imx-pcm.c                            |  105 ++++++++++
 sound/soc/fsl/imx-pcm.h                            |   32 +++
 sound/soc/fsl/imx-sgtl5000.c                       |  210 ++++++++++++++++++++
 sound/soc/{imx => fsl}/imx-ssi.c                   |   92 +---------
 sound/soc/{imx => fsl}/imx-ssi.h                   |   16 +--
 sound/soc/fsl/mpc8610_hpcd.c                       |  159 ++--------------
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c           |   20 +-
 sound/soc/fsl/p1022_ds.c                           |  181 ++----------------
 sound/soc/{imx => fsl}/phycore-ac97.c              |   27 +++-
 sound/soc/{imx => fsl}/wm1133-ev1.c                |   25 ++--
 sound/soc/imx/Kconfig                              |   60 ------
 sound/soc/imx/Makefile                             |   19 --
 40 files changed, 1163 insertions(+), 844 deletions(-)

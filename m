From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 12 Jul 2011 23:04:35 +0800
Subject: [PATCH V2 00/10]
Message-ID: <1310483085-31442-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is to add audio support based on saif for mxs platform.
The driver only supports playback currently.
For capturing, due to hardware limitation that we have to use two saif
instances to implement full duplex (playback & recording), we need to
figure out a good design to fit in ASoC as the following work.

In addition, we simply just support master mode since saif tx can
only work as a master due to hw limitation(rx can work in both
master & slave mode).

Code is written based on the branch imx-for-3.1 in sascha's tree
http://git.pengutronix.de/git/imx/linux-2.6.git

Tested on MX28EVK.

Main changes since v1:
 * export saif mclk control interface to machine driver.
   Machine driver can decide whether it needs to use mclk supplied by
   saif according to its requirement.
 * error checking improvement
 * remove a few unneccesary code

Dong Aisheng (10):
  ASoc: mxs: add mxs-pcm driver
  ASoc: mxs: add mxs-saif driver
  ASoc: mxs: add mxs-sgtl5000 machine driver
  ASoc: mxs: add asoc configuration files
  ARM: mxs: add saif clock
  ARM: mxs: add saif device
  ARM: mxs: add sgtl5000 i2c device
  ARM: mxs: add mxs-sgtl5000 device
  ARM: mxs: correct the using of frac div for saif
  ARM: mxs-dma: include <linux/dmaengine.h>

 arch/arm/mach-mxs/Kconfig                       |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    8 +-
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |   60 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +
 arch/arm/mach-mxs/include/mach/dma.h            |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                |   39 ++
 sound/soc/Kconfig                               |    1 +
 sound/soc/Makefile                              |    1 +
 sound/soc/mxs/Kconfig                           |   19 +
 sound/soc/mxs/Makefile                          |   10 +
 sound/soc/mxs/mxs-pcm.c                         |  367 +++++++++++++
 sound/soc/mxs/mxs-pcm.h                         |   43 ++
 sound/soc/mxs/mxs-saif.c                        |  656 +++++++++++++++++++++++
 sound/soc/mxs/mxs-saif.h                        |  130 +++++
 sound/soc/mxs/mxs-sgtl5000.c                    |  175 ++++++
 18 files changed, 1529 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-saif.c
 create mode 100644 sound/soc/mxs/Kconfig
 create mode 100644 sound/soc/mxs/Makefile
 create mode 100644 sound/soc/mxs/mxs-pcm.c
 create mode 100644 sound/soc/mxs/mxs-pcm.h
 create mode 100644 sound/soc/mxs/mxs-saif.c
 create mode 100644 sound/soc/mxs/mxs-saif.h
 create mode 100644 sound/soc/mxs/mxs-sgtl5000.c

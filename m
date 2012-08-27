From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 27 Aug 2012 18:56:38 +0530
Subject: [PATCH V2 0/6]  ARM/ASoC: Davinci: Add Device Tree Support
Message-ID: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set is a cumulative of below tasks
1. Split asp header into platform and audio specific
   Davinci driver is shared by few OMAP platforms (like TI81xx, AM335x).
   Splitting asp header into Davinci platform specific and Audio specific helps
   to share them across platforms.

2. Add DT support for Davinci Audio Module (McASP, machine, pcm & Codec)


This patch was tested on AM18x Board (Tested to check if the commits doesn't
break on compile or runtime) and is based on repo at 
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;
a=shortlog;h=refs/heads/for-3.7 (v3.6-rc2)

Note:
Matt Porter from TI is working on DMA engine conversion of DaVinci EDMA
support and DT conversion of DMA parts will be taken up post that is
complete.
Since Audio requires DMA to work, this patch set does not yet provide
complete functionality required to use sound on DT-based platforms, but
is a step towards that direction.

Changes from V1:
	- Instanciate seudo-device (davinci-pcm) directly from DAI driver rather
	  than having a separate virtual-device registered
	- add more explanation to DT parameters
	- Change DT parameter from "ti,codec-clock" to "ti,codec-clock-rate"
	- use standard DT GPIO reference by phandle to populate gpio based DT
	  parameters
	- Dont return err if some DT parameters are missing. They will be
	  treated as 0.
	- Through Error warning if num-serializer != "serial-dir" array size
	- Coding Style correction

Hebbar, Gururaja (6):
  ASoC: davinci: davinci-pcm does not need to be a plaform_driver
  ARM: Davinci: Remove references to davinci pcm
  ASoC/ARM: Davinci: McASP: split asp header into platform and audio
    specific
  ASoC: Davinci: McASP: add device tree support for McASP
  ASoC: Davinci: machine: Add device tree binding
  ASoC: tlv320aic3x: Add device tree bindings

 .../bindings/sound/davinci-evm-audio.txt           |   63 ++++++
 .../bindings/sound/davinci-mcasp-audio.txt         |   44 +++++
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   20 ++
 arch/arm/mach-davinci/asp.h                        |   49 +++++
 arch/arm/mach-davinci/davinci.h                    |    3 +-
 arch/arm/mach-davinci/devices-da8xx.c              |    8 +-
 arch/arm/mach-davinci/devices.c                    |   11 -
 arch/arm/mach-davinci/dm355.c                      |    2 +-
 arch/arm/mach-davinci/dm365.c                      |    2 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/dm646x.c                     |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
 .../linux/platform_data/davinci_asp.h              |   73 ++-----
 sound/soc/codecs/tlv320aic3x.c                     |   31 +++
 sound/soc/davinci/davinci-evm.c                    |  203 +++++++++++++++++---
 sound/soc/davinci/davinci-i2s.c                    |   13 +-
 sound/soc/davinci/davinci-mcasp.c                  |  134 +++++++++++++-
 sound/soc/davinci/davinci-mcasp.h                  |    3 +-
 sound/soc/davinci/davinci-pcm.c                    |   24 +--
 sound/soc/davinci/davinci-pcm.h                    |    6 +-
 sound/soc/davinci/davinci-sffsdr.c                 |    2 +-
 sound/soc/davinci/davinci-vcif.c                   |    8 +
 22 files changed, 573 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.txt
 create mode 100644 arch/arm/mach-davinci/asp.h
 rename arch/arm/mach-davinci/include/mach/asp.h => include/linux/platform_data/davinci_asp.h (56%)

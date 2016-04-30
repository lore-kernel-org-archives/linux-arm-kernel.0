From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 30 Apr 2016 23:15:32 +0200
Subject: [RFC PATCH 0/7] AC97 device/driver model revamp
Message-ID: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It all started in the pxa device-tree submission here :
   https://lkml.org/lkml/2016/2/25/965
It will be maintained in :
   git fetch https://github.com/rjarzmik/linux.git work/ac97

And now it transformed into this RFC, which would bring a ground for AC'97
devices closer to the linux device/driver model.

This is just an RFC to see if we understand each other Mark.

Amongst the driving ideas behind this RFC :
 - use device/driver model for AC'97
   device/driver binding is based on vendor_id{1,2}
 - use auto-probe of the AC'97 bus to enumerate codecs and create devices
 - be compatible with previous platform_data model for codecs
   => this enables a smooth transition, where a codec (here wm9713) can
      be used either through platform_device or automatic discovery
 - struct snd_ac97 is not used
   This structure is really heavy, and doesn't represent an AC97 device, but
   rather an AC'97 codec internals IIUC.
   I think it's right place would be in include/sound/ac97/codec.h.
   This is also a problem for regmap adherence, hence the
   include/sound/ac97/compat.h.
 - a new AC'97 bus Kconfig is created
   This was done for a smooth transition ... let's see if it's a good idea.
 - split the AC'97 into :
   - the codec
   - the digital controller
   - the bus

Amongst the things that are not all touched yet :
 - ac97_codec.c
   The generic AC'97 codec in sound/pci/ac97/ac97_codec.c has really a lot
   features, which are not at all PCI related. They could be transfered to
   sound/ac97, without the pci specific field.
   => this deserves a deep ahead thinking, which I'll do if the current approach
   is accepted by the communauty.

The most important patch is 2/7 "ALSA: ac97: add an ac97 bus". This is the main
evaluation point for the serie, the others are here so that I can test it all.

Well, this is a long term effort, which might need a complete rewrite according
to the comments it'll get. Let's expose it for comments and see how I can
progress with it.

Cheers.

--
Robert

Robert Jarzmik (7):
  ALSA: ac97: split out the generic ac97 registers
  ALSA: ac97: add an ac97 bus
  ASoC: wm9713: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support
  ARM: pxa: mioa701 remove wm9713 from platform devices
  ASoC: mioa701_wm9713: convert to new ac97 bus
  ASoC: add new ac97 bus support

 arch/arm/mach-pxa/mioa701.c     |   1 -
 include/sound/ac97/codec.h      |  98 ++++++++++++
 include/sound/ac97/compat.h     |  21 +++
 include/sound/ac97/controller.h |  39 +++++
 include/sound/ac97/regs.h       | 262 +++++++++++++++++++++++++++++++
 include/sound/ac97_codec.h      | 239 +----------------------------
 include/sound/pxa2xx-lib.h      |  14 +-
 sound/Kconfig                   |   7 +
 sound/Makefile                  |   1 +
 sound/ac97/Kconfig              |   9 ++
 sound/ac97/Makefile             |   5 +
 sound/ac97/ac97_core.h          |  10 ++
 sound/ac97/bus.c                | 330 ++++++++++++++++++++++++++++++++++++++++
 sound/ac97/codec.c              |  15 ++
 sound/ac97/snd_ac97_compat.c    | 104 +++++++++++++
 sound/arm/Kconfig               |   1 -
 sound/arm/pxa2xx-ac97-lib.c     |  31 ++--
 sound/soc/Kconfig               |   4 +
 sound/soc/codecs/wm9713.c       |  62 +++++++-
 sound/soc/pxa/Kconfig           |   4 +-
 sound/soc/pxa/mioa701_wm9713.c  |   4 +-
 sound/soc/pxa/pxa2xx-ac97.c     |  12 +-
 22 files changed, 1000 insertions(+), 273 deletions(-)
 create mode 100644 include/sound/ac97/codec.h
 create mode 100644 include/sound/ac97/compat.h
 create mode 100644 include/sound/ac97/controller.h
 create mode 100644 include/sound/ac97/regs.h
 create mode 100644 sound/ac97/Kconfig
 create mode 100644 sound/ac97/Makefile
 create mode 100644 sound/ac97/ac97_core.h
 create mode 100644 sound/ac97/bus.c
 create mode 100644 sound/ac97/codec.c
 create mode 100644 sound/ac97/snd_ac97_compat.c

-- 
2.1.4

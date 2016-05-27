From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 27 May 2016 22:26:52 +0200
Subject: [RFC PATCH v2 0/7] AC97 device/driver model revamp
Message-ID: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It all started in the pxa device-tree submission here :
   https://lkml.org/lkml/2016/2/25/965
   
It will be maintained in :
   git fetch https://github.com/rjarzmik/linux.git work/ac97

And now it transformed into this RFC, which would bring a ground for AC'97
devices closer to the linux device/driver model.

The driving ideas are still the same, and I put them in [1] for memory. This is
the second opus of the RFC. I'm intending to stop the RFC cycle here if possible
and have a true PATCH v1 submission after this RFC v2 unless there is a deep
design flaw uncovered.

I took into account Mark's and Takashi's remarks, I hope I forgot none. All the
changes should be documented in the first 2 patches mainly. I also added :
 - the AC97 link clock
   For now, bus code doesn't disable it in suspend and re-enable in resume,
   leaving the controller decide. I'm still pondering if for S2RAM (as opposed
   to runtime suspend), bus code should disable the clock.

 - the .h guards
   I'm not particularly happy with my naming even for v2, feel free to propose
   anything better, the codec.h is particularly ugly.

 - statics and namespace pollution
   I made more functions static, limiting further the namespace pollution.

 - Kconfig/Makefile layout change
   I get the feeling that the KConfig "select" flavor would have better been a
   "depends on" one. And yet I didn't find a good way to enforce it, because of
   the way sound/soc/codecs/Kconfig is designed, and I'm afraid to break the
   structure by doing a "depends on AC97_BUS_NEW" in WM9713 configuration.

Let's have another review cycle, that will let me test this serie more
thoroughly, especially the suspend/resume and the reset in the resume, which
doesn't work, and requires me to test more deeply. I'll also test by removing
the wm9713 change to see how robust the implementation is.

Happy review.

--
Robert

Robert Jarzmik (7):
  ALSA: ac97: split out the generic ac97 registers
  ALSA: ac97: add an ac97 bus
  ASoC: add new ac97 bus support
  ASoC: wm9713: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support
  ARM: pxa: mioa701 convert to the new AC97 bus
  ASoC: mioa701_wm9713: convert to new ac97 bus

 arch/arm/mach-pxa/mioa701.c     |  12 +-
 include/sound/ac97/codec.h      | 111 ++++++++++++
 include/sound/ac97/compat.h     |  21 +++
 include/sound/ac97/controller.h |  80 +++++++++
 include/sound/ac97/regs.h       | 262 +++++++++++++++++++++++++++
 include/sound/ac97_codec.h      | 239 +------------------------
 include/sound/pxa2xx-lib.h      |  15 +-
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   1 +
 sound/ac97/Kconfig              |  18 ++
 sound/ac97/Makefile             |   8 +
 sound/ac97/ac97_core.h          |  10 ++
 sound/ac97/bus.c                | 381 ++++++++++++++++++++++++++++++++++++++++
 sound/ac97/codec.c              |  15 ++
 sound/ac97/snd_ac97_compat.c    | 104 +++++++++++
 sound/arm/Kconfig               |   1 -
 sound/arm/pxa2xx-ac97-lib.c     |  39 ++--
 sound/soc/Kconfig               |   4 +
 sound/soc/codecs/Kconfig        |   1 +
 sound/soc/codecs/wm9713.c       |  62 ++++++-
 sound/soc/pxa/Kconfig           |   4 +-
 sound/soc/pxa/mioa701_wm9713.c  |   4 +-
 sound/soc/pxa/pxa2xx-ac97.c     |  20 ++-
 23 files changed, 1132 insertions(+), 282 deletions(-)
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

[1] RFC PATCH reminder:

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

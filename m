From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 19 Jun 2017 09:26:57 +0200
Subject: [PATCH v2 00/12] AC97 device/driver model revamp
Message-ID: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars, Mark, Charles, Lee,

This serie has been stalled for almost one year, as I wasn't feeling that
well lately. I'm quite better now, so let's get back to it.

As it's been so long since the last review, I basically withdrew all my former
objections and took into account all remarks regardless of my own
judgement. This is especially the case with Lars's review on the bus code, where
I tried to address all his comments.

For this next round, let's sum up what happened :
 - I rebased against latest Linus's tree
   => as Lars had made ports to regmap of several impacted wm97xx drivers, all
   the better for me.
   
 - ALSA: ac97: add an ac97 bus
   => this addresses Lars's comments
   => history : https://patchwork.kernel.org/patch/9398229/
   => there is one remark which was left out, the drop of the table
      ac97_controller->codecs. The reason is that there are traversals required
      in the bus scan and controller removal, and the code is way simpler with a
      table, and the data structure very compact.
   
 - Input: wm97xx: split out touchscreen registering
   => Charles's comment taken into account
   => history: http://https://patchwork.kernel.org/patch/9398223/

Have a happy review.

--
Robert

Robert Jarzmik (11):
  ALSA: ac97: add an ac97 bus
  ASoC: add new ac97 bus support
  ASoC: arm: make pxa2xx-ac97-lib ac97 codec agnostic
  Input: wm97xx: split out touchscreen registering
  mfd: wm97xx-core: core support for wm97xx Codec
  Input: wm97xx: add new AC97 bus support
  ASoC: wm9713: add ac97 new bus support
  ASoC: wm9712: add ac97 new bus support
  ASoC: wm9705: add private structure
  ASoC: wm9705: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support

Takashi Iwai (1):
  ASoC: Fix use-after-free at card unregistration

 drivers/input/touchscreen/Kconfig       |   2 +-
 drivers/input/touchscreen/wm97xx-core.c | 252 ++++++++++-----
 drivers/mfd/Kconfig                     |  14 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 282 +++++++++++++++++
 include/linux/mfd/wm97xx.h              |  31 ++
 include/sound/ac97/codec.h              | 118 +++++++
 include/sound/ac97/compat.h             |  21 ++
 include/sound/ac97/controller.h         |  85 ++++++
 include/sound/pxa2xx-lib.h              |  15 +-
 sound/Kconfig                           |   2 +
 sound/Makefile                          |   1 +
 sound/ac97/Kconfig                      |  19 ++
 sound/ac97/Makefile                     |   8 +
 sound/ac97/ac97_core.h                  |  10 +
 sound/ac97/bus.c                        | 526 ++++++++++++++++++++++++++++++++
 sound/ac97/codec.c                      |  15 +
 sound/ac97/snd_ac97_compat.c            | 105 +++++++
 sound/arm/Kconfig                       |   1 -
 sound/arm/pxa2xx-ac97-lib.c             |  37 ++-
 sound/arm/pxa2xx-ac97.c                 |  35 ++-
 sound/soc/Kconfig                       |   4 +
 sound/soc/codecs/Kconfig                |   9 +-
 sound/soc/codecs/wm9705.c               |  59 ++--
 sound/soc/codecs/wm9712.c               |  37 ++-
 sound/soc/codecs/wm9713.c               |  39 ++-
 sound/soc/pxa/Kconfig                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c             |  43 ++-
 sound/soc/soc-core.c                    |   5 +-
 29 files changed, 1603 insertions(+), 178 deletions(-)
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/linux/mfd/wm97xx.h
 create mode 100644 include/sound/ac97/codec.h
 create mode 100644 include/sound/ac97/compat.h
 create mode 100644 include/sound/ac97/controller.h
 create mode 100644 sound/ac97/Kconfig
 create mode 100644 sound/ac97/Makefile
 create mode 100644 sound/ac97/ac97_core.h
 create mode 100644 sound/ac97/bus.c
 create mode 100644 sound/ac97/codec.c
 create mode 100644 sound/ac97/snd_ac97_compat.c

-- 
2.1.4

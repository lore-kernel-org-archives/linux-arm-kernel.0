From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:03:58 +0400
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
Message-ID: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Main features: lots of cleanup, finished conversion to gpiolib,
machine specific platform code separated, added support for
gpio-keys, and reused h3600 pcmcia driver on h3100

Patchset is based on top of RMK's sa1100 branch
(commit "ARM: iPAQ: no need to set PWER_RTC")
If anybody wants to test it, full patchset against 2.6.32-rc5
(including Russell's patches) can be found here:
http://mad.is-a-geek.org/h3600/2.6.32-h3600-patches-20091024.tar.bz2

Other than that patches doesn't depend on anything else. Although
I should note that assign_h3600_egpio conversion doesn't touch broken
mtd/maps/ipaq.c driver, making it's even more broken. Patch for its
removal has already been posted.

Compile and run tested on iPAQs h3150 and h3635 with CF jacket.
Patches are mostly checkpatch clean - there's some comments
exceeding 80-line limit, but otherwise all code should be ok.

Also, please note, that patches are generated with "-C" flag
of git-format-patch for easier review. If there's problems with
applying, use patches from URL above - they're generated without "-C".

Dmitry Artamonow (20):
  SA1100: h3100/h3600: mark *_mach_init functions as __init
  SA1100: h3100/h3600: remove dead links from Kconfig help text
  SA1100: h3600: remove IRDA bits from serial PM callback
  SA1100: h3600: remove unused cruft from h3600.h
  SA1100: h3600: stop setting direction for LCD pins
  pcmcia: convert sa1100_h3600 driver to gpiolib
  SA1100: h3100/h3600: separate machine-specific LCD helpers
  SA1100: h3100/h3600: add htc-egpio driver
  SA1100: h3100/h3600: convert all users of assign_h3600_egpio to
    gpiolib
  SA1100: h3100/h3600: remove now unused assign_h3600_egpio handlers
  SA1100: h3600: remove IRQ_GPIO_* definitions
  SA1100: h3100/h3600: configure all unused gpios as inputs
  SA1100: h3100/h3600: drop old GPIO definitions
  SA1100: h3100/h3600: merge h3600.h and h3600_gpio.h into h3xxx.h
  SA1100: h3100/h3600: split h3600.c
  SA1100: h3100/h3600: revise copyright boilerplates
  SA1100: h3100/h3600: clean up #includes
  SA1100: h3100/h3600: add support for gpio-keys
  SA1100: reuse h3600 PCMCIA driver on h3100
  SA1100: h3600: update defconfig

 arch/arm/configs/h3600_defconfig                   |  976 ++++++++++++--------
 arch/arm/mach-sa1100/Kconfig                       |    2 -
 arch/arm/mach-sa1100/Makefile                      |    4 +-
 arch/arm/mach-sa1100/h3100.c                       |   93 ++
 arch/arm/mach-sa1100/h3600.c                       |  505 ++---------
 arch/arm/mach-sa1100/{h3600.c => h3xxx.c}          |  458 +++-------
 arch/arm/mach-sa1100/include/mach/h3600.h          |  100 --
 .../include/mach/{h3600_gpio.h => h3xxx.h}         |  120 ++--
 drivers/pcmcia/sa1100_generic.c                    |    2 +-
 drivers/pcmcia/sa1100_h3600.c                      |  140 +++-
 10 files changed, 1059 insertions(+), 1341 deletions(-)
 create mode 100644 arch/arm/mach-sa1100/h3100.c
 copy arch/arm/mach-sa1100/{h3600.c => h3xxx.c} (31%)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/h3600.h
 rename arch/arm/mach-sa1100/include/mach/{h3600_gpio.h => h3xxx.h} (17%)

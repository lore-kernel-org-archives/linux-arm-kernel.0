From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:29:25 +0100
Subject: [PATCH 0/6] ARM: integrator: multiplatform advancements
Message-ID: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This takes some steps towards enabling multiplatform support for the
Integrator. This also removes some minor strings attached to the
Versatile and RealView platforms to help them advancing.

File movement is trivial, but I need some advice on the memory.h
removal patch which is more of a puzzle due to lack of history
with this header on my behalf.

What remains for multiplatform afte this is just one
thing: <plat/clcd.h>. That is the only dependency toward
plat-versatile and the <plat/*> inclusion hierarchy remaining
for the Integrator.

This is a display database and timing set-up callback driver
where the Versatile family looks up settings for VGA and similar
displays.

I'm tempted to attempt to just move this down into drivers/video
alongside the CLCD driver with some platform data header in
<linux/platform_data/video-clcd.h>.

The *real* solution, one might argue is to convert the CLCD
driver to DRM and add device tree bindings, but it appears that
this is an orthogonal goal that has been attempted by other with
mixed results.

I have tested all patches on the Integrator/AP and Integrator/CP,
but I'd appreciate help testing some PCI traffic as well if
you (Will!) have an Integrator/AP with working PCI set-up.

Since this is based on other patches from me, here is a
pullable branch based on v3.14-rc2:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git multiplatform


Linus Walleij (6):
  ARM: integrator: localize the lm.h header
  ARM: integrator: localize the impd1.h header
  ARM: integrator: merge platform.h to hardware.h
  ARM: integrator: localize the hardware.h header
  ARM: integrator: register sched_clock directly
  RFC: ARM: integrator: get rid of <mach/memory.h>

 arch/arm/Kconfig                                 |   1 -
 arch/arm/mach-integrator/core.c                  |   4 +-
 arch/arm/mach-integrator/hardware.h              | 354 +++++++++++++++++++++
 arch/arm/mach-integrator/impd1.c                 |   4 +-
 arch/arm/mach-integrator/impd1.h                 |  14 +
 arch/arm/mach-integrator/include/mach/hardware.h |  45 ---
 arch/arm/mach-integrator/include/mach/impd1.h    |  18 --
 arch/arm/mach-integrator/include/mach/lm.h       |  23 --
 arch/arm/mach-integrator/include/mach/memory.h   |  34 --
 arch/arm/mach-integrator/include/mach/platform.h | 382 -----------------------
 arch/arm/mach-integrator/integrator_ap.c         |   6 +-
 arch/arm/mach-integrator/integrator_cp.c         |  17 +-
 arch/arm/mach-integrator/leds.c                  |   4 +-
 arch/arm/mach-integrator/lm.c                    |   2 +-
 arch/arm/mach-integrator/lm.h                    |  23 ++
 arch/arm/mach-integrator/pci_v3.c                |   4 +-
 drivers/clk/versatile/clk-impd1.c                |   6 +-
 17 files changed, 411 insertions(+), 530 deletions(-)
 create mode 100644 arch/arm/mach-integrator/hardware.h
 create mode 100644 arch/arm/mach-integrator/impd1.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/impd1.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/lm.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/memory.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/platform.h
 create mode 100644 arch/arm/mach-integrator/lm.h

-- 
1.8.5.3

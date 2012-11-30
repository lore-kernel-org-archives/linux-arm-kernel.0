From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 30 Nov 2012 17:45:58 +0000
Subject: [PATCH 00/10] Unify arm_generic and arch_timer drivers
Message-ID: <1354297568-26366-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have two drivers for the ARM generic / architected timer,
arch_timer in arch/arm, and arm_generic in drivers/clocksource. This is
an unnecessary duplication of code, and will only lead to maintenance
headaches later.

This patch series splits the generic portion of the arch_timer out to
drivers/clocksource, and ports the arm64 code to use it. The now unused
arm_generic driver is removed in the process.

The series applies to v3.7-rc7, and has been tested on a TC2 test chip.
Aside from a slight conflict in arch/arm64/Kconfig, it also applies to
Catalin's soc-armv8-model branch [1], the result of which has been
tested on an AArch64 model.

Obviously I'm not aiming for the merge window, but I'm posting now in
the hope this can get some early feedback.

Thanks,
Mark

[1] git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-model

Mark Rutland (10):
  arm: arch_timer: remove redundant available check
  arm: arch_timer: use u64/u32 for register data
  arm: arch_timer: standardise counter reading
  arm: arch_timer: split cntfrq accessor
  arm: arch_timer: factor out register accessors
  arm: arch_timer: divorce from local_timer api
  arm: arch_timer: add arch_counter_enable_user_access
  arm: arch_timer: move core to drivers/clocksource
  arm64: move from arm_generic to arm_arch_timer
  Documentation: Add ARMv8 to arch_timer devicetree

 .../devicetree/bindings/arm/arch_timer.txt         |    7 +-
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/include/asm/arch_timer.h                  |  107 ++++-
 arch/arm/kernel/arch_timer.c                       |  504 +-------------------
 arch/arm/mach-omap2/Kconfig                        |    2 +-
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/include/asm/arch_timer.h                |  133 +++++
 arch/arm64/include/asm/arm_generic.h               |  100 ----
 arch/arm64/kernel/time.c                           |   29 +-
 drivers/clocksource/Kconfig                        |    6 +-
 drivers/clocksource/Makefile                       |    2 +-
 drivers/clocksource/arm_arch_timer.c               |  375 +++++++++++++++
 drivers/clocksource/arm_generic.c                  |  232 ---------
 include/clocksource/arm_arch_timer.h               |   63 +++
 include/clocksource/arm_generic.h                  |   21 -
 15 files changed, 730 insertions(+), 855 deletions(-)
 create mode 100644 arch/arm64/include/asm/arch_timer.h
 delete mode 100644 arch/arm64/include/asm/arm_generic.h
 create mode 100644 drivers/clocksource/arm_arch_timer.c
 delete mode 100644 drivers/clocksource/arm_generic.c
 create mode 100644 include/clocksource/arm_arch_timer.h
 delete mode 100644 include/clocksource/arm_generic.h

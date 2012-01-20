From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:32:58 -0600
Subject: [PATCH v2 00/13] Make mach/irqs.h optional
Message-ID: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series removes the include of mach/irqs.h from asm/irq.h when
SPARSE_IRQ is selected. Platforms which select SPARSE_IRQ have been
updated.

This breaks platforms where SPARSE_IRQ is user selectable. This is on
purpose so that SPARSE_IRQ gets properly supported. We could push
HAVE_SPARSE_IRQ option down to the platforms that select it if that is
preferred. But as recent experience has shown, perhaps breaking platforms
is the only way to get some platforms updated.

Platforms either need to set nr_irqs in their machine desc or all irqchips
used by a platform need to allocate their irq_descs. There cannot be a
mixture. Once this is done, the platforms can select SPARSE_IRQ. shmobile
does the latter, and mnp and pxa do the former.

I've built all defconfigs, but don't have any of the affected platforms to
boot test. I really need shmobile testing with this series.

Changes from v1:
- Rework SH INTC_NR_IRQS and evt2irq/irq2evt macros
- Add commit "ARM: remove mc146818rtc.h from time.c"
- Add irqs.h removal for picocell
- Fixup newly added platforms in 3.3
- Drop sa1100 rtc changes. Not needed with platform device conversion.
- Make RTC_IRQ define to BUILD_BUG_ON
- Rebase to 3.3-rc1

This series is available here:
git://sources.calxeda.com/kernel/linux.git sparse_irq

Rob

Jamie Iles (1):
  ARM: picoxcell: remove mach/irqs.h

Rob Herring (12):
  sound: pxa2xx-ac97: include mach/irqs.h directly
  gpio: pxa: explicitly include mach/irqs.h
  ARM: remove mc146818rtc.h from time.c
  ARM: mc146818rtc: remove unnecessary include of mach/irqs.h
  ARM: it8152: explicitly include mach/irqs.h
  sh: intc: unify evt2irq/irq2evt macros for sh and arm
  sh: intc: remove dependency on NR_IRQS
  ARM: mmp: remove NR_IRQS
  ARM: pxa: remove NR_IRQS
  ARM: shmobile: remove NR_IRQS
  ARM: only include mach/irqs.h for !SPARSE_IRQ
  ARM: highbank: select SPARSE_IRQ and remove irqs.h

 arch/arm/Kconfig                            |    1 +
 arch/arm/include/asm/hardware/it8152.h      |    3 +++
 arch/arm/include/asm/irq.h                  |    8 ++++++--
 arch/arm/include/asm/mc146818rtc.h          |    4 +++-
 arch/arm/kernel/time.c                      |    2 --
 arch/arm/mach-highbank/highbank.c           |    1 -
 arch/arm/mach-highbank/include/mach/irqs.h  |    6 ------
 arch/arm/mach-mmp/aspenite.c                |    5 +++--
 arch/arm/mach-mmp/avengers_lite.c           |    1 +
 arch/arm/mach-mmp/brownstone.c              |    4 ++--
 arch/arm/mach-mmp/flint.c                   |    3 ++-
 arch/arm/mach-mmp/gplugd.c                  |    2 +-
 arch/arm/mach-mmp/include/mach/irqs.h       |    3 +--
 arch/arm/mach-mmp/irq-mmp2.c                |    1 +
 arch/arm/mach-mmp/jasper.c                  |    5 +++--
 arch/arm/mach-mmp/tavorevb.c                |    1 +
 arch/arm/mach-mmp/teton_bga.c               |    3 ++-
 arch/arm/mach-mmp/ttc_dkb.c                 |    4 ++--
 arch/arm/mach-picoxcell/include/mach/irqs.h |   20 --------------------
 arch/arm/mach-pxa/capc7117.c                |    1 +
 arch/arm/mach-pxa/cm-x300.c                 |    1 +
 arch/arm/mach-pxa/colibri-pxa270.c          |    2 ++
 arch/arm/mach-pxa/colibri-pxa300.c          |    1 +
 arch/arm/mach-pxa/colibri-pxa320.c          |    1 +
 arch/arm/mach-pxa/corgi.c                   |    3 +++
 arch/arm/mach-pxa/csb726.c                  |    1 +
 arch/arm/mach-pxa/devices.c                 |    1 +
 arch/arm/mach-pxa/em-x270.c                 |    2 ++
 arch/arm/mach-pxa/gumstix.c                 |    1 +
 arch/arm/mach-pxa/h5000.c                   |    1 +
 arch/arm/mach-pxa/himalaya.c                |    1 +
 arch/arm/mach-pxa/icontrol.c                |    1 +
 arch/arm/mach-pxa/idp.c                     |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h       |    2 +-
 arch/arm/mach-pxa/mioa701.c                 |    1 +
 arch/arm/mach-pxa/mp900.c                   |    1 +
 arch/arm/mach-pxa/palmld.c                  |    1 +
 arch/arm/mach-pxa/palmt5.c                  |    1 +
 arch/arm/mach-pxa/palmtc.c                  |    1 +
 arch/arm/mach-pxa/palmte2.c                 |    1 +
 arch/arm/mach-pxa/palmtreo.c                |    2 ++
 arch/arm/mach-pxa/palmtx.c                  |    1 +
 arch/arm/mach-pxa/palmz72.c                 |    1 +
 arch/arm/mach-pxa/pxa3xx.c                  |    1 +
 arch/arm/mach-pxa/raumfeld.c                |    3 +++
 arch/arm/mach-pxa/saar.c                    |    1 +
 arch/arm/mach-pxa/spitz.c                   |    3 +++
 arch/arm/mach-pxa/stargate2.c               |    1 +
 arch/arm/mach-pxa/tavorevb.c                |    1 +
 arch/arm/mach-pxa/time.c                    |    1 +
 arch/arm/mach-pxa/trizeps4.c                |    2 ++
 arch/arm/mach-pxa/viper.c                   |    1 +
 arch/arm/mach-pxa/vpac270.c                 |    1 +
 arch/arm/mach-pxa/xcep.c                    |    1 +
 arch/arm/mach-pxa/z2.c                      |    1 +
 arch/arm/mach-shmobile/Kconfig              |    4 ++++
 arch/arm/mach-shmobile/board-ag5evm.c       |    1 +
 arch/arm/mach-shmobile/board-bonito.c       |    1 +
 arch/arm/mach-shmobile/board-g3evm.c        |    1 +
 arch/arm/mach-shmobile/board-g4evm.c        |    1 +
 arch/arm/mach-shmobile/board-kota2.c        |    1 +
 arch/arm/mach-shmobile/board-mackerel.c     |    1 +
 arch/arm/mach-shmobile/board-marzen.c       |    1 +
 arch/arm/mach-shmobile/include/mach/irqs.h  |    6 +-----
 arch/arm/mach-shmobile/intc-r8a7740.c       |    1 +
 arch/arm/mach-shmobile/intc-sh7367.c        |    1 +
 arch/arm/mach-shmobile/intc-sh7372.c        |    1 +
 arch/arm/mach-shmobile/intc-sh7377.c        |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c        |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c      |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c      |    1 +
 arch/arm/mach-shmobile/setup-sh7367.c       |    1 +
 arch/arm/mach-shmobile/setup-sh7372.c       |    1 +
 arch/arm/mach-shmobile/setup-sh7377.c       |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c       |    1 +
 arch/sh/include/asm/irq.h                   |   11 -----------
 drivers/gpio/gpio-pxa.c                     |    2 ++
 drivers/sh/intc/balancing.c                 |    2 +-
 drivers/sh/intc/core.c                      |    2 +-
 drivers/sh/intc/handle.c                    |    2 +-
 drivers/sh/intc/virq.c                      |    2 +-
 include/linux/sh_intc.h                     |   17 +++++++++++++++++
 sound/arm/pxa2xx-ac97-lib.c                 |    2 +-
 83 files changed, 125 insertions(+), 67 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h

-- 
1.7.5.4

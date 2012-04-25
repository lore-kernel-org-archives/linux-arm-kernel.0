From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Apr 2012 17:50:56 +0200
Subject: [GIT PULL] ux500-core for ARM SoC
Message-ID: <1335369056-5331-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM SoC maintainers,

this is a ux500-core pull request so we can get these quite
important patches to rotate in linux-next.

Main features:

- - - Core support for the U9540 after finalized review

- - - A big deletion of U5500 after obsoletion of this ASIC,
  including two patches to the MFD subsystem that have been
  ACK:ed by Samuel Ortiz.

- - - A cpuidle driver from Daniel Lezcano

- - - Four core patches paving the way for device tree enablement
  of the Snowball and ux500 at large by Lee Jones.

There are two branches more or less orthogonal to this one that
I will send separately: ux500-devicetree and ux500-gpio-pins.
The latter branch will have some trivial merge conflicts in
the top ux500 Makefile, and I show how I solved it.

Please pull this in!

Yours,
Linus Walleij


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-core-for-arm-soc

Daniel Lezcano (1):
      ARM: ux500: add the cpuidle driver for WFI and ARM retention

Lee Jones (4):
      ARM: ux500: Do not attempt to register non-existent i2c devices on Snowball
      ARM: ux500: Fork cpu-db8500 platform_devs for sequential DT enablement
      ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
      ARM: ux500: Enable PRCMU Timer 4 (clocksource) for Device Tree

Linus Walleij (4):
      ARM: ux500: core U9540 support
      ARM: ux500: delete U5500 support
      mfd/db5500-prcmu: delete DB5500 PRCMU support
      mfd/ab5500: delete AB5500 support

Michel Jaouen (1):
      ARM: ux500: ioremap differences for DB9540

 arch/arm/mach-ux500/Kconfig                        |   25 -
 arch/arm/mach-ux500/Makefile                       |    6 +-
 arch/arm/mach-ux500/board-mop500-uib.c             |    2 +-
 arch/arm/mach-ux500/board-mop500.c                 |   26 +-
 arch/arm/mach-ux500/board-u5500-sdi.c              |   74 -
 arch/arm/mach-ux500/board-u5500.c                  |  162 ---
 arch/arm/mach-ux500/cache-l2x0.c                   |   18 +-
 arch/arm/mach-ux500/clock.c                        |   12 +-
 arch/arm/mach-ux500/cpu-db5500.c                   |  247 ----
 arch/arm/mach-ux500/cpu-db8500.c                   |   42 +-
 arch/arm/mach-ux500/cpu.c                          |   10 +-
 arch/arm/mach-ux500/cpuidle.c                      |  171 +++
 arch/arm/mach-ux500/devices-db5500.h               |   99 --
 arch/arm/mach-ux500/dma-db5500.c                   |  137 --
 arch/arm/mach-ux500/id.c                           |    9 +-
 arch/arm/mach-ux500/include/mach/db5500-regs.h     |  143 --
 arch/arm/mach-ux500/include/mach/db8500-regs.h     |    6 +
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    4 -
 arch/arm/mach-ux500/include/mach/devices.h         |    1 -
 arch/arm/mach-ux500/include/mach/hardware.h        |    4 +-
 arch/arm/mach-ux500/include/mach/id.h              |   17 +-
 .../arm/mach-ux500/include/mach/irqs-board-u5500.h |   21 -
 arch/arm/mach-ux500/include/mach/irqs-db5500.h     |  113 --
 arch/arm/mach-ux500/include/mach/irqs.h            |    7 +-
 arch/arm/mach-ux500/include/mach/mbox-db5500.h     |   88 --
 arch/arm/mach-ux500/include/mach/setup.h           |    6 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |    7 +-
 arch/arm/mach-ux500/mbox-db5500.c                  |  565 --------
 arch/arm/mach-ux500/modem-irq-db5500.c             |  143 --
 arch/arm/mach-ux500/pins-db5500.h                  |  620 ---------
 arch/arm/mach-ux500/platsmp.c                      |    8 +-
 arch/arm/mach-ux500/ste-dma40-db5500.h             |  135 --
 arch/arm/mach-ux500/timer.c                        |   37 +-
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/cpufreq/db8500-cpufreq.c                   |    2 +-
 drivers/mfd/Kconfig                                |   27 -
 drivers/mfd/Makefile                               |    3 -
 drivers/mfd/ab5500-core.c                          | 1439 --------------------
 drivers/mfd/ab5500-debugfs.c                       |  807 -----------
 drivers/mfd/ab5500-debugfs.h                       |   22 -
 drivers/mfd/db5500-prcmu.c                         |  451 ------
 include/linux/mfd/abx500.h                         |    5 +-
 include/linux/mfd/abx500/ab5500.h                  |  140 --
 include/linux/mfd/db5500-prcmu.h                   |  105 --
 include/linux/mfd/dbx500-prcmu.h                   |  242 +---
 45 files changed, 348 insertions(+), 5862 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-u5500-sdi.c
 delete mode 100644 arch/arm/mach-ux500/board-u5500.c
 delete mode 100644 arch/arm/mach-ux500/cpu-db5500.c
 create mode 100644 arch/arm/mach-ux500/cpuidle.c
 delete mode 100644 arch/arm/mach-ux500/devices-db5500.h
 delete mode 100644 arch/arm/mach-ux500/dma-db5500.c
 delete mode 100644 arch/arm/mach-ux500/include/mach/db5500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/irqs-board-u5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/irqs-db5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/mbox-db5500.h
 delete mode 100644 arch/arm/mach-ux500/mbox-db5500.c
 delete mode 100644 arch/arm/mach-ux500/modem-irq-db5500.c
 delete mode 100644 arch/arm/mach-ux500/pins-db5500.h
 delete mode 100644 arch/arm/mach-ux500/ste-dma40-db5500.h
 delete mode 100644 drivers/mfd/ab5500-core.c
 delete mode 100644 drivers/mfd/ab5500-debugfs.c
 delete mode 100644 drivers/mfd/ab5500-debugfs.h
 delete mode 100644 drivers/mfd/db5500-prcmu.c
 delete mode 100644 include/linux/mfd/abx500/ab5500.h
 delete mode 100644 include/linux/mfd/db5500-prcmu.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmB1AAAoJEEEQszewGV1zydYP/2f0ODyR4SQf4FhObByG2fH8
oflcrZJB/ZdRyo3jKJjcAEImlI0bw1NfFPK0MjG5dk7hv5saHqQZ2xT+ckF0BJcQ
8VSWlQj1uFhKhkrrvyLm3aZPGFcLrodDgENzs1D4yhmpbI/Az8vSJRepTjdje2ka
Vc8nkUyFA4CgWlP4Ikb3FTH/Z1rwMfv2azuicrmKxCN74FmL/kk5S22KLWyORD4r
LwdwSbk0oWX4S6YGM3NmTlCh/hHvVq72g+ef/u3m7dy4hcBTrVlxSjn3FCaJdgCr
fAlmSyyWJ/w++3ogJlEGw3uUpFcHsHYkYu3W4zBO0qzKMd/NStXAc8yq8r1jsKCK
hCkyyMA05gvrGg7yze3/ZBqiomU7RGtVB6N7PLgALUTv5uKLK2clgHvgoWehoGvf
GIG3vlGijvHBzUu7wrdsRHnFSvZsljeLYo/1Sknc46moPbK9DgGwuMHkjivvUSSJ
uXgJP/tR+A70GLg7wV1+Cx840FDugTPWzMDnb2D4LRK1btKYF6nfUxjons9DeEe+
u1Ny9w70DlSRP5evUulWkR4clkiOIeuIymOh5M2touGlbKZQH4NTwVbS2Xu6Ws2C
NrX0u1C261DQQjbiM/PgPp8l5TLYbzvovQzAEaoBB/XB6haf1+VjgtF26dESYUfy
wTdCG5YNQZrHLmgaUOX0
=b08J
-----END PGP SIGNATURE-----

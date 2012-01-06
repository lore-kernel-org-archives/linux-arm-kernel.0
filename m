From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 7 Jan 2012 00:22:40 +0100
Subject: [PATCH 0/8] S3C24XX: remove global plat/s3c24??.h SoC-headers
Message-ID: <201201070022.40431.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The plat-samsung/s3c24??.h headers contain function declarations that are
mostly private to the relevant SoCs.

This patchset follows the work started by Kukjin Kim for newer Samsung-SoCs
and moves them from a global space to their SoC directories as common.h .

The the only non-mach user of these files is plat-s3c24xx/cpu.c . It seemes
to have been built to generalize the init of S3C24XX-SoCs, but in reality
its savings are rather low and introduce ifdef-voodoo to distinguish
between S3C2412 and S3C2416.

Therefore the series introduces common.c files for these SoCs, that now
contain the SoC-specific cpu-init - the relevant parts of the cpu.c code.
cpu.c is completely removed at the end of the series.

The number of lines add + deleted is mostly equal and the positive diffstat
results from the added GPL headers to the common.c files for the most part.
Another sign of low savings in the cpu.c abstraction.

As always, each patch is compile-tested individually and correctnes of the
move was tested on s3c2416 hardware - so hopefully I did not break any other
of the touched SoCs.

As with the newer SoCs more common code can move into the common.c files
later on.

The series is based on the linux-samsung/for-next branch of 2012-01-02,
as it needs the restart patches, that create the common.h for some SoCs.

Heiko Stuebner (8):
  S3C24XX: Remove extern declaration of clk_msysclk
  S3C24XX: move common S3C2443 clock definitions to clock.h
  S3C2410: move s3c2410_baseclk_add to clock.h
  S3C2416: move io-init to SoC specific files
  S3C2443: move io-init to SoC specific files
  S3C2440: move io-init to SoC specific files
  S3C2412: move io-init to SoC specific files
  S3C2410: move io-init to SoC specific files

 arch/arm/mach-s3c2410/Makefile               |    2 +-
 arch/arm/mach-s3c2410/common.c               |   80 ++++++++++
 arch/arm/mach-s3c2410/common.h               |   11 ++
 arch/arm/mach-s3c2410/mach-amlm5900.c        |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c            |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c           |    2 +-
 arch/arm/mach-s3c2410/mach-n30.c             |    3 +-
 arch/arm/mach-s3c2410/mach-otom.c            |    3 +-
 arch/arm/mach-s3c2410/mach-qt2410.c          |    2 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c        |    2 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c      |    2 +-
 arch/arm/mach-s3c2410/mach-vr1000.c          |    2 +-
 arch/arm/mach-s3c2410/s3c2410.c              |    3 +-
 arch/arm/mach-s3c2412/Makefile               |    2 +-
 arch/arm/mach-s3c2412/clock.c                |    3 +-
 arch/arm/mach-s3c2412/common.c               |   79 ++++++++++
 arch/arm/mach-s3c2412/common.h               |   30 ++++
 arch/arm/mach-s3c2412/mach-jive.c            |    5 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c        |    6 +-
 arch/arm/mach-s3c2412/mach-vstms.c           |    5 +-
 arch/arm/mach-s3c2412/pm.c                   |    2 +-
 arch/arm/mach-s3c2412/s3c2412.c              |    3 +-
 arch/arm/mach-s3c2416/Makefile               |    2 +-
 arch/arm/mach-s3c2416/clock.c                |    4 +-
 arch/arm/mach-s3c2416/common.c               |   70 +++++++++
 arch/arm/mach-s3c2416/common.h               |   30 ++++
 arch/arm/mach-s3c2416/mach-smdk2416.c        |    6 +-
 arch/arm/mach-s3c2416/s3c2416.c              |    3 +-
 arch/arm/mach-s3c2440/Makefile               |    2 +-
 arch/arm/mach-s3c2440/common.c               |  100 ++++++++++++
 arch/arm/mach-s3c2440/common.h               |   20 +++
 arch/arm/mach-s3c2440/dsc.c                  |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c          |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c       |    2 +-
 arch/arm/mach-s3c2440/mach-gta02.c           |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c        |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c        |    4 +-
 arch/arm/mach-s3c2440/mach-osiris.c          |    2 +-
 arch/arm/mach-s3c2440/mach-rx1950.c          |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c          |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c        |    4 +-
 arch/arm/mach-s3c2440/s3c2440.c              |    3 +-
 arch/arm/mach-s3c2440/s3c2442.c              |    3 +-
 arch/arm/mach-s3c2440/s3c244x.c              |    4 +-
 arch/arm/mach-s3c2443/Makefile               |    2 +-
 arch/arm/mach-s3c2443/clock.c                |    3 +-
 arch/arm/mach-s3c2443/common.c               |   70 +++++++++
 arch/arm/mach-s3c2443/common.h               |   31 ++++
 arch/arm/mach-s3c2443/mach-smdk2443.c        |    6 +-
 arch/arm/mach-s3c2443/s3c2443.c              |    3 +-
 arch/arm/plat-s3c24xx/Makefile               |    1 -
 arch/arm/plat-s3c24xx/cpu.c                  |  208 --------------------------
 arch/arm/plat-s3c24xx/s3c2410-clock.c        |    1 -
 arch/arm/plat-s3c24xx/s3c2443-clock.c        |    1 -
 arch/arm/plat-samsung/include/plat/clock.h   |   22 +++
 arch/arm/plat-samsung/include/plat/cpu.h     |    2 -
 arch/arm/plat-samsung/include/plat/s3c2410.h |   33 ----
 arch/arm/plat-samsung/include/plat/s3c2412.h |   32 ----
 arch/arm/plat-samsung/include/plat/s3c2416.h |   33 ----
 arch/arm/plat-samsung/include/plat/s3c2443.h |   54 -------
 arch/arm/plat-samsung/include/plat/s3c244x.h |   42 -----
 61 files changed, 603 insertions(+), 463 deletions(-)
 create mode 100644 arch/arm/mach-s3c2410/common.c
 create mode 100644 arch/arm/mach-s3c2412/common.c
 create mode 100644 arch/arm/mach-s3c2412/common.h
 create mode 100644 arch/arm/mach-s3c2416/common.c
 create mode 100644 arch/arm/mach-s3c2416/common.h
 create mode 100644 arch/arm/mach-s3c2440/common.c
 create mode 100644 arch/arm/mach-s3c2443/common.c
 create mode 100644 arch/arm/mach-s3c2443/common.h
 delete mode 100644 arch/arm/plat-s3c24xx/cpu.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2410.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2412.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2416.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c244x.h

-- 
1.7.5.4

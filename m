From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Nov 2011 17:31:13 +0000
Subject: [01: PATCH 0/7] Preparation for arch_reset changes
Message-ID: <20111106173113.GI12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series lays down the ground work for changing the way we handle the
reset (now called restart) handling on ARM.

As a result of these patches, we provide a new hook in the machine_desc
record called 'restart' which is pointed at a function to perform the
appropriate restart actions for the platform.  This is called directly
from machine_restart() with IRQs and caches on.

The 'soft_reboot' flag is changed to a more generic 'restart_mode'
character - which is used to initialize the default reboot mode (which
can be changed via the 'reboot=' command line parameter.)

'soft_restart(addr)' is added which performs a soft restart (iow,
orderly shutdown of caches and MMU and a jump to the passed address),
rather than the old way which separated the tear-down of the caches
and MMU from the code doing the jump.  This will be necessary to
resolve the ARMv6 and ARMv7 CPU restarting problems.

Finally, appropriate 'restart_mode' values are added to several
platforms which were hard-coding the restart mode by intercepting
the restarting via arm_pm_restart.

 arch/arm/include/asm/mach/arch.h                  |    9 +++--
 arch/arm/include/asm/system.h                     |    1 +
 arch/arm/kernel/machine_kexec.c                   |    4 +-
 arch/arm/kernel/process.c                         |   35 ++++++++++++--------
 arch/arm/kernel/setup.c                           |    7 +++-
 arch/arm/mach-clps711x/include/mach/system.h      |    2 +-
 arch/arm/mach-ebsa110/core.c                      |    2 +-
 arch/arm/mach-ebsa110/include/mach/system.h       |    2 +-
 arch/arm/mach-ep93xx/include/mach/system.h        |    2 -
 arch/arm/mach-footbridge/cats-hw.c                |    2 +-
 arch/arm/mach-footbridge/include/mach/system.h    |    2 +-
 arch/arm/mach-iop32x/include/mach/system.h        |    4 +--
 arch/arm/mach-iop33x/include/mach/system.h        |    2 +-
 arch/arm/mach-ixp2000/include/mach/system.h       |    2 -
 arch/arm/mach-ixp4xx/include/mach/system.h        |    2 +-
 arch/arm/mach-ks8695/include/mach/system.h        |    2 +-
 arch/arm/mach-lpc32xx/include/mach/system.h       |    3 --
 arch/arm/mach-mmp/include/mach/system.h           |    4 +-
 arch/arm/mach-mxs/system.c                        |    2 +-
 arch/arm/mach-pnx4008/include/mach/system.h       |    2 +-
 arch/arm/mach-pxa/mioa701.c                       |    1 +
 arch/arm/mach-pxa/reset.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                         |    3 ++
 arch/arm/mach-pxa/tosa.c                          |    1 +
 arch/arm/mach-rpc/include/mach/system.h           |    2 +-
 arch/arm/mach-s3c2410/include/mach/system-reset.h |    4 +-
 arch/arm/mach-s3c64xx/include/mach/system.h       |    2 +-
 arch/arm/mach-sa1100/include/mach/system.h        |    2 +-
 arch/arm/mach-shark/core.c                        |    1 -
 arch/arm/mach-shmobile/include/mach/system.h      |    2 +-
 arch/arm/mach-u300/include/mach/system.h          |    2 -
 arch/arm/mach-w90x900/include/mach/system.h       |    2 +-
 arch/arm/mm/idmap.c                               |    2 +-
 arch/arm/mm/nommu.c                               |    2 +-
 arch/arm/plat-mxc/system.c                        |    2 +-
 arch/arm/plat-spear/include/plat/system.h         |    2 +-
 36 files changed, 64 insertions(+), 59 deletions(-)

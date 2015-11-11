From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 11 Nov 2015 16:49:16 +0000
Subject: [PATCH v3 0/6] Xen wallclock on arm and arm64
Message-ID: <alpine.DEB.2.02.1511111639500.5676@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series introduces PV wallclock time support on arm and arm64.

Changes in v3:
- use ktime_get_ns instead of calling into the arch_timer functions
  directly
- read the wallclock from the late_initcall
- s/%llu.%0u/%llu.%09u
- in xen_pvclock_gtod_notify use the passed struct timekeeper pointer
  rather than calling __current_kernel_time64
- use the passed struct timekeeper pointer to get the system time too
- drop introduce __current_kernel_time64


Changes in v2:
- introduce __current_kernel_time64
- rename dom0_op to platform_op
- introduce XENPF_settime64
- extend pvclock_wall_clock with sec_hi
- properly convert arch_timer ticker to nsec
- use timespec64 interfaces
- use sec_hi to get a 64-bit seconds value
- use XENPF_settime64
- rename dom0_op to platform_op


Stefano Stabellini (6):
      xen: rename dom0_op to platform_op
      xen/arm: introduce HYPERVISOR_platform_op on arm and arm64
      xen: introduce XENPF_settime64
      arm: extend pvclock_wall_clock with sec_hi
      xen/arm: introduce xen_read_wallclock
      xen/arm: set the system time in Xen via the XENPF_settime64 hypercall

 arch/arm/include/asm/xen/hypercall.h |    2 +
 arch/arm/include/asm/xen/interface.h |    1 +
 arch/arm/xen/enlighten.c             |   86 +++++++++++++++++++++++++++++++++-
 arch/arm/xen/hypercall.S             |    1 +
 arch/arm64/xen/hypercall.S           |    1 +
 arch/x86/include/asm/xen/hypercall.h |    6 +--
 arch/x86/xen/apic.c                  |    2 +-
 arch/x86/xen/enlighten.c             |    8 ++--
 arch/x86/xen/time.c                  |   10 ++--
 drivers/xen/acpi.c                   |    2 +-
 drivers/xen/efi.c                    |   30 ++++++------
 drivers/xen/pcpu.c                   |    8 ++--
 drivers/xen/xen-acpi-cpuhotplug.c    |    2 +-
 drivers/xen/xen-acpi-pad.c           |    4 +-
 drivers/xen/xen-acpi-processor.c     |    8 ++--
 drivers/xen/xenfs/xensyms.c          |    4 +-
 include/xen/interface/platform.h     |   18 +++++--
 include/xen/interface/xen.h          |    2 +-
 18 files changed, 147 insertions(+), 48 deletions(-)

Cheers,

Stefano

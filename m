From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 3 Nov 2015 16:18:52 +0000
Subject: [PATCH v10 0/5] xen/arm/arm64: CONFIG_PARAVIRT and stolen ticks
 accounting
Message-ID: <alpine.DEB.2.02.1511031536540.3438@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I dusted off this series from Jan 2014. Patch #2 and #3 still need an ack.


This patch series introduces stolen ticks accounting for Xen on ARM and
ARM64.  Stolen ticks are clocksource ticks that have been "stolen" from
the cpu, typically because Linux is running in a virtual machine and the
vcpu has been descheduled.  To account for these ticks we introduce
CONFIG_PARAVIRT and pv_time_ops so that we can make use of:

kernel/sched/cputime.c:steal_account_process_tick

Changes in v10:
- rebase
- remove ia64 xen changes
- add acks
- send the correct version of patch #2 (last time I sent an older
  version by mistake)
- remove ifdef CONFIG_PARAVIRT from kernel/sched/core.c
- replace "---help---" with "help" in arm and arm64 Kconfig changes


Stefano Stabellini (5):
      xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
      missing include in cputime.c, remove #ifdef CONFIG_PARAVIRT from sched/core.c
      arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      xen/arm: account for stolen ticks

 arch/arm/Kconfig                  |   20 ++++++++
 arch/arm/include/asm/paravirt.h   |   20 ++++++++
 arch/arm/kernel/Makefile          |    1 +
 arch/arm/kernel/paravirt.c        |   25 ++++++++++
 arch/arm/xen/enlighten.c          |   21 +++++++++
 arch/arm64/Kconfig                |   20 ++++++++
 arch/arm64/include/asm/paravirt.h |   20 ++++++++
 arch/arm64/kernel/Makefile        |    1 +
 arch/arm64/kernel/paravirt.c      |   25 ++++++++++
 arch/x86/xen/time.c               |   76 +------------------------------
 drivers/xen/Makefile              |    2 +-
 drivers/xen/time.c                |   91 +++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h             |    5 ++
 kernel/sched/core.c               |    2 -
 kernel/sched/cputime.c            |    1 +
 15 files changed, 252 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/include/asm/paravirt.h
 create mode 100644 arch/arm/kernel/paravirt.c
 create mode 100644 arch/arm64/include/asm/paravirt.h
 create mode 100644 arch/arm64/kernel/paravirt.c
 create mode 100644 drivers/xen/time.c

Cheers,

Stefano

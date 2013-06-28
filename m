From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 28 Jun 2013 12:19:54 +0100
Subject: [PATCH v7 0/6] xen/arm/arm64: CONFIG_PARAVIRT and stolen ticks
 accounting
Message-ID: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces stolen ticks accounting for Xen on ARM and
ARM64.
Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
typically because Linux is running in a virtual machine and the vcpu has
been descheduled.
To account for these ticks we introduce CONFIG_PARAVIRT and pv_time_ops
so that we can make use of:

kernel/sched/cputime.c:steal_account_process_tick


Stefano Stabellini (6):
      xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
      kernel: missing include in cputime.c
      arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      core: remove ifdef CONFIG_PARAVIRT
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
 arch/ia64/xen/time.c              |   48 +++-----------------
 arch/x86/xen/time.c               |   76 +------------------------------
 drivers/xen/Makefile              |    2 +-
 drivers/xen/time.c                |   91 +++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h             |    5 ++
 kernel/sched/core.c               |    2 -
 kernel/sched/cputime.c            |    1 +
 16 files changed, 258 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/include/asm/paravirt.h
 create mode 100644 arch/arm/kernel/paravirt.c
 create mode 100644 arch/arm64/include/asm/paravirt.h
 create mode 100644 arch/arm64/kernel/paravirt.c
 create mode 100644 drivers/xen/time.c

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_7


Cheers,

Stefano

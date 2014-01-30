From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Thu, 30 Jan 2014 11:11:05 -0500
Subject: [PATCH V3 0/5] ARM CoreSight: ETM: Fix a vmalloc/vfree failure and
 enhance tracing control
Message-ID: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Different ARM users have shown their interest in this patch, so I made
a third version that is compatible with PID namespaces.

Mainly:
- It fixes a "vmalloc: allocation failure: 0 bytes" when reading an
  ETB buffer that is empty.
- It extends current support of CoreSight ETM, that is currently
  very limited.

ETM is a dedicated hardware that provides program tracing, a
cycle-precise and low-overhead solution that software tools such as
'perf record' cannot provide.

Usage of ETM tracing facility is presently limited to start and stop
tracing.  This set of patches enables management of address combinations
and PIDs that trigger tracing, thus allowing to trace specific
functions and processes.  ETM management was done via sysfs entries
(trace_info, trace_running...), this code adds trace_addrrange and
trace_pid to let the user read/write custom values.

Changes in V2:
- Fix a vmalloc/vfree failure when ETB is empty
- Use device attributes rather than raw kobjects
- Make PID_IN_CONTEXTIDR incompatible with PID_NS in Kconfig
- Use pid_t instead of long

Changes in V3:
- Support tracing processes by their PID in PID namespaces
- Reset PID_IN_CONTEXTIDR and PID_NS independent

This series of patches applies to v3.13.

Adrien Verg? (5):
  ARM CoreSight: ETM: Fix a memory allocation failure
  ARM CoreSight: ETM: Use device attributes
  ARM CoreSight: ETM: Rename 'comparator' to 'address comparator'
  ARM CoreSight: ETM: Add address control support
  ARM CoreSight: ETM: Add PID control support

 arch/arm/include/asm/hardware/coresight.h |   9 +-
 arch/arm/kernel/etm.c                     | 257 ++++++++++++++++++++++++------
 2 files changed, 216 insertions(+), 50 deletions(-)

-- 
1.8.5.3

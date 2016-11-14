From: panand@redhat.com (Pratyush Anand)
Date: Mon, 14 Nov 2016 19:32:41 +0530
Subject: [PATCH V3 0/5] ARM64: More flexible HW watchpoint
Message-ID: <cover.1479130617.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we do not support all the byte select option provided by ARM64
specs for a HW watchpoint.

This patch set will help user to instrument a watchpoint with all possible
byte select options.

Changes since v2:
- used __ffs() instead of ffs() - 1. Similarly for fls().
- fixed ptrace_hbp_get_addr() to report correct address to user space
- handling stepping for inexact watchpoint as well now.

Changes since v1:
- Introduced a new patch 3/5 where it takes care of the situation when HW
does not report a watchpoint hit with the address that matches one of the
watchpoints set.
- Added corresponding test case to test that functionality.

Pavel Labath (1):
  arm64: hw_breakpoint: Handle inexact watchpoint addresses

Pratyush Anand (4):
  hw_breakpoint: Allow watchpoint of length 3,5,6 and 7
  arm64: Allow hw watchpoint at varied offset from base address
  arm64: Allow hw watchpoint of length 3,5,6 and 7
  selftests: arm64: add test for unaligned/inexact watchpoint handling

 arch/arm64/include/asm/hw_breakpoint.h             |   6 +-
 arch/arm64/kernel/hw_breakpoint.c                  | 153 +++++++++----
 arch/arm64/kernel/ptrace.c                         |   7 +-
 include/uapi/linux/hw_breakpoint.h                 |   4 +
 tools/include/uapi/linux/hw_breakpoint.h           |   4 +
 tools/testing/selftests/breakpoints/Makefile       |   5 +-
 .../selftests/breakpoints/breakpoint_test_arm64.c  | 236 +++++++++++++++++++++
 7 files changed, 372 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c

-- 
2.7.4

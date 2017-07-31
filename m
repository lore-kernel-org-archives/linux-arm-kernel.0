From: panand@redhat.com (Pratyush Anand)
Date: Mon, 31 Jul 2017 16:10:28 +0530
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
Message-ID: <cover.1501496603.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 -> v3
- Moved step_needed from uapi structure to kernel only structure
- Re-enable interrupt if stepped instruction faults
- Modified register_wide_hw_breakpoint() to accept step_needed arg
v2 was here: http://marc.info/?l=linux-arm-kernel&m=149942910730496&w=2

v1 -> v2:
- patch 1 of v1 has been modified to patch 1-3 of v2.
- Introduced a new event attribute step_needed and implemented
  hw_breakpoint_needs_single_step() (patch 1)
- Replaced usage of is_default_overflow_handler() with
  hw_breakpoint_needs_single_step(). (patch 2)
- Modified sample test to set set step_needed bit field (patch 3)
v1 was here: http://marc.info/?l=linux-arm-kernel&m=149910958418708&w=2

samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
tried to come up with patches which can resolve it for ARM64 as well.

I noticed that even perf step exception can go into an infinite loop if CPU
receives an interrupt while executing breakpoint/watchpoint handler. So,
event though we are not concerned about above test, we will have to find a
solution for the perf issue.

This patchset attempts to resolve both the issue. Please review.
Since, it also takes care of SW breakpoint, so I hope kgdb should also be
fine. However, I have not tested that.
@Takahiro: Will it be possible to test these patches for kgdb.

[1] http://marc.info/?l=linux-arm-kernel&m=149580777524910&w=2
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/425266.html


Pratyush Anand (5):
  hw_breakpoint: Add step_needed event attribute
  arm64: use hw_breakpoint_needs_single_step() to decide if step is
    needed
  register_wide_hw_breakpoint(): modify to accept step_needed arg
  arm64: disable irq between breakpoint and step exception
  arm64: fault: re-enable irq if it was disabled for single stepping

 arch/arm64/kernel/debug-monitors.c      |  3 +++
 arch/arm64/kernel/hw_breakpoint.c       | 10 +++++-----
 arch/arm64/mm/fault.c                   | 28 ++++++++++++++++++++++++----
 arch/x86/kernel/kgdb.c                  |  2 +-
 include/linux/hw_breakpoint.h           | 10 ++++++++--
 include/linux/perf_event.h              |  6 ++++++
 kernel/events/core.c                    |  2 ++
 kernel/events/hw_breakpoint.c           |  4 +++-
 samples/hw_breakpoint/data_breakpoint.c |  3 ++-
 9 files changed, 54 insertions(+), 14 deletions(-)

-- 
2.9.4

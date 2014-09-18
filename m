From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Thu, 18 Sep 2014 09:59:32 -0500
Subject: [PATCH v2 0/3] arm_arch_timer: VDSO preparation, code consolidation
Message-ID: <1411052390-27238-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the necessary changes to allow architected timer
access from user-space on 32-bit ARM.  This allows the VDSO to support
high resolution timestamps for clock_gettime and gettimeofday.  This
also merges substantially similar code from arm and arm64 into the
core arm_arch_timer driver.

The functional changes are:
- When available, CNTVCT is made readable by user space on arm, as it
  is on arm64.
- The clocksource name becomes "arch_mem_counter" if CP15 access to
  the counter is not available.

These changes have been carried as part of the ARM VDSO patch set over
the last several months, but I am splitting them out here as I assume
they should go through the clocksource maintainers.

Changes since v1:
- Fix minor checkpatch complaints.
- Rework patches 2-4.  v1 copied arm64's arch_timer_evtstrm_enable
  and arch_counter_set_user_access to the driver with slightly
  different names in one patch, then removed the unused functions in
  subsequent patches for each of arm and arm64.  This seemed kind of
  awkward to me, so I've reorganized those changes into two patches
  that should be easier to review.  Patch #1 is unchanged.

Nathan Lynch (3):
  clocksource: arm_arch_timer: change clocksource name if CP15
    unavailable
  clocksource: arm_arch_timer: enable counter access for 32-bit ARM
  clocksource: arm_arch_timer: consolidate arch_timer_evtstrm_enable

 arch/arm/include/asm/arch_timer.h    | 25 --------------------
 arch/arm64/include/asm/arch_timer.h  | 31 -------------------------
 drivers/clocksource/arm_arch_timer.c | 44 ++++++++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 58 deletions(-)

-- 
1.9.3

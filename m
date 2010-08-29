From: will.deacon@arm.com (Will Deacon)
Date: Sun, 29 Aug 2010 19:51:58 +0100
Subject: [PATCH 0/3] stop OProfile calling arch_exit when arch_init fails
Message-ID: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches remove the oprofile_arch_exit call from oprofile_init,
allowing architectures that perform memory allocation in their init
functions to be simplified. This requires some changes to the ARM and
x86 OProfile backends to ensure that their init functions clean up
after themselves if they fail.

This is required for Matt's combined OProfile/Perf driver which will
be shared between all architectures.

Patches taken against tip/master.

Cc: Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>

Will Deacon (3):
  oprofile: don't call arch exit code from init code on failure
  ARM: oprofile: fix and simplify init/exit functions
  x86: oprofile: fix oprofile_arch_init behaviour on failure

 arch/arm/oprofile/common.c |   47 +++++++++++++++++++++++--------------------
 arch/x86/oprofile/init.c   |   26 ++++++++++++++----------
 drivers/oprofile/oprof.c   |   11 +--------
 3 files changed, 42 insertions(+), 42 deletions(-)

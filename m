From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Feb 2015 17:21:31 +0530
Subject: [PATCH 0/3] clockevents: Manage device's state separately for core
Message-ID: <cover.1425037853.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas/Ingo,

This is in response to the suggestions Ingo gave [1] on the shortcomings of
clockevents core's state machine.

This first separates out the RESUME functionality from other states as its a
special case. Then it defines a new enum to map possible states of a clockevent
device.

Ideally it should only be available for the core, but as bL switcher is using it
today, it is exposed in clockchips.h. That dependency will go away after
applying the Thomas's work (Sent out be Peter) and then we can move this enum to
somewhere in kernel/time/.

The last patch moves the legacy check to the legacy code.

Please see if this meets your expectation or if you have some suggestions on it.

Rebased of tip/master as there were some dependencies:
575daeea39a3 Merge branch 'tools/kvm'

This along with migration of few clockevents drivers is pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git clkevt/manage-state

--
Viresh

[1] https://lkml.org/lkml/2015/2/20/107

Viresh Kumar (3):
  clockevents: Handle tick device's resume separately
  clockevents: Manage device's state separately for the core
  clockevents: Don't validate dev->mode against CLOCK_EVT_MODE_UNUSED
    for new interface

 arch/arm/common/bL_switcher.c |   8 +--
 include/linux/clockchips.h    |  48 +++++++++++------
 kernel/time/clockevents.c     | 118 ++++++++++++++++++++++++------------------
 kernel/time/tick-broadcast.c  |  22 ++++----
 kernel/time/tick-common.c     |   9 ++--
 kernel/time/tick-internal.h   |   1 +
 kernel/time/tick-oneshot.c    |   6 +--
 kernel/time/timer_list.c      |  16 +++---
 8 files changed, 134 insertions(+), 94 deletions(-)

-- 
2.3.0.rc0.44.ga94655d

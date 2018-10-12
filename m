From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Oct 2018 16:46:29 +0100
Subject: [GIT PULL] Couple more arm64 fixes for 4.19
Message-ID: <20181012154629.GB11387@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Please pull these two arm64 fixes for 4.19. One of them fixes a nasty
WARN() that has started triggering because we assumed that memory
reservations from firmware would always correspond to regions of the
physical address space that we have mapped as memory. Unfortunately,
some existing device-tree files break this assumption and we need to
continue supporting them. The other fix addresses an issue where a
CHAIN PMU event can be requested as a 32-bit counter via perf, which
makes no sense in isolation since these events are intended to be used
in conjunction with another event when creating a 64-bit counter.

This is summarised in the tag.

Cheers,

Will

--->8

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ca2b497253ad01c80061a1f3ee9eb91b5d54a849:

  arm64: perf: Reject stand-alone CHAIN events for PMUv3 (2018-10-12 15:25:17 +0100)

----------------------------------------------------------------
More arm64 fixes

- Reject CHAIN PMU events when they are not part of a 64-bit counter

- Fix WARN_ON_ONCE() that triggers for reserved regions that don't
  correspond to mapped memory

----------------------------------------------------------------
Will Deacon (2):
      arm64: Fix /proc/iomem for reserved but not memory regions
      arm64: perf: Reject stand-alone CHAIN events for PMUv3

 arch/arm64/kernel/perf_event.c |  7 ++++++
 arch/arm64/kernel/setup.c      | 56 ++++++++++++++++++++----------------------
 drivers/perf/arm_pmu.c         |  8 +++++-
 include/linux/perf/arm_pmu.h   |  1 +
 4 files changed, 42 insertions(+), 30 deletions(-)

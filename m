From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 17:31:49 +0100
Subject: [PATCH 0/6] PMUv3 event handling improvements
Message-ID: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Following on-list discussion with Ganapat [1], I found and fixed a few
issues with the arm64 PMUv3 code:

  - We don't reject standalone CHAIN events requested in a 32-bit perf event
  - We don't interpret the upper 32 bits of the PMCEID registers for 8.1 events
  - We have duplicate cache events for read and write, which is very confusing
  - Our events are straddled between arm_pmu.c and arm_pmu.h and aren't in
    numerical order
  - We don't advertise a bunch fo new events that have been added since v8.0

This series addresses all of these problems.

Cheers,

Will

[1] http://lkml.kernel.org/r/CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ at mail.gmail.com

--->8

Will Deacon (6):
  arm64: perf: Reject stand-alone CHAIN events for PMUv3
  arm64: perf: Terminate PMU assignment statements with semicolons
  arm64: perf: Add support for Armv8.1 PMCEID register format
  arm64: perf: Remove duplicate generic cache events
  arm64: perf: Move event definitions into perf_event.h
  arm64: perf: Hook up new events

 arch/arm64/include/asm/perf_event.h | 164 ++++++++++++++++++++++++--
 arch/arm64/kernel/perf_event.c      | 225 ++++++++++--------------------------
 drivers/perf/arm_pmu.c              |   8 +-
 include/linux/perf/arm_pmu.h        |   5 +-
 4 files changed, 225 insertions(+), 177 deletions(-)

-- 
2.1.4

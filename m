From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Feb 2010 18:18:31 +0000
Subject: [PATCH] ARM: perf-events: fix v7 event selection mask
Message-ID: <1267121911-18667-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The event selection mask for ARMv7 cores [ARMV7_EVTSEL_MASK]
is incorrectly set to 0x7f. This means that the top bit of an
event ID is ignored, so counting branch misses (id=0x10) and
ISBs (id=0x90) give the same results.

This patch sets the event selection mask to the correct value
of 0xff.

Cc: Jean Pihet <jpihet@mvista.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index b44d159..c45a155 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -1625,7 +1625,7 @@ enum armv7_counters {
 /*
  * EVTSEL: Event selection reg
  */
-#define	ARMV7_EVTSEL_MASK	0x7f		/* Mask for writable bits */
+#define	ARMV7_EVTSEL_MASK	0xff		/* Mask for writable bits */
 
 /*
  * SELECT: Counter selection reg
-- 
1.6.3.3

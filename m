From: will.deacon@arm.com (Will Deacon)
Date: Wed,  3 Nov 2010 17:22:26 +0000
Subject: [PATCH 2/3] ARM: perf-events: squash compiler warning
In-Reply-To: <1288804947-21213-1-git-send-email-will.deacon@arm.com>
References: <1288804947-21213-1-git-send-email-will.deacon@arm.com>
Message-ID: <1288804947-21213-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

armv7_pmnc_counter_has_overflowed can return uninitialised data
if an invalid counter is specified.

This patch fixes the code to return 0 in this case, which squashes
the compiler warning from GCC 4.5.

Cc: Jean Pihet <jpihet@mvista.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 49643b1..07a5035 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -1749,7 +1749,7 @@ static inline int armv7_pmnc_has_overflowed(unsigned long pmnc)
 static inline int armv7_pmnc_counter_has_overflowed(unsigned long pmnc,
 					enum armv7_counters counter)
 {
-	int ret;
+	int ret = 0;
 
 	if (counter == ARMV7_CYCLE_COUNTER)
 		ret = pmnc & ARMV7_FLAG_C;
-- 
1.7.0.4

From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 17 Jul 2013 12:46:53 +0300
Subject: [PATCH] time: sched_clock: fix integer overflow
Message-ID: <232c026d1b8d2556679aea56cf77a6811f9a96c5.1374054369.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The expression '(1 << 32)' happens to evaluate as 0 on ARM, but it evaluates as
1 on xtensa and x86_64. This zeros sched_clock_mask, and breaks sched_clock().
Set the type of 1 to 'unsigned long long' to get the value we need.

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index a326f27..0b479a6 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -121,7 +121,7 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 	BUG_ON(bits > 32);
 	WARN_ON(!irqs_disabled());
 	read_sched_clock = read;
-	sched_clock_mask = (1 << bits) - 1;
+	sched_clock_mask = (1ULL << bits) - 1;
 	cd.rate = rate;
 
 	/* calculate the mult/shift to convert counter ticks to ns. */
-- 
1.8.3.2

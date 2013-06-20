From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 17:43:32 +0100
Subject: [PATCH v2 2/2] init: calibrate: don't print out bogomips value on boot
In-Reply-To: <1371746612-23950-1-git-send-email-will.deacon@arm.com>
References: <1371746612-23950-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371746612-23950-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BogoMIPs is a confusing concept to the ill-informed, so allow
architectures to print it only if they find it worthwhile. The delay
calibration code should stick to lpj and avoid trying to draw any
correlation with BogoMIPs, which may be a fixed value derived from a
timer frequency independent of the CPU clock speed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 init/calibrate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/init/calibrate.c b/init/calibrate.c
index fda0a7b..cf48068 100644
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -135,13 +135,13 @@ static unsigned long __cpuinit calibrate_delay_direct(void)
 		if ((measured_times[max] - estimate) <
 				(estimate - measured_times[min])) {
 			printk(KERN_NOTICE "calibrate_delay_direct() dropping "
-					"min bogoMips estimate %d = %lu\n",
+					"min delay estimate %d = %lu\n",
 				min, measured_times[min]);
 			measured_times[min] = 0;
 			min = max;
 		} else {
 			printk(KERN_NOTICE "calibrate_delay_direct() dropping "
-					"max bogoMips estimate %d = %lu\n",
+					"max delay estimate %d = %lu\n",
 				max, measured_times[max]);
 			measured_times[max] = 0;
 			max = min;
@@ -292,9 +292,7 @@ void __cpuinit calibrate_delay(void)
 	}
 	per_cpu(cpu_loops_per_jiffy, this_cpu) = lpj;
 	if (!printed)
-		pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
-			lpj/(500000/HZ),
-			(lpj/(5000/HZ)) % 100, lpj);
+		pr_cont("lpj=%lu\n", lpj);
 
 	loops_per_jiffy = lpj;
 	printed = true;
-- 
1.8.2.2

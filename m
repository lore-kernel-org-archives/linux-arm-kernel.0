From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Fri, 31 May 2013 16:14:26 +0530
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
Message-ID: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code considers every wakeup as spurious, which is not
correct. Handle the same way as other arm platforms are doing.

Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
---
 arch/arm/mach-zynq/hotplug.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
index c89672b..a1ab22c 100644
--- a/arch/arm/mach-zynq/hotplug.c
+++ b/arch/arm/mach-zynq/hotplug.c
@@ -67,6 +67,13 @@ static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
 		dsb();
 		wfi();
 
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
 		/*
 		 * Getting here, means that we have come out of WFI without
 		 * having been woken up - this shouldn't happen
-- 
1.7.9.5

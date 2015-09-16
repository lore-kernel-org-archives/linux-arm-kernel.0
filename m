From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:09 +0100
Subject: [PATCH 11/22] arm64: Populate cpuinfo after notify_cpu_starting
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch delays populating the cpuinfo for a new (hotplugged)
CPU until the notifiers have executed. This will enable us to verify
if the new (hotplugged) CPU has all the capabilities which the system
already has. If it doesn't, we could prevent it from turning online and
also modifying the system wide feature register status.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index cb3e0d8..6987de4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -163,14 +163,14 @@ asmlinkage void secondary_start_kernel(void)
 		cpu_ops[cpu]->cpu_postboot();
 
 	/*
-	 * Log the CPU info before it is marked online and might get read.
+	 * Enable GIC and timers.
 	 */
-	cpuinfo_store_cpu();
+	notify_cpu_starting(cpu);
 
 	/*
-	 * Enable GIC and timers.
+	 * Log the CPU info before it is marked online and might get read.
 	 */
-	notify_cpu_starting(cpu);
+	cpuinfo_store_cpu();
 
 	smp_store_cpu_info(cpu);
 
-- 
1.7.9.5

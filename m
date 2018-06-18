From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 Jun 2018 14:18:41 +0100
Subject: [PATCH v2 5/7] arm64: smp: remove cpu and numa topology information
 when hotplugging out CPU
In-Reply-To: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1529327923-17911-6-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already repopulate the information on CPU hotplug-in, so we can safely
remove the CPU topology and NUMA cpumap information during CPU hotplug
out operation. This will help to provide the correct cpumask for
scheduler domains.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 49a021e30dfb..63a40ba3cd37 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -279,6 +279,9 @@ int __cpu_disable(void)
 	if (ret)
 		return ret;

+	remove_cpu_topology(cpu);
+	numa_remove_cpu(cpu);
+
 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
 	 * and we must not schedule until we're ready to give up the cpu.
--
2.7.4

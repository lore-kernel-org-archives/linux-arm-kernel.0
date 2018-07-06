From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:46 +0100
Subject: [PATCH v3 5/7] arm64: smp: remove cpu and numa topology information
 when hotplugging out CPU
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-6-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already repopulate the information on CPU hotplug-in, so we can safely
remove the CPU topology and NUMA cpumap information during CPU hotplug
out operation. This will help to provide the correct cpumask for
scheduler domains.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2a315f32fad3..a44cc09059b5 100644
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

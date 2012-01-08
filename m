From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun,  8 Jan 2012 15:32:21 +0200
Subject: [RFC PATCH v2 1/9] arm: avoid using on_each_cpu hard coded ret value
In-Reply-To: <1326029549-2794-1-git-send-email-gilad@benyossef.com>
References: <1326029549-2794-1-git-send-email-gilad@benyossef.com>
Message-ID: <1326029549-2794-2-git-send-email-gilad@benyossef.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on_each_cpu always returns a hard coded return code of zero.

Removing all tests based on this return value saves run time
cycles for compares and code bloat for branches.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Reviewed-by: Michal Nazarewicz <mina86@mina86.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Paul Mackerras <paulus@samba.org>
CC: Ingo Molnar <mingo@elte.hu>
CC: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
CC: Russell King <linux@arm.linux.org.uk>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Rob Herring <rob.herring@calxeda.com>
CC: linux-arm-kernel at lists.infradead.org
CC: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5bb91bf..6e9acb7 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -616,7 +616,7 @@ static int __init
 cpu_pmu_reset(void)
 {
 	if (cpu_pmu && cpu_pmu->reset)
-		return on_each_cpu(cpu_pmu->reset, NULL, 1);
+		on_each_cpu(cpu_pmu->reset, NULL, 1);
 	return 0;
 }
 arch_initcall(cpu_pmu_reset);
-- 
1.7.0.4

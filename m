From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 21 Oct 2013 13:30:32 +0100
Subject: [PATCH] ARM: DT/kernel: fix arch_match_cpu_phys_id to avoid erroneous
 match
Message-ID: <1382358632-32762-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

The MPIDR contains specific bitfields(MPIDR.Aff{2..0}) which uniquely
identify a CPU, in addition to some non-identifying information and
reserved bits. The ARM cpu binding defines the 'reg' property to only
contain the affinity bits, and any cpu nodes with other bits set in
their 'reg' entry are skipped.

As such it is not necessary to mask the phys_id with MPIDR_HWID_BITMASK,
and doing so could lead to matching erroneous CPU nodes in the device
tree. This patch removes the masking of the physical identifier.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/devtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f35906b..41960fb 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -171,7 +171,7 @@ void __init arm_dt_init_cpu_maps(void)
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
-	return (phys_id & MPIDR_HWID_BITMASK) == cpu_logical_map(cpu);
+	return phys_id == cpu_logical_map(cpu);
 }
 
 /**
-- 
1.8.1.2

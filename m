From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 10:30:07 +0100
Subject: [PATCH v4 05/19] ARM: DT/kernel: define ARM specific
 arch_match_cpu_phys_id
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376991021-12160-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

OF/DT core library now provides architecture specific hook to match the
logical cpu index with the corresponding physical identifier. Most of the
cpu DT node parsing and initialisation is contained in devtree.c. So it's
better to define ARM specific arch_match_cpu_phys_id there.

This mainly helps to avoid replication of the code doing CPU node parsing
and physical(MPIDR) to logical mapping.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/kernel/devtree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5859c8b..2ee8a17 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -169,6 +169,11 @@ void __init arm_dt_init_cpu_maps(void)
 	}
 }
 
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return (phys_id & MPIDR_HWID_BITMASK) == cpu_logical_map(cpu);
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
-- 
1.8.1.2

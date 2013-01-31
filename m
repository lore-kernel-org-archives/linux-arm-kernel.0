From: robherring2@gmail.com (Rob Herring)
Date: Thu, 31 Jan 2013 14:01:13 -0600
Subject: [PATCH 2/3] ARM: scu: mask cluster id from cpu_logical_map
In-Reply-To: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
References: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
Message-ID: <1359662474-1883-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit a0ae0240 (ARM: kernel: add device tree init map function),
the cpu id value may include the cluster id and is no longer 0-3, so we
need to mask it in scu_power_mode to get the local cpu number. Since we
are only dealing with the cpu we are running on, the cluster id should
not ever be needed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/smp_scu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index b9f015e..45eac87 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -75,7 +75,7 @@ void scu_enable(void __iomem *scu_base)
 int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 {
 	unsigned int val;
-	int cpu = cpu_logical_map(smp_processor_id());
+	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
 
 	if (mode > 3 || mode == 1 || cpu > 3)
 		return -EINVAL;
-- 
1.7.10.4

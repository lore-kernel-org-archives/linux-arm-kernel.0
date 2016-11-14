From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:03 +0530
Subject: [PATCH 08/16] ARM: vexpress: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-9-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Liviu Dudau <liviu.dudau@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-vexpress/platsmp.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 8b8d072..17dee2b 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -41,20 +41,9 @@ bool __init vexpress_smp_init_ops(void)
 	return false;
 }
 
-static const struct of_device_id vexpress_smp_dt_scu_match[] __initconst = {
-	{ .compatible = "arm,cortex-a5-scu", },
-	{ .compatible = "arm,cortex-a9-scu", },
-	{}
-};
-
 static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
 {
-	struct device_node *scu = of_find_matching_node(NULL,
-			vexpress_smp_dt_scu_match);
-
-	if (scu)
-		scu_enable(of_iomap(scu, 0));
-
+	of_scu_enable();
 	/*
 	 * Write the address of secondary startup into the
 	 * system-wide flags register. The boot monitor waits
-- 
2.7.4

From: j@bitron.ch (=?UTF-8?q?J=C3=BCrg=20Billeter?=)
Date: Mon, 24 Feb 2014 12:22:40 +0100
Subject: [PATCH] ARM: kernel: respect device tree status of cpu nodes
Message-ID: <1393240960-31846-1-git-send-email-j@bitron.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Skip 'disabled' cpu nodes when building the cpu logical map. This avoids
booting cpus that have been disabled in the device tree.

Signed-off-by: J?rg Billeter <j@bitron.ch>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/devtree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 739c3df..9aed299 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -95,6 +95,10 @@ void __init arm_dt_init_cpu_maps(void)
 		if (of_node_cmp(cpu->type, "cpu"))
 			continue;
 
+		/* Check if CPU is enabled */
+		if (!of_device_is_available(cpu))
+			continue;
+
 		pr_debug(" * %s...\n", cpu->full_name);
 		/*
 		 * A device tree containing CPU nodes with missing "reg"
-- 
1.9.0

From: robh@kernel.org (Rob Herring)
Date: Wed,  5 Sep 2018 14:37:20 -0500
Subject: [PATCH 03/21] ARM: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Message-ID: <20180905193738.19325-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm/kernel/devtree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index ecaa68dd1af5..13bcd3b867cb 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -87,14 +87,11 @@ void __init arm_dt_init_cpu_maps(void)
 	if (!cpus)
 		return;

-	for_each_child_of_node(cpus, cpu) {
+	for_each_of_cpu_node(cpu) {
 		const __be32 *cell;
 		int prop_bytes;
 		u32 hwid;

-		if (of_node_cmp(cpu->type, "cpu"))
-			continue;
-
 		pr_debug(" * %pOF...\n", cpu);
 		/*
 		 * A device tree containing CPU nodes with missing "reg"
--
2.17.1

From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Apr 2017 15:33:27 -0700
Subject: [PATCH 1/2] ARM: Silence first allocation with
 CONFIG_ARM_MODULE_PLTS=y
In-Reply-To: <20170425223332.6999-1-f.fainelli@gmail.com>
References: <20170425223332.6999-1-f.fainelli@gmail.com>
Message-ID: <20170425223332.6999-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARM_MODULE_PLTS is enabled, the first allocation using the
module space fails, because the module is too big, and then the module
allocation is attempted from vmalloc space. Silence the first allocation
failure in that case by setting __GFP_NOWARN.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/kernel/module.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 80254b47dc34..503d1a39464a 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -40,8 +40,15 @@
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
-	void *p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+	gfp_t gfp_mask = GFP_KERNEL;
+	void *p;
+
+#if IS_ENABLED(CONFIG_ARM_MODULE_PLTS)
+	/* Silence the initial allocation */
+	gfp_mask |= __GFP_NOWARN;
+#endif
+	p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+				gfp_mask, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
 		return p;
-- 
2.9.3

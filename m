From: rick.p.edgecombe@intel.com (Rick Edgecombe)
Date: Thu, 11 Oct 2018 16:31:13 -0700
Subject: [PATCH v2 3/7] arm/modules: Add rlimit checking for arm modules
In-Reply-To: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
Message-ID: <20181011233117.7883-4-rick.p.edgecombe@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds in the rlimit checking for the arm module allocator.

This has not been tested.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/arm/kernel/module.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..e331863553d2 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -43,6 +43,9 @@ void *module_alloc(unsigned long size)
 	gfp_t gfp_mask = GFP_KERNEL;
 	void *p;
 
+	if (check_inc_mod_rlimit(size))
+		return NULL;
+
 	/* Silence the initial allocation */
 	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
 		gfp_mask |= __GFP_NOWARN;
@@ -51,10 +54,15 @@ void *module_alloc(unsigned long size)
 				gfp_mask, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
-		return p;
-	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
+		goto done;
+	p = __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
 				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
+
+done:
+	update_mod_rlimit(p, size);
+
+	return p;
 }
 #endif
 
-- 
2.17.1

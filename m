From: rick.p.edgecombe@intel.com (Rick Edgecombe)
Date: Thu, 11 Oct 2018 16:31:14 -0700
Subject: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64 modules
In-Reply-To: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
Message-ID: <20181011233117.7883-5-rick.p.edgecombe@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds in the rlimit checking for the arm64 module allocator.

This has not been tested.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/arm64/kernel/module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f0f27aeefb73..ea9794f2f571 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -39,6 +39,9 @@ void *module_alloc(unsigned long size)
 	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
 		gfp_mask |= __GFP_NOWARN;
 
+	if (check_inc_mod_rlimit(size))
+		return NULL;
+
 	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
 				module_alloc_base + MODULES_VSIZE,
 				gfp_mask, PAGE_KERNEL_EXEC, 0,
@@ -65,6 +68,8 @@ void *module_alloc(unsigned long size)
 		return NULL;
 	}
 
+	update_mod_rlimit(p, size);
+
 	return p;
 }
 
-- 
2.17.1

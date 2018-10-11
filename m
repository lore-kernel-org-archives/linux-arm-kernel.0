From: rick.p.edgecombe@intel.com (Rick Edgecombe)
Date: Thu, 11 Oct 2018 16:31:16 -0700
Subject: [PATCH v2 6/7] sparc/modules: Add rlimit for sparc modules
In-Reply-To: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
Message-ID: <20181011233117.7883-7-rick.p.edgecombe@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds in the rlimit checking for the sparc module allocator.

This has not been tested.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/sparc/kernel/module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index df39580f398d..24854fdfa7c3 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -44,10 +44,15 @@ void *module_alloc(unsigned long size)
 {
 	void *ret;
 
+	if (check_inc_mod_rlimit(size))
+		return NULL;
+
 	ret = module_map(size);
 	if (ret)
 		memset(ret, 0, size);
 
+	update_mod_rlimit(ret, size);
+
 	return ret;
 }
 
-- 
2.17.1

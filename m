From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Jul 2013 16:53:49 -0600
Subject: [PATCH] ARM: move body of head-common.S back to text section
Message-ID: <1372805629-18382-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 281ecb7 "arm: delete __cpuinit/__CPUINIT usage from all ARM
users" removed a __CPUINIT from head-common.S. However, the code
immediately before the removed tag was marked __INIT, and was missing
a match __FINIT. This caused code after the removed __CPUINIT to end
up in the init section rather than the main text section as desired.
This caused issues such as secondary CPU boot failures or crashes.
Add the missing __FINIT to solve this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/kernel/head-common.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 529ce99..a9dc804 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -122,6 +122,8 @@ __mmap_switched_data:
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
+	__FINIT
+
 /*
  * This provides a C-API version of __lookup_processor_type
  */
-- 
1.8.1.5

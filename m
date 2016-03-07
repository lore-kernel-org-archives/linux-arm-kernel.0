From: vdmit11@gmail.com (Dmitry Vasilyanov)
Date: Mon,  7 Mar 2016 16:17:18 +0300
Subject: [PATCH] ARM: mm: fix address check in change_memory_common()
Message-ID: <1457356638-16410-1-git-send-email-vdmit11@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (start >= MODULES_END) is checked twice.
The second check has no sense.
Clearly, the intention was: (end >= MODULE_CHECK).
Seems to be a typo, so this patch fixes it.
---
 arch/arm/mm/pageattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index d19b1ad..9edf6b0 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -55,7 +55,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (start < MODULES_VADDR || start >= MODULES_END)
 		return -EINVAL;
 
-	if (end < MODULES_VADDR || start >= MODULES_END)
+	if (end < MODULES_VADDR || end >= MODULES_END)
 		return -EINVAL;
 
 	data.set_mask = set_mask;
-- 
2.1.4

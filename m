From: andrea.adami@gmail.com (Andrea Adami)
Date: Sun, 21 Jul 2013 01:07:50 +0200
Subject: [PATCH] pxa: sharpsl_param: fix invalid memory access in
 sharpsl_save_param()
Message-ID: <1374361670-3214-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede@gmail.com>

Unbreak kernel boot (tested with kexecboot)

Patch was sent twice upstrream:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137284.html
Devices that call sharpsl_save_param() will hang on boot due to
a memcpy call that uses a physical address that is no longer * accessible. Fix
his by converting the physical address into a virtual one.

Signed-off-by: Marko Katic <dromede@gmail.com>
[andrea.adami at gmail.com: checkpatch.pl dislikes void * param_start]
Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/common/sharpsl_param.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
index d56c932..b70b13a 100644
--- a/arch/arm/common/sharpsl_param.c
+++ b/arch/arm/common/sharpsl_param.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <asm/memory.h>
 #include <asm/mach/sharpsl_param.h>
 
 /*
@@ -41,7 +42,8 @@ EXPORT_SYMBOL(sharpsl_param);
 
 void sharpsl_save_param(void)
 {
-	memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct sharpsl_param_info));
+	void *param_start = phys_to_virt(PARAM_BASE);
+	memcpy(&sharpsl_param, param_start, sizeof(struct sharpsl_param_info));
 
 	if (sharpsl_param.comadj_keyword != COMADJ_MAGIC)
 		sharpsl_param.comadj=-1;
-- 
1.8.1.5

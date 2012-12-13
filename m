From: dromede@gmail.com (dromede at gmail.com)
Date: Thu, 13 Dec 2012 15:44:53 +0100
Subject: [PATCH] [ARM] sharpsl_param: fix invalid memory access in
 sharpsl_save_param()
Message-ID: <1355409893-24200-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>

Devices that call sharpsl_save_param() will hang on boot due to
a memcpy call that uses physical addresses that are no longer
valid. This is caused by the following commit:

commit 72662e01088394577be4a3f14da94cf87bea2591
Author: Will Deacon <will.deacon@arm.com>
Date:   Wed Nov 23 12:03:27 2011 +0000

    ARM: head.S: only include __turn_mmu_on in the initial identity mapping

Tested  on Zaurus corgi/poodle/spitz devices.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 arch/arm/common/sharpsl_param.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
index d56c932..04555dc 100644
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
1.7.10.4

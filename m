From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Aug 2016 18:07:05 +0200
Subject: [PATCH] ARM: pxa: Use kmalloc_array() in pxa_pm_init()
Message-ID: <49864e7d-f786-9739-6d8c-4480ce228830@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 18:01:37 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-pxa/pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index 388463b..e7450fb 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -104,8 +104,9 @@ static int __init pxa_pm_init(void)
 		return -EINVAL;
 	}
 
-	sleep_save = kmalloc(pxa_cpu_pm_fns->save_count * sizeof(unsigned long),
-			     GFP_KERNEL);
+	sleep_save = kmalloc_array(pxa_cpu_pm_fns->save_count,
+				   sizeof(*sleep_save),
+				   GFP_KERNEL);
 	if (!sleep_save) {
 		printk(KERN_ERR "failed to alloc memory for pm save\n");
 		return -ENOMEM;
-- 
2.9.3

From: zonque@gmail.com (Daniel Mack)
Date: Thu, 26 Jul 2012 21:16:25 +0200
Subject: [PATCH v2 5/7] ARM: pxa3xx: skip default device initialization when
 booting via DT
In-Reply-To: <1343330187-20049-1-git-send-email-zonque@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
Message-ID: <1343330187-20049-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting via DT, the default PXA devices must not have been probed
before, otherwise the augmented information from the device tree is
ignored.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/pxa3xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 1827d3c..4a9d04a 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/syscore_ops.h>
 #include <linux/i2c/pxa-i2c.h>
 
@@ -479,7 +480,8 @@ static int __init pxa3xx_init(void)
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa3xx_clock_syscore_ops);
 
-		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		if (!of_have_populated_dt())
+			ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
 
 	return ret;
-- 
1.7.11.2

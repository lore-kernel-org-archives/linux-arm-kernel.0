From: mporter@linaro.org (Matt Porter)
Date: Sun, 27 Apr 2014 20:27:40 -0400
Subject: [PATCH] ARM: l2c: prima2: only call l2x0_of_init() on matching nodes
Message-ID: <1398644860-22973-1-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2x0_of_init() is executed unconditionally within the sirfsoc_l2x0_init()
early initcall. In a multi v7 kernel this causes bcm281xx and bcm21664
platform to fail boot since they have their own pre l2x0 init sequence
that is required. Fix this by checking that a matching OF ID is present
before calling l2x0_of_init().

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Matt Porter <mporter@linaro.org>
---
Applies against next-20140424 to fix the issue introduced in
50655e6 ARM: l2c: prima2: remove cache size override

 arch/arm/mach-prima2/l2x0.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index 09f68f0..1c2ed15 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -8,10 +8,24 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 
+static const struct of_device_id sirf_l2x0_ids[] __initconst = {
+	{ .compatible = "sirf,prima2-pl310-cache" },
+	{ .compatible = "sirf,marco-pl310-cache" },
+	{},
+};
+
 static int __init sirfsoc_l2x0_init(void)
 {
-	return l2x0_of_init(0, ~0);
+	struct device_node *np;
+	int ret = -EINVAL;
+
+	np = of_find_matching_node(NULL, sirf_l2x0_ids);
+	if (np)
+		ret = l2x0_of_init(0, ~0);
+
+	return ret;
 }
 early_initcall(sirfsoc_l2x0_init);
-- 
1.8.3.2

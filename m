From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:08 -0700
Subject: [PATCH 06/10] ux500: added snowball-netev with latest fixes
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
---
 arch/arm/mach-ux500/board-snowball-netdev.c |   86 +++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-snowball-netdev.c

diff --git a/arch/arm/mach-ux500/board-snowball-netdev.c b/arch/arm/mach-ux500/board-snowball-netdev.c
new file mode 100644
index 0000000..ee2ab7a
--- /dev/null
+++ b/arch/arm/mach-ux500/board-snowball-netdev.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2010-2011 ST-Ericsson
+ *
+ * Author: Alessandro Rubini <rubini@gnudd.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/module.h>
+#include <linux/resource.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <mach/irqs.h>
+#include <asm/io.h>
+#include <asm/mach-types.h>
+
+struct smsc911x_platform_config sbnet_cfg = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.shift = 1,
+	.flags = SMSC911X_USE_16BIT | SMSC911X_FORCE_INTERNAL_PHY,
+};
+
+struct resource sbnet_res[] = {
+	{
+		.name = "smsc911x-memory",
+		.start = (0x5000 << 16),
+		.end  =  (0x5000 << 16) + 0x3ff,
+		.flags = IORESOURCE_MEM,
+	},{
+		.start = NOMADIK_GPIO_TO_IRQ(140),
+		.end = NOMADIK_GPIO_TO_IRQ(140),
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+	},
+};
+
+struct platform_device sbnet_dev = {
+	.name		= "smsc911x",
+	.num_resources	= ARRAY_SIZE(sbnet_res),
+	.resource	= sbnet_res,
+	.dev		= {
+		.platform_data = &sbnet_cfg,
+	},
+};
+
+int sbnet_init(void)
+{
+	volatile u32 *ptr = ioremap(0x80000000, 0x10000);
+
+	if (!machine_is_snowball()) {
+		printk("no netdev: no snowball\n");
+		return 0;
+	}
+	printk("init netdev: is snowball\n");
+
+	/*
+	 * Horribly, fix all the configuration by hand
+	 */
+	/* Turn on the FSMC device */
+	*(ptr + 0xf000 / 4) = 1;
+	*(ptr + 0xf008 / 4) = 1;
+
+	/* Configure the FSMC device */
+	*(ptr + 0x0000 / 4) = 0x0000305b;
+	*(ptr + 0x0004 / 4) = 0x01010110;
+
+	/* Fix some gpio bits */
+	*(ptr + 0xe120 / 4) &= ~0x7f8;
+	*(ptr + 0xe124 / 4) |=  0x7f8;
+	iounmap(ptr);
+
+	return platform_device_register(&sbnet_dev);
+}
+
+void sbnet_exit(void)
+{
+	platform_device_unregister(&sbnet_dev);
+}
+
+module_init(sbnet_init);
+module_exit(sbnet_exit);
+
+MODULE_LICENSE("GPL");
-- 
1.7.1

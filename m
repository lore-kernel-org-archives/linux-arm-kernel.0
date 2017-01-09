From: khilman@baylibre.com (Kevin Hilman)
Date: Mon,  9 Jan 2017 12:55:29 -0800
Subject: [PATCH v2 4/6] ARM: davinci: add skeleton for pdata-quirks
In-Reply-To: <20170109205531.3435-1-khilman@baylibre.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
Message-ID: <20170109205531.3435-5-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add skeleton pdata-quirks for for davinci.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/include/mach/common.h |  2 ++
 arch/arm/mach-davinci/pdata-quirks.c        | 39 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/arm/mach-davinci/pdata-quirks.c

diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 0b3c169758ed..037aa66bcac1 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -102,6 +102,8 @@ int davinci_pm_init(void);
 static inline int davinci_pm_init(void) { return 0; }
 #endif
 
+void __init pdata_quirks_init(void);
+
 #define SRAM_SIZE	SZ_128K
 
 #endif /* __ARCH_ARM_MACH_DAVINCI_COMMON_H */
diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
new file mode 100644
index 000000000000..5b57da475065
--- /dev/null
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -0,0 +1,39 @@
+/*
+ * Legacy platform_data quirks
+ *
+ * Copyright (C) 2016 BayLibre, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+#include <mach/common.h>
+
+struct pdata_init {
+	const char *compatible;
+	void (*fn)(void);
+};
+
+static void pdata_quirks_check(struct pdata_init *quirks)
+{
+	while (quirks->compatible) {
+		if (of_machine_is_compatible(quirks->compatible)) {
+			if (quirks->fn)
+				quirks->fn();
+			break;
+		}
+		quirks++;
+	}
+}
+
+static struct pdata_init pdata_quirks[] __initdata = {
+	{ /* sentinel */ },
+};
+
+void __init pdata_quirks_init(void)
+{
+	pdata_quirks_check(pdata_quirks);
+}
-- 
2.9.3

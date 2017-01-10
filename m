From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jan 2017 16:20:53 +0530
Subject: [PATCH v2 4/6] ARM: davinci: add skeleton for pdata-quirks
In-Reply-To: <ffa4c887-d9eb-94d0-441f-ed0fa8ba038d@ti.com>
References: <20170109205531.3435-1-khilman@baylibre.com>
 <20170109205531.3435-5-khilman@baylibre.com>
 <ffa4c887-d9eb-94d0-441f-ed0fa8ba038d@ti.com>
Message-ID: <5300e77b-0e76-245d-8f80-689865d471b8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 January 2017 03:56 PM, Sekhar Nori wrote:
> On Tuesday 10 January 2017 02:25 AM, Kevin Hilman wrote:
>> Add skeleton pdata-quirks for for davinci.
> 
> s/for for/for
> 
>>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> 
> Applied to v4.11/soc

After reviewing 5/6, I think some parts of that patch should actually 
be part of basic pdata-quirks support addition. I have moved them here. 
Here is the updated patch. Let me know if it looks fine.

Thanks,
Sekhar

---8<---
Author:     Kevin Hilman <khilman@baylibre.com>
AuthorDate: Mon Jan 9 12:55:29 2017 -0800
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Tue Jan 10 16:12:22 2017 +0530

    ARM: davinci: add skeleton for pdata-quirks
    
    Add skeleton pdata-quirks for davinci.
    
    Signed-off-by: Kevin Hilman <khilman@baylibre.com>
    [nsekhar at ti.com: move changes to build pdata-quirks.c and call
                     to pdata_quirks_init() to this patch]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 0a2e6da45f28..df96ca9eab6d 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_AINTC)			+= irq.o
 obj-$(CONFIG_CP_INTC)			+= cp_intc.o
 
 # Board specific
-obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o
+obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
 obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
 obj-$(CONFIG_MACH_SFFSDR)		+= board-sffsdr.o
 obj-$(CONFIG_MACH_NEUROS_OSD2)		+= board-neuros-osd2.o
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 9ee44da6eb7b..d2be1941a687 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -62,6 +62,7 @@ static void __init da850_init_machine(void)
 
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 	davinci_pm_init();
+	pdata_quirks_init();
 }
 
 static const char *const da850_boards_compat[] __initconst = {
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

From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri,  9 Jun 2017 17:00:37 +0930
Subject: [PATCH] arm: aspeed: Add Aspeed board file with clocksource
 devicetree fixup
In-Reply-To: <CAK8P3a0EaqwmAMRWn--29e4Kt6zJA9kHL2dpj=7Uabn5hANxOA@mail.gmail.com>
References: <CAK8P3a0EaqwmAMRWn--29e4Kt6zJA9kHL2dpj=7Uabn5hANxOA@mail.gmail.com>
Message-ID: <20170609073037.21871-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock-names property in init_timer() to work-around Aspeed
devicetrees from times prior to merging the Moxart/Aspeed and Faraday
drivers.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
Well, here's an implementation I knocked up. It's a fair chunk of code for
marginal benefit. Joel is against it.

At least it's something to debate.

Tested under QEMU for both AST2400 and AST2500 SoCs.

Cheers,

Andrew

 arch/arm/Makefile             |  1 +
 arch/arm/mach-aspeed/Makefile |  1 +
 arch/arm/mach-aspeed/aspeed.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/aspeed.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ab30cc634d02..f3ed359e5b28 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -154,6 +154,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_AT91)		+= at91
+machine-$(CONFIG_ARCH_ASPEED)		+= aspeed
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
diff --git a/arch/arm/mach-aspeed/Makefile b/arch/arm/mach-aspeed/Makefile
new file mode 100644
index 000000000000..de8cd76fcf5d
--- /dev/null
+++ b/arch/arm/mach-aspeed/Makefile
@@ -0,0 +1 @@
+obj-y	 += aspeed.o
diff --git a/arch/arm/mach-aspeed/aspeed.c b/arch/arm/mach-aspeed/aspeed.c
new file mode 100644
index 000000000000..feaac8eb5d2d
--- /dev/null
+++ b/arch/arm/mach-aspeed/aspeed.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2017 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <asm/mach/arch.h>
+
+const char *aspeed_timer_compatibles[] = {
+	"aspeed,ast2400-timer",
+	"aspeed,ast2500-timer",
+	NULL,
+};
+
+/*
+ * For backwards compatibility with pre-4.13 devicetrees, populate the
+ * clock-names property in the clocksource node
+ */
+static void __init aspeed_timer_set_clock_names(void)
+{
+	const char **compatible = aspeed_timer_compatibles;
+	struct device_node *np;
+
+	while (*compatible) {
+		for_each_compatible_node(np, NULL, *compatible) {
+			struct property *clock_names;
+			int rc;
+
+			rc = of_property_count_strings(np, "clock-names");
+			if (rc != -EINVAL)
+				continue;
+
+			clock_names = kzalloc(sizeof(*clock_names), GFP_KERNEL);
+
+			clock_names->name = kstrdup("clock-names", GFP_KERNEL);
+			clock_names->length = sizeof("PCLK");
+			clock_names->value = kstrdup("PCLK", GFP_KERNEL);
+
+			of_add_property(np, clock_names);
+		}
+
+		compatible++;
+	}
+}
+
+static void __init aspeed_init_time(void)
+{
+	aspeed_timer_set_clock_names();
+
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#endif
+	timer_probe();
+}
+
+static const char *const aspeed_dt_match[] __initconst = {
+		"aspeed,ast2400",
+		"aspeed,ast2500",
+		NULL,
+};
+
+DT_MACHINE_START(aspeed_dt, "Aspeed SoC")
+	.init_time	= aspeed_init_time,
+	.dt_compat	= aspeed_dt_match,
+MACHINE_END
-- 
2.11.0

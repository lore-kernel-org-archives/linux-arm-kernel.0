From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 27 May 2017 11:58:42 +0200
Subject: [PATCH 1/7] Revert "clockevents: Add a clkevt-of mechanism like
 clksrc-of"
Message-ID: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After discussing it, this feature is dropped as it is not considered
adequate:

	https://patchwork.kernel.org/patch/9639317/

There is no user of this macro yet, so there is no impact on the drivers.

This reverts commit 376bc27150f180d9f5eddec6a14117780177589d.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig        |  7 -----
 drivers/clocksource/Makefile       |  1 -
 drivers/clocksource/clkevt-probe.c | 56 --------------------------------------
 include/linux/clockchips.h         |  9 ------
 4 files changed, 73 deletions(-)
 delete mode 100644 drivers/clocksource/clkevt-probe.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1b22ade..623fcc6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -5,10 +5,6 @@ config CLKSRC_OF
 	bool
 	select CLKSRC_PROBE
 
-config CLKEVT_OF
-	bool
-	select CLKEVT_PROBE
-
 config CLKSRC_ACPI
 	bool
 	select CLKSRC_PROBE
@@ -16,9 +12,6 @@ config CLKSRC_ACPI
 config CLKSRC_PROBE
 	bool
 
-config CLKEVT_PROBE
-	bool
-
 config CLKSRC_I8253
 	bool
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cf0c30b..cad713c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,5 +1,4 @@
 obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
-obj-$(CONFIG_CLKEVT_PROBE)	+= clkevt-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
diff --git a/drivers/clocksource/clkevt-probe.c b/drivers/clocksource/clkevt-probe.c
deleted file mode 100644
index 8c30fec..0000000
--- a/drivers/clocksource/clkevt-probe.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright (c) 2016, Linaro Ltd.  All rights reserved.
- * Daniel Lezcano <daniel.lezcano@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/clockchip.h>
-
-extern struct of_device_id __clkevt_of_table[];
-
-static const struct of_device_id __clkevt_of_table_sentinel
-	__used __section(__clkevt_of_table_end);
-
-int __init clockevent_probe(void)
-{
-	struct device_node *np;
-	const struct of_device_id *match;
-	of_init_fn_1_ret init_func;
-	int ret, clockevents = 0;
-
-	for_each_matching_node_and_match(np, __clkevt_of_table, &match) {
-		if (!of_device_is_available(np))
-			continue;
-
-		init_func = match->data;
-
-		ret = init_func(np);
-		if (ret) {
-			pr_warn("Failed to initialize '%s' (%d)\n",
-				np->name, ret);
-			continue;
-		}
-
-		clockevents++;
-	}
-
-	if (!clockevents) {
-		pr_crit("%s: no matching clockevent found\n", __func__);
-		return -ENODEV;
-	}
-
-	return 0;
-}
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index eef1569..a116926 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -223,13 +223,4 @@ static inline void tick_setup_hrtimer_broadcast(void) { }
 
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
-#define CLOCKEVENT_OF_DECLARE(name, compat, fn) \
-	OF_DECLARE_1_RET(clkevt, name, compat, fn)
-
-#ifdef CONFIG_CLKEVT_PROBE
-extern int clockevent_probe(void);
-#els
-static inline int clockevent_probe(void) { return 0; }
-#endif
-
 #endif /* _LINUX_CLOCKCHIPS_H */
-- 
2.7.4

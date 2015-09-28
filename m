From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 15:49:16 +0100
Subject: [PATCH v3 5/7] clocksource: Add new CLKSRC_{PROBE,
 ACPI} config symbols
In-Reply-To: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443451758-22717-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocksource probing infrastructure currently depends on
CONFIG_CLKSRC_OF, which depends on CONFIG_OF. In order to make
this infrastructure selectable even if CONFIG_OF is not selected,
introduce a new CONFIG_CLKSRC_PROBE (which allow the infrastructure
to be compiled in), and CONFIG_CLKSRC_ACPI (which is the pendent
of CONFIG_CLKSRC_OF for ACPI).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/Kconfig  | 8 ++++++++
 drivers/clocksource/Makefile | 2 +-
 include/linux/clocksource.h  | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a7726db..fefedf1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -2,6 +2,14 @@ menu "Clock Source drivers"
 
 config CLKSRC_OF
 	bool
+	select CLKSRC_PROBE
+
+config CLKSRC_ACPI
+	bool
+	select CLKSRC_PROBE
+
+config CLKSRC_PROBE
+	bool
 
 config CLKSRC_I8253
 	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5c00863..b47be92 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_CLKSRC_OF)	+= clksrc-of.o
+obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-of.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 8cde048..6eab6ab 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -246,7 +246,7 @@ extern int clocksource_i8253_init(void);
 #define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1(clksrc, name, compat, fn)
 
-#ifdef CONFIG_CLKSRC_OF
+#ifdef CONFIG_CLKSRC_PROBE
 extern void clocksource_of_init(void);
 #else
 static inline void clocksource_of_init(void) {}
-- 
2.1.4

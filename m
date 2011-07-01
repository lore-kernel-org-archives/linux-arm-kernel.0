From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  1 Jul 2011 11:46:32 +0200
Subject: [RFC PATCH 1/3] ARM: common abstraction for specifying a baseboard
In-Reply-To: <20110701094403.GT11559@pengutronix.de>
References: <20110701094403.GT11559@pengutronix.de>
Message-ID: <1309513594-31016-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch unifies handling of baseboards. It allows to use the same
parameter name on all boards.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/kernel-parameters.txt |    2 +
 arch/arm/common/Kconfig             |    3 ++
 arch/arm/common/Makefile            |    1 +
 arch/arm/common/baseboard.c         |   58 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/baseboard.h    |   31 ++++++++++++++++++
 5 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/common/baseboard.c
 create mode 100644 arch/arm/include/asm/baseboard.h

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fd248a31..b349a43 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -373,6 +373,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	autotest	[IA64]
 
+	baseboard=	[ARM] Select a baseboard
+
 	baycom_epp=	[HW,AX25]
 			Format: <io>,<mode>
 
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 4b71766..c91f7c6 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -39,3 +39,6 @@ config SHARP_PARAM
 
 config SHARP_SCOOP
 	bool
+
+config BASEBOARD
+	bool
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 6ea9b6f..4020be3 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
+obj-$(CONFIG_BASEBOARD)		+= baseboard.o
diff --git a/arch/arm/common/baseboard.c b/arch/arm/common/baseboard.c
new file mode 100644
index 0000000..b2919a7
--- /dev/null
+++ b/arch/arm/common/baseboard.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2011 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/baseboard.h>
+
+static const char *baseboard_name __initdata;
+
+/**
+ * baseboard_select - set baseboard name
+ *
+ * @name: name of the board to select
+ */
+int __init baseboard_select(const char *name)
+{
+	baseboard_name = name;
+	return 0;
+}
+__setup("baseboard=", baseboard_select);
+
+/**
+ * baseboard_setup - call initfunc for the board set earlier by baseboard_select
+ *
+ * @map: array of available baseboards, sorted by name
+ * @mapsize: length of array @map
+ */
+int __init baseboard_setup(const struct baseboard_entry *map, size_t mapsize)
+{
+	size_t i;
+	int ret;
+
+	if (!baseboard_name)
+		baseboard_name = "";
+
+	for (i = 0; i < mapsize; ++i) {
+		WARN_ON(i + 1 < mapsize &&
+				strcmp(map[i].name, map[i + 1].name) >= 0);
+
+		ret = strcmp(baseboard_name, map[i].name);
+		if (!ret)
+			return map[i].initfunc(&map[i]);
+
+		if (ret < 0)
+			break;
+	}
+
+	if (*baseboard_name)
+		pr_warn("Unknown baseboard selected\n");
+
+	return -ENOENT;
+}
diff --git a/arch/arm/include/asm/baseboard.h b/arch/arm/include/asm/baseboard.h
new file mode 100644
index 0000000..9e49648
--- /dev/null
+++ b/arch/arm/include/asm/baseboard.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2011 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#ifndef __ASM_BASEBOARD_H
+#define __ASM_BASEBOARD_H
+
+#include <linux/kernel.h>
+
+/**
+ * struct baseboard_entry
+ *
+ * @name: identifying name used by baseboard_set and baseboard kernel parameter.
+ * @initfunc: function called by baseboard_setup when the corresponding
+ * 	baseboard was selected.
+ * @initdata: callback data for @initfunc.
+ */
+struct baseboard_entry {
+	const char *name;
+	int (*initfunc)(const struct baseboard_entry *);
+	void *initdata;
+};
+
+int baseboard_select(const char *name);
+int baseboard_setup(const struct baseboard_entry *map, size_t mapsize);
+
+#endif /* ifndef __ASM_BASEBOARD_H */
-- 
1.7.5.3

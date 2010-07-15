From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 15 Jul 2010 11:10:38 +0200
Subject: [PATCH 07/10 v2] ARM: S5PV210: add common Aquila & GONI code
In-Reply-To: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279185041-6004-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig              |    5 +++
 arch/arm/mach-s5pv210/Makefile             |    2 +
 arch/arm/mach-s5pv210/common-aquila-goni.c |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/common-aquila-goni.h |    2 +
 4 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/common-aquila-goni.c
 create mode 100644 arch/arm/mach-s5pv210/common-aquila-goni.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 4bb5a85..5206562 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -126,6 +126,11 @@ config MACH_P1P2
 
 endmenu
 
+config COMMON_AQUILA_GONI
+	bool
+	help
+	  Compile common code for Samsung Aquila and Samsung GONI machines
+
 config S5PC110_DEV_ONENAND
 	bool
 	help
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 6eceeb8..06de97f 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -24,6 +24,8 @@ obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
 obj-$(CONFIG_MACH_UNIVERSAL)	+= mach-universal.o
 obj-$(CONFIG_MACH_P1P2)		+= mach-p1p2.o
 
+obj-$(CONFIG_COMMON_AQUILA_GONI)	+= common-aquila-goni.o
+
 # device support
 
 obj-y				+= dev-audio.o
diff --git a/arch/arm/mach-s5pv210/common-aquila-goni.c b/arch/arm/mach-s5pv210/common-aquila-goni.c
new file mode 100644
index 0000000..cdfc40e
--- /dev/null
+++ b/arch/arm/mach-s5pv210/common-aquila-goni.c
@@ -0,0 +1,39 @@
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <plat/fimc.h>
+
+#include "common-aquila-goni.h"
+
+void __init s5pv210_common_fimc_clk_init(void)
+{
+	int i;
+	struct clk *clk_fimc, *parent;
+
+	struct device *fimc_devs[] = {
+		&s5p_device_fimc0.dev,
+		&s5p_device_fimc1.dev,
+		&s5p_device_fimc2.dev
+	};
+
+	parent = clk_get(NULL, "mout_epll");
+	if (IS_ERR(parent)) {
+		printk("%s: Could not get FIMC parent clock\n", __func__);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(fimc_devs); i++) {
+		if (fimc_devs[i]) {
+			clk_fimc = clk_get(fimc_devs[i], "sclk_fimc");
+
+			if (IS_ERR(clk_fimc)) {
+				printk("%s: Could not get sclk_fimc clock\n",
+				       __func__);
+				continue;
+			}
+
+			clk_set_parent(clk_fimc, parent);
+			clk_set_rate(clk_fimc, 133000000);
+		}
+	}
+	clk_put(parent);
+}
diff --git a/arch/arm/mach-s5pv210/common-aquila-goni.h b/arch/arm/mach-s5pv210/common-aquila-goni.h
new file mode 100644
index 0000000..f666462
--- /dev/null
+++ b/arch/arm/mach-s5pv210/common-aquila-goni.h
@@ -0,0 +1,2 @@
+
+extern void s5pv210_common_fimc_clk_init(void);
-- 
1.7.0.4

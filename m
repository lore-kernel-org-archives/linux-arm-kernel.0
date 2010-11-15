From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:33 +0800
Subject: [PATCH 09/11] ARM: imx: Add memory map support for i.MX28
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1289831795-4373-10-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/mm-imx28.c |   50 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-imx/mm-imx28.c

diff --git a/arch/arm/mach-imx/mm-imx28.c b/arch/arm/mach-imx/mm-imx28.c
new file mode 100644
index 0000000..358f2d2
--- /dev/null
+++ b/arch/arm/mach-imx/mm-imx28.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License.  You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * Create static mapping between physical to virtual memory.
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/iomux-pinctrl.h>
+
+/*
+ * Define the MX28 memory map.
+ */
+static struct map_desc mx28_io_desc[] __initdata = {
+	imx_map_entry(MX28, OCRAM, MT_DEVICE),
+	imx_map_entry(MX28, IO, MT_DEVICE),
+};
+
+/*
+ * This function initializes the memory map. It is called during the
+ * system startup to create static physical to virtual memory mappings
+ * for the IO modules.
+ */
+void __init mx28_map_io(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX28);
+	mxc_iomux_pinctrl_init(MX28_IO_ADDRESS(MX28_PINCTRL_BASE_ADDR));
+	mxc_arch_reset_init(MX28_IO_ADDRESS(MX28_RTC_BASE_ADDR));
+	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
+}
+
+int imx28_register_gpios(void);
+
+void __init mx28_init_irq(void)
+{
+	icoll_init_irq(MX28_IO_ADDRESS(MX28_ICOLL_BASE_ADDR));
+	imx28_register_gpios();
+}
-- 
1.7.1

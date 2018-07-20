From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:32 +0200
Subject: [PATCH 2/5] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <cover.1532086956.git.horms+renesas@verge.net.au>
References: <cover.1532086956.git.horms+renesas@verge.net.au>
Message-ID: <cde4f86f9249be73a31c93df4706b300fba48315.1532086956.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Pollet <michel.pollet@bp.renesas.com>

The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
equires a special enable method to get it started.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Makefile        |  1 +
 drivers/soc/renesas/r9a06g032-smp.c | 96 +++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 drivers/soc/renesas/r9a06g032-smp.c

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 7dc0f20d7907..44a0d6b10192 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
 obj-$(CONFIG_SYSC_R8A77980)	+= r8a77980-sysc.o
 obj-$(CONFIG_SYSC_R8A77990)	+= r8a77990-sysc.o
 obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
+obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
diff --git a/drivers/soc/renesas/r9a06g032-smp.c b/drivers/soc/renesas/r9a06g032-smp.c
new file mode 100644
index 000000000000..a1926e8d73f2
--- /dev/null
+++ b/drivers/soc/renesas/r9a06g032-smp.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * R9A06G032 Second CA7 enabler.
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
+ * Derived from actions,s500-smp
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+
+/*
+ * The second CPU is parked in ROM at boot time. It requires waking it after
+ * writing an address into the BOOTADDR register of sysctrl.
+ *
+ * So the default value of the "cpu-release-addr" corresponds to BOOTADDR...
+ *
+ * *However* the BOOTADDR register is not available when the kernel
+ * starts in NONSEC mode.
+ *
+ * So for NONSEC mode, the bootloader re-parks the second CPU into a pen
+ * in SRAM, and changes the "cpu-release-addr" of linux's DT to a SRAM address,
+ * which is not restricted.
+ */
+
+static void __iomem *cpu_bootaddr;
+
+static DEFINE_SPINLOCK(cpu_lock);
+
+static int
+r9a06g032_smp_boot_secondary(unsigned int cpu,
+			     struct task_struct *idle)
+{
+	if (!cpu_bootaddr)
+		return -ENODEV;
+
+	spin_lock(&cpu_lock);
+
+	writel(__pa_symbol(secondary_startup), cpu_bootaddr);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	spin_unlock(&cpu_lock);
+
+	return 0;
+}
+
+static void __init r9a06g032_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *dn;
+	int ret = -EINVAL, dns;
+	u32 bootaddr;
+
+	dn = of_get_cpu_node(1, NULL);
+	if (!dn) {
+		pr_err("CPU#1: missing device tree node\n");
+		return;
+	}
+	/*
+	 * Determine the address from which the CPU is polling.
+	 * The bootloader *does* change this property.
+	 * Note: The property can be either 64 or 32 bits, so handle both cases
+	 */
+	if (of_find_property(dn, "cpu-release-addr", &dns)) {
+		if (dns == sizeof(u64)) {
+			u64 temp;
+
+			ret = of_property_read_u64(dn,
+						   "cpu-release-addr", &temp);
+			bootaddr = temp;
+		} else {
+			ret = of_property_read_u32(dn,
+						   "cpu-release-addr",
+						   &bootaddr);
+		}
+	}
+	of_node_put(dn);
+	if (ret) {
+		pr_err("CPU#1: invalid cpu-release-addr property\n");
+		return;
+	}
+	pr_info("CPU#1: cpu-release-addr %08x\n", bootaddr);
+
+	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
+}
+
+static const struct smp_operations r9a06g032_smp_ops __initconst = {
+	.smp_prepare_cpus = r9a06g032_smp_prepare_cpus,
+	.smp_boot_secondary = r9a06g032_smp_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(r9a06g032_smp,
+		      "renesas,r9a06g032-smp", &r9a06g032_smp_ops);
-- 
2.11.0

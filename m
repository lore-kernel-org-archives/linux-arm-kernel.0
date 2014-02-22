From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Feb 2014 20:14:47 +0100
Subject: [PATCH v4 05/22] ARM: Kirkwood: Seperate board-dt from common and
 pcie code.
In-Reply-To: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393096504-11844-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to move DT support into mach-mvebu, the DT code
needs to be cleanly separated from common and pcie code. Import the
needed bits of these files into board-dt.c. The "common" code then
becomes purely legacy, supporting none DT boards, so reflect this in
the Makefile targets.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/mach-kirkwood/Makefile   |  3 +-
 arch/arm/mach-kirkwood/board-dt.c | 88 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index dc22bf5b21ed..3a72c5c6e747 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,5 +1,4 @@
-obj-y				+= common.o pcie.o
-obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o
+obj-$(CONFIG_KIRKWOOD_LEGACY)	+= irq.o mpp.o common.o pcie.o
 obj-$(CONFIG_PM)		+= pm.o
 
 obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index a0c0ff39788e..64151a4a378f 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -21,11 +21,97 @@
 #include <linux/irqchip.h>
 #include <linux/kexec.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
 #include <plat/common.h>
-#include "common.h"
+#include <plat/cache-feroceon-l2.h>
+#include <plat/pcie.h>
 #include "pm.h"
 
+static struct map_desc kirkwood_io_desc[] __initdata = {
+	{
+		.virtual	= (unsigned long) KIRKWOOD_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
+		.length		= KIRKWOOD_REGS_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init kirkwood_map_io(void)
+{
+	iotable_init(kirkwood_io_desc, ARRAY_SIZE(kirkwood_io_desc));
+}
+
+static void __init kirkwood_l2_init(void)
+{
+#ifdef CONFIG_CACHE_FEROCEON_L2
+#ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
+	writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
+	feroceon_l2_init(1);
+#else
+	writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
+	feroceon_l2_init(0);
+#endif
+#endif
+}
+
+static struct resource kirkwood_cpufreq_resources[] = {
+	[0] = {
+		.start  = CPU_CONTROL_PHYS,
+		.end    = CPU_CONTROL_PHYS + 3,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device kirkwood_cpufreq_device = {
+	.name		= "kirkwood-cpufreq",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(kirkwood_cpufreq_resources),
+	.resource	= kirkwood_cpufreq_resources,
+};
+
+static void __init kirkwood_cpufreq_init(void)
+{
+	platform_device_register(&kirkwood_cpufreq_device);
+}
+
+static struct resource kirkwood_cpuidle_resource[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+		.start	= DDR_OPERATION_BASE,
+		.end	= DDR_OPERATION_BASE + 3,
+	},
+};
+
+static struct platform_device kirkwood_cpuidle = {
+	.name		= "kirkwood_cpuidle",
+	.id		= -1,
+	.resource	= kirkwood_cpuidle_resource,
+	.num_resources	= 1,
+};
+
+static void __init kirkwood_cpuidle_init(void)
+{
+	platform_device_register(&kirkwood_cpuidle);
+}
+
+/* Temporary here since mach-mvebu has a function we can use */
+static void kirkwood_restart(enum reboot_mode mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+
+	while (1)
+		;
+}
+
 #define MV643XX_ETH_MAC_ADDR_LOW	0x0414
 #define MV643XX_ETH_MAC_ADDR_HIGH	0x0418
 
-- 
1.8.5.3

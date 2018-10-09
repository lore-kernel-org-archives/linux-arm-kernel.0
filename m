From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Tue,  9 Oct 2018 13:20:20 +0200
Subject: [PATCH v2 2/3] ARM: socfpga: Turn on all peripheral clocks for a
 system reboot
In-Reply-To: <20181009112021.756-1-peron.clem@gmail.com>
References: <20181009112021.756-1-peron.clem@gmail.com>
Message-ID: <20181009112021.756-2-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

When doing a software reboot, all peripheral clocks must get turned on for the
L3 interconnect to work.

This code is needed when doing a "reboot" from user-space and a peripheral
clock as been gated off. Why would a peripheral clock get gated? An example
use case would be a .ko that gets insmod and rmmod during runtime. The insmod
would turn on the IP's clock, and the rmmod would turn off the IP's clock.
Doing a "reboot" would cause the system to hang.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
---

 v2:
	- Remove fixes tag in commit log

 arch/arm/mach-socfpga/core.h    | 3 +++
 arch/arm/mach-socfpga/socfpga.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 92cae0a9213f..17c8a97c04d9 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -52,4 +52,7 @@ extern unsigned long socfpga_cpu1start_addr;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfee00000
 
+/* Clock manager defines */
+#define SOCFPGA_ENABLE_PLL_REG	0xA0
+
 #endif
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 5fb6f79059a8..c9c881f7c67c 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -31,6 +31,7 @@ void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
 void __iomem *sdr_ctl_base_addr;
 unsigned long socfpga_cpu1start_addr;
+void __iomem *clkmgr_base_addr;
 
 static void __init socfpga_sysmgr_init(void)
 {
@@ -51,6 +52,10 @@ static void __init socfpga_sysmgr_init(void)
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
 
+	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
+	clkmgr_base_addr = of_iomap(np, 0);
+	WARN_ON(!clkmgr_base_addr);
+
 	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
 	sdr_ctl_base_addr = of_iomap(np, 0);
 }
@@ -80,6 +85,9 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 {
 	u32 temp;
 
+	/* Turn on all periph PLL clocks */
+	writel(0xffff, clkmgr_base_addr + SOCFPGA_ENABLE_PLL_REG);
+
 	temp = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 
 	if (mode == REBOOT_HARD)
-- 
2.17.1

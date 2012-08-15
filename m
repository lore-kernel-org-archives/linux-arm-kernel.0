From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 Aug 2012 17:22:30 +0800
Subject: [PATCH V2 2/6] ARM: tegra: replace the CPU CAR access code by
 tegra_cpu_car_ops
In-Reply-To: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
References: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345022554-26292-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replacing the code that directly access to CAR registers with
tegra_cpu_car_ops. This ops hides CPU CAR access inside and
provides control interface for it.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c |   29 +++++------------------------
 1 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 1a208db..96ed171 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -31,6 +31,7 @@
 #include "fuse.h"
 #include "flowctrl.h"
 #include "reset.h"
+#include "tegra_cpu_car.h"
 
 extern void tegra_secondary_startup(void);
 
@@ -38,17 +39,6 @@ static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
 
 #define EVP_CPU_RESET_VECTOR \
 	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
-#define CLK_RST_CONTROLLER_CLK_CPU_CMPLX \
-	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x4c)
-#define CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET \
-	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x340)
-#define CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR \
-	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x344)
-#define CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR \
-	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x34c)
-
-#define CPU_CLOCK(cpu)	(0x1<<(8+cpu))
-#define CPU_RESET(cpu)	(0x1111ul<<(cpu))
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
@@ -63,13 +53,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 
 static int tegra20_power_up_cpu(unsigned int cpu)
 {
-	u32 reg;
-
 	/* Enable the CPU clock. */
-	reg = readl(CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
-	writel(reg & ~CPU_CLOCK(cpu), CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
-	barrier();
-	reg = readl(CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+	tegra_enable_cpu_clock(cpu);
 
 	/* Clear flow controller CSR. */
 	flowctrl_write_cpu_csr(cpu, 0);
@@ -79,7 +64,6 @@ static int tegra20_power_up_cpu(unsigned int cpu)
 
 static int tegra30_power_up_cpu(unsigned int cpu)
 {
-	u32 reg;
 	int ret, pwrgateid;
 	unsigned long timeout;
 
@@ -103,8 +87,7 @@ static int tegra30_power_up_cpu(unsigned int cpu)
 	}
 
 	/* CPU partition is powered. Enable the CPU clock. */
-	writel(CPU_CLOCK(cpu), CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
-	reg = readl(CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
+	tegra_enable_cpu_clock(cpu);
 	udelay(10);
 
 	/* Remove I/O clamps. */
@@ -128,8 +111,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * via the flow controller). This will have no effect on first boot
 	 * of the CPU since it should already be in reset.
 	 */
-	writel(CPU_RESET(cpu), CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
-	dmb();
+	tegra_put_cpu_in_reset(cpu);
 
 	/*
 	 * Unhalt the CPU. If the flow controller was used to power-gate the
@@ -155,8 +137,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 		goto done;
 
 	/* Take the CPU out of reset. */
-	writel(CPU_RESET(cpu), CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR);
-	wmb();
+	tegra_cpu_out_of_reset(cpu);
 done:
 	return status;
 }
-- 
1.7.0.4

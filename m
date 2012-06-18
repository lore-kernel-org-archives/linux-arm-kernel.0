From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:11:13 +0200
Subject: [PATCH] arm: zynq: Support GIC OF initialization
Message-ID: <1340017873-18170-1-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zynq is OF driven platfrom which requires OF initialization.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/arm/mach-zynq/common.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 17d68d6..7941544 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -56,12 +56,17 @@ static void __init xilinx_init_machine(void)
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
 }
 
+static const struct of_device_id zynq_dt_irq_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
+	{ }
+};
+
 /**
  * xilinx_irq_init() - Interrupt controller initialization for the GIC.
  */
 static void __init xilinx_irq_init(void)
 {
-	gic_init(0, 29, SCU_GIC_DIST_BASE, SCU_GIC_CPU_BASE);
+	of_irq_init(zynq_dt_irq_match);
 }
 
 /* The minimum devices needed to be mapped before the VM system is up and
-- 
1.7.0.4

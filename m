From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  6 Jul 2012 13:32:38 +0100
Subject: [PATCH] ARM: ux500: Pass PMU platform data due for Perf though AUXDATA
Message-ID: <1341577958-8521-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with Device Tree we need a way to call-back to the
DB8500 PMU IRQ handler. This is necessary because the two CPU
IRQ lines are muxed together on the DB8500 chip. The DB8500
PMU IRQ handler contains logic to pass over to the other core
in the case of IRQ_NONE. This patch allows the DB8500 PMU IRQ
handler to be passed to Perf through platform data.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 ++
 arch/arm/mach-ux500/board-mop500.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9c78e40..aa1bdcf 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -727,6 +727,8 @@ MACHINE_END
 #ifdef CONFIG_MACH_UX500_DT
 
 struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
+	/* Requires call-back bindings. */
+	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
 	/* Requires DMA and call-back bindings. */
 	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
 	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index b5bfc1a..d04a8e6 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -81,6 +81,7 @@ struct device;
 struct i2c_board_info;
 extern struct mmci_platform_data mop500_sdi0_data;
 extern struct mmci_platform_data mop500_sdi4_data;
+extern struct arm_pmu_platdata db8500_pmu_platdata;
 
 extern void mop500_sdi_init(struct device *parent);
 extern void snowball_sdi_init(struct device *parent);
-- 
1.7.9.5

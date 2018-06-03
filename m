From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  3 Jun 2018 10:33:45 +0800
Subject: [PATCH V2 2/3] ARM: imx: add cpu idle support for i.MX6SLL
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1527993226-19587-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL supports cpu idle with ARM power gated,
it can reuse i.MX6SX's cpu idle driver to support
below 3 states of cpu idle:

state0: WFI;
state1: WAIT mode with ARM power on;
state2: WAIT mode with ARM power off.

L2_PGE in GPC_CNTR needs to be cleared to support
state2 cpu idle.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	Fix build error when cpuidle-imx6sx.c is NOT included in Makefile by different SoC configuration.
 arch/arm/mach-imx/Makefile         | 4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
 arch/arm/mach-imx/mach-imx6sl.c    | 5 ++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 2327e3e..127fdf3 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -25,8 +25,8 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
-obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index d0f14b7..243a108 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -103,6 +103,7 @@ int __init imx6sx_cpuidle_init(void)
 {
 	imx6_set_int_mem_clk_lpm(true);
 	imx6_enable_rbc(false);
+	imx_gpc_set_l2_mem_power_in_lpm(false);
 	/*
 	 * set ARM power up/down timing to the fastest,
 	 * sw2iso and sw can be set to one 32K cycle = 31us
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index c7a1ef1..183540e 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -42,7 +42,10 @@ static void __init imx6sl_init_late(void)
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 
-	imx6sl_cpuidle_init();
+	if (cpu_is_imx6sl())
+		imx6sl_cpuidle_init();
+	else
+		imx6sx_cpuidle_init();
 }
 
 static void __init imx6sl_init_machine(void)
-- 
2.7.4

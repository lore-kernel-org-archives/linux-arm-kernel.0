From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 30 May 2013 19:19:41 +0800
Subject: [PATCH 2/3] ARM: tegra114: add low level support for CPU idle
 powered-down mode
In-Reply-To: <1369912782-30663-1-git-send-email-josephl@nvidia.com>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com>
Message-ID: <1369912782-30663-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flow controller would take care the power sequence when CPU idle in
powered-down mode. It powered gate the CPU when CPU runs into WFI
instruction. And wake up the CPU when event be triggered.

The sequence is below.
* setting wfi bitmap for the CPU as the halt event in the
  FLOW_CTRL_CPU_HALT_REG to monitor the CPU running into WFI,then power
  gate it
* setting IRQ and FIQ as wake up event to wake up CPU when event triggered

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.h      | 2 ++
 arch/arm/mach-tegra/sleep-tegra30.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index 7a29bae..e56a950 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -28,6 +28,8 @@
 #define FLOW_CTRL_SCLK_RESUME		(1 << 27)
 #define FLOW_CTRL_HALT_CPU_IRQ		(1 << 10)
 #define	FLOW_CTRL_HALT_CPU_FIQ		(1 << 8)
+#define FLOW_CTRL_HALT_GIC_IRQ		(1 << 9)
+#define FLOW_CTRL_HALT_GIC_FIQ		(1 << 8)
 #define FLOW_CTRL_CPU0_CSR		0x8
 #define	FLOW_CTRL_CSR_INTR_FLAG		(1 << 15)
 #define FLOW_CTRL_CSR_EVENT_FLAG	(1 << 14)
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index ada8821..5877f26 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -99,6 +99,8 @@ flow_ctrl_setting_for_lp2:
 	cmp	r10, #TEGRA30
 	moveq   r3, #FLOW_CTRL_WAIT_FOR_INTERRUPT	@ For LP2
 	movne	r3, #FLOW_CTRL_WAITEVENT
+	orrne	r3, r3, #FLOW_CTRL_HALT_GIC_IRQ
+	orrne	r3, r3, #FLOW_CTRL_HALT_GIC_FIQ
 flow_ctrl_done:
 	cmp	r10, #TEGRA30
 	str	r3, [r2]
-- 
1.8.3

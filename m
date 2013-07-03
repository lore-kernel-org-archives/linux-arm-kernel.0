From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:50:40 +0800
Subject: [PATCH V2 04/11] ARM: tegra114: add low level support code for
 cluster power down
In-Reply-To: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372845047-25147-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CPU cluster power down, the vGIC is powered down too. The
flow controller needs to monitor the legacy interrupt controller to
wake up CPU. So setting up the appropriate wake up event in flow
controller.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/flowctrl.h      | 2 ++
 arch/arm/mach-tegra/sleep-tegra30.S | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index e56a950..de0acb9 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -28,6 +28,8 @@
 #define FLOW_CTRL_SCLK_RESUME		(1 << 27)
 #define FLOW_CTRL_HALT_CPU_IRQ		(1 << 10)
 #define	FLOW_CTRL_HALT_CPU_FIQ		(1 << 8)
+#define FLOW_CTRL_HALT_LIC_IRQ		(1 << 11)
+#define FLOW_CTRL_HALT_LIC_FIQ		(1 << 10)
 #define FLOW_CTRL_HALT_GIC_IRQ		(1 << 9)
 #define FLOW_CTRL_HALT_GIC_FIQ		(1 << 8)
 #define FLOW_CTRL_CPU0_CSR		0x8
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 6744161..ecad4ea 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -175,8 +175,12 @@ tegra30_enter_sleep:
 	orr	r0, r0, #FLOW_CTRL_CSR_ENABLE
 	str	r0, [r6, r2]
 
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r10
+	cmp	r10, #TEGRA30
 	mov	r0, #FLOW_CTRL_WAIT_FOR_INTERRUPT
-	orr	r0, r0, #FLOW_CTRL_HALT_CPU_IRQ | FLOW_CTRL_HALT_CPU_FIQ
+	orreq	r0, r0, #FLOW_CTRL_HALT_CPU_IRQ | FLOW_CTRL_HALT_CPU_FIQ
+	orrne   r0, r0, #FLOW_CTRL_HALT_LIC_IRQ | FLOW_CTRL_HALT_LIC_FIQ
+
 	cpu_to_halt_reg r2, r1
 	str	r0, [r6, r2]
 	dsb
-- 
1.8.3.2

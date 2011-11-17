From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 17 Nov 2011 18:54:29 +0800
Subject: [PATCH 1/1] ARM: imx6q: move clock register map to machine_desc.map_io
Message-ID: <1321527269-26784-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

map_io is the only place to call iotable_init.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c         |    7 +++++--
 arch/arm/mach-imx/mach-imx6q.c          |    1 +
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 613a1b9..d3b0a8e 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1953,14 +1953,17 @@ static struct map_desc imx6q_clock_desc[] = {
 	imx_map_entry(MX6Q, ANATOP, MT_DEVICE),
 };
 
+void __init imx_clock_map_io(void)
+{
+	iotable_init(imx6q_clock_desc, ARRAY_SIZE(imx6q_clock_desc));
+}
+
 int __init mx6q_clocks_init(void)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int i, irq;
 
-	iotable_init(imx6q_clock_desc, ARRAY_SIZE(imx6q_clock_desc));
-
 	/* retrieve the freqency of fixed clocks from device tree */
 	for_each_compatible_node(np, NULL, "fixed-clock") {
 		u32 rate;
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 8bf5fa3..7f35a82 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -34,6 +34,7 @@ static void __init imx6q_map_io(void)
 {
 	imx_lluart_map_io();
 	imx_scu_map_io();
+	imx_clock_map_io();
 }
 
 static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 83b745a..f27ae54 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -120,6 +120,7 @@ extern void imx_smp_prepare(void);
 static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
 #endif
+void imx_clock_map_io(void);
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void imx_src_init(void);
-- 
1.7.5.4

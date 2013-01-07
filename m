From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 07 Jan 2013 17:36:46 +0800
Subject: [PATCH] arch/arm/mach-s5pv210: adding ifdef CONFIG_CPU_S5PV210 to
 fix compiling issue
Message-ID: <50EA972E.3040404@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  if not define CONFIG_CPU_S5PV210

    it will define NULL in common.h for:
      s5pv210_map_io, s5pv210_init_clocks, s5pv210_init, s5pv210_init_uarts

    so need using #ifdef CONFIG_CPU_S5PV210 for them too, in common.c.
      or compiling issue will occur.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-s5pv210/common.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 9dfe93e..ad56485 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -167,6 +167,8 @@ void __init s5pv210_init_io(struct map_desc *mach_desc, int size)
 	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
 
+#ifdef CONFIG_CPU_S5PV210
+
 void __init s5pv210_map_io(void)
 {
 	/* initialise device information early */
@@ -209,6 +211,9 @@ void __init s5pv210_init_clocks(int xtal)
 	s5pv210_setup_clocks();
 }
 
+#endif /* CONFIG_CPU_S5PV210 */
+
+
 void __init s5pv210_init_irq(void)
 {
 	u32 vic[4];	/* S5PV210 supports 4 VIC */
@@ -222,6 +227,8 @@ void __init s5pv210_init_irq(void)
 	s5p_init_irq(vic, ARRAY_SIZE(vic));
 }
 
+#ifdef CONFIG_CPU_S5PV210
+
 struct bus_type s5pv210_subsys = {
 	.name		= "s5pv210-core",
 	.dev_name	= "s5pv210-core",
@@ -249,3 +256,5 @@ void __init s5pv210_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
 }
+
+#endif /* CONFIG_CPU_S5PV210 */
-- 
1.7.10.4

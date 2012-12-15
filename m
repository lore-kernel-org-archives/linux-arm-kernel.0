From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 15 Dec 2012 13:39:24 +0800
Subject: [PATCH] arm: vexpress: hook platform_data to clcd_pl11x by amba
 bus_notify
Message-ID: <1355549964-12893-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

when using dtb to boot v2p-ca9, clcd probe will fail due to missed
the platform_data:
clcd-pl11x: probe of 10020000.clcd failed with error -22
this patch hooks the platform_data to clcd and make lcd of v2p-ca9
can work while booting vexpress by DTB.
Tested on qemu by "qemu-system-arm -M vexpress-a9 -m 512M -kernel
zImage -dtb ./vexpress-v2p-ca9.dtb"

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   30 +++++++++++++++++++++
 arch/arm/mach-vexpress/include/mach/motherboard.h |    1 +
 arch/arm/mach-vexpress/v2m.c                      |   10 +++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 4f471fa..92b03e7 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -111,6 +111,35 @@ static struct amba_device *ct_ca9x4_amba_devs[] __initdata = {
 	&gpio_device,
 };
 
+static int ct_ca9x4_of_amba_notify(struct notifier_block *nb, unsigned long action,
+		void *data)
+{
+	struct device *dev = data;
+
+	/* We are only intereted in device addition */
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	if (!of_find_compatible_node(NULL, NULL, "arm,vexpress,v2p-ca9"))
+		return 0;
+
+	if (of_device_is_compatible(dev->of_node, "arm,pl111"))
+		dev->platform_data = &ct_ca9x4_clcd_data;
+
+	return 0;
+}
+
+static struct notifier_block ct_ca9x4_amba_nb = {
+	.notifier_call = ct_ca9x4_of_amba_notify,
+};
+
+static void ct_ca9x4_register_bus_nb(void)
+{
+	/* Register callbacks on OF amba device addition/removal
+	 * to handle linking them to the right platform_data
+	 */
+	bus_register_notifier(&amba_bustype, &ct_ca9x4_amba_nb);
+}
 
 static struct v2m_osc ct_osc1 = {
 	.osc = 1,
@@ -211,6 +240,7 @@ struct ct_desc ct_ca9x4_desc __initdata = {
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
 	.init_tile	= ct_ca9x4_init,
+	.bus_notifer	= ct_ca9x4_register_bus_nb,
 #ifdef CONFIG_SMP
 	.init_cpu_map	= ct_ca9x4_init_cpu_map,
 	.smp_enable	= ct_ca9x4_smp_enable,
diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 1e388c7..f88982b 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -141,6 +141,7 @@ struct ct_desc {
 	void			(*init_early)(void);
 	void			(*init_irq)(void);
 	void			(*init_tile)(void);
+	void			(*bus_notifer)(void);
 #ifdef CONFIG_SMP
 	void			(*init_cpu_map)(void);
 	void			(*smp_enable)(unsigned int);
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 560e0df..e9147f8 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -431,6 +431,8 @@ static void __init v2m_clk_init(void)
 	clk = v2m_osc_register("mb:osc1", &v2m_mb_osc1);
 	for (i = 0; i < ARRAY_SIZE(v2m_osc1_periphs); i++)
 		WARN_ON(clk_register_clkdev(clk, NULL, v2m_osc1_periphs[i]));
+	if (of_find_compatible_node(NULL, NULL, "arm,vexpress,v2p-ca9"))
+		WARN_ON(clk_register_clkdev(clk, NULL, "10020000.clcd"));
 
 	clk = clk_register_fixed_rate(NULL, "mb:osc2", NULL,
 			CLK_IS_ROOT, 24000000);
@@ -651,7 +653,15 @@ static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
 
 static void __init v2m_dt_init(void)
 {
+	int i;
+
 	l2x0_of_init(0x00400000, 0xfe0fffff);
+
+	/* some devices need to hook platform_data */
+	for (i = 0; i < ARRAY_SIZE(ct_descs); i++)
+		if (ct_descs[i]->bus_notifer)
+			ct_descs[i]->bus_notifer();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			v2m_dt_auxdata_lookup, NULL);
 	pm_power_off = v2m_power_off;
-- 
1.7.1

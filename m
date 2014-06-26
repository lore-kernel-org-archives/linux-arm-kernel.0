From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 26 Jun 2014 12:05:40 +0800
Subject: [PATCH v4 1/8] ARM: hisi: store reboot reg in global variable
In-Reply-To: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
References: <1403755547-623-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1403755547-623-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to parse DT in restart() function. Parsing these in init_late()
instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/hisilicon.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..a2387bc 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -45,33 +45,38 @@ static struct map_desc hi3620_io_desc[] __initdata = {
 	},
 };
 
+static void __iomem *sysctrl_base;
+static u32 reboot_offset;
+
 static void __init hi3620_map_io(void)
 {
 	debug_ll_io_init();
 	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
 }
 
-static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
+static void __init hi3xxx_init_late(void)
 {
 	struct device_node *np;
-	void __iomem *base;
-	int offset;
 
 	np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
 	if (!np) {
 		pr_err("failed to find hisilicon,sysctrl node\n");
 		return;
 	}
-	base = of_iomap(np, 0);
-	if (!base) {
+	sysctrl_base = of_iomap(np, 0);
+	if (!sysctrl_base) {
 		pr_err("failed to map address in hisilicon,sysctrl node\n");
 		return;
 	}
-	if (of_property_read_u32(np, "reboot-offset", &offset) < 0) {
+	if (of_property_read_u32(np, "reboot-offset", &reboot_offset) < 0) {
 		pr_err("failed to find reboot-offset property\n");
 		return;
 	}
-	writel_relaxed(0xdeadbeef, base + offset);
+}
+
+static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
+{
+	writel_relaxed(0xdeadbeef, sysctrl_base + reboot_offset);
 
 	while (1)
 		cpu_do_idle();
@@ -85,6 +90,7 @@ static const char *hi3xxx_compat[] __initconst = {
 DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
 	.dt_compat	= hi3xxx_compat,
+	.init_late	= hi3xxx_init_late,
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
 MACHINE_END
-- 
1.9.1

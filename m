From: scott.shu@mediatek.com (Scott Shu)
Date: Sun, 23 Aug 2015 17:01:04 +0800
Subject: [PATCH v4 5/8] ARM: mediatek: add smp bringup code for MT6580
In-Reply-To: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
References: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1440320467-26118-6-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for cpu enable-method "mediatek,mt6580-smp" for booting
secondary CPUs on MT6580.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/mach-mediatek/platsmp.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index a5bc108..41fade2 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -21,10 +21,19 @@
 #include <linux/of_address.h>
 #include <linux/string.h>
 #include <linux/threads.h>
+#include <linux/delay.h>
+#include <asm/cacheflush.h>
+
+#include <linux/soc/mediatek/scpsys.h>
 
 #define MTK_MAX_CPU		8
 #define MTK_SMP_REG_SIZE	0x1000
 
+#define MT6580_INFRACFG_AO	0x10001000
+#define INFRACFG_AO_BOOT_ADDR	0x800
+#define INFRACFG_AO_SEC_CTRL	0x804
+#define SW_ROM_PD		BIT(31)
+
 struct mtk_smp_boot_info {
 	unsigned long smp_base;
 	unsigned int jump_reg;
@@ -56,6 +65,54 @@ static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 static void __iomem *mtk_smp_base;
 static const struct mtk_smp_boot_info *mtk_smp_info;
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int mt6580_cpu_kill(unsigned cpu)
+{
+	int ret;
+
+	ret = scpsys_cpu_power_off(cpu, 1);
+	if (ret < 0)
+		return 0;
+
+	return 1;
+}
+
+static void mt6580_cpu_die(unsigned int cpu)
+{
+	for (;;)
+		cpu_do_idle();
+}
+#endif
+
+static int mt6580_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	return scpsys_cpu_power_on(cpu);
+}
+
+static void __init mt6580_smp_prepare_cpus(unsigned int max_cpus)
+{
+	static void __iomem *infracfg_ao_base;
+	static unsigned int temp;
+
+	infracfg_ao_base = ioremap(MT6580_INFRACFG_AO, 0x1000);
+	if (!infracfg_ao_base) {
+		pr_err("%s: Unable to map I/O memory\n", __func__);
+		return;
+	}
+
+	/* Enable bootrom power down mode */
+	temp = readl(infracfg_ao_base + INFRACFG_AO_SEC_CTRL);
+	temp |= SW_ROM_PD;
+	writel_relaxed(temp, infracfg_ao_base + INFRACFG_AO_SEC_CTRL);
+
+	/* Write the address of slave startup into boot address
+	   register for bootrom power down mode */
+	writel_relaxed(virt_to_phys(secondary_startup_arm),
+		       infracfg_ao_base + INFRACFG_AO_BOOT_ADDR);
+
+	iounmap(infracfg_ao_base);
+}
+
 static int mtk_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (!mtk_smp_base)
@@ -142,3 +199,13 @@ static struct smp_operations mt6589_smp_ops __initdata = {
 	.smp_boot_secondary = mtk_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(mt6589_smp, "mediatek,mt6589-smp", &mt6589_smp_ops);
+
+static struct smp_operations mt6580_smp_ops __initdata = {
+	.smp_prepare_cpus = mt6580_smp_prepare_cpus,
+	.smp_boot_secondary = mt6580_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill = mt6580_cpu_kill,
+	.cpu_die = mt6580_cpu_die,
+#endif
+};
+CPU_METHOD_OF_DECLARE(mt6580_smp, "mediatek,mt6580-smp", &mt6580_smp_ops);
-- 
1.9.1

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!

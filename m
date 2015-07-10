From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 10 Jul 2015 14:04:06 +0800
Subject: [PATCH v2 3/6] ARM: mediatek: add smp bringup code for MT6580
In-Reply-To: <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <scott.shu@gmail.com>
 <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1436508249-49338-4-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for cpu enable-method "mediatek,mt6580-smp" for booting
secondary CPUs on MT6580.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/mach-mediatek/platsmp.c | 139 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index 12fefb3..7f5a5cfb 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -13,7 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
  */
 #include <linux/io.h>
 #include <linux/memblock.h>
@@ -21,10 +20,15 @@
 #include <linux/of_address.h>
 #include <linux/string.h>
 #include <linux/threads.h>
+#include <linux/delay.h>
+#include <asm/cacheflush.h>
+#include "generic.h"
 
 #define MTK_MAX_CPU		8
 #define MTK_SMP_REG_SIZE	0x1000
 
+static DEFINE_SPINLOCK(boot_lock);
+
 struct mtk_smp_boot_info {
 	unsigned long smp_base;
 	unsigned int jump_reg;
@@ -57,6 +61,128 @@ static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 static void __iomem *mtk_smp_base;
 static const struct mtk_smp_boot_info *mtk_smp_info;
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int mt6580_cpu_kill(unsigned cpu)
+{
+	int ret;
+
+	ret = spm_cpu_mtcmos_off(cpu, 1);
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
+static void write_pen_release(int val)
+{
+	pen_release = val;
+	/* Make sure this is visible to other CPUs */
+	smp_wmb();
+	sync_cache_w(&pen_release);
+}
+
+/*
+ * Refer common "pen" secondary release method
+ */
+static int mt6580_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	int ret;
+
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	write_pen_release(cpu);
+
+	/*
+	 * CPU power on control by SPM
+	 */
+	ret = spm_cpu_mtcmos_on(cpu);
+	if (ret < 0) {
+		spin_unlock(&boot_lock);
+		return -ENOSYS;
+	}
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		/* Read barrier */
+		smp_rmb();
+
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * Now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return (pen_release != -1 ? -ENOSYS : 0);
+}
+
+static void mt6580_secondary_init(unsigned int cpu)
+{
+	/*
+	 * Let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+#define MT6580_INFRACFG_AO	0x10001000
+#define SW_ROM_PD		BIT(31)
+
+static void __init mt6580_smp_prepare_cpus(unsigned int max_cpus)
+{
+	static void __iomem *infracfg_ao_base;
+
+	infracfg_ao_base = ioremap(MT6580_INFRACFG_AO, 0x1000);
+
+	if (!infracfg_ao_base)
+		pr_err("%s: Unable to map I/O memory\n", __func__);
+
+	/* Enable bootrom power down mode */
+	writel_relaxed(readl(infracfg_ao_base + 0x804) | SW_ROM_PD,
+		       infracfg_ao_base + 0x804);
+
+	/* Write the address of slave startup into boot address
+	   register for bootrom power down mode */
+	writel_relaxed(virt_to_phys(secondary_startup_arm),
+		       infracfg_ao_base + 0x800);
+
+	iounmap(infracfg_ao_base);
+
+	/* Initial spm cpu mtcmos memory map */
+	spm_cpu_mtcmos_init();
+}
+
 static int mtk_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (!mtk_smp_base)
@@ -143,3 +269,14 @@ static struct smp_operations mt65xx_smp_ops __initdata = {
 	.smp_boot_secondary = mtk_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(mt65xx_smp, "mediatek,mt65xx-smp", &mt65xx_smp_ops);
+
+static struct smp_operations mt6580_smp_ops __initdata = {
+	.smp_prepare_cpus = mt6580_smp_prepare_cpus,
+	.smp_secondary_init = mt6580_secondary_init,
+	.smp_boot_secondary = mt6580_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill = mt6580_cpu_kill,
+	.cpu_die = mt6580_cpu_die,
+#endif
+};
+CPU_METHOD_OF_DECLARE(mt6580_smp, "mediatek,mt6580-smp", &mt6580_smp_ops);
-- 
1.8.1.1.dirty

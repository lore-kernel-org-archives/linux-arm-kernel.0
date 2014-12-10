From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Dec 2014 15:39:47 +1300
Subject: [RFC/PATCH 4/4] ARM: mvebu: Custom smp_ops for 98DX4251
In-Reply-To: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <1418179187-18486-5-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compared to the armada-xp the 98DX4251 uses different registers to set
the boot address for the secondary CPU. This seems to contradict the
datasheet which lists the same PMSU registers. This could be an error in
the datasheet since it is likely to reproduce much of the armada-xp
information. Or it could be an artifact of the early silicon revision
being used.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

I wasn't sure about the name "pmsu-98dx4251" originally I called this
"msys" but following previous conversations on the subject I've opted to
go with something specific to the chip I'm dealing with. I could fold
this into pmsu.c so it was alongside mvebu_pmsu_set_cpu_boot_addr if
people think that would be better.

 arch/arm/boot/dts/rd-dxbc2.dts      |  9 +++++
 arch/arm/mach-mvebu/Makefile        |  1 +
 arch/arm/mach-mvebu/common.h        |  2 ++
 arch/arm/mach-mvebu/platsmp.c       | 28 +++++++++++++++
 arch/arm/mach-mvebu/pmsu-98dx4251.c | 68 +++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/pmsu-98dx4251.c

diff --git a/arch/arm/boot/dts/rd-dxbc2.dts b/arch/arm/boot/dts/rd-dxbc2.dts
index 97a72d4..5763c4f 100644
--- a/arch/arm/boot/dts/rd-dxbc2.dts
+++ b/arch/arm/boot/dts/rd-dxbc2.dts
@@ -28,6 +28,10 @@
 	model = "Marvell Bobcat2 Evaluation Board";
 	compatible = "marvell,axp-db", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
 
+	cpus {
+		enable-method = "marvell,98dx4251-smp";
+	};
+
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
@@ -104,6 +108,11 @@
 			xor at f0900 {
 				status = "disabled";
 			};
+
+			resume at 20980 {
+				compatible = "marvell,98dx4251-resume-ctrl";
+				reg = <0x20980 0x10>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index e24136b..866822e 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
 obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
+obj-y				 += pmsu-98dx4251.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
 endif
 
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 3ccb40c..5064ac5 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,4 +25,6 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
 void __iomem *mvebu_get_scu_base(void);
 
+void mv98dx4251_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
+
 #endif
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 895dc37..2a2ed65d 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -180,5 +180,33 @@ struct smp_operations armada_xp_smp_ops __initdata = {
 #endif
 };
 
+static int mv98dx4251_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int ret, hw_cpu;
+
+	pr_info("Booting CPU %d\n", cpu);
+
+	hw_cpu = cpu_logical_map(cpu);
+	mv98dx4251_resume_set_cpu_boot_addr(hw_cpu, armada_xp_secondary_startup);
+	ret = mvebu_cpu_reset_deassert(hw_cpu);
+	if (ret) {
+		pr_warn("unable to boot CPU: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+struct smp_operations mv98dx4251_smp_ops __initdata = {
+	.smp_init_cpus		= armada_xp_smp_init_cpus,
+	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
+	.smp_boot_secondary	= mv98dx4251_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= armada_xp_cpu_die,
+#endif
+};
+
 CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
 		      &armada_xp_smp_ops);
+CPU_METHOD_OF_DECLARE(mv98dx4251_smp, "marvell,98dx4251-smp",
+		      &mv98dx4251_smp_ops);
diff --git a/arch/arm/mach-mvebu/pmsu-98dx4251.c b/arch/arm/mach-mvebu/pmsu-98dx4251.c
new file mode 100644
index 0000000..e4d3ad46
--- /dev/null
+++ b/arch/arm/mach-mvebu/pmsu-98dx4251.c
@@ -0,0 +1,68 @@
+/**
+ * CPU resume support for 98DX4521 internal CPU (a.k.a. MSYS).
+ */
+
+#define pr_fmt(fmt) "mv98dx4251-resume: " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include "common.h"
+
+static void __iomem *mv98dx4251_resume_base;
+#define MV98DX4251_CPU_RESUME_CTRL_OFFSET	0x08
+#define MV98DX4251_CPU_RESUME_ADDR_OFFSET	0x04
+
+static struct of_device_id of_mv98dx4251_resume_table[] = {
+	{.compatible = "marvell,98dx4251-resume-ctrl",},
+	{ /* end of list */ },
+};
+
+void mv98dx4251_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
+{
+	WARN_ON(hw_cpu != 1);
+
+	writel(0, mv98dx4251_resume_base + MV98DX4251_CPU_RESUME_CTRL_OFFSET);
+	writel(virt_to_phys(boot_addr), mv98dx4251_resume_base +
+	       MV98DX4251_CPU_RESUME_ADDR_OFFSET);
+}
+
+static int __init mv98dx4251_resume_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int ret = 0;
+
+	np = of_find_matching_node(NULL, of_mv98dx4251_resume_table);
+	if (!np)
+		return 0;
+
+	pr_info("Initializing 98DX4521 Resume\n");
+
+	if (of_address_to_resource(np, 0, &res)) {
+		pr_err("unable to get resource\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (!request_mem_region(res.start, resource_size(&res), np->full_name)) {
+		pr_err("unable to request region\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	mv98dx4251_resume_base = ioremap(res.start, resource_size(&res));
+	if (!mv98dx4251_resume_base) {
+		pr_err("unable to map registers\n");
+		release_mem_region(res.start, resource_size(&res));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
+early_initcall(mv98dx4251_resume_init);
-- 
2.2.0.rc0

From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Tue,  8 Feb 2011 16:14:43 +0100
Subject: [PATCH 1/2] ARM: iMX: cpuidle driver
In-Reply-To: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
Message-ID: <1297178084-28363-2-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

implement cpu idle driver which allow different imx SOCs and boards
to register their own cpuidle parameters

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/plat-mxc/Makefile               |    1 +
 arch/arm/plat-mxc/cpuidle.c              |   74 ++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/cpuidle.h |    6 ++
 3 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/cpuidle.c
 create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 5fd20e9..e6ba9c2 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
+obj-$(CONFIG_CPU_IDLE)    += cpuidle.o
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/plat-mxc/cpuidle.c b/arch/arm/plat-mxc/cpuidle.c
new file mode 100644
index 0000000..ca5f759
--- /dev/null
+++ b/arch/arm/plat-mxc/cpuidle.c
@@ -0,0 +1,74 @@
+/*
+ * arch/arm/plat-mxc/cpuidle.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/cpuidle.h>
+#include <mach/cpuidle.h>
+#include <linux/platform_device.h>
+
+static struct cpuidle_driver imx_cpuidle_driver = {
+	.name =         "imx_idle",
+	.owner =        THIS_MODULE,
+};
+
+static DEFINE_PER_CPU(struct cpuidle_device, imx_cpuidle_device);
+
+static int imx_cpuidle_register(struct imx_cpuidle_state *pstate)
+{
+	struct cpuidle_device *device;
+	struct cpuidle_state *state = pstate->state;
+	int i;
+
+	cpuidle_register_driver(&imx_cpuidle_driver);
+
+	device = &per_cpu(imx_cpuidle_device, smp_processor_id());
+	device->state_count = pstate->state_number;
+
+	for (i = 0; i < device->state_count; i++) {
+		device->states[i].enter = state[i].enter;
+		device->states[i].exit_latency = state[i].exit_latency;
+		device->states[i].target_residency = state[i].target_residency;
+		device->states[i].flags = state[i].flags;
+		strcpy(device->states[i].name, state[i].name);
+		strcpy(device->states[i].desc, state[i].desc);
+	}
+
+	if (cpuidle_register_device(device)) {
+		printk(KERN_ERR "imx_cpuidle_register: Failed registering\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int __devinit imx_cpuidle_probe(struct platform_device *pdev)
+{
+	struct imx_cpuidle_state *state = pdev->dev.platform_data;
+
+	return imx_cpuidle_register(state);
+}
+
+static struct platform_driver imx_cpuidle_platform_driver = {
+	.driver		= {
+		.name	= "imx_cpuidle",
+	},
+	.probe		= imx_cpuidle_probe,
+};
+
+static int __init imx_cpuidle_init(void)
+{
+	return platform_driver_register(&imx_cpuidle_platform_driver);
+}
+arch_initcall(imx_cpuidle_init);
+
+static void __exit imx_cpuidle_exit(void)
+{
+	platform_driver_unregister(&imx_cpuidle_platform_driver);
+}
+module_exit(imx_cpuidle_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Yong Shen <yong.shen@freescale.com>");
diff --git a/arch/arm/plat-mxc/include/mach/cpuidle.h b/arch/arm/plat-mxc/include/mach/cpuidle.h
new file mode 100644
index 0000000..4d672aa
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/cpuidle.h
@@ -0,0 +1,6 @@
+#include <linux/cpuidle.h>
+
+struct imx_cpuidle_state {
+	unsigned short state_number;
+	struct cpuidle_state *state;
+};
-- 
1.7.1

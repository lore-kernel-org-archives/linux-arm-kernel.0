From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sat, 15 May 2010 22:16:54 +0400
Subject: [PATCH v6 2/3] DA8xx: CPPI 4.1 platform code
Message-ID: <201005152216.54242.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add da8xx_cppi41_init() function to initialize the CPPI 4.1 subsystem along
with the data describing the CPPI 4.1 queue manager and the DMA block found
in OMAP-L1x/DA8xx chips.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree.

Changes since the previous version (mostly due to move of the CPPI 4.1 support
to arch/arm/common/):
- replaced #include <mach/cppi41.h> with #include <asm/hardware/cppi41.h>;
- added 'select TI_CPPI41' to DA8[35]0 entries in Kconfig;
- removed #ifdef CONFIG_CPPI41 around da8xx_cppi41_init() and its data;
- exported cppi41_queue_mgr[];
- moved USB 2.0 clock entry change to another, already merged patch...

 arch/arm/mach-davinci/Kconfig              |    2 
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 
 arch/arm/mach-davinci/usb.c                |  106 +++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

Index: linux-davinci/arch/arm/mach-davinci/Kconfig
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/Kconfig
+++ linux-davinci/arch/arm/mach-davinci/Kconfig
@@ -32,12 +32,14 @@ config ARCH_DAVINCI_DM646x
 config ARCH_DAVINCI_DA830
         bool "DA830/OMAP-L137 based system"
 	select CP_INTC
+	select TI_CPPI41
 	select ARCH_DAVINCI_DA8XX
 	select CPU_DCACHE_WRITETHROUGH # needed on silicon revs 1.0, 1.1
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138 based system"
 	select CP_INTC
+	select TI_CPPI41
 	select ARCH_DAVINCI_DA8XX
 	select ARCH_HAS_CPUFREQ
 
Index: linux-davinci/arch/arm/mach-davinci/include/mach/da8xx.h
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/include/mach/da8xx.h
+++ linux-davinci/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -67,6 +67,8 @@ extern void __iomem *da8xx_syscfg1_base;
 void __init da830_init(void);
 void __init da850_init(void);
 
+int da8xx_cppi41_init(void);
+
 int da8xx_register_edma(void);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_watchdog(void);
Index: linux-davinci/arch/arm/mach-davinci/usb.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/usb.c
+++ linux-davinci/arch/arm/mach-davinci/usb.c
@@ -2,11 +2,14 @@
  * USB
  */
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
 #include <linux/usb/musb.h>
 
+#include <asm/hardware/cppi41.h>
+
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
@@ -173,4 +176,107 @@ int __init da8xx_register_usb11(struct d
 	da8xx_usb11_device.dev.platform_data = pdata;
 	return platform_device_register(&da8xx_usb11_device);
 }
+
+static const struct cppi41_tx_ch tx_ch_info[] = {
+	[0] = {
+		.port_num	= 1,
+		.num_tx_queue	= 2,
+		.tx_queue	= { { 0, 16 }, { 0, 17 } }
+	},
+	[1] = {
+		.port_num	= 2,
+		.num_tx_queue	= 2,
+		.tx_queue	= { { 0, 18 }, { 0, 19 } }
+	},
+	[2] = {
+		.port_num	= 3,
+		.num_tx_queue	= 2,
+		.tx_queue	= { { 0, 20 }, { 0, 21 } }
+	},
+	[3] = {
+		.port_num	= 4,
+		.num_tx_queue	= 2,
+		.tx_queue	= { { 0, 22 }, { 0, 23 } }
+	}
+};
+
+/* DMA block configuration */
+const struct cppi41_dma_block cppi41_dma_block[1] = {
+	[0] = {
+		.global_ctrl_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x1000),
+		.ch_ctrl_stat_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x1800),
+		.sched_ctrl_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x2000),
+		.sched_table_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x2800),
+		.num_tx_ch		= 4,
+		.num_rx_ch		= 4,
+		.tx_ch_info		= tx_ch_info
+	}
+};
+EXPORT_SYMBOL(cppi41_dma_block);
+
+/* Queues 0 to 27 are pre-assigned, others are spare */
+static const unsigned long assigned_queues[] = { 0x0fffffff, 0 };
+
+/* Queue manager information */
+const struct cppi41_queue_mgr cppi41_queue_mgr[1] = {
+	[0] = {
+		.q_mgr_rgn_base 	= IO_ADDRESS(DA8XX_USB0_BASE + 0x4000),
+		.desc_mem_rgn_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x5000),
+		.q_mgmt_rgn_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x6000),
+		.q_stat_rgn_base	= IO_ADDRESS(DA8XX_USB0_BASE + 0x6800),
+
+		.num_queue		= 64,
+		.queue_types		= CPPI41_FREE_DESC_BUF_QUEUE |
+					  CPPI41_UNASSIGNED_QUEUE,
+		.base_fdbq_num		= 0,
+		.assigned		= assigned_queues
+	}
+};
+EXPORT_SYMBOL(cppi41_queue_mgr);
+
+const u8 cppi41_num_queue_mgr = 1;
+const u8 cppi41_num_dma_block = 1;
+
+/* Fair DMA scheduling */
+static const u8 dma_sched_table[] = {
+	0x00, 0x80, 0x01, 0x81, 0x02, 0x82, 0x03, 0x83
+};
+
+int __init da8xx_cppi41_init(void)
+{
+	struct clk *usb20_clk;
+	int ret;
+
+	/* CPPI 4.1 is clocked by USB 2.0 clock. */
+	usb20_clk = clk_get(NULL, "usb20");
+	if (IS_ERR(usb20_clk)) {
+		ret = PTR_ERR(usb20_clk);
+		pr_warning("%s: clk_get() call failed: %d\n", __func__, ret);
+		return ret;
+	}
+	clk_enable(usb20_clk);
+
+	/* We provide no memory for the queue manager's linking RAM region 0. */
+	ret = cppi41_queue_mgr_init(0, 0, 0);
+	if (ret) {
+		pr_warning("%s: queue manager initialization failed: %d\n",
+			   __func__, ret);
+		return ret;
+	}
+
+	/* Allocate 32 (2^5) DMA teardown descriptors from queue manager 0. */
+	ret = cppi41_dma_ctrlr_init(0, 0, 5);
+	if (ret) {
+		pr_warning("%s: DMA controller initialization failed: %d\n",
+			   __func__, ret);
+		return ret;
+	}
+
+	ret = cppi41_dma_sched_init(0, dma_sched_table,
+				    sizeof(dma_sched_table));
+	if (ret)
+		pr_warning("%s: DMA scheduler initialization failed: %d\n",
+			   __func__, ret);
+	return ret;
+}
 #endif	/* CONFIG_DAVINCI_DA8XX */

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:06 +0100
Subject: [RFC PATCH 12/18] ARM: msm: make smd behave like a normal driver
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smd driver is registered as a platform driver with a probe
function, but hardcodes soc-specific interrupts and other settings
at compile-time, which gets in the way of reusing the same driver
on multiple machines.

This changes all compile-time configuration in the smd driver
to runtime configuration from platform device resources and
the platform device id, like we do for other drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/Makefile          |   5 +-
 arch/arm/mach-msm/board-halibut.c   |   6 --
 arch/arm/mach-msm/board-msm7x30.c   |   8 ---
 arch/arm/mach-msm/board-qsd8x50.c   |   7 --
 arch/arm/mach-msm/board-sapphire.c  |   6 --
 arch/arm/mach-msm/board-trout.c     |   6 --
 arch/arm/mach-msm/common.h          |   6 --
 arch/arm/mach-msm/devices-msm7x00.c |  11 ++-
 arch/arm/mach-msm/devices-msm7x30.c |  18 ++++-
 arch/arm/mach-msm/devices-qsd8x50.c |  11 ++-
 arch/arm/mach-msm/last_radio_log.c  |   1 -
 arch/arm/mach-msm/proc_comm.c       |  10 +--
 arch/arm/mach-msm/proc_comm.h       |   2 +
 arch/arm/mach-msm/smd.c             | 127 ++++++++++++++++----------------
 arch/arm/mach-msm/smd_debug.c       | 140 ++++++++++++------------------------
 arch/arm/mach-msm/smd_private.h     |  65 +++++++----------
 16 files changed, 173 insertions(+), 256 deletions(-)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index eb0fa4bf7f36..59ef46a881ea 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -9,8 +9,9 @@ obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
 
 obj-$(CONFIG_ARCH_MSM) += gpio-msm-v1.o
 
-obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
-obj-$(CONFIG_MSM_SMD) += last_radio_log.o
+obj-$(CONFIG_MSM_SMD) += msm-smd.o
+msm-smd-y += smd.o last_radio_log.o
+msm-smd-$(CONFIG_DEBUG_FS) += smd_debug.o
 
 obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o devices-msm7x00.o
 obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o board-trout-panel.o devices-msm7x00.o
diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 1b62427ad5ed..1b6d64196631 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -88,17 +88,11 @@ static void __init halibut_map_io(void)
 	msm_map_common_io();
 }
 
-static void __init halibut_init_late(void)
-{
-	smd_debugfs_init();
-}
-
 MACHINE_START(HALIBUT, "Halibut Board (QCT SURF7200A)")
 	.atag_offset	= 0x100,
 	.map_io		= halibut_map_io,
 	.init_early	= halibut_init_early,
 	.init_irq	= halibut_init_irq,
 	.init_machine	= halibut_init,
-	.init_late	= halibut_init_late,
 	.init_time	= msm7x01_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 4718a661306e..295d7c03e53f 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -206,11 +206,6 @@ static void __init msm7x30_map_io(void)
 	msm_map_msm7x30_io();
 }
 
-static void __init msm7x30_init_late(void)
-{
-	smd_debugfs_init();
-}
-
 MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 	.atag_offset = 0x100,
 	.fixup = msm7x30_fixup,
@@ -218,7 +213,6 @@ MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
-	.init_late = msm7x30_init_late,
 	.init_time	= msm7x30_timer_init,
 MACHINE_END
 
@@ -229,7 +223,6 @@ MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
-	.init_late = msm7x30_init_late,
 	.init_time	= msm7x30_timer_init,
 MACHINE_END
 
@@ -240,6 +233,5 @@ MACHINE_START(MSM7X30_FLUID, "QCT MSM7X30 FLUID")
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
-	.init_late = msm7x30_init_late,
 	.init_time	= msm7x30_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index ff458806785b..7bd36b9908c8 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -293,17 +293,11 @@ static void __init qsd8x50_init(void)
 	qsd8x50_init_mmc();
 }
 
-static void __init qsd8x50_init_late(void)
-{
-	smd_debugfs_init();
-}
-
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 	.atag_offset = 0x100,
 	.map_io = msm_map_qsd8x50_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
-	.init_late = qsd8x50_init_late,
 	.init_time	= qsd8x50_timer_init,
 MACHINE_END
 
@@ -319,7 +313,6 @@ MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 	.map_io = msm_map_qsd8x50_io_rev_a,
 	.init_irq = qsd8x50_init_irq_rev_a,
 	.init_machine = qsd8x50_init,
-	.init_late = qsd8x50_init_late,
 	.init_time	= qsd8x50_timer_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index e50967926dcd..e3aa71e839f4 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -97,11 +97,6 @@ static void __init sapphire_map_io(void)
 	msm_clock_init();
 }
 
-static void __init sapphire_init_late(void)
-{
-	smd_debugfs_init();
-}
-
 MACHINE_START(SAPPHIRE, "sapphire")
 /* Maintainer: Brian Swetland <swetland@google.com> */
 	.atag_offset    = 0x100,
@@ -109,6 +104,5 @@ MACHINE_START(SAPPHIRE, "sapphire")
 	.map_io         = sapphire_map_io,
 	.init_irq       = sapphire_init_irq,
 	.init_machine   = sapphire_init,
-	.init_late      = sapphire_init_late,
 	.init_time	= msm_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 7c1b06fa9a76..e1c6e8528150 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -94,11 +94,6 @@ static void __init trout_map_io(void)
 #endif
 }
 
-static void __init trout_init_late(void)
-{
-	smd_debugfs_init();
-}
-
 MACHINE_START(TROUT, "HTC Dream")
 	.atag_offset	= 0x100,
 	.fixup		= trout_fixup,
@@ -106,6 +101,5 @@ MACHINE_START(TROUT, "HTC Dream")
 	.init_early	= trout_init_early,
 	.init_irq	= trout_init_irq,
 	.init_machine	= trout_init,
-	.init_late	= trout_init_late,
 	.init_time	= msm7x01_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-msm/common.h b/arch/arm/mach-msm/common.h
index 7e4ddfdf4fe8..3c5214057657 100644
--- a/arch/arm/mach-msm/common.h
+++ b/arch/arm/mach-msm/common.h
@@ -34,10 +34,4 @@ extern int msm_add_sdcc(unsigned int controller,
 			struct msm_mmc_platform_data *plat,
 			unsigned int stat_irq, unsigned long stat_irq_flags);
 
-#if defined(CONFIG_MSM_SMD) && defined(CONFIG_DEBUG_FS)
-extern int smd_debugfs_init(void);
-#else
-static inline int smd_debugfs_init(void) { return 0; }
-#endif
-
 #endif
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index dc0ea895568b..1bac32b690cf 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -247,9 +247,16 @@ struct platform_device msm_device_nand = {
 	},
 };
 
+static struct resource resources_smd[] = {
+	DEFINE_RES_IRQ(INT_A9_M2A_0),
+	DEFINE_RES_IRQ(INT_A9_M2A_5),
+};
+
 struct platform_device msm_device_smd = {
-	.name	= "msm_smd",
-	.id	= -1,
+	.name		= "msm7x00_smd",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(resources_smd),
+	.resource	= resources_smd,
 };
 
 static struct resource resources_sdc1[] = {
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index 824e0d86b93f..f4ff40caac27 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -30,6 +30,7 @@
 
 #include "clock.h"
 #include "clock-pcom.h"
+#include "proc_comm.h"
 
 #include <linux/platform_data/mmc-msm_sdcc.h>
 
@@ -55,10 +56,16 @@ static struct map_desc msm7x30_io_desc[] __initdata = {
 	},
 };
 
+static void msm_a2m_int_msm7x00(uint32_t irq)
+{
+	writel(1 << irq, MSM_GCC_BASE + 0x8);
+}
+
 void __init msm_map_msm7x30_io(void)
 {
 	debug_ll_io_init();
 	iotable_init(msm7x30_io_desc, ARRAY_SIZE(msm7x30_io_desc));
+	msm_a2m_int = msm_a2m_int_msm7x00;
 }
 
 static struct resource msm_gpio_resources[] = {
@@ -113,9 +120,16 @@ struct platform_device msm_device_uart2 = {
 	.resource	= resources_uart2,
 };
 
+static struct resource resources_smd[] = {
+	DEFINE_RES_IRQ(INT_A9_M2A_0),
+	DEFINE_RES_IRQ(INT_A9_M2A_5),
+};
+
 struct platform_device msm_device_smd = {
-	.name   = "msm_smd",
-	.id     = -1,
+	.name   	= "msm_smd",
+	.id     	= -1,
+	.num_resources	= ARRAY_SIZE(resources_smd),
+	.resource	= resources_smd,
 };
 
 static struct resource resources_otg[] = {
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index f80a8efee126..5dcf17a24d70 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -130,9 +130,16 @@ struct platform_device msm_device_uart3 = {
 	.resource	= resources_uart3,
 };
 
+static struct resource resources_smd[] = {
+	DEFINE_RES_IRQ(INT_A9_M2A_0),
+	DEFINE_RES_IRQ(INT_A9_M2A_5),
+};
+
 struct platform_device msm_device_smd = {
-	.name   = "msm_smd",
-	.id     = -1,
+	.name		= "msm_smd",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(resources_smd),
+	.resource	= resources_smd,
 };
 
 static struct resource resources_otg[] = {
diff --git a/arch/arm/mach-msm/last_radio_log.c b/arch/arm/mach-msm/last_radio_log.c
index 9c392a29fc7e..7fd9fbde2025 100644
--- a/arch/arm/mach-msm/last_radio_log.c
+++ b/arch/arm/mach-msm/last_radio_log.c
@@ -68,4 +68,3 @@ void msm_init_last_radio_log(struct module *owner)
 	last_radio_log_fops.owner = owner;
 	proc_set_size(entry, radio_log_size);
 }
-EXPORT_SYMBOL(msm_init_last_radio_log);
diff --git a/arch/arm/mach-msm/proc_comm.c b/arch/arm/mach-msm/proc_comm.c
index 507f5ca80697..f79f57d7a0dd 100644
--- a/arch/arm/mach-msm/proc_comm.c
+++ b/arch/arm/mach-msm/proc_comm.c
@@ -22,14 +22,14 @@
 
 #include "proc_comm.h"
 
-static inline void msm_a2m_int(uint32_t irq)
+/* msm7x00 uses a different method and needs to override
+ * this function
+ */
+static void msm_a2m_int_scorpion(uint32_t irq)
 {
-#if defined(CONFIG_ARCH_MSM7X30)
-	writel(1 << irq, MSM_GCC_BASE + 0x8);
-#else
 	writel(1, MSM_CSR_BASE + 0x400 + (irq * 4));
-#endif
 }
+void (*msm_a2m_int)(uint32_t irq) = msm_a2m_int_scorpion;
 
 static inline void notify_other_proc_comm(void)
 {
diff --git a/arch/arm/mach-msm/proc_comm.h b/arch/arm/mach-msm/proc_comm.h
index e8d043a0e990..a0224327e8c7 100644
--- a/arch/arm/mach-msm/proc_comm.h
+++ b/arch/arm/mach-msm/proc_comm.h
@@ -255,4 +255,6 @@ enum {
 int msm_proc_comm(unsigned cmd, unsigned *data1, unsigned *data2);
 void proc_comm_boot_wait(void);
 
+extern void (*msm_a2m_int)(uint32_t irq);
+
 #endif
diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
index 7550f5a08956..b87f183a86c5 100644
--- a/arch/arm/mach-msm/smd.c
+++ b/arch/arm/mach-msm/smd.c
@@ -34,9 +34,21 @@
 #include "smd_private.h"
 #include "proc_comm.h"
 
-#if defined(CONFIG_ARCH_QSD8X50)
-#define CONFIG_QDSP6 1
-#endif
+enum msm_smd_version {
+	SMD_MSM7X00,
+	SMD_MSM7X30,
+	SMD_QSD8X50,
+} smd_version;
+
+#define SMSM_STATE_APPS (smd_version == SMD_MSM7X00 ? \
+	MSM7X00_SMSM_STATE_APPS : SCORPION_SMSM_STATE_APPS)
+
+#define SMSM_STATE_MODEM (smd_version == SMD_MSM7X00 ? \
+	MSM7X00_SMSM_STATE_MODEM : SCORPION_SMSM_STATE_MODEM)
+
+#define SMSM_STATE_COUNT \
+	(MSM7X00_SMSM_STATE_COUNT > SCORPION_SMSM_STATE_COUNT ? \
+	 MSM7X00_SMSM_STATE_COUNT : SCORPION_SMSM_STATE_COUNT)
 
 #define MODULE_NAME "msm_smd"
 
@@ -67,9 +79,8 @@ static unsigned last_heap_free = 0xffffffff;
 static inline void notify_other_smsm(void)
 {
 	msm_a2m_int(5);
-#ifdef CONFIG_QDSP6
-	msm_a2m_int(8);
-#endif
+	if (smd_version == SMD_QSD8X50)
+		msm_a2m_int(8);
 }
 
 static inline void notify_modem_smd(void)
@@ -374,13 +385,11 @@ static irqreturn_t smd_modem_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#if defined(CONFIG_QDSP6)
 static irqreturn_t smd_dsp_irq_handler(int irq, void *data)
 {
 	handle_smd_irq(&smd_ch_list_dsp, notify_dsp_smd);
 	return IRQ_HANDLED;
 }
-#endif
 
 static void smd_fake_irq_handler(unsigned long arg)
 {
@@ -553,6 +562,7 @@ static int smd_packet_read(smd_channel_t *ch, void *data, int len)
 static int smd_alloc_channel(const char *name, uint32_t cid, uint32_t type)
 {
 	struct smd_channel *ch;
+	int ret;
 
 	ch = kzalloc(sizeof(struct smd_channel), GFP_KERNEL);
 	if (ch == 0) {
@@ -561,7 +571,12 @@ static int smd_alloc_channel(const char *name, uint32_t cid, uint32_t type)
 	}
 	ch->n = cid;
 
-	if (_smd_alloc_channel(ch)) {
+	if (smd_version == SMD_MSM7X00)
+		ret = _smd_alloc_channel_pkg3(ch);
+	else
+		ret = _smd_alloc_channel_pkg4(ch);
+
+	if (ret) {
 		kfree(ch);
 		return -1;
 	}
@@ -892,48 +907,12 @@ uint32_t smsm_get_state(enum smsm_state_item item)
 	return rv;
 }
 
-#ifdef CONFIG_ARCH_MSM_SCORPION
-
-int smsm_set_sleep_duration(uint32_t delay)
-{
-	struct msm_dem_slave_data *ptr;
-
-	ptr = smem_find(SMEM_APPS_DEM_SLAVE_DATA, sizeof(*ptr));
-	if (ptr == NULL) {
-		pr_err("smsm_set_sleep_duration <SM NO APPS_DEM_SLAVE_DATA>\n");
-		return -EIO;
-	}
-	if (msm_smd_debug_mask & MSM_SMSM_DEBUG)
-		pr_info("smsm_set_sleep_duration %d -> %d\n",
-		       ptr->sleep_time, delay);
-	ptr->sleep_time = delay;
-	return 0;
-}
-
-#else
-
-int smsm_set_sleep_duration(uint32_t delay)
-{
-	uint32_t *ptr;
-
-	ptr = smem_find(SMEM_SMSM_SLEEP_DELAY, sizeof(*ptr));
-	if (ptr == NULL) {
-		pr_err("smsm_set_sleep_duration <SM NO SLEEP_DELAY>\n");
-		return -EIO;
-	}
-	if (msm_smd_debug_mask & MSM_SMSM_DEBUG)
-		pr_info("smsm_set_sleep_duration %d -> %d\n",
-		       *ptr, delay);
-	*ptr = delay;
-	return 0;
-}
-
-#endif
-
-int smd_core_init(void)
+static int smd_core_init(int version, int irq_a9_m2a_0, int irq_a9_m2a_5, int irq_adsp_a11)
 {
 	int r;
 
+	smd_version = version;
+
 	/* wait for essential items to be initialized */
 	for (;;) {
 		unsigned size;
@@ -947,33 +926,33 @@ int smd_core_init(void)
 
 	smd_info.ready = 1;
 
-	r = request_irq(INT_A9_M2A_0, smd_modem_irq_handler,
+	r = request_irq(irq_a9_m2a_0, smd_modem_irq_handler,
 			IRQF_TRIGGER_RISING, "smd_dev", 0);
 	if (r < 0)
 		return r;
-	r = enable_irq_wake(INT_A9_M2A_0);
+	r = enable_irq_wake(irq_a9_m2a_0);
 	if (r < 0)
 		pr_err("smd_core_init: enable_irq_wake failed for A9_M2A_0\n");
 
-	r = request_irq(INT_A9_M2A_5, smsm_irq_handler,
+	r = request_irq(irq_a9_m2a_5, smsm_irq_handler,
 			IRQF_TRIGGER_RISING, "smsm_dev", 0);
 	if (r < 0) {
-		free_irq(INT_A9_M2A_0, 0);
+		free_irq(irq_a9_m2a_0, 0);
 		return r;
 	}
-	r = enable_irq_wake(INT_A9_M2A_5);
+	r = enable_irq_wake(irq_a9_m2a_5);
 	if (r < 0)
 		pr_err("smd_core_init: enable_irq_wake failed for A9_M2A_5\n");
 
-#if defined(CONFIG_QDSP6)
-	r = request_irq(INT_ADSP_A11, smd_dsp_irq_handler,
-			IRQF_TRIGGER_RISING, "smd_dsp", 0);
-	if (r < 0) {
-		free_irq(INT_A9_M2A_0, 0);
-		free_irq(INT_A9_M2A_5, 0);
-		return r;
+	if (smd_version == SMD_QSD8X50) {
+		r = request_irq(irq_adsp_a11, smd_dsp_irq_handler,
+				IRQF_TRIGGER_RISING, "smd_dsp", 0);
+		if (r < 0) {
+			free_irq(irq_a9_m2a_0, 0);
+			free_irq(irq_a9_m2a_5, 0);
+			return r;
+		}
 	}
-#endif
 
 	/* check for any SMD channels that may already exist */
 	do_smd_probe();
@@ -981,15 +960,16 @@ int smd_core_init(void)
 	/* indicate that we're up and running */
 	smsm_change_state(SMSM_STATE_APPS,
 			  ~0, SMSM_INIT | SMSM_SMDINIT | SMSM_RPCINIT | SMSM_RUN);
-#ifdef CONFIG_ARCH_MSM_SCORPION
-	smsm_change_state(SMSM_STATE_APPS_DEM, ~0, 0);
-#endif
+	if (smd_version != SMD_MSM7X00)
+		smsm_change_state(SCORPION_SMSM_STATE_APPS_DEM, ~0, 0);
 
 	return 0;
 }
 
 static int msm_smd_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	/*
 	 * If we haven't waited for the ARM9 to boot up till now,
 	 * then we need to wait here. Otherwise this should just
@@ -999,9 +979,14 @@ static int msm_smd_probe(struct platform_device *pdev)
 
 	INIT_WORK(&probe_work, smd_channel_probe_worker);
 
-	if (smd_core_init()) {
+	ret = smd_core_init(pdev->id_entry->driver_data,
+			    platform_get_irq(pdev, 0),
+			    platform_get_irq(pdev, 1),
+			    platform_get_irq(pdev, 2));
+
+	if (ret) {
 		pr_err("smd_core_init() failed\n");
-		return -1;
+		return ret;
 	}
 
 	do_smd_probe();
@@ -1010,13 +995,23 @@ static int msm_smd_probe(struct platform_device *pdev)
 
 	msm_init_last_radio_log(THIS_MODULE);
 
+	smd_debugfs_init(pdev->id_entry->driver_data != SMD_MSM7X00);
+
 	smd_initialized = 1;
 
 	return 0;
 }
 
+struct platform_device_id msm_smd_id_table[] = {
+	{ "msm7x00_smd", SMD_MSM7X00 },
+	{ "msm7x30_smd", SMD_MSM7X00 },
+	{ "qsd8x50_smd", SMD_QSD8X50 },
+	{}
+};
+
 static struct platform_driver msm_smd_driver = {
 	.probe = msm_smd_probe,
+	.id_table = msm_smd_id_table,
 	.driver = {
 		.name = MODULE_NAME,
 	},
diff --git a/arch/arm/mach-msm/smd_debug.c b/arch/arm/mach-msm/smd_debug.c
index 8056b3e5590f..daffcc9e802d 100644
--- a/arch/arm/mach-msm/smd_debug.c
+++ b/arch/arm/mach-msm/smd_debug.c
@@ -21,8 +21,6 @@
 
 #include "smd_private.h"
 
-#if defined(CONFIG_DEBUG_FS)
-
 static char *chstate(unsigned n)
 {
 	switch (n) {
@@ -76,33 +74,56 @@ static int dump_ch(char *buf, int max, struct smd_channel *ch)
 		);
 }
 
-static int debug_read_stat(char *buf, int max)
+static int debug_read_stat_common(char *buf, int max)
 {
 	char *msg;
-	int i = 0;
 
 	msg = smem_find(ID_DIAG_ERR_MSG, SZ_DIAG_ERR_MSG);
+	if (!msg)
+		return 0;
+
+	msg[SZ_DIAG_ERR_MSG - 1] = 0;
+	return scnprintf(buf, max, "diag: '%s'\n", msg);
+}
+
+static int debug_read_stat_msm7x00(char *buf, int max)
+{
+	int i = 0;
+
+	if (raw_smsm_get_state(MSM7X00_SMSM_STATE_MODEM) & SMSM_RESET)
+		i += scnprintf(buf + i, max - i,
+			       "smsm: ARM9 HAS CRASHED\n");
+
+	i += scnprintf(buf + i, max - i, "smsm: a9: %08x a11: %08x\n",
+		       raw_smsm_get_state(MSM7X00_SMSM_STATE_MODEM),
+		       raw_smsm_get_state(MSM7X00_SMSM_STATE_APPS));
+
+	i += debug_read_stat_common(buf + i, max - i);
+
+	return i;
+}
+
+static int debug_read_stat_scorpion(char *buf, int max)
+{
+	int i = 0;
 
-	if (raw_smsm_get_state(SMSM_STATE_MODEM) & SMSM_RESET)
+	if (raw_smsm_get_state(SCORPION_SMSM_STATE_MODEM) & SMSM_RESET)
 		i += scnprintf(buf + i, max - i,
 			       "smsm: ARM9 HAS CRASHED\n");
 
 	i += scnprintf(buf + i, max - i, "smsm: a9: %08x a11: %08x\n",
-		       raw_smsm_get_state(SMSM_STATE_MODEM),
-		       raw_smsm_get_state(SMSM_STATE_APPS));
-#ifdef CONFIG_ARCH_MSM_SCORPION
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_MODEM),
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_APPS));
 	i += scnprintf(buf + i, max - i, "smsm dem: apps: %08x modem: %08x "
 		       "qdsp6: %08x power: %08x time: %08x\n",
-		       raw_smsm_get_state(SMSM_STATE_APPS_DEM),
-		       raw_smsm_get_state(SMSM_STATE_MODEM_DEM),
-		       raw_smsm_get_state(SMSM_STATE_QDSP6_DEM),
-		       raw_smsm_get_state(SMSM_STATE_POWER_MASTER_DEM),
-		       raw_smsm_get_state(SMSM_STATE_TIME_MASTER_DEM));
-#endif
-	if (msg) {
-		msg[SZ_DIAG_ERR_MSG - 1] = 0;
-		i += scnprintf(buf + i, max - i, "diag: '%s'\n", msg);
-	}
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_APPS_DEM),
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_MODEM_DEM),
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_QDSP6_DEM),
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_POWER_MASTER_DEM),
+		       raw_smsm_get_state(SCORPION_SMSM_STATE_TIME_MASTER_DEM));
+
+	i += debug_read_stat_common(buf + i, max - i);
+
 	return i;
 }
 
@@ -216,7 +237,7 @@ static void debug_create(const char *name, umode_t mode,
 	debugfs_create_file(name, mode, dent, fill, &debug_ops);
 }
 
-int __init smd_debugfs_init(void)
+int smd_debugfs_init(bool is_scorpion)
 {
 	struct dentry *dent;
 
@@ -225,7 +246,10 @@ int __init smd_debugfs_init(void)
 		return 1;
 
 	debug_create("ch", 0444, dent, debug_read_ch);
-	debug_create("stat", 0444, dent, debug_read_stat);
+	if (is_scorpion)
+		debug_create("stat", 0444, dent, debug_read_stat_scorpion);
+	else
+		debug_create("stat", 0444, dent, debug_read_stat_msm7x00);
 	debug_create("mem", 0444, dent, debug_read_mem);
 	debug_create("version", 0444, dent, debug_read_version);
 	debug_create("tbl", 0444, dent, debug_read_alloc_tbl);
@@ -233,79 +257,3 @@ int __init smd_debugfs_init(void)
 
 	return 0;
 }
-
-#endif
-
-
-#define MAX_NUM_SLEEP_CLIENTS		64
-#define MAX_SLEEP_NAME_LEN		8
-
-#define NUM_GPIO_INT_REGISTERS		6
-#define GPIO_SMEM_NUM_GROUPS		2
-#define GPIO_SMEM_MAX_PC_INTERRUPTS	8
-
-struct tramp_gpio_save {
-	unsigned int enable;
-	unsigned int detect;
-	unsigned int polarity;
-};
-
-struct tramp_gpio_smem {
-	uint16_t num_fired[GPIO_SMEM_NUM_GROUPS];
-	uint16_t fired[GPIO_SMEM_NUM_GROUPS][GPIO_SMEM_MAX_PC_INTERRUPTS];
-	uint32_t enabled[NUM_GPIO_INT_REGISTERS];
-	uint32_t detection[NUM_GPIO_INT_REGISTERS];
-	uint32_t polarity[NUM_GPIO_INT_REGISTERS];
-};
-
-
-void smsm_print_sleep_info(void)
-{
-	unsigned long flags;
-	uint32_t *ptr;
-#ifndef CONFIG_ARCH_MSM_SCORPION
-	struct tramp_gpio_smem *gpio;
-	struct smsm_interrupt_info *int_info;
-#endif
-
-
-	spin_lock_irqsave(&smem_lock, flags);
-
-	ptr = smem_alloc(SMEM_SMSM_SLEEP_DELAY, sizeof(*ptr));
-	if (ptr)
-		pr_info("SMEM_SMSM_SLEEP_DELAY: %x\n", *ptr);
-
-	ptr = smem_alloc(SMEM_SMSM_LIMIT_SLEEP, sizeof(*ptr));
-	if (ptr)
-		pr_info("SMEM_SMSM_LIMIT_SLEEP: %x\n", *ptr);
-
-	ptr = smem_alloc(SMEM_SLEEP_POWER_COLLAPSE_DISABLED, sizeof(*ptr));
-	if (ptr)
-		pr_info("SMEM_SLEEP_POWER_COLLAPSE_DISABLED: %x\n", *ptr);
-
-#ifndef CONFIG_ARCH_MSM_SCORPION
-	int_info = smem_alloc(SMEM_SMSM_INT_INFO, sizeof(*int_info));
-	if (int_info)
-		pr_info("SMEM_SMSM_INT_INFO %x %x %x\n",
-			int_info->interrupt_mask,
-			int_info->pending_interrupts,
-			int_info->wakeup_reason);
-
-	gpio = smem_alloc(SMEM_GPIO_INT, sizeof(*gpio));
-	if (gpio) {
-		int i;
-		for (i = 0; i < NUM_GPIO_INT_REGISTERS; i++)
-			pr_info("SMEM_GPIO_INT: %d: e %x d %x p %x\n",
-				i, gpio->enabled[i], gpio->detection[i],
-				gpio->polarity[i]);
-
-		for (i = 0; i < GPIO_SMEM_NUM_GROUPS; i++)
-			pr_info("SMEM_GPIO_INT: %d: f %d: %d %d...\n",
-				i, gpio->num_fired[i], gpio->fired[i][0],
-				gpio->fired[i][1]);
-	}
-#else
-#endif
-	spin_unlock_irqrestore(&smem_lock, flags);
-}
-
diff --git a/arch/arm/mach-msm/smd_private.h b/arch/arm/mach-msm/smd_private.h
index 727bfe68aa9b..50f7b7d22023 100644
--- a/arch/arm/mach-msm/smd_private.h
+++ b/arch/arm/mach-msm/smd_private.h
@@ -64,15 +64,14 @@ struct smem_shared {
 #define SMSM_V1_SIZE		(sizeof(unsigned) * 8)
 #define SMSM_V2_SIZE		(sizeof(unsigned) * 4)
 
-#ifdef CONFIG_MSM_SMD_PKG3
-struct smsm_interrupt_info {
+struct smsm_interrupt_info_pkg3 {
 	uint32_t interrupt_mask;
 	uint32_t pending_interrupts;
 	uint32_t wakeup_reason;
 };
-#else
+
 #define DEM_MAX_PORT_NAME_LEN (20)
-struct msm_dem_slave_data {
+struct msm_dem_slave_data_pkg4 {
 	uint32_t sleep_time;
 	uint32_t interrupt_mask;
 	uint32_t resources_used;
@@ -85,7 +84,6 @@ struct msm_dem_slave_data {
 	char     smd_port_name[DEM_MAX_PORT_NAME_LEN];
 	uint32_t reserved2;
 };
-#endif
 
 #define SZ_DIAG_ERR_MSG 0xC8
 #define ID_DIAG_ERR_MSG SMEM_DIAG_ERR_MESSAGE
@@ -126,30 +124,24 @@ struct msm_dem_slave_data {
 #define SMSM_WKUP_REASON_ALARM	0x00000010
 #define SMSM_WKUP_REASON_RESET	0x00000020
 
-#ifdef CONFIG_ARCH_MSM7X00A
-enum smsm_state_item {
-	SMSM_STATE_APPS = 1,
-	SMSM_STATE_MODEM = 3,
-	SMSM_STATE_COUNT,
-};
-#else
 enum smsm_state_item {
-	SMSM_STATE_APPS,
-	SMSM_STATE_MODEM,
-	SMSM_STATE_HEXAGON,
-	SMSM_STATE_APPS_DEM,
-	SMSM_STATE_MODEM_DEM,
-	SMSM_STATE_QDSP6_DEM,
-	SMSM_STATE_POWER_MASTER_DEM,
-	SMSM_STATE_TIME_MASTER_DEM,
-	SMSM_STATE_COUNT,
+	MSM7X00_SMSM_STATE_APPS = 1,
+	MSM7X00_SMSM_STATE_MODEM = 3,
+	MSM7X00_SMSM_STATE_COUNT,
+	SCORPION_SMSM_STATE_APPS = 0,
+	SCORPION_SMSM_STATE_MODEM,
+	SCORPION_SMSM_STATE_HEXAGON,
+	SCORPION_SMSM_STATE_APPS_DEM,
+	SCORPION_SMSM_STATE_MODEM_DEM,
+	SCORPION_SMSM_STATE_QDSP6_DEM,
+	SCORPION_SMSM_STATE_POWER_MASTER_DEM,
+	SCORPION_SMSM_STATE_TIME_MASTER_DEM,
+	SCORPION_SMSM_STATE_COUNT,
 };
-#endif
 
 void *smem_alloc(unsigned id, unsigned size);
 int smsm_change_state(enum smsm_state_item item, uint32_t clear_mask, uint32_t set_mask);
 uint32_t smsm_get_state(enum smsm_state_item item);
-int smsm_set_sleep_duration(uint32_t delay);
 void smsm_print_sleep_info(void);
 
 #define SMEM_NUM_SMD_CHANNELS        64
@@ -335,12 +327,17 @@ uint32_t raw_smsm_get_state(enum smsm_state_item item);
 
 extern void msm_init_last_radio_log(struct module *);
 
-#ifdef CONFIG_MSM_SMD_PKG3
+#if defined(CONFIG_MSM_SMD) && defined(CONFIG_DEBUG_FS)
+extern int smd_debugfs_init(bool);
+#else
+static inline int smd_debugfs_init(bool is_scorpion) { return 0; }
+#endif
+
 /*
  * This allocator assumes an SMD Package v3 which only exists on
  * MSM7x00 SoC's.
  */
-static inline int _smd_alloc_channel(struct smd_channel *ch)
+static inline int _smd_alloc_channel_pkg3(struct smd_channel *ch)
 {
 	struct smd_shared_v1 *shared1;
 
@@ -356,12 +353,12 @@ static inline int _smd_alloc_channel(struct smd_channel *ch)
 	ch->fifo_size = SMD_BUF_SIZE;
 	return 0;
 }
-#else
+
 /*
  * This allocator assumes an SMD Package v4, the most common
  * and the default.
  */
-static inline int _smd_alloc_channel(struct smd_channel *ch)
+static inline int _smd_alloc_channel_pkg4(struct smd_channel *ch)
 {
 	struct smd_shared_v2 *shared2;
 	void *buffer;
@@ -385,19 +382,5 @@ static inline int _smd_alloc_channel(struct smd_channel *ch)
 	ch->fifo_size = buffer_sz;
 	return 0;
 }
-#endif /* CONFIG_MSM_SMD_PKG3 */
-
-#if defined(CONFIG_ARCH_MSM7X30)
-static inline void msm_a2m_int(uint32_t irq)
-{
-	writel(1 << irq, MSM_GCC_BASE + 0x8);
-}
-#else
-static inline void msm_a2m_int(uint32_t irq)
-{
-	writel(1, MSM_CSR_BASE + 0x400 + (irq * 4));
-}
-#endif /* CONFIG_ARCH_MSM7X30 */
-
 
 #endif
-- 
2.1.0.rc2

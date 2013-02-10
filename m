From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 10 Feb 2013 17:32:52 +0100
Subject: [PATCH 2/2] mfd: db8500-prcmu: update resource passing
Message-ID: <1360513972-31729-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

When trying to get rid of the cross-includes of <mach/id.h>
from different drivers, so we can localize ASIC/CPU detection
to the mach-ux500 folder, we run into the way the PRCMU
handles base addresses and firmware detection.

This patch updates the firmware version detection to pass
the required information as platform data instead of
relying on cpu_is_* macros.

Now the PRCMU base address, the secondary TCDM area, the
TCPM area and the IRQ are passed as resources instead of
being grabbed from <mach/*> files. Incidentally this also
removes part of the reliance on <mach/irqs.h>.

Further it updates the firmware version detection, since the
location of the firmware ID bytes in the designated memory
are is now passed from the platform data instead. There is
no reason not to include the nice split-off of a struct to
hold the firmware information and a separate function to
populate it.

The patch actually rids the need to use the external
db8500_prcmu_early_init call at all, but I'm keepin back
that removal as I don't want the patch to be too big.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: arm at kernel.org
Cc: Michel Jaoen <michel.jaouen@stericsson.com>
Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Loic Pallardy <loic.pallardy@stericsson.com>
Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, we'd really like to take this into the ARM SoC
tree next/cleanup branch. This is because it is currently broken
on ux500 since <mach/id.h> is already deleted there.

I have tested this by git-pull:in the branch with this
patch right on top of linux-next, and it worked flawlessly.

If it anyway doesn't work out for MFD we'll have to merge
this during the -rc phase (which isn't the end of the world),
but it'd be great to know.

ARM SoC: please merge this to next/cleanup if Samuel is OK
with it.
---
 arch/arm/mach-ux500/board-mop500.c   |   5 +-
 arch/arm/mach-ux500/cpu-db8500.c     |   7 +-
 arch/arm/mach-ux500/devices-db8500.c |  44 +++++++++++++
 arch/arm/mach-ux500/devices-db8500.h |   5 ++
 drivers/mfd/db8500-prcmu.c           | 122 +++++++++++++++++++++++------------
 include/linux/mfd/db8500-prcmu.h     |  14 ----
 include/linux/mfd/dbx500-prcmu.h     |  46 +++++++++++++
 7 files changed, 180 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index d453522..6cb1407 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -215,7 +215,7 @@ static struct platform_device snowball_sbnet_dev = {
 	},
 };
 
-static struct ab8500_platform_data ab8500_platdata = {
+struct ab8500_platform_data ab8500_platdata = {
 	.irq_base	= MOP500_AB8500_IRQ_BASE,
 	.regulator_reg_init = ab8500_regulator_reg_init,
 	.num_regulator_reg_init	= ARRAY_SIZE(ab8500_regulator_reg_init),
@@ -651,6 +651,7 @@ static void __init mop500_init_machine(void)
 	int i2c0_devs;
 	int i;
 
+	platform_device_register(&db8500_prcmu_device);
 	mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
 
 	mop500_pinmaps_init();
@@ -685,6 +686,7 @@ static void __init snowball_init_machine(void)
 	struct device *parent = NULL;
 	int i;
 
+	platform_device_register(&db8500_prcmu_device);
 	snowball_pinmaps_init();
 	parent = u8500_init_devices(&ab8500_platdata);
 
@@ -710,6 +712,7 @@ static void __init hrefv60_init_machine(void)
 	int i2c0_devs;
 	int i;
 
+	platform_device_register(&db8500_prcmu_device);
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
 	 * all these GPIO pins to the internal GPIO controller
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 09c3fee..8501970 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -139,14 +139,9 @@ static struct platform_device db8500_pmu_device = {
 	.dev.platform_data	= &db8500_pmu_platdata,
 };
 
-static struct platform_device db8500_prcmu_device = {
-	.name			= "db8500-prcmu",
-};
-
 static struct platform_device *platform_devs[] __initdata = {
 	&u8500_dma40_device,
 	&db8500_pmu_device,
-	&db8500_prcmu_device,
 };
 
 static resource_size_t __initdata db8500_gpio_base[] = {
@@ -286,6 +281,8 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80128000, "nmk-i2c.2", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x80110000, "nmk-i2c.3", NULL),
 	OF_DEV_AUXDATA("st,nomadik-i2c", 0x8012a000, "nmk-i2c.4", NULL),
+	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
+			&db8500_prcmu_pdata),
 	/* Requires device name bindings. */
 	OF_DEV_AUXDATA("stericsson,nmk_pinctrl", 0, "pinctrl-db8500", NULL),
 	/* Requires clock name and DMA bindings. */
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 318d490..f3d9419 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -13,11 +13,13 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
 #include <linux/platform_data/dma-ste-dma40.h>
+#include <linux/mfd/dbx500-prcmu.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/irqs.h>
 
+#include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
 
 static struct resource dma40_resources[] = {
@@ -194,3 +196,45 @@ struct platform_device u8500_ske_keypad_device = {
 	.num_resources = ARRAY_SIZE(keypad_resources),
 	.resource = keypad_resources,
 };
+
+struct prcmu_pdata db8500_prcmu_pdata = {
+	.ab_platdata	= &ab8500_platdata,
+	.version_offset	= DB8500_PRCMU_FW_VERSION_OFFSET,
+	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
+};
+
+static struct resource db8500_prcmu_res[] = {
+	{
+		.name  = "prcmu",
+		.start = U8500_PRCMU_BASE,
+		.end   = U8500_PRCMU_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.name  = "prcmu-tcdm",
+		.start = U8500_PRCMU_TCDM_BASE,
+		.end   = U8500_PRCMU_TCDM_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.name  = "irq",
+		.start = IRQ_DB8500_PRCMU1,
+		.end   = IRQ_DB8500_PRCMU1,
+		.flags = IORESOURCE_IRQ,
+	},
+	{
+		.name  = "prcmu-tcpm",
+		.start = U8500_PRCMU_TCPM_BASE,
+		.end   = U8500_PRCMU_TCPM_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device db8500_prcmu_device = {
+	.name			= "db8500-prcmu",
+	.resource		= db8500_prcmu_res,
+	.num_resources		= ARRAY_SIZE(db8500_prcmu_res),
+	.dev = {
+		.platform_data = &db8500_prcmu_pdata,
+	},
+};
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index a5e05f6..dbcb35c 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -14,6 +14,11 @@
 
 struct ske_keypad_platform_data;
 struct pl022_ssp_controller;
+struct platform_device;
+
+extern struct ab8500_platform_data ab8500_platdata;
+extern struct prcmu_pdata db8500_prcmu_pdata;
+extern struct platform_device db8500_prcmu_device;
 
 static inline struct platform_device *
 db8500_add_ske_keypad(struct device *parent,
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 67d8b25..eba03d2 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -38,9 +38,6 @@
 #include <mach/db8500-regs.h>
 #include "dbx500-prcmu-regs.h"
 
-/* Offset for the firmware version within the TCPM */
-#define PRCMU_FW_VERSION_OFFSET 0xA4
-
 /* Index of different voltages to be used when accessing AVSData */
 #define PRCM_AVS_BASE		0x2FC
 #define PRCM_AVS_VBB_RET	(PRCM_AVS_BASE + 0x0)
@@ -2704,21 +2701,43 @@ static struct irq_chip prcmu_irq_chip = {
 	.irq_unmask	= prcmu_irq_unmask,
 };
 
-static char *fw_project_name(u8 project)
+static __init char *fw_project_name(u32 project)
 {
 	switch (project) {
 	case PRCMU_FW_PROJECT_U8500:
 		return "U8500";
-	case PRCMU_FW_PROJECT_U8500_C2:
-		return "U8500 C2";
+	case PRCMU_FW_PROJECT_U8400:
+		return "U8400";
 	case PRCMU_FW_PROJECT_U9500:
 		return "U9500";
-	case PRCMU_FW_PROJECT_U9500_C2:
-		return "U9500 C2";
+	case PRCMU_FW_PROJECT_U8500_MBB:
+		return "U8500 MBB";
+	case PRCMU_FW_PROJECT_U8500_C1:
+		return "U8500 C1";
+	case PRCMU_FW_PROJECT_U8500_C2:
+		return "U8500 C2";
+	case PRCMU_FW_PROJECT_U8500_C3:
+		return "U8500 C3";
+	case PRCMU_FW_PROJECT_U8500_C4:
+		return "U8500 C4";
+	case PRCMU_FW_PROJECT_U9500_MBL:
+		return "U9500 MBL";
+	case PRCMU_FW_PROJECT_U8500_MBL:
+		return "U8500 MBL";
+	case PRCMU_FW_PROJECT_U8500_MBL2:
+		return "U8500 MBL2";
 	case PRCMU_FW_PROJECT_U8520:
-		return "U8520";
+		return "U8520 MBL";
 	case PRCMU_FW_PROJECT_U8420:
 		return "U8420";
+	case PRCMU_FW_PROJECT_U9540:
+		return "U9540";
+	case PRCMU_FW_PROJECT_A9420:
+		return "A9420";
+	case PRCMU_FW_PROJECT_L8540:
+		return "L8540";
+	case PRCMU_FW_PROJECT_L8580:
+		return "L8580";
 	default:
 		return "Unknown";
 	}
@@ -2759,37 +2778,44 @@ static int db8500_irq_init(struct device_node *np)
 	return 0;
 }
 
-void __init db8500_prcmu_early_init(void)
+static void dbx500_fw_version_init(struct platform_device *pdev,
+			    u32 version_offset)
 {
-	if (cpu_is_u8500v2() || cpu_is_u9540()) {
-		void *tcpm_base = ioremap_nocache(U8500_PRCMU_TCPM_BASE, SZ_4K);
-
-		if (tcpm_base != NULL) {
-			u32 version;
-			version = readl(tcpm_base + PRCMU_FW_VERSION_OFFSET);
-			fw_info.version.project = version & 0xFF;
-			fw_info.version.api_version = (version >> 8) & 0xFF;
-			fw_info.version.func_version = (version >> 16) & 0xFF;
-			fw_info.version.errata = (version >> 24) & 0xFF;
-			fw_info.valid = true;
-			pr_info("PRCMU firmware: %s, version %d.%d.%d\n",
-				fw_project_name(fw_info.version.project),
-				(version >> 8) & 0xFF, (version >> 16) & 0xFF,
-				(version >> 24) & 0xFF);
-			iounmap(tcpm_base);
-		}
+	struct resource *res;
+	void __iomem *tcpm_base;
 
-		if (cpu_is_u9540())
-			tcdm_base = ioremap_nocache(U8500_PRCMU_TCDM_BASE,
-						SZ_4K + SZ_8K) + SZ_8K;
-		else
-			tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
-	} else {
-		pr_err("prcmu: Unsupported chip version\n");
-		BUG();
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "prcmu-tcpm");
+	if (!res) {
+		dev_err(&pdev->dev,
+			"Error: no prcmu tcpm memory region provided\n");
+		return;
+	}
+	tcpm_base = ioremap(res->start, resource_size(res));
+	if (tcpm_base != NULL) {
+		u32 version;
+
+		version = readl(tcpm_base + version_offset);
+		fw_info.version.project = (version & 0xFF);
+		fw_info.version.api_version = (version >> 8) & 0xFF;
+		fw_info.version.func_version = (version >> 16) & 0xFF;
+		fw_info.version.errata = (version >> 24) & 0xFF;
+		strncpy(fw_info.version.project_name,
+			fw_project_name(fw_info.version.project),
+			PRCMU_FW_PROJECT_NAME_LEN);
+		fw_info.valid = true;
+		pr_info("PRCMU firmware: %s(%d), version %d.%d.%d\n",
+			fw_info.version.project_name,
+			fw_info.version.project,
+			fw_info.version.api_version,
+			fw_info.version.func_version,
+			fw_info.version.errata);
+		iounmap(tcpm_base);
 	}
-	tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
+}
 
+void __init db8500_prcmu_early_init(void)
+{
 	spin_lock_init(&mb0_transfer.lock);
 	spin_lock_init(&mb0_transfer.dbb_irqs_lock);
 	mutex_init(&mb0_transfer.ac_wake_lock);
@@ -3099,20 +3125,30 @@ static void db8500_prcmu_update_cpufreq(void)
  */
 static int db8500_prcmu_probe(struct platform_device *pdev)
 {
-	struct ab8500_platform_data *ab8500_platdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
+	struct prcmu_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int irq = 0, err = 0, i;
+	struct resource *res;
 
 	init_prcm_registers();
 
+	dbx500_fw_version_init(pdev, pdata->version_offset);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu-tcdm");
+	if (!res) {
+		dev_err(&pdev->dev, "no prcmu tcdm region provided\n");
+		return -ENOENT;
+	}
+	tcdm_base = devm_ioremap(&pdev->dev, res->start,
+			resource_size(res));
+
 	/* Clean up the mailbox interrupts after pre-kernel code. */
 	writel(ALL_MBOX_BITS, PRCM_ARM_IT1_CLR);
 
-	if (np)
-		irq = platform_get_irq(pdev, 0);
-
-	if (!np || irq <= 0)
-		irq = IRQ_DB8500_PRCMU1;
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "no prcmu irq provided\n");
+		return -ENOENT;
+	}
 
 	err = request_threaded_irq(irq, prcmu_irq_handler,
 	        prcmu_irq_thread_fn, IRQF_NO_SUSPEND, "prcmu", NULL);
@@ -3126,7 +3162,7 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(db8500_prcmu_devs); i++) {
 		if (!strcmp(db8500_prcmu_devs[i].name, "ab8500-core")) {
-			db8500_prcmu_devs[i].platform_data = ab8500_platdata;
+			db8500_prcmu_devs[i].platform_data = pdata->ab_platdata;
 			db8500_prcmu_devs[i].pdata_size = sizeof(struct ab8500_platform_data);
 		}
 	}
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index a65dedd..77a46ae 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -487,20 +487,6 @@ struct prcmu_auto_pm_config {
 	u8 sva_policy;
 };
 
-#define PRCMU_FW_PROJECT_U8500		2
-#define PRCMU_FW_PROJECT_U9500		4
-#define PRCMU_FW_PROJECT_U8500_C2	7
-#define PRCMU_FW_PROJECT_U9500_C2	11
-#define PRCMU_FW_PROJECT_U8520		13
-#define PRCMU_FW_PROJECT_U8420		14
-
-struct prcmu_fw_version {
-	u8 project;
-	u8 api_version;
-	u8 func_version;
-	u8 errata;
-};
-
 #ifdef CONFIG_MFD_DB8500_PRCMU
 
 void db8500_prcmu_early_init(void);
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 1552806..f8bac7c 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -12,6 +12,10 @@
 #include <linux/notifier.h>
 #include <linux/err.h>
 
+/* Offset for the firmware version within the TCPM */
+#define DB8500_PRCMU_FW_VERSION_OFFSET 0xA4
+#define DBX540_PRCMU_FW_VERSION_OFFSET 0xA8
+
 /* PRCMU Wakeup defines */
 enum prcmu_wakeup_index {
 	PRCMU_WAKEUP_INDEX_RTC,
@@ -214,6 +218,48 @@ enum ddr_pwrst {
 	DDR_PWR_STATE_OFFHIGHLAT    = 0x03
 };
 
+#define DB8500_PRCMU_LEGACY_OFFSET		0xDD4
+
+struct prcmu_pdata
+{
+	bool enable_set_ddr_opp;
+	bool enable_ape_opp_100_voltage;
+	struct ab8500_platform_data *ab_platdata;
+	u32 version_offset;
+	u32 legacy_offset;
+	u32 adt_offset;
+};
+
+#define PRCMU_FW_PROJECT_U8500		2
+#define PRCMU_FW_PROJECT_U8400		3
+#define PRCMU_FW_PROJECT_U9500		4 /* Customer specific */
+#define PRCMU_FW_PROJECT_U8500_MBB	5
+#define PRCMU_FW_PROJECT_U8500_C1	6
+#define PRCMU_FW_PROJECT_U8500_C2	7
+#define PRCMU_FW_PROJECT_U8500_C3	8
+#define PRCMU_FW_PROJECT_U8500_C4	9
+#define PRCMU_FW_PROJECT_U9500_MBL	10
+#define PRCMU_FW_PROJECT_U8500_MBL	11 /* Customer specific */
+#define PRCMU_FW_PROJECT_U8500_MBL2	12 /* Customer specific */
+#define PRCMU_FW_PROJECT_U8520		13
+#define PRCMU_FW_PROJECT_U8420		14
+#define PRCMU_FW_PROJECT_A9420		20
+/* [32..63] 9540 and derivatives */
+#define PRCMU_FW_PROJECT_U9540		32
+/* [64..95] 8540 and derivatives */
+#define PRCMU_FW_PROJECT_L8540		64
+/* [96..126] 8580 and derivatives */
+#define PRCMU_FW_PROJECT_L8580		96
+
+#define PRCMU_FW_PROJECT_NAME_LEN	20
+struct prcmu_fw_version {
+	u32 project; /* Notice, project shifted with 8 on ux540 */
+	u8 api_version;
+	u8 func_version;
+	u8 errata;
+	char project_name[PRCMU_FW_PROJECT_NAME_LEN];
+};
+
 #include <linux/mfd/db8500-prcmu.h>
 
 #if defined(CONFIG_UX500_SOC_DB8500)
-- 
1.7.11.3

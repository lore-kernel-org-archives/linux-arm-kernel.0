From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 16:02:45 +0200
Subject: [PATCH 4/4] mfd: db8500 stop passing around platform data
Message-ID: <1462889050-2818609-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Except for the constant DB8500_PRCMU_FW_VERSION_OFFSET number, nothing
is ever passed through the platform data and used in a driver, so we
can simply stop passing it around.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/cpu-db8500.c          | 17 ++--------------
 arch/arm/mach-ux500/setup.h               |  1 -
 drivers/mfd/ab8500-core.c                 |  4 ----
 drivers/mfd/ab8500-sysctrl.c              | 34 -------------------------------
 drivers/mfd/db8500-prcmu.c                | 10 +++------
 include/linux/mfd/abx500/ab8500-sysctrl.h |  6 ------
 include/linux/mfd/dbx500-prcmu.h          | 10 ---------
 7 files changed, 5 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index c015ef8dd535..bbd1b4b8d441 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -16,8 +16,6 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/dbx500-prcmu.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/perf/arm_pmu.h>
@@ -32,15 +30,6 @@
 #include "db8500-regs.h"
 #include "id.h"
 
-static struct ab8500_platform_data ab8500_platdata = {
-};
-
-static struct prcmu_pdata db8500_prcmu_pdata = {
-	.ab_platdata	= &ab8500_platdata,
-	.version_offset	= DB8500_PRCMU_FW_VERSION_OFFSET,
-	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
-};
-
 static void __init u8500_map_io(void)
 {
 	debug_ll_io_init();
@@ -109,8 +98,7 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80125000,
 		       "ux500-msp-i2s.3", &msp3_platform_data),
 	/* Requires non-DT:able platform data. */
-	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
-			&db8500_prcmu_pdata),
+	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu", NULL),
 	OF_DEV_AUXDATA("stericsson,ux500-cryp", 0xa03cb000, "cryp1", NULL),
 	OF_DEV_AUXDATA("stericsson,ux500-hash", 0xa03c2000, "hash1", NULL),
 	OF_DEV_AUXDATA("stericsson,snd-soc-mop500", 0, "snd-soc-mop500.0",
@@ -119,8 +107,7 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 };
 
 static struct of_dev_auxdata u8540_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
-			&db8500_prcmu_pdata),
+	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu", NULL),
 	{},
 };
 
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index c704254ab67c..e606847c8b58 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -13,7 +13,6 @@
 
 #include <asm/mach/arch.h>
 #include <linux/init.h>
-#include <linux/mfd/abx500/ab8500.h>
 
 void ux500_restart(enum reboot_mode mode, const char *cmd);
 
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f3d689176fc2..589eebfc13df 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1087,7 +1087,6 @@ static int ab8500_probe(struct platform_device *pdev)
 		"Vbus Detect (USB)",
 		"USB ID Detect",
 		"UART Factory Mode Detect"};
-	struct ab8500_platform_data *plat = dev_get_platdata(&pdev->dev);
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	enum ab8500_version version = AB8500_VERSION_UNDEFINED;
 	struct device_node *np = pdev->dev.of_node;
@@ -1219,9 +1218,6 @@ static int ab8500_probe(struct platform_device *pdev)
 		pr_cont("None\n");
 	}
 
-	if (plat && plat->init)
-		plat->init(ab8500);
-
 	if (is_ab9540(ab8500)) {
 		ret = get_register_interruptible(ab8500, AB8500_CHARGER,
 			AB8500_CH_USBCH_STAT1_REG, &value);
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index b9f0010309f9..207cc497958a 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -127,45 +127,11 @@ EXPORT_SYMBOL(ab8500_sysctrl_write);
 
 static int ab8500_sysctrl_probe(struct platform_device *pdev)
 {
-	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
-	struct ab8500_platform_data *plat;
-	struct ab8500_sysctrl_platform_data *pdata;
-
-	plat = dev_get_platdata(pdev->dev.parent);
-
-	if (!plat)
-		return -EINVAL;
-
 	sysctrl_dev = &pdev->dev;
 
 	if (!pm_power_off)
 		pm_power_off = ab8500_power_off;
 
-	pdata = plat->sysctrl;
-	if (pdata) {
-		int last, ret, i, j;
-
-		if (is_ab8505(ab8500))
-			last = AB8500_SYSCLKREQ4RFCLKBUF;
-		else
-			last = AB8500_SYSCLKREQ8RFCLKBUF;
-
-		for (i = AB8500_SYSCLKREQ1RFCLKBUF; i <= last; i++) {
-			j = i - AB8500_SYSCLKREQ1RFCLKBUF;
-			ret = ab8500_sysctrl_write(i, 0xff,
-					pdata->initial_req_buf_config[j]);
-			dev_dbg(&pdev->dev,
-					"Setting SysClkReq%dRfClkBuf 0x%X\n",
-					j + 1,
-					pdata->initial_req_buf_config[j]);
-			if (ret < 0) {
-				dev_err(&pdev->dev,
-					"Can't set sysClkReq%dRfClkBuf: %d\n",
-					j + 1, ret);
-			}
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index c0a86aeb1733..388e268b9bcf 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3094,8 +3094,7 @@ static void db8500_prcmu_update_cpufreq(void)
 	}
 }
 
-static int db8500_prcmu_register_ab8500(struct device *parent,
-					struct ab8500_platform_data *pdata)
+static int db8500_prcmu_register_ab8500(struct device *parent)
 {
 	struct device_node *np;
 	struct resource ab8500_resource;
@@ -3103,8 +3102,6 @@ static int db8500_prcmu_register_ab8500(struct device *parent,
 		.name = "ab8500-core",
 		.of_compatible = "stericsson,ab8500",
 		.id = AB8500_VERSION_AB8500,
-		.platform_data = pdata,
-		.pdata_size = sizeof(struct ab8500_platform_data),
 		.resources = &ab8500_resource,
 		.num_resources = 1,
 	};
@@ -3133,7 +3130,6 @@ static int db8500_prcmu_register_ab8500(struct device *parent,
 static int db8500_prcmu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct prcmu_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int irq = 0, err = 0;
 	struct resource *res;
 
@@ -3149,7 +3145,7 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	init_prcm_registers();
-	dbx500_fw_version_init(pdev, pdata->version_offset);
+	dbx500_fw_version_init(pdev, DB8500_PRCMU_FW_VERSION_OFFSET);
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu-tcdm");
 	if (!res) {
 		dev_err(&pdev->dev, "no prcmu tcdm region provided\n");
@@ -3204,7 +3200,7 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = db8500_prcmu_register_ab8500(&pdev->dev, pdata->ab_platdata);
+	err = db8500_prcmu_register_ab8500(&pdev->dev);
 	if (err) {
 		mfd_remove_devices(&pdev->dev);
 		pr_err("prcmu: Failed to add ab8500 subdevice\n");
diff --git a/include/linux/mfd/abx500/ab8500-sysctrl.h b/include/linux/mfd/abx500/ab8500-sysctrl.h
index 689312745b2f..01024d1aed0e 100644
--- a/include/linux/mfd/abx500/ab8500-sysctrl.h
+++ b/include/linux/mfd/abx500/ab8500-sysctrl.h
@@ -37,12 +37,6 @@ static inline int ab8500_sysctrl_clear(u16 reg, u8 bits)
 	return ab8500_sysctrl_write(reg, bits, 0);
 }
 
-/* Configuration data for SysClkReq1RfClkBuf - SysClkReq8RfClkBuf */
-struct ab8500_sysctrl_platform_data {
-	u8 initial_req_buf_config[8];
-	u16 (*reboot_reason_code)(const char *cmd);
-};
-
 /* Registers */
 #define AB8500_TURNONSTATUS		0x100
 #define AB8500_RESETSTATUS		0x101
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index bf5109d38a26..5d374601404c 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -178,16 +178,6 @@ enum ddr_pwrst {
 
 #define DB8500_PRCMU_LEGACY_OFFSET		0xDD4
 
-struct prcmu_pdata
-{
-	bool enable_set_ddr_opp;
-	bool enable_ape_opp_100_voltage;
-	struct ab8500_platform_data *ab_platdata;
-	u32 version_offset;
-	u32 legacy_offset;
-	u32 adt_offset;
-};
-
 #define PRCMU_FW_PROJECT_U8500		2
 #define PRCMU_FW_PROJECT_U8400		3
 #define PRCMU_FW_PROJECT_U9500		4 /* Customer specific */
-- 
2.7.0

From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 11 Jan 2012 01:18:05 -0600
Subject: [RFC] ARM: imx: Add imx6q thermal
Message-ID: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal support for i.MX6Q.  Uses recently submitted common
cpu_cooling functionality shown here:

http://www.spinics.net/lists/linux-pm/msg26500.html

Have some todo items but basic implementation is done and I'd like to
get any helpful feedback on it.

Todo:
- Add sensor calibration.
- Re-organize code/files if deemed necessary by community.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 drivers/thermal/Kconfig         |    6 +
 drivers/thermal/Makefile        |    1 +
 drivers/thermal/imx6q_thermal.c |  370 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/imx6q_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 298c1cd..dd8cede 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -29,3 +29,9 @@ config CPU_THERMAL
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 	  If you want this support, you should say Y or M here.
+
+config IMX6Q_THERMAL
+	bool "IMX6Q Thermal interface support"
+	depends on THERMAL && CPU_THERMAL
+	help
+	  Adds thermal management for IMX6Q.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 655cbc4..e2bcffe 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 obj-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
+obj-$(CONFIG_IMX6Q_THERMAL)	+= imx6q_thermal.o
diff --git a/drivers/thermal/imx6q_thermal.c b/drivers/thermal/imx6q_thermal.c
new file mode 100644
index 0000000..161a1a9
--- /dev/null
+++ b/drivers/thermal/imx6q_thermal.c
@@ -0,0 +1,370 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/* i.MX6Q Thermal Implementation */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/dmi.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/thermal.h>
+#include <linux/io.h>
+#include <linux/syscalls.h>
+#include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <linux/cpu_cooling.h>
+
+/* register define of anatop */
+#define HW_ANADIG_ANA_MISC0	(0x00000150)
+#define HW_ANADIG_ANA_MISC0_SET	(0x00000154)
+#define HW_ANADIG_ANA_MISC0_CLR	(0x00000158)
+#define HW_ANADIG_ANA_MISC0_TOG	(0x0000015c)
+
+#define HW_ANADIG_TEMPSENSE0	(0x00000180)
+#define HW_ANADIG_TEMPSENSE0_SET	(0x00000184)
+#define HW_ANADIG_TEMPSENSE0_CLR	(0x00000188)
+#define HW_ANADIG_TEMPSENSE0_TOG	(0x0000018c)
+
+#define HW_ANADIG_TEMPSENSE1	(0x00000190)
+#define HW_ANADIG_TEMPSENSE1_SET	(0x00000194)
+#define HW_ANADIG_TEMPSENSE1_CLR	(0x00000198)
+
+#define BM_ANADIG_ANA_MISC0_REFTOP_SELBIASOFF 0x00000008
+
+#define BP_ANADIG_TEMPSENSE0_TEMP_VALUE      8
+#define BM_ANADIG_TEMPSENSE0_TEMP_VALUE 0x000FFF00
+#define BF_ANADIG_TEMPSENSE0_TEMP_VALUE(v)  \
+	(((v) << 8) & BM_ANADIG_TEMPSENSE0_TEMP_VALUE)
+#define BM_ANADIG_TEMPSENSE0_FINISHED 0x00000004
+#define BM_ANADIG_TEMPSENSE0_MEASURE_TEMP 0x00000002
+#define BM_ANADIG_TEMPSENSE0_POWER_DOWN 0x00000001
+
+#define BP_ANADIG_TEMPSENSE1_MEASURE_FREQ      0
+#define BM_ANADIG_TEMPSENSE1_MEASURE_FREQ 0x0000FFFF
+#define BF_ANADIG_TEMPSENSE1_MEASURE_FREQ(v)  \
+	(((v) << 0) & BM_ANADIG_TEMPSENSE1_MEASURE_FREQ)
+
+#define CONVER_CONST			14113  /* need to add calibration */
+#define CONVER_DIV				17259
+#define REG_VALUE_TO_CEL(val) (((CONVER_CONST - val * 10)\
+			* 1000) / CONVER_DIV);
+
+#define IMX6Q_THERMAL_POLLING_FREQUENCY_MS 1000
+#define IMX6Q_THERMAL_ACT_TRP_PTS 3
+/* assumption: always one critical trip point */
+#define IMX6Q_THERMAL_TOTAL_TRP_PTS (IMX6Q_THERMAL_ACT_TRP_PTS + 1)
+#define IMX6Q_THERMAL_DEBUG 1
+
+struct trip_point {
+	u8 temp; /* in celcius */
+	u8 type;
+};
+
+struct imx6q_thermal_data {
+	struct trip_point trp_pts[IMX6Q_THERMAL_TOTAL_TRP_PTS];
+	struct freq_pctg_table freq_tab[IMX6Q_THERMAL_ACT_TRP_PTS];
+};
+
+struct thermal_sensor_conf {
+	char	*name;
+	int	(*read_temperature)(void *data);
+};
+
+static int imx6q_get_temp(struct thermal_zone_device *thermal,
+				  unsigned long *temp);
+
+static struct thermal_sensor_conf imx6q_sensor_conf = {
+	.name			= "imx6q-temp_sens",
+	.read_temperature	= (int (*)(void *))imx6q_get_temp,
+
+};
+
+/*
+ * This data defines the various trip points that will trigger action
+ * when crossed.
+ */
+static struct imx6q_thermal_data thermal_data = {
+	.trp_pts[0] = {
+		.temp	 = 85,
+		.type	 = THERMAL_TRIP_STATE_ACTIVE,
+	},
+	.freq_tab[0] = {
+		.freq_clip_pctg[0] = 25,
+	},
+	.trp_pts[1] = {
+		.temp	 = 90,
+		.type	 = THERMAL_TRIP_STATE_ACTIVE,
+	},
+	.freq_tab[1] = {
+		.freq_clip_pctg[0] = 65,
+	},
+	.trp_pts[2] = {
+		.temp	 = 95,
+		.type	 = THERMAL_TRIP_STATE_ACTIVE,
+	},
+	.freq_tab[2] = {
+		.freq_clip_pctg[0] = 99,
+	},
+	.trp_pts[3] = {
+		.temp	 = 100,
+		.type	 = THERMAL_TRIP_CRITICAL,
+	},
+};
+
+struct imx6q_thermal_zone {
+	struct thermal_zone_device *therm_dev;
+	struct thermal_cooling_device *cool_dev;
+	struct thermal_sensor_conf *sensor_conf;
+	struct imx6q_thermal_data *thermal_data;
+};
+
+static struct imx6q_thermal_zone *th_zone;
+
+static void __iomem *anatop_base;
+
+static int imx6q_get_mode(struct thermal_zone_device *thermal,
+			    enum thermal_device_mode *mode)
+{
+	*mode = THERMAL_DEVICE_ENABLED;
+	return 0;
+}
+
+static int imx6q_get_trip_type(struct thermal_zone_device *thermal, int trip,
+				 enum thermal_trip_type *type)
+{
+	if (trip >= IMX6Q_THERMAL_TOTAL_TRP_PTS)
+		return -EINVAL;
+
+	*type = th_zone->thermal_data->trp_pts[trip].type;
+
+	return 0;
+}
+
+static int imx6q_get_trip_temp(struct thermal_zone_device *thermal, int trip,
+				 unsigned long *temp)
+{
+	if (trip >= IMX6Q_THERMAL_TOTAL_TRP_PTS)
+		return -EINVAL;
+
+	*temp = th_zone->thermal_data->trp_pts[trip].temp;
+
+	/*convert the temperature into millicelsius*/
+	*temp = *temp * 1000;
+	return 0;
+}
+
+static int imx6q_get_crit_temp(struct thermal_zone_device *thermal,
+				 unsigned long *temp)
+{
+
+	*temp = th_zone->thermal_data->trp_pts[
+		IMX6Q_THERMAL_TOTAL_TRP_PTS - 1].temp;
+	/*convert the temperature into millicelsius*/
+	*temp = *temp * 1000;
+	return 0;
+}
+
+static int imx6q_bind(struct thermal_zone_device *thermal,
+			struct thermal_cooling_device *cdev)
+{
+	/* if the cooling device is the one from imx6 bind it */
+	if (cdev != th_zone->cool_dev)
+		return 0;
+
+	if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
+		pr_err("error binding cooling dev\n");
+		return -EINVAL;
+	}
+	if (thermal_zone_bind_cooling_device(thermal, 1, cdev)) {
+		pr_err("error binding cooling dev\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx6q_unbind(struct thermal_zone_device *thermal,
+			  struct thermal_cooling_device *cdev)
+{
+	if (cdev != th_zone->cool_dev)
+		return 0;
+	if (thermal_zone_unbind_cooling_device(thermal, 0, cdev)) {
+		pr_err("error unbinding cooling dev\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int imx6q_temp_sens_reg_dump(void)
+{
+	if (!anatop_base) {
+		pr_info("anatop_base is not initialized!!!\n");
+		return -EINVAL;
+	}
+	pr_info("HW_ANADIG_TEMPSENSE0 = 0x%x\n",
+			readl_relaxed(anatop_base + HW_ANADIG_TEMPSENSE0));
+	pr_info("HW_ANADIG_TEMPSENSE1 = 0x%x\n",
+			readl_relaxed(anatop_base + HW_ANADIG_TEMPSENSE1));
+	return 0;
+}
+
+static int imx6q_get_temp(struct thermal_zone_device *thermal,
+				  unsigned long *temp)
+{
+	unsigned int tmp;
+	unsigned int reg;
+
+	/*
+	 * For now we only using single measure.  Every time we measure
+	 * the temperature, we will power on/down the anadig module
+	 */
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_FINISHED,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+		anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+	/*
+	 * According to designers, may take up to ~17us for hardware to make
+	 * a measurement.  But because we have a 'finished' status bit, so we
+	 * check it just in case the designers are liars.
+	 */
+	do  {
+		msleep(1);
+	} while (!(readl_relaxed(anatop_base + HW_ANADIG_TEMPSENSE0)
+		& BM_ANADIG_TEMPSENSE0_FINISHED));
+
+	reg = readl_relaxed(anatop_base + HW_ANADIG_TEMPSENSE0);
+
+	tmp = (reg & BM_ANADIG_TEMPSENSE0_TEMP_VALUE)
+			>> BP_ANADIG_TEMPSENSE0_TEMP_VALUE;
+
+#if IMX6Q_THERMAL_DEBUG
+	imx6q_temp_sens_reg_dump();
+#endif
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+			anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+
+	*temp = REG_VALUE_TO_CEL(tmp);
+
+#if IMX6Q_THERMAL_DEBUG
+	pr_info("Temperature is %lu C\n", *temp);
+#endif
+	return 0;
+}
+
+/* bind callback functions to thermalzone */
+static struct thermal_zone_device_ops imx6q_dev_ops = {
+	.bind = imx6q_bind,
+	.unbind = imx6q_unbind,
+	.get_temp = imx6q_get_temp,
+	.get_mode = imx6q_get_mode,
+	.get_trip_type = imx6q_get_trip_type,
+	.get_trip_temp = imx6q_get_trip_temp,
+	.get_crit_temp = imx6q_get_crit_temp,
+};
+
+void imx6q_unregister_thermal(void)
+{
+	if (th_zone && th_zone->cool_dev)
+		cpufreq_cooling_unregister();
+
+	if (th_zone && th_zone->therm_dev)
+		thermal_zone_device_unregister(th_zone->therm_dev);
+
+	kfree(th_zone);
+
+	pr_info("i.MX6Q: Kernel Thermal management unregistered\n");
+}
+EXPORT_SYMBOL(imx6q_unregister_thermal);
+
+int __init imx6q_register_thermal(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+	anatop_base = of_iomap(np, 0);
+
+	if (!anatop_base) {
+		pr_err("Could not retrieve anantop-base\n");
+		return -EINVAL;
+	}
+
+	/* Make sure sensor is in known good state for measurements */
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+			anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_MEASURE_TEMP,
+		anatop_base + HW_ANADIG_TEMPSENSE0_CLR);
+	writel_relaxed(BM_ANADIG_TEMPSENSE1_MEASURE_FREQ,
+		anatop_base + HW_ANADIG_TEMPSENSE1_CLR);
+	writel_relaxed(BM_ANADIG_ANA_MISC0_REFTOP_SELBIASOFF,
+			anatop_base + HW_ANADIG_ANA_MISC0_SET);
+	writel_relaxed(BM_ANADIG_TEMPSENSE0_POWER_DOWN,
+			anatop_base + HW_ANADIG_TEMPSENSE0_SET);
+
+	th_zone = kzalloc(sizeof(struct imx6q_thermal_zone), GFP_KERNEL);
+	if (!th_zone) {
+		ret = -ENOMEM;
+		goto err_unregister;
+	}
+
+	th_zone->sensor_conf = &imx6q_sensor_conf;
+
+	th_zone->thermal_data = &thermal_data;
+	if (!th_zone->thermal_data) {
+		pr_err("Temperature sensor data not initialised\n");
+		ret = -EINVAL;
+		goto err_unregister;
+	}
+
+	th_zone->cool_dev = cpufreq_cooling_register(
+		(struct freq_pctg_table *)th_zone->thermal_data->freq_tab,
+		IMX6Q_THERMAL_ACT_TRP_PTS, cpumask_of(0));
+
+	if (IS_ERR(th_zone->cool_dev)) {
+		pr_err("Failed to register cpufreq cooling device\n");
+		ret = -EINVAL;
+		goto err_unregister;
+	}
+
+	th_zone->therm_dev = thermal_zone_device_register(
+		th_zone->sensor_conf->name, 3, NULL, &imx6q_dev_ops,
+		0, 0, 0, IMX6Q_THERMAL_POLLING_FREQUENCY_MS);
+
+	if (IS_ERR(th_zone->therm_dev)) {
+		pr_err("Failed to register thermal zone device\n");
+		ret = -EINVAL;
+		goto err_unregister;
+	}
+
+	pr_info("i.MX6: Kernel Thermal management registered\n");
+
+	return 0;
+
+err_unregister:
+	imx6q_unregister_thermal();
+	return ret;
+}
+EXPORT_SYMBOL(imx6q_register_thermal);
+
+module_init(imx6q_register_thermal);
-- 
1.7.1

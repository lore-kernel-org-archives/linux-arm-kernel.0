From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue,  9 Jan 2018 14:31:26 -0800
Subject: [PATCH linux dev-4.10 6/6] drivers/hwmon: Add a driver for a generic
 PECI hwmon
In-Reply-To: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180109223126.13093-7-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds driver implementation for a generic PECI hwmon.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/hwmon/Kconfig      |   6 +
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/peci-hwmon.c | 953 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 960 insertions(+)
 create mode 100644 drivers/hwmon/peci-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9256dd0..3a62c60 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1234,6 +1234,12 @@ config SENSORS_NCT7904
 	  This driver can also be built as a module.  If so, the module
 	  will be called nct7904.
 
+config SENSORS_PECI_HWMON
+	tristate "PECI hwmon support"
+	depends on ASPEED_PECI
+	help
+	  If you say yes here you get support for the generic PECI hwmon driver.
+
 config SENSORS_NSA320
 	tristate "ZyXEL NSA320 and compatible fan speed and temperature sensors"
 	depends on GPIOLIB && OF
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 98000fc..41d43a5 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
 obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
 obj-$(CONFIG_SENSORS_NSA320)	+= nsa320-hwmon.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
+obj-$(CONFIG_SENSORS_PECI_HWMON)	+= peci-hwmon.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
diff --git a/drivers/hwmon/peci-hwmon.c b/drivers/hwmon/peci-hwmon.c
new file mode 100644
index 0000000..2d2a288
--- /dev/null
+++ b/drivers/hwmon/peci-hwmon.c
@@ -0,0 +1,953 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Intel Corporation
+
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/syscalls.h>
+#include <misc/peci.h>
+
+#define DEVICE_NAME "peci-hwmon"
+#define HWMON_NAME "peci_hwmon"
+
+#define CPU_ID_MAX           8   /* Max CPU number configured by socket ID */
+#define DIMM_NUMS_MAX        16  /* Max DIMM numbers (channel ranks x 2) */
+#define CORE_NUMS_MAX        28  /* Max core numbers (max on SKX Platinum) */
+#define TEMP_TYPE_PECI       6   /* Sensor type 6: Intel PECI */
+#define CORE_INDEX_OFFSET    100 /* sysfs filename start offset for core temp */
+#define DIMM_INDEX_OFFSET    200 /* sysfs filename start offset for DIMM temp */
+#define TEMP_NAME_HEADER_LEN 4   /* sysfs temp type header length */
+#define OF_DIMM_NUMS_DEFAULT 16  /* default dimm-nums setting */
+
+#define CORE_TEMP_ATTRS      5
+#define DIMM_TEMP_ATTRS      2
+#define ATTR_NAME_LEN        24
+
+#define UPDATE_INTERVAL_MIN  HZ
+
+enum sign_t {
+	POS,
+	NEG
+};
+
+struct cpuinfo_t {
+	bool valid;
+	u32  dib;
+	u8   cpuid;
+	u8   platform_id;
+	u32  microcode;
+	u8   logical_thread_nums;
+};
+
+struct temp_data_t {
+	bool valid;
+	s32  value;
+	unsigned long last_updated;
+};
+
+struct temp_group_t {
+	struct temp_data_t tjmax;
+	struct temp_data_t tcontrol;
+	struct temp_data_t tthrottle;
+	struct temp_data_t dts_margin;
+	struct temp_data_t die;
+	struct temp_data_t core[CORE_NUMS_MAX];
+	struct temp_data_t dimm[DIMM_NUMS_MAX];
+};
+
+struct core_temp_attr_group_t {
+	struct sensor_device_attribute sd_attrs[CORE_NUMS_MAX][CORE_TEMP_ATTRS];
+	char attr_name[CORE_NUMS_MAX][CORE_TEMP_ATTRS][ATTR_NAME_LEN];
+	struct attribute *attrs[CORE_NUMS_MAX][CORE_TEMP_ATTRS + 1];
+	struct attribute_group attr_group[CORE_NUMS_MAX];
+};
+
+struct dimm_temp_attr_group_t {
+	struct sensor_device_attribute sd_attrs[DIMM_NUMS_MAX][DIMM_TEMP_ATTRS];
+	char attr_name[DIMM_NUMS_MAX][DIMM_TEMP_ATTRS][ATTR_NAME_LEN];
+	struct attribute *attrs[DIMM_NUMS_MAX][DIMM_TEMP_ATTRS + 1];
+	struct attribute_group attr_group[DIMM_NUMS_MAX];
+};
+
+struct peci_hwmon {
+	struct device *dev;
+	struct device *hwmon_dev;
+	char name[NAME_MAX];
+	const struct attribute_group **groups;
+	struct cpuinfo_t cpuinfo;
+	struct temp_group_t temp;
+	u32 cpu_id;
+	bool show_core;
+	u32 core_nums;
+	u32 dimm_nums;
+	atomic_t core_group_created;
+	struct core_temp_attr_group_t core;
+	struct dimm_temp_attr_group_t dimm;
+};
+
+enum label_t {
+	L_DIE,
+	L_DTS,
+	L_TCONTROL,
+	L_TTHROTTLE,
+	L_MAX
+};
+
+static const char *peci_label[L_MAX] = {
+	"Die temperature\n",
+	"DTS thermal margin to Tcontrol\n",
+	"Tcontrol temperature\n",
+	"Tthrottle temperature\n",
+};
+
+static DEFINE_MUTEX(peci_hwmon_lock);
+
+static int create_core_temp_group(struct peci_hwmon *priv, int core_no);
+
+
+static int xfer_peci_msg(int cmd, void *pmsg)
+{
+	int rc;
+
+	mutex_lock(&peci_hwmon_lock);
+	rc = peci_ioctl(NULL, cmd, (unsigned long)pmsg);
+	mutex_unlock(&peci_hwmon_lock);
+
+	return rc;
+}
+
+static int get_cpuinfo(struct peci_hwmon *priv)
+{
+	struct peci_get_dib_msg dib_msg;
+	struct peci_rd_pkg_cfg_msg cfg_msg;
+	int rc, i;
+
+	if (!priv->cpuinfo.valid) {
+		dib_msg.target = PECI_BASE_ADDR + priv->cpu_id;
+
+		rc = xfer_peci_msg(PECI_IOC_GET_DIB, (void *)&dib_msg);
+		if (rc < 0)
+			return rc;
+
+		priv->cpuinfo.dib = dib_msg.dib;
+
+		cfg_msg.target = PECI_BASE_ADDR + priv->cpu_id;
+		cfg_msg.index = MBX_INDEX_CPU_ID;
+		cfg_msg.param = 0;
+		cfg_msg.rx_len = 4;
+
+		rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&cfg_msg);
+		if (rc < 0)
+			return rc;
+
+		priv->cpuinfo.cpuid = cfg_msg.pkg_config[0];
+
+		cfg_msg.target = PECI_BASE_ADDR + priv->cpu_id;
+		cfg_msg.index = MBX_INDEX_CPU_ID;
+		cfg_msg.param = 1;
+		cfg_msg.rx_len = 4;
+
+		rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&cfg_msg);
+		if (rc < 0)
+			return rc;
+
+		priv->cpuinfo.platform_id = cfg_msg.pkg_config[0];
+
+		cfg_msg.target = PECI_BASE_ADDR + priv->cpu_id;
+		cfg_msg.index = MBX_INDEX_CPU_ID;
+		cfg_msg.param = 3;
+		cfg_msg.rx_len = 4;
+
+		rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&cfg_msg);
+		if (rc < 0)
+			return rc;
+
+		priv->cpuinfo.logical_thread_nums = cfg_msg.pkg_config[0] + 1;
+
+		cfg_msg.target = PECI_BASE_ADDR + priv->cpu_id;
+		cfg_msg.index = MBX_INDEX_CPU_ID;
+		cfg_msg.param = 4;
+		cfg_msg.rx_len = 4;
+
+		rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&cfg_msg);
+		if (rc < 0)
+			return rc;
+
+		priv->cpuinfo.microcode = (cfg_msg.pkg_config[3] << 24) |
+					  (cfg_msg.pkg_config[2] << 16) |
+					  (cfg_msg.pkg_config[1] << 8) |
+					  cfg_msg.pkg_config[0];
+
+		priv->core_nums = priv->cpuinfo.logical_thread_nums / 2;
+
+		if (priv->show_core &&
+		    atomic_inc_return(&priv->core_group_created) == 1) {
+			for (i = 0; i < priv->core_nums; i++) {
+				rc = create_core_temp_group(priv, i);
+				if (rc != 0) {
+					dev_err(priv->dev,
+						"Failed to create core temp group\n");
+					for (--i; i >= 0; i--) {
+						sysfs_remove_group(
+						     &priv->hwmon_dev->kobj,
+						     &priv->core.attr_group[i]);
+					}
+					atomic_set(&priv->core_group_created,
+						   0);
+					return rc;
+				}
+			}
+		}
+
+		priv->cpuinfo.valid = true;
+	}
+
+	return 0;
+}
+
+static int get_tjmax(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	int rc;
+
+	rc = get_cpuinfo(priv);
+	if (rc < 0)
+		return rc;
+
+	if (!priv->temp.tjmax.valid) {
+		msg.target = PECI_BASE_ADDR + priv->cpu_id;
+		msg.index = MBX_INDEX_TEMP_TARGET;
+		msg.param = 0;
+		msg.rx_len = 4;
+
+		rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&msg);
+		if (rc < 0)
+			return rc;
+
+		priv->temp.tjmax.value = (s32)msg.pkg_config[2] * 1000;
+		priv->temp.tjmax.valid = true;
+	}
+
+	return 0;
+}
+
+static int get_tcontrol(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 tcontrol_margin;
+	int rc;
+
+	if (priv->temp.tcontrol.valid &&
+	    time_before(jiffies, priv->temp.tcontrol.last_updated +
+				 UPDATE_INTERVAL_MIN))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.target = PECI_BASE_ADDR + priv->cpu_id;
+	msg.index = MBX_INDEX_TEMP_TARGET;
+	msg.param = 0;
+	msg.rx_len = 4;
+
+	rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	tcontrol_margin = msg.pkg_config[1];
+	tcontrol_margin = ((tcontrol_margin ^ 0x80) - 0x80) * 1000;
+
+	priv->temp.tcontrol.value = priv->temp.tjmax.value - tcontrol_margin;
+
+	if (!priv->temp.tcontrol.valid) {
+		priv->temp.tcontrol.last_updated = INITIAL_JIFFIES;
+		priv->temp.tcontrol.valid = true;
+	} else {
+		priv->temp.tcontrol.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_tthrottle(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 tthrottle_offset;
+	int rc;
+
+	if (priv->temp.tthrottle.valid &&
+	    time_before(jiffies, priv->temp.tthrottle.last_updated +
+				 UPDATE_INTERVAL_MIN))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.target = PECI_BASE_ADDR + priv->cpu_id;
+	msg.index = MBX_INDEX_TEMP_TARGET;
+	msg.param = 0;
+	msg.rx_len = 4;
+
+	rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	tthrottle_offset = (msg.pkg_config[3] & 0x2f) * 1000;
+	priv->temp.tthrottle.value = priv->temp.tjmax.value - tthrottle_offset;
+
+	if (!priv->temp.tthrottle.valid) {
+		priv->temp.tthrottle.last_updated = INITIAL_JIFFIES;
+		priv->temp.tthrottle.valid = true;
+	} else {
+		priv->temp.tthrottle.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_die_temp(struct peci_hwmon *priv)
+{
+	struct peci_get_temp_msg msg;
+	int rc;
+
+	if (priv->temp.die.valid &&
+	    time_before(jiffies, priv->temp.die.last_updated +
+				 UPDATE_INTERVAL_MIN))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.target = PECI_BASE_ADDR + priv->cpu_id;
+
+	rc = xfer_peci_msg(PECI_IOC_GET_TEMP, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	priv->temp.die.value = priv->temp.tjmax.value +
+			       ((s32)msg.temp_raw * 1000 / 64);
+
+	if (!priv->temp.die.valid) {
+		priv->temp.die.last_updated = INITIAL_JIFFIES;
+		priv->temp.die.valid = true;
+	} else {
+		priv->temp.die.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_dts_margin(struct peci_hwmon *priv)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 dts_margin;
+	int rc;
+
+	if (priv->temp.dts_margin.valid &&
+	    time_before(jiffies, priv->temp.dts_margin.last_updated +
+				 UPDATE_INTERVAL_MIN))
+		return 0;
+
+	rc = get_cpuinfo(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.target = PECI_BASE_ADDR + priv->cpu_id;
+	msg.index = MBX_INDEX_DTS_MARGIN;
+	msg.param = 0;
+	msg.rx_len = 4;
+
+	rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	dts_margin = (msg.pkg_config[1] << 8) | msg.pkg_config[0];
+
+	/*
+	 * Processors return a value of DTS reading in 10.6 format
+	 * (10 bits signed decimal, 6 bits fractional).
+	 * Error codes:
+	 *   0x8000: General sensor error
+	 *   0x8001: Reserved
+	 *   0x8002: Underflow on reading value
+	 *   0x8003-0x81ff: Reserved
+	 */
+	if (dts_margin >= 0x8000 && dts_margin <= 0x81ff)
+		return -1;
+
+	dts_margin = ((dts_margin ^ 0x8000) - 0x8000) * 1000 / 64;
+
+	priv->temp.dts_margin.value = dts_margin;
+
+	if (!priv->temp.dts_margin.valid) {
+		priv->temp.dts_margin.last_updated = INITIAL_JIFFIES;
+		priv->temp.dts_margin.valid = true;
+	} else {
+		priv->temp.dts_margin.last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_core_temp(struct peci_hwmon *priv, int core_index)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	s32 core_dts_margin;
+	int rc;
+
+	if (priv->temp.core[core_index].valid &&
+	    time_before(jiffies, priv->temp.core[core_index].last_updated +
+				 UPDATE_INTERVAL_MIN))
+		return 0;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.target = PECI_BASE_ADDR + priv->cpu_id;
+	msg.index = MBX_INDEX_PER_CORE_DTS_TEMP;
+	msg.param = core_index;
+	msg.rx_len = 4;
+
+	rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	core_dts_margin = (msg.pkg_config[1] << 8) | msg.pkg_config[0];
+
+	/*
+	 * Processors return a value of the core DTS reading in 10.6 format
+	 * (10 bits signed decimal, 6 bits fractional).
+	 * Error codes:
+	 *   0x8000: General sensor error
+	 *   0x8001: Reserved
+	 *   0x8002: Underflow on reading value
+	 *   0x8003-0x81ff: Reserved
+	 */
+	if (core_dts_margin >= 0x8000 && core_dts_margin <= 0x81ff)
+		return -1;
+
+	core_dts_margin = ((core_dts_margin ^ 0x8000) - 0x8000) * 1000 / 64;
+
+	priv->temp.core[core_index].value = priv->temp.tjmax.value +
+					    core_dts_margin;
+
+	if (!priv->temp.core[core_index].valid) {
+		priv->temp.core[core_index].last_updated = INITIAL_JIFFIES;
+		priv->temp.core[core_index].valid = true;
+	} else {
+		priv->temp.core[core_index].last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static int get_dimm_temp(struct peci_hwmon *priv, int dimm_index)
+{
+	struct peci_rd_pkg_cfg_msg msg;
+	int channel_rank = dimm_index / 2;
+	int dimm_order = dimm_index % 2;
+	int rc;
+
+	if (priv->temp.core[dimm_index].valid &&
+	    time_before(jiffies, priv->temp.core[dimm_index].last_updated +
+				 UPDATE_INTERVAL_MIN))
+		return 0;
+
+	rc = get_cpuinfo(priv);
+	if (rc < 0)
+		return rc;
+
+	msg.target = PECI_BASE_ADDR + priv->cpu_id;
+	msg.index = MBX_INDEX_DDR_DIMM_TEMP;
+	msg.param = channel_rank;
+	msg.rx_len = 4;
+
+	rc = xfer_peci_msg(PECI_IOC_RD_PKG_CFG, (void *)&msg);
+	if (rc < 0)
+		return rc;
+
+	priv->temp.dimm[dimm_index].value = msg.pkg_config[dimm_order] * 1000;
+
+	if (!priv->temp.dimm[dimm_index].valid) {
+		priv->temp.dimm[dimm_index].last_updated = INITIAL_JIFFIES;
+		priv->temp.dimm[dimm_index].valid = true;
+	} else {
+		priv->temp.dimm[dimm_index].last_updated = jiffies;
+	}
+
+	return 0;
+}
+
+static ssize_t show_info(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_cpuinfo(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "dib         : 0x%08x\n"
+			    "cpuid       : 0x%x\n"
+			    "platform id : %d\n"
+			    "stepping    : %d\n"
+			    "microcode   : 0x%08x\n"
+			    "logical thread nums : %d\n",
+			    priv->cpuinfo.dib,
+			    priv->cpuinfo.cpuid,
+			    priv->cpuinfo.platform_id,
+			    priv->cpuinfo.cpuid & 0xf,
+			    priv->cpuinfo.microcode,
+			    priv->cpuinfo.logical_thread_nums);
+}
+
+static ssize_t show_tcontrol(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_tcontrol(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.tcontrol.value);
+}
+
+static ssize_t show_tcontrol_margin(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int rc;
+
+	rc = get_tcontrol(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", sensor_attr->index == POS ?
+				    priv->temp.tjmax.value -
+				    priv->temp.tcontrol.value :
+				    priv->temp.tcontrol.value -
+				    priv->temp.tjmax.value);
+}
+
+static ssize_t show_tthrottle(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_tthrottle(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.tthrottle.value);
+}
+
+static ssize_t show_tjmax(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_tjmax(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.tjmax.value);
+}
+
+static ssize_t show_die_temp(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_die_temp(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.die.value);
+}
+
+static ssize_t show_dts_therm_margin(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	int rc;
+
+	rc = get_dts_margin(priv);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.dts_margin.value);
+}
+
+static ssize_t show_core_temp(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int core_index = sensor_attr->index;
+	int rc;
+
+	rc = get_core_temp(priv, core_index);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.core[core_index].value);
+}
+
+static ssize_t show_dimm_temp(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int dimm_index = sensor_attr->index;
+	int rc;
+
+	rc = get_dimm_temp(priv, dimm_index);
+	if (rc < 0)
+		return rc;
+
+	return sprintf(buf, "%d\n", priv->temp.dimm[dimm_index].value);
+}
+
+static ssize_t show_value(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "%d\n", sensor_attr->index);
+}
+
+static ssize_t show_label(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, peci_label[sensor_attr->index]);
+}
+
+static ssize_t show_core_label(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	return sprintf(buf, "Core #%d temperature\n", sensor_attr->index);
+}
+
+static ssize_t show_dimm_label(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+
+	char channel = 'A' + (sensor_attr->index / 2);
+	int index = sensor_attr->index % 2;
+
+	return sprintf(buf, "Channel Rank %c DDR DIMM #%d temperature\n",
+		       channel, index);
+}
+
+/* Die temperature */
+static SENSOR_DEVICE_ATTR(temp1_label, 0444, show_label, NULL, L_DIE);
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, show_die_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, 0444, show_tcontrol, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit, 0444, show_tjmax, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, 0444, show_tcontrol_margin, NULL,
+			  POS);
+
+static struct attribute *die_temp_attrs[] = {
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group die_temp_attr_group = {
+	.attrs = die_temp_attrs,
+};
+
+/* DTS thermal margin temperature */
+static SENSOR_DEVICE_ATTR(temp2_label, 0444, show_label, NULL, L_DTS);
+static SENSOR_DEVICE_ATTR(temp2_input, 0444, show_dts_therm_margin, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, 0444, show_value, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_lcrit, 0444, show_tcontrol_margin, NULL, NEG);
+
+static struct attribute *dts_margin_temp_attrs[] = {
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_lcrit.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group dts_margin_temp_attr_group = {
+	.attrs = dts_margin_temp_attrs,
+};
+
+/* Tcontrol temperature */
+static SENSOR_DEVICE_ATTR(temp3_label, 0444, show_label, NULL, L_TCONTROL);
+static SENSOR_DEVICE_ATTR(temp3_input, 0444, show_tcontrol, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp3_crit, 0444, show_tjmax, NULL, 0);
+
+static struct attribute *tcontrol_temp_attrs[] = {
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group tcontrol_temp_attr_group = {
+	.attrs = tcontrol_temp_attrs,
+};
+
+/* Tthrottle temperature */
+static SENSOR_DEVICE_ATTR(temp4_label, 0444, show_label, NULL, L_TTHROTTLE);
+static SENSOR_DEVICE_ATTR(temp4_input, 0444, show_tthrottle, NULL, 0);
+
+static struct attribute *tthrottle_temp_attrs[] = {
+	&sensor_dev_attr_temp4_label.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group tthrottle_temp_attr_group = {
+	.attrs = tthrottle_temp_attrs,
+};
+
+/* CPU info */
+static SENSOR_DEVICE_ATTR(info, 0444, show_info, NULL, 0);
+
+static struct attribute *info_attrs[] = {
+	&sensor_dev_attr_info.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group info_attr_group = {
+	.attrs = info_attrs,
+};
+
+const struct attribute_group *peci_hwmon_attr_groups[] = {
+	&info_attr_group,
+	&die_temp_attr_group,
+	&dts_margin_temp_attr_group,
+	&tcontrol_temp_attr_group,
+	&tthrottle_temp_attr_group,
+	NULL
+};
+
+static ssize_t (*const core_show_fn[CORE_TEMP_ATTRS]) (struct device *dev,
+		struct device_attribute *devattr, char *buf) = {
+	show_core_label,
+	show_core_temp,
+	show_tcontrol,
+	show_tjmax,
+	show_tcontrol_margin,
+};
+
+static const char *const core_suffix[CORE_TEMP_ATTRS] = {
+	"label",
+	"input",
+	"max",
+	"crit",
+	"crit_hyst",
+};
+
+static int create_core_temp_group(struct peci_hwmon *priv, int core_no)
+{
+	int i;
+
+	for (i = 0; i < CORE_TEMP_ATTRS; i++) {
+		snprintf(priv->core.attr_name[core_no][i],
+			 ATTR_NAME_LEN, "temp%d_%s",
+			 CORE_INDEX_OFFSET + core_no, core_suffix[i]);
+		sysfs_attr_init(
+			    &priv->core.sd_attrs[core_no][i].dev_attr.attr);
+		priv->core.sd_attrs[core_no][i].dev_attr.attr.name =
+					       priv->core.attr_name[core_no][i];
+		priv->core.sd_attrs[core_no][i].dev_attr.attr.mode = 0444;
+		priv->core.sd_attrs[core_no][i].dev_attr.show = core_show_fn[i];
+		if (i == 0 || i == 1) /* label or temp */
+			priv->core.sd_attrs[core_no][i].index = core_no;
+		priv->core.attrs[core_no][i] =
+				 &priv->core.sd_attrs[core_no][i].dev_attr.attr;
+	}
+
+	priv->core.attr_group[core_no].attrs = priv->core.attrs[core_no];
+
+	return sysfs_create_group(&priv->hwmon_dev->kobj,
+				  &priv->core.attr_group[core_no]);
+}
+
+static ssize_t (*const dimm_show_fn[DIMM_TEMP_ATTRS]) (struct device *dev,
+		struct device_attribute *devattr, char *buf) = {
+	show_dimm_label,
+	show_dimm_temp,
+};
+
+static const char *const dimm_suffix[DIMM_TEMP_ATTRS] = {
+	"label",
+	"input",
+};
+
+static int create_dimm_temp_group(struct peci_hwmon *priv, int dimm_no)
+{
+	int i;
+
+	for (i = 0; i < DIMM_TEMP_ATTRS; i++) {
+		snprintf(priv->dimm.attr_name[dimm_no][i],
+			 ATTR_NAME_LEN, "temp%d_%s",
+			 DIMM_INDEX_OFFSET + dimm_no, dimm_suffix[i]);
+		sysfs_attr_init(&priv->dimm.sd_attrs[dimm_no][i].dev_attr.attr);
+		priv->dimm.sd_attrs[dimm_no][i].dev_attr.attr.name =
+					       priv->dimm.attr_name[dimm_no][i];
+		priv->dimm.sd_attrs[dimm_no][i].dev_attr.attr.mode = 0444;
+		priv->dimm.sd_attrs[dimm_no][i].dev_attr.show = dimm_show_fn[i];
+		priv->dimm.sd_attrs[dimm_no][i].index = dimm_no;
+		priv->dimm.attrs[dimm_no][i] =
+				 &priv->dimm.sd_attrs[dimm_no][i].dev_attr.attr;
+	}
+
+	priv->dimm.attr_group[dimm_no].attrs = priv->dimm.attrs[dimm_no];
+
+	return sysfs_create_group(&priv->hwmon_dev->kobj,
+				  &priv->dimm.attr_group[dimm_no]);
+}
+
+static int peci_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct peci_hwmon *priv;
+	struct device *hwmon;
+	int rc, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
+
+	rc = of_property_read_u32(np, "cpu-id", &priv->cpu_id);
+	if (rc || priv->cpu_id >= CPU_ID_MAX) {
+		dev_err(dev, "Invalid cpu-id configuration\n");
+		return rc;
+	}
+
+	rc = of_property_read_u32(np, "dimm-nums", &priv->dimm_nums);
+	if (rc || priv->dimm_nums > DIMM_NUMS_MAX) {
+		dev_warn(dev, "Invalid dimm-nums : %u. Use default : %u\n",
+			 priv->dimm_nums, OF_DIMM_NUMS_DEFAULT);
+		priv->dimm_nums = OF_DIMM_NUMS_DEFAULT;
+	}
+
+	priv->show_core = of_property_read_bool(np, "show-core");
+
+	priv->groups = peci_hwmon_attr_groups;
+
+	snprintf(priv->name, NAME_MAX, HWMON_NAME ".cpu%d", priv->cpu_id);
+
+	hwmon = devm_hwmon_device_register_with_groups(dev,
+						       priv->name,
+						       priv, priv->groups);
+
+	rc = PTR_ERR_OR_ZERO(hwmon);
+	if (rc != 0) {
+		dev_err(dev, "Failed to register peci hwmon\n");
+		return rc;
+	}
+
+	priv->hwmon_dev = hwmon;
+
+	for (i = 0; i < priv->dimm_nums; i++) {
+		rc = create_dimm_temp_group(priv, i);
+		if (rc != 0) {
+			dev_err(dev, "Failed to create dimm temp group\n");
+			for (--i; i >= 0; i--) {
+				sysfs_remove_group(&priv->hwmon_dev->kobj,
+						   &priv->dimm.attr_group[i]);
+			}
+			return rc;
+		}
+	}
+
+	/*
+	 * Try to create core temp group now. It will be created if CPU is
+	 * curretnly online or it will be created after the first reading of
+	 * cpuinfo from the online CPU otherwise.
+	 */
+	if (priv->show_core)
+		(void) get_cpuinfo(priv);
+
+	dev_info(dev, "peci hwmon for CPU#%d registered\n", priv->cpu_id);
+
+	return rc;
+}
+
+static int peci_hwmon_remove(struct platform_device *pdev)
+{
+	struct peci_hwmon *priv = dev_get_drvdata(&pdev->dev);
+	int i;
+
+	if (atomic_read(&priv->core_group_created))
+		for (i = 0; i < priv->core_nums; i++) {
+			sysfs_remove_group(&priv->hwmon_dev->kobj,
+					   &priv->core.attr_group[i]);
+		}
+
+	for (i = 0; i < priv->dimm_nums; i++) {
+		sysfs_remove_group(&priv->hwmon_dev->kobj,
+				   &priv->dimm.attr_group[i]);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id peci_of_table[] = {
+	{ .compatible = "peci-hwmon", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, peci_of_table);
+
+static struct platform_driver peci_hwmon_driver = {
+	.probe = peci_hwmon_probe,
+	.remove = peci_hwmon_remove,
+	.driver = {
+		.name           = DEVICE_NAME,
+		.of_match_table = peci_of_table,
+	},
+};
+
+module_platform_driver(peci_hwmon_driver);
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_DESCRIPTION("PECI hwmon driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

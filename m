From: pratikp@codeaurora.org (pratikp at codeaurora.org)
Date: Tue, 18 Dec 2012 11:19:18 -0800
Subject: [RFC 1/8] coresight: add CoreSight core layer framework
In-Reply-To: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
Message-ID: <1355858365-11849-2-git-send-email-pratikp@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratik Patel <pratikp@codeaurora.org>

CoreSight components are compliant with the ARM CoreSight
architecture specification and can be connected in various
topologies to suite a particular SoCs tracing needs. These trace
components can generally be classified as sources, links and
sinks. Trace data produced by one or more sources flows through
the intermediate links connecting the source to the currently
selected sink.

CoreSight framework provides an interface for the CoreSight trace
drivers to register themselves with. It's intended to build up a
topological view of the CoreSight components and configure the
right series of components on user input via sysfs.

For eg., when enabling a source, framework builds up a path
consisting of all the components connecting the source to the
currently selected sink and enables all of them.

Framework also supports switching between available sinks and
also provides status information to user space applications
through sysfs interface.

Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
---
 .../devicetree/bindings/arm/coresight.txt          |  106 +++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/coresight/Kconfig                          |    9 +
 drivers/coresight/Makefile                         |    5 +
 drivers/coresight/coresight-priv.h                 |   48 ++
 drivers/coresight/coresight.c                      |  681 ++++++++++++++++++++
 drivers/coresight/of_coresight.c                   |   99 +++
 include/linux/coresight.h                          |  167 +++++
 include/linux/of_coresight.h                       |   27 +
 10 files changed, 1145 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
 create mode 100644 drivers/coresight/Kconfig
 create mode 100644 drivers/coresight/Makefile
 create mode 100644 drivers/coresight/coresight-priv.h
 create mode 100644 drivers/coresight/coresight.c
 create mode 100644 drivers/coresight/of_coresight.c
 create mode 100644 include/linux/coresight.h
 create mode 100644 include/linux/of_coresight.h

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
new file mode 100644
index 0000000..c584073
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -0,0 +1,106 @@
+* CoreSight Components
+
+CoreSight components are compliant with the ARM CoreSight architecture
+specification and can be connected in various topologies to suite a particular
+SoCs tracing needs. These trace components can generally be classified as sinks,
+links and sources. Trace data produced by one or more sources flows through the
+intermediate links connecting the source to the currently selected sink. Each
+CoreSight component device should use these properties to describe its hardware
+characteristcs.
+
+Required properties:
+
+- compatible : name of the component used for driver matching
+- reg : physical base address and length of the register set(s) of the component
+- coresight-id : unique integer identifier for the component
+- coresight-name : unique descriptive name of the component
+- coresight-nr-inports : number of input ports on the component
+
+coresight-outports, coresight-child-list and coresight-child-ports lists will
+be of the same length and will have a one to one correspondence among the
+elements at the same list index.
+
+coresight-default-sink must be specified for one of the sink devices that is
+intended to be made the default sink. Other sink devices must not have this
+specified. Not specifying this property on any of the sinks is invalid.
+
+Optional properties:
+
+- coresight-outports : list of output port numbers of this component
+- coresight-child-list : list of phandles pointing to the children of this
+			 component
+- coresight-child-ports : list of input port numbers of the children
+- coresight-default-sink : represents the default compile time CoreSight sink
+
+Examples:
+
+1. Sinks
+	tmc_etr: tmc at fc322000 {
+		compatible = "arm,coresight-tmc";
+		reg = <0xfc322000 0x1000>;
+
+		coresight-id = <0>;
+		coresight-name = "coresight-tmc-etr";
+		coresight-nr-inports = <1>;
+		coresight-default-sink;
+	};
+
+	tpiu: tpiu at fc318000 {
+		compatible = "arm,coresight-tpiu";
+		reg = <0xfc318000 0x1000>;
+
+		coresight-id = <1>;
+		coresight-name = "coresight-tpiu";
+		coresight-nr-inports = <1>;
+	};
+
+2. Links
+	funnel_merg: funnel at fc31b000 {
+		compatible = "arm,coresight-funnel";
+		reg = <0xfc31b000 0x1000>;
+
+		coresight-id = <4>;
+		coresight-name = "coresight-funnel-merg";
+		coresight-nr-inports = <2>;
+		coresight-outports = <0>;
+		coresight-child-list = <&tmc_etf>;
+		coresight-child-ports = <0>;
+	};
+
+	funnel_in0: funnel at fc319000 {
+		compatible = "arm,coresight-funnel";
+		reg = <0xfc319000 0x1000>;
+
+		coresight-id = <5>;
+		coresight-name = "coresight-funnel-in0";
+		coresight-nr-inports = <8>;
+		coresight-outports = <0>;
+		coresight-child-list = <&funnel_merg>;
+		coresight-child-ports = <0>;
+	};
+
+3. Sources
+	stm: stm at fc321000 {
+		compatible = "arm,coresight-stm";
+		reg = <0xfc321000 0x1000>,
+		      <0xfa280000 0x180000>;
+
+		coresight-id = <9>;
+		coresight-name = "coresight-stm";
+		coresight-nr-inports = <0>;
+		coresight-outports = <0>;
+		coresight-child-list = <&funnel_in1>;
+		coresight-child-ports = <7>;
+	};
+
+	etm0: etm at fc33c000 {
+		compatible = "arm,coresight-etm";
+		reg = <0xfc33c000 0x1000>;
+
+		coresight-id = <10>;
+		coresight-name = "coresight-etm0";
+		coresight-nr-inports = <0>;
+		coresight-outports = <0>;
+		coresight-child-list = <&funnel_kpss>;
+		coresight-child-ports = <0>;
+	};
diff --git a/drivers/Kconfig b/drivers/Kconfig
index dbdefa3..9b6f810 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -156,4 +156,6 @@ source "drivers/pwm/Kconfig"
 
 source "drivers/irqchip/Kconfig"
 
+source "drivers/coresight/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index a16a8d0..4650105 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -145,3 +145,4 @@ obj-$(CONFIG_EXTCON)		+= extcon/
 obj-$(CONFIG_MEMORY)		+= memory/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_VME_BUS)		+= vme/
+obj-$(CONFIG_CORESIGHT) 	+= coresight/
diff --git a/drivers/coresight/Kconfig b/drivers/coresight/Kconfig
new file mode 100644
index 0000000..65279c4
--- /dev/null
+++ b/drivers/coresight/Kconfig
@@ -0,0 +1,9 @@
+menuconfig CORESIGHT
+	bool "CoreSight Tracing Support"
+	help
+	  This framework provides an interface for the CoreSight debug and
+	  trace drivers to register themselves with. It's intended to build
+	  up a topological view of the CoreSight components and configure
+	  the right series of components on user input via sysfs. It also
+	  provides status information to user space applications through
+	  sysfs interface.
diff --git a/drivers/coresight/Makefile b/drivers/coresight/Makefile
new file mode 100644
index 0000000..218e3b5
--- /dev/null
+++ b/drivers/coresight/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for CoreSight drivers.
+#
+obj-$(CONFIG_CORESIGHT) += coresight.o
+obj-$(CONFIG_OF) += of_coresight.o
diff --git a/drivers/coresight/coresight-priv.h b/drivers/coresight/coresight-priv.h
new file mode 100644
index 0000000..29dbd82
--- /dev/null
+++ b/drivers/coresight/coresight-priv.h
@@ -0,0 +1,48 @@
+/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CORESIGHT_PRIV_H
+#define _CORESIGHT_PRIV_H
+
+#include <linux/bitops.h>
+
+/*
+ * Coresight management registers (0xF00-0xFCC)
+ * 0xFA0 - 0xFA4: Management	registers in PFTv1.0
+ *		  Trace		registers in PFTv1.1
+ */
+#define CORESIGHT_ITCTRL	(0xF00)
+#define CORESIGHT_CLAIMSET	(0xFA0)
+#define CORESIGHT_CLAIMCLR	(0xFA4)
+#define CORESIGHT_LAR		(0xFB0)
+#define CORESIGHT_LSR		(0xFB4)
+#define CORESIGHT_AUTHSTATUS	(0xFB8)
+#define CORESIGHT_DEVID		(0xFC8)
+#define CORESIGHT_DEVTYPE	(0xFCC)
+
+#define CORESIGHT_UNLOCK	(0xC5ACCE55)
+
+#define TIMEOUT_US		(100)
+
+#define BM(lsb, msb)		((BIT(msb) - BIT(lsb)) + BIT(msb))
+#define BMVAL(val, lsb, msb)	((val & BM(lsb, msb)) >> lsb)
+#define BVAL(val, n)		((val & BIT(n)) >> n)
+
+#ifdef CONFIG_CORESIGHT_SOURCE_ETM
+extern unsigned int etm_readl_cp14(uint32_t off);
+extern void etm_writel_cp14(uint32_t val, uint32_t off);
+#else
+static inline unsigned int etm_readl_cp14(uint32_t off) { return 0; }
+static inline void etm_writel_cp14(uint32_t val, uint32_t off) {}
+#endif
+
+#endif
diff --git a/drivers/coresight/coresight.c b/drivers/coresight/coresight.c
new file mode 100644
index 0000000..66389f7
--- /dev/null
+++ b/drivers/coresight/coresight.c
@@ -0,0 +1,681 @@
+/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/semaphore.h>
+#include <linux/clk.h>
+#include <linux/coresight.h>
+
+#include "coresight-priv.h"
+
+#define NO_SINK		(-1)
+
+static int curr_sink = NO_SINK;
+static LIST_HEAD(coresight_orph_conns);
+static LIST_HEAD(coresight_devs);
+static DEFINE_SEMAPHORE(coresight_mutex);
+
+static int coresight_find_link_inport(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *parent;
+	struct coresight_connection *conn;
+
+	parent = container_of(csdev->path_link.next, struct coresight_device,
+			     path_link);
+	for (i = 0; i < parent->nr_conns; i++) {
+		conn = &parent->conns[i];
+		if (conn->child_dev == csdev)
+			return conn->child_port;
+	}
+
+	pr_err("coresight: couldn't find inport, parent: %d, child: %d\n",
+	       parent->id, csdev->id);
+	return 0;
+}
+
+static int coresight_find_link_outport(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *child;
+	struct coresight_connection *conn;
+
+	child = container_of(csdev->path_link.prev, struct coresight_device,
+			      path_link);
+	for (i = 0; i < csdev->nr_conns; i++) {
+		conn = &csdev->conns[i];
+		if (conn->child_dev == child)
+			return conn->outport;
+	}
+
+	pr_err("coresight: couldn't find outport, parent: %d, child: %d\n",
+	       csdev->id, child->id);
+	return 0;
+}
+
+static int coresight_enable_sink(struct coresight_device *csdev)
+{
+	int ret;
+
+	if (csdev->refcnt.sink_refcnt == 0) {
+		if (csdev->ops->sink_ops->enable) {
+			ret = csdev->ops->sink_ops->enable(csdev);
+			if (ret)
+				goto err;
+			csdev->enable = true;
+		}
+	}
+	csdev->refcnt.sink_refcnt++;
+
+	return 0;
+err:
+	return ret;
+}
+
+static void coresight_disable_sink(struct coresight_device *csdev)
+{
+	if (csdev->refcnt.sink_refcnt == 1) {
+		if (csdev->ops->sink_ops->disable) {
+			csdev->ops->sink_ops->disable(csdev);
+			csdev->enable = false;
+		}
+	}
+	csdev->refcnt.sink_refcnt--;
+}
+
+static int coresight_enable_link(struct coresight_device *csdev)
+{
+	int ret;
+	int link_subtype;
+	int refport, inport, outport;
+
+	inport = coresight_find_link_inport(csdev);
+	outport = coresight_find_link_outport(csdev);
+
+	link_subtype = csdev->subtype.link_subtype;
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
+		refport = inport;
+	else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
+		refport = outport;
+	else
+		refport = 0;
+
+	if (csdev->refcnt.link_refcnts[refport] == 0) {
+		if (csdev->ops->link_ops->enable) {
+			ret = csdev->ops->link_ops->enable(csdev, inport,
+							   outport);
+			if (ret)
+				goto err;
+			csdev->enable = true;
+		}
+	}
+	csdev->refcnt.link_refcnts[refport]++;
+
+	return 0;
+err:
+	return ret;
+}
+
+static void coresight_disable_link(struct coresight_device *csdev)
+{
+	int link_subtype;
+	int refport, inport, outport;
+
+	inport = coresight_find_link_inport(csdev);
+	outport = coresight_find_link_outport(csdev);
+
+	link_subtype = csdev->subtype.link_subtype;
+	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
+		refport = inport;
+	else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
+		refport = outport;
+	else
+		refport = 0;
+
+	if (csdev->refcnt.link_refcnts[refport] == 1) {
+		if (csdev->ops->link_ops->disable) {
+			csdev->ops->link_ops->disable(csdev, inport, outport);
+			csdev->enable = false;
+		}
+	}
+	csdev->refcnt.link_refcnts[refport]--;
+}
+
+static int coresight_enable_source(struct coresight_device *csdev)
+{
+	int ret;
+
+	if (csdev->refcnt.source_refcnt == 0) {
+		if (csdev->ops->source_ops->enable) {
+			ret = csdev->ops->source_ops->enable(csdev);
+			if (ret)
+				goto err;
+			csdev->enable = true;
+		}
+	}
+	csdev->refcnt.source_refcnt++;
+
+	return 0;
+err:
+	return ret;
+}
+
+static void coresight_disable_source(struct coresight_device *csdev)
+{
+	if (csdev->refcnt.source_refcnt == 1) {
+		if (csdev->ops->source_ops->disable) {
+			csdev->ops->source_ops->disable(csdev);
+			csdev->enable = false;
+		}
+	}
+	csdev->refcnt.source_refcnt--;
+}
+
+static struct list_head *coresight_build_path(struct coresight_device *csdev,
+					      struct list_head *path)
+{
+	int i;
+	struct list_head *p;
+	struct coresight_connection *conn;
+
+	if (csdev->id == curr_sink) {
+		list_add_tail(&csdev->path_link, path);
+		return path;
+	}
+
+	for (i = 0; i < csdev->nr_conns; i++) {
+		conn = &csdev->conns[i];
+		p = coresight_build_path(conn->child_dev, path);
+		if (p) {
+			list_add_tail(&csdev->path_link, p);
+			return p;
+		}
+	}
+	return NULL;
+}
+
+static void coresight_release_path(struct list_head *path)
+{
+	struct coresight_device *cd, *temp;
+
+	list_for_each_entry_safe(cd, temp, path, path_link)
+		list_del(&cd->path_link);
+}
+
+static int coresight_enable_path(struct list_head *path, bool incl_source)
+{
+	int ret = 0;
+	struct coresight_device *cd;
+
+	list_for_each_entry(cd, path, path_link) {
+		if (cd == list_first_entry(path, struct coresight_device,
+					   path_link)) {
+			ret = coresight_enable_sink(cd);
+		} else if (list_is_last(&cd->path_link, path)) {
+			if (incl_source)
+				ret = coresight_enable_source(cd);
+		} else {
+			ret = coresight_enable_link(cd);
+		}
+		if (ret)
+			goto err;
+	}
+	return 0;
+err:
+	list_for_each_entry_continue_reverse(cd, path, path_link) {
+		if (cd == list_first_entry(path, struct coresight_device,
+					   path_link)) {
+			coresight_disable_sink(cd);
+		} else if (list_is_last(&cd->path_link, path)) {
+			if (incl_source)
+				coresight_disable_source(cd);
+		} else {
+			coresight_disable_link(cd);
+		}
+	}
+	return ret;
+}
+
+static void coresight_disable_path(struct list_head *path, bool incl_source)
+{
+	struct coresight_device *cd;
+
+	list_for_each_entry(cd, path, path_link) {
+		if (cd == list_first_entry(path, struct coresight_device,
+					   path_link)) {
+			coresight_disable_sink(cd);
+		} else if (list_is_last(&cd->path_link, path)) {
+			if (incl_source)
+				coresight_disable_source(cd);
+		} else {
+			coresight_disable_link(cd);
+		}
+	}
+}
+
+static int coresight_switch_sink(struct coresight_device *csdev)
+{
+	int ret = 0;
+	LIST_HEAD(path);
+	struct coresight_device *cd;
+
+	if (IS_ERR_OR_NULL(csdev))
+		return -EINVAL;
+
+	down(&coresight_mutex);
+	if (csdev->id == curr_sink)
+		goto out;
+
+	list_for_each_entry(cd, &coresight_devs, dev_link) {
+		if (cd->type == CORESIGHT_DEV_TYPE_SOURCE && cd->enable) {
+			coresight_build_path(cd, &path);
+			coresight_disable_path(&path, false);
+			coresight_release_path(&path);
+		}
+	}
+	curr_sink = csdev->id;
+	list_for_each_entry(cd, &coresight_devs, dev_link) {
+		if (cd->type == CORESIGHT_DEV_TYPE_SOURCE && cd->enable) {
+			coresight_build_path(cd, &path);
+			ret = coresight_enable_path(&path, false);
+			coresight_release_path(&path);
+			if (ret)
+				goto err;
+		}
+	}
+out:
+	up(&coresight_mutex);
+	return 0;
+err:
+	list_for_each_entry(cd, &coresight_devs, dev_link) {
+		if (cd->type == CORESIGHT_DEV_TYPE_SOURCE && cd->enable)
+			coresight_disable_source(cd);
+	}
+	pr_err("coresight: sink switch failed, sources disabled; try again\n");
+	return ret;
+}
+
+int coresight_enable(struct coresight_device *csdev)
+{
+	int ret = 0;
+	LIST_HEAD(path);
+
+	if (IS_ERR_OR_NULL(csdev))
+		return -EINVAL;
+
+	down(&coresight_mutex);
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE) {
+		ret = -EINVAL;
+		pr_err("coresight: wrong device type in %s\n", __func__);
+		goto out;
+	}
+	if (csdev->enable)
+		goto out;
+
+	coresight_build_path(csdev, &path);
+	ret = coresight_enable_path(&path, true);
+	coresight_release_path(&path);
+	if (ret)
+		pr_err("coresight: enable failed\n");
+out:
+	up(&coresight_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(coresight_enable);
+
+void coresight_disable(struct coresight_device *csdev)
+{
+	LIST_HEAD(path);
+
+	if (IS_ERR_OR_NULL(csdev))
+		return;
+
+	down(&coresight_mutex);
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE) {
+		pr_err("coresight: wrong device type in %s\n", __func__);
+		goto out;
+	}
+	if (!csdev->enable)
+		goto out;
+
+	coresight_build_path(csdev, &path);
+	coresight_disable_path(&path, true);
+	coresight_release_path(&path);
+out:
+	up(&coresight_mutex);
+}
+EXPORT_SYMBOL_GPL(coresight_disable);
+
+void coresight_abort(void)
+{
+	struct coresight_device *cd;
+
+	if (down_trylock(&coresight_mutex)) {
+		pr_err("coresight: abort could not be processed\n");
+		return;
+	}
+	if (curr_sink == NO_SINK)
+		goto out;
+
+	list_for_each_entry(cd, &coresight_devs, dev_link) {
+		if (cd->id == curr_sink) {
+			if (cd->enable && cd->ops->sink_ops->abort) {
+				cd->ops->sink_ops->abort(cd);
+				cd->enable = false;
+			}
+		}
+	}
+out:
+	up(&coresight_mutex);
+}
+EXPORT_SYMBOL_GPL(coresight_abort);
+
+static ssize_t coresight_show_type(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", dev->type->name);
+}
+
+static struct device_attribute coresight_dev_attrs[] = {
+	__ATTR(type, S_IRUGO, coresight_show_type, NULL),
+	{ },
+};
+
+struct bus_type coresight_bus_type = {
+	.name		= "coresight",
+	.dev_attrs	= coresight_dev_attrs,
+};
+
+static ssize_t coresight_show_curr_sink(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 csdev->id == curr_sink ? 1 : 0);
+}
+
+static ssize_t coresight_store_curr_sink(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t size)
+{
+	int ret = 0;
+	unsigned long val;
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	if (val)
+		ret = coresight_switch_sink(csdev);
+	else
+		ret = -EINVAL;
+
+	if (ret)
+		return ret;
+	return size;
+}
+static DEVICE_ATTR(curr_sink, S_IRUGO | S_IWUSR, coresight_show_curr_sink,
+		   coresight_store_curr_sink);
+
+static ssize_t coresight_show_enable(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->enable);
+}
+
+static ssize_t coresight_store_enable(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	int ret = 0;
+	unsigned long val;
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	if (val)
+		ret = coresight_enable(csdev);
+	else
+		coresight_disable(csdev);
+
+	if (ret)
+		return ret;
+	return size;
+}
+static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, coresight_show_enable,
+		   coresight_store_enable);
+
+static struct attribute *coresight_attrs_sink[] = {
+	&dev_attr_curr_sink.attr,
+	NULL,
+};
+
+static struct attribute_group coresight_attr_grp_sink = {
+	.attrs = coresight_attrs_sink,
+};
+
+static const struct attribute_group *coresight_attr_grps_sink[] = {
+	&coresight_attr_grp_sink,
+	NULL,
+};
+
+static struct attribute *coresight_attrs_source[] = {
+	&dev_attr_enable.attr,
+	NULL,
+};
+
+static struct attribute_group coresight_attr_grp_source = {
+	.attrs = coresight_attrs_source,
+};
+
+static const struct attribute_group *coresight_attr_grps_source[] = {
+	&coresight_attr_grp_source,
+	NULL,
+};
+
+static struct device_type coresight_dev_type[] = {
+	{
+		.name = "none",
+	},
+	{
+		.name = "sink",
+		.groups = coresight_attr_grps_sink,
+	},
+	{
+		.name = "link",
+	},
+	{
+		.name = "linksink",
+		.groups = coresight_attr_grps_sink,
+	},
+	{
+		.name = "source",
+		.groups = coresight_attr_grps_source,
+	},
+};
+
+static void coresight_device_release(struct device *dev)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+	kfree(csdev);
+}
+
+static void coresight_fixup_orphan_conns(struct coresight_device *csdev)
+{
+	struct coresight_connection *conn, *temp;
+
+	list_for_each_entry_safe(conn, temp, &coresight_orph_conns, link) {
+		if (conn->child_id == csdev->id) {
+			conn->child_dev = csdev;
+			list_del(&conn->link);
+		}
+	}
+}
+
+static void coresight_fixup_device_conns(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *cd;
+	bool found;
+
+	for (i = 0; i < csdev->nr_conns; i++) {
+		found = false;
+		list_for_each_entry(cd, &coresight_devs, dev_link) {
+			if (csdev->conns[i].child_id == cd->id) {
+				csdev->conns[i].child_dev = cd;
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			list_add_tail(&csdev->conns[i].link,
+				      &coresight_orph_conns);
+	}
+}
+
+struct coresight_device *coresight_register(struct coresight_desc *desc)
+{
+	int i;
+	int ret;
+	int link_subtype;
+	int nr_refcnts;
+	int *refcnts = NULL;
+	struct coresight_device *csdev;
+	struct coresight_connection *conns;
+
+	if (IS_ERR_OR_NULL(desc))
+		return ERR_PTR(-EINVAL);
+
+	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
+	if (!csdev) {
+		ret = -ENOMEM;
+		goto err_kzalloc_csdev;
+	}
+
+	csdev->id = desc->pdata->id;
+
+	if (desc->type == CORESIGHT_DEV_TYPE_LINK ||
+	    desc->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		link_subtype = desc->subtype.link_subtype;
+		if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
+			nr_refcnts = desc->pdata->nr_inports;
+		else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
+			nr_refcnts = desc->pdata->nr_outports;
+		else
+			nr_refcnts = 1;
+
+		refcnts = kzalloc(sizeof(*refcnts) * nr_refcnts, GFP_KERNEL);
+		if (!refcnts) {
+			ret = -ENOMEM;
+			goto err_kzalloc_refcnts;
+		}
+		csdev->refcnt.link_refcnts = refcnts;
+	}
+
+	csdev->nr_conns = desc->pdata->nr_outports;
+	conns = kzalloc(sizeof(*conns) * csdev->nr_conns, GFP_KERNEL);
+	if (!conns) {
+		ret = -ENOMEM;
+		goto err_kzalloc_conns;
+	}
+	for (i = 0; i < csdev->nr_conns; i++) {
+		conns[i].outport = desc->pdata->outports[i];
+		conns[i].child_id = desc->pdata->child_ids[i];
+		conns[i].child_port = desc->pdata->child_ports[i];
+	}
+	csdev->conns = conns;
+
+	csdev->type = desc->type;
+	csdev->subtype = desc->subtype;
+	csdev->ops = desc->ops;
+	csdev->owner = desc->owner;
+
+	csdev->dev.type = &coresight_dev_type[desc->type];
+	csdev->dev.groups = desc->groups;
+	csdev->dev.parent = desc->dev;
+	csdev->dev.bus = &coresight_bus_type;
+	csdev->dev.release = coresight_device_release;
+	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
+
+	down(&coresight_mutex);
+	if (desc->pdata->default_sink) {
+		if (curr_sink == NO_SINK) {
+			curr_sink = csdev->id;
+		} else {
+			ret = -EINVAL;
+			goto err_default_sink;
+		}
+	}
+
+	coresight_fixup_device_conns(csdev);
+	ret = device_register(&csdev->dev);
+	if (ret)
+		goto err_dev_reg;
+	coresight_fixup_orphan_conns(csdev);
+
+	list_add_tail(&csdev->dev_link, &coresight_devs);
+	up(&coresight_mutex);
+
+	return csdev;
+err_dev_reg:
+	put_device(&csdev->dev);
+err_default_sink:
+	up(&coresight_mutex);
+	kfree(conns);
+err_kzalloc_conns:
+	kfree(refcnts);
+err_kzalloc_refcnts:
+	kfree(csdev);
+err_kzalloc_csdev:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(coresight_register);
+
+void coresight_unregister(struct coresight_device *csdev)
+{
+	if (IS_ERR_OR_NULL(csdev))
+		return;
+
+	if (get_device(&csdev->dev)) {
+		device_unregister(&csdev->dev);
+		put_device(&csdev->dev);
+	}
+}
+EXPORT_SYMBOL_GPL(coresight_unregister);
+
+static int __init coresight_init(void)
+{
+	return bus_register(&coresight_bus_type);
+}
+subsys_initcall(coresight_init);
+
+static void __exit coresight_exit(void)
+{
+	bus_unregister(&coresight_bus_type);
+}
+module_exit(coresight_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
new file mode 100644
index 0000000..a9d0182
--- /dev/null
+++ b/drivers/coresight/of_coresight.c
@@ -0,0 +1,99 @@
+/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/coresight.h>
+
+struct coresight_platform_data *of_get_coresight_platform_data(
+				struct device *dev, struct device_node *node)
+{
+	int i, ret = 0;
+	uint32_t outports_len = 0;
+	struct device_node *child_node;
+	struct coresight_platform_data *pdata;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	ret = of_property_read_u32(node, "coresight-id", &pdata->id);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_string(node, "coresight-name", &pdata->name);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_property_read_u32(node, "coresight-nr-inports",
+				   &pdata->nr_inports);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pdata->nr_outports = 0;
+	if (of_get_property(node, "coresight-outports", &outports_len))
+		pdata->nr_outports = outports_len/sizeof(uint32_t);
+
+	if (pdata->nr_outports) {
+		pdata->outports = devm_kzalloc(dev, pdata->nr_outports *
+					       sizeof(*pdata->outports),
+					       GFP_KERNEL);
+		if (!pdata->outports)
+			return ERR_PTR(-ENOMEM);
+
+		ret = of_property_read_u32_array(node, "coresight-outports",
+						 (u32 *)pdata->outports,
+						 pdata->nr_outports);
+		if (ret)
+			return ERR_PTR(ret);
+
+		pdata->child_ids = devm_kzalloc(dev, pdata->nr_outports *
+						sizeof(*pdata->child_ids),
+						GFP_KERNEL);
+		if (!pdata->child_ids)
+			return ERR_PTR(-ENOMEM);
+
+		for (i = 0; i < pdata->nr_outports; i++) {
+			child_node = of_parse_phandle(node,
+						      "coresight-child-list",
+						      i);
+			if (!child_node)
+				return ERR_PTR(-EINVAL);
+
+			ret = of_property_read_u32(child_node, "coresight-id",
+						   (u32 *)&pdata->child_ids[i]);
+			of_node_put(child_node);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+
+		pdata->child_ports = devm_kzalloc(dev, pdata->nr_outports *
+						  sizeof(*pdata->child_ports),
+						  GFP_KERNEL);
+		if (!pdata->child_ports)
+			return ERR_PTR(-ENOMEM);
+
+		ret = of_property_read_u32_array(node, "coresight-child-ports",
+						 (u32 *)pdata->child_ports,
+						 pdata->nr_outports);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	pdata->default_sink = of_property_read_bool(node,
+						    "coresight-default-sink");
+	return pdata;
+}
+EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
new file mode 100644
index 0000000..f98bd7f
--- /dev/null
+++ b/include/linux/coresight.h
@@ -0,0 +1,167 @@
+/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_CORESIGHT_H
+#define _LINUX_CORESIGHT_H
+
+#include <linux/device.h>
+
+/* Peripheral id registers (0xFD0-0xFEC) */
+#define CORESIGHT_PERIPHIDR4	(0xFD0)
+#define CORESIGHT_PERIPHIDR5	(0xFD4)
+#define CORESIGHT_PERIPHIDR6	(0xFD8)
+#define CORESIGHT_PERIPHIDR7	(0xFDC)
+#define CORESIGHT_PERIPHIDR0	(0xFE0)
+#define CORESIGHT_PERIPHIDR1	(0xFE4)
+#define CORESIGHT_PERIPHIDR2	(0xFE8)
+#define CORESIGHT_PERIPHIDR3	(0xFEC)
+/* Component id registers (0xFF0-0xFFC) */
+#define CORESIGHT_COMPIDR0	(0xFF0)
+#define CORESIGHT_COMPIDR1	(0xFF4)
+#define CORESIGHT_COMPIDR2	(0xFF8)
+#define CORESIGHT_COMPIDR3	(0xFFC)
+
+#define ETM_ARCH_V3_3		(0x23)
+#define PFT_ARCH_V1_1		(0x31)
+
+enum coresight_clk_rate {
+	CORESIGHT_CLK_RATE_OFF,
+	CORESIGHT_CLK_RATE_TRACE,
+	CORESIGHT_CLK_RATE_HSTRACE,
+};
+
+enum coresight_dev_type {
+	CORESIGHT_DEV_TYPE_NONE,
+	CORESIGHT_DEV_TYPE_SINK,
+	CORESIGHT_DEV_TYPE_LINK,
+	CORESIGHT_DEV_TYPE_LINKSINK,
+	CORESIGHT_DEV_TYPE_SOURCE,
+};
+
+enum coresight_dev_subtype_sink {
+	CORESIGHT_DEV_SUBTYPE_SINK_NONE,
+	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
+	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
+};
+
+enum coresight_dev_subtype_link {
+	CORESIGHT_DEV_SUBTYPE_LINK_NONE,
+	CORESIGHT_DEV_SUBTYPE_LINK_MERG,
+	CORESIGHT_DEV_SUBTYPE_LINK_SPLIT,
+	CORESIGHT_DEV_SUBTYPE_LINK_FIFO,
+};
+
+enum coresight_dev_subtype_source {
+	CORESIGHT_DEV_SUBTYPE_SOURCE_NONE,
+	CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
+	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
+	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
+};
+
+struct coresight_dev_subtype {
+	enum coresight_dev_subtype_sink sink_subtype;
+	enum coresight_dev_subtype_link link_subtype;
+	enum coresight_dev_subtype_source source_subtype;
+};
+
+struct coresight_platform_data {
+	int id;
+	const char *name;
+	int nr_inports;
+	const int *outports;
+	const int *child_ids;
+	const int *child_ports;
+	int nr_outports;
+	bool default_sink;
+};
+
+struct coresight_desc {
+	enum coresight_dev_type type;
+	struct coresight_dev_subtype subtype;
+	const struct coresight_ops *ops;
+	struct coresight_platform_data *pdata;
+	struct device *dev;
+	const struct attribute_group **groups;
+	struct module *owner;
+};
+
+struct coresight_connection {
+	int outport;
+	int child_id;
+	int child_port;
+	struct coresight_device *child_dev;
+	struct list_head link;
+};
+
+struct coresight_refcnt {
+	int sink_refcnt;
+	int *link_refcnts;
+	int source_refcnt;
+};
+
+struct coresight_device {
+	int id;
+	struct coresight_connection *conns;
+	int nr_conns;
+	enum coresight_dev_type type;
+	struct coresight_dev_subtype subtype;
+	const struct coresight_ops *ops;
+	struct device dev;
+	struct coresight_refcnt refcnt;
+	struct list_head dev_link;
+	struct list_head path_link;
+	struct module *owner;
+	bool enable;
+};
+
+#define to_coresight_device(d) container_of(d, struct coresight_device, dev)
+
+struct coresight_ops_sink {
+	int (*enable)(struct coresight_device *csdev);
+	void (*disable)(struct coresight_device *csdev);
+	void (*abort)(struct coresight_device *csdev);
+};
+
+struct coresight_ops_link {
+	int (*enable)(struct coresight_device *csdev, int iport, int oport);
+	void (*disable)(struct coresight_device *csdev, int iport, int oport);
+};
+
+struct coresight_ops_source {
+	int (*enable)(struct coresight_device *csdev);
+	void (*disable)(struct coresight_device *csdev);
+};
+
+struct coresight_ops {
+	const struct coresight_ops_sink *sink_ops;
+	const struct coresight_ops_link *link_ops;
+	const struct coresight_ops_source *source_ops;
+};
+
+#ifdef CONFIG_CORESIGHT
+extern struct coresight_device *
+coresight_register(struct coresight_desc *desc);
+extern void coresight_unregister(struct coresight_device *csdev);
+extern int coresight_enable(struct coresight_device *csdev);
+extern void coresight_disable(struct coresight_device *csdev);
+extern void coresight_abort(void);
+#else
+static inline struct coresight_device *
+coresight_register(struct coresight_desc *desc) { return NULL; }
+static inline void coresight_unregister(struct coresight_device *csdev) {}
+static inline int
+coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
+static inline void coresight_disable(struct coresight_device *csdev) {}
+static inline void coresight_abort(void) {}
+#endif
+
+#endif
diff --git a/include/linux/of_coresight.h b/include/linux/of_coresight.h
new file mode 100644
index 0000000..6a5e4d4
--- /dev/null
+++ b/include/linux/of_coresight.h
@@ -0,0 +1,27 @@
+/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_OF_CORESIGHT_H
+#define __LINUX_OF_CORESIGHT_H
+
+#ifdef CONFIG_OF
+extern struct coresight_platform_data *of_get_coresight_platform_data(
+				struct device *dev, struct device_node *node);
+#else
+static inline struct coresight_platform_data *of_get_coresight_platform_data(
+				struct device *dev, struct device_node *node)
+{
+	return NULL;
+}
+#endif
+
+#endif
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:37:00 -0700
Subject: [PATCH v2 4/9] remoteproc: Introduce Qualcomm WCNSS firmware loader
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-5-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

This introduces the peripheral image loader, for loading WCNSS firmware
and boot the core on e.g. MSM8974. The firmware is verified and booted
with the help of the Peripheral Authentication System (PAS) in
TrustZone.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Split iris definition into separate driver/dt-node
- Move constants from DT to code
- Make stop-state and some of interrupts optional to properly work on 8064
- Cleaned up and made mdt loader support relocation, which is needed on 8016.

 drivers/remoteproc/Kconfig           |  12 +
 drivers/remoteproc/Makefile          |   2 +
 drivers/remoteproc/qcom_mdt_loader.c | 172 +++++++++++
 drivers/remoteproc/qcom_mdt_loader.h |   7 +
 drivers/remoteproc/qcom_wcnss.c      | 579 +++++++++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_wcnss.h      |  22 ++
 drivers/remoteproc/qcom_wcnss_iris.c | 185 +++++++++++
 7 files changed, 979 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_mdt_loader.c
 create mode 100644 drivers/remoteproc/qcom_mdt_loader.h
 create mode 100644 drivers/remoteproc/qcom_wcnss.c
 create mode 100644 drivers/remoteproc/qcom_wcnss.h
 create mode 100644 drivers/remoteproc/qcom_wcnss_iris.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 72e97d7a5209..7290c46fff9d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -86,4 +86,16 @@ config ST_REMOTEPROC
 	  processor framework.
 	  This can be either built-in or a loadable module.
 
+config QCOM_MDT_LOADER
+	tristate
+
+config QCOM_WCNSS_PIL
+	tristate "Qualcomm WCNSS Peripheral Image Loader"
+	depends on OF && ARCH_QCOM
+	select REMOTEPROC
+	select QCOM_MDT_LOADER
+	select QCOM_SCM
+	help
+	  Peripherial Image Loader for the WCNSS block.
+
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 279cb2edc880..97e6ddbe17ea 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
+obj-$(CONFIG_QCOM_MDT_LOADER)		+= qcom_mdt_loader.o
+obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss.o qcom_wcnss_iris.o
diff --git a/drivers/remoteproc/qcom_mdt_loader.c b/drivers/remoteproc/qcom_mdt_loader.c
new file mode 100644
index 000000000000..a8195093d640
--- /dev/null
+++ b/drivers/remoteproc/qcom_mdt_loader.c
@@ -0,0 +1,172 @@
+/*
+ * Qualcomm Peripheral Image Loader
+ *
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2015 Sony Mobile Communications Inc
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/elf.h>
+#include <linux/firmware.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/qcom_scm.h>
+#include <linux/remoteproc.h>
+#include <linux/slab.h>
+
+#include "remoteproc_internal.h"
+
+#define QCOM_MDT_TYPE_MASK	(7 << 24)
+#define QCOM_MDT_TYPE_HASH	(2 << 24)
+#define QCOM_MDT_RELOCATABLE	BIT(27)
+
+/**
+ * qcom_mdt_find_rsc_table() - provide dummy resource table for remoteproc
+ * @rproc:	remoteproc handle
+ * @fw:		firmware header
+ * @tablesz:	outgoing size of the table
+ *
+ * Returns a dummy table.
+ */
+struct resource_table *qcom_mdt_find_rsc_table(struct rproc *rproc,
+					       const struct firmware *fw,
+					       int *tablesz)
+{
+	static struct resource_table table = { .ver = 1, };
+
+	*tablesz = sizeof(table);
+	return &table;
+}
+EXPORT_SYMBOL_GPL(qcom_mdt_find_rsc_table);
+
+/**
+ * qcom_mdt_load() - load the firmware which header is defined in fw
+ * @rproc:	rproc handle
+ * @pas_id:	PAS identifier to load this firmware into
+ * @fw:		frimware object for the header
+ * @mem_phys:	physical address of reserved memory region for the firmware
+ * @mem_region:	pointer to a mapping of the reserved memory region
+ * @mem_size:	size of the reserved memory region
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+int qcom_mdt_load(struct rproc *rproc,
+		  unsigned int pas_id,
+		  const struct firmware *fw,
+		  phys_addr_t mem_phys,
+		  void *mem_region,
+		  size_t mem_size)
+{
+	const struct elf32_phdr *phdrs;
+	const struct elf32_phdr *phdr;
+	const struct elf32_hdr *ehdr;
+	unsigned int fw_name_len;
+	phys_addr_t min_addr = (phys_addr_t)ULLONG_MAX;
+	phys_addr_t max_addr = 0;
+	bool relocate = false;
+	char *fw_name;
+	void *ptr;
+	int ret;
+	int i;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+	phdrs = (struct elf32_phdr *)(ehdr + 1);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		if ((phdr->p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH)
+			continue;
+
+		if (!phdr->p_memsz)
+			continue;
+
+		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
+			relocate = true;
+
+		if (phdr->p_paddr < min_addr)
+			min_addr = phdr->p_paddr;
+
+		if (phdr->p_paddr + phdr->p_memsz > max_addr)
+			max_addr = round_up(phdr->p_paddr + phdr->p_memsz, SZ_4K);
+	}
+
+	ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
+	if (ret) {
+		dev_err(&rproc->dev, "invalid firmware metadata\n");
+		return -EINVAL;
+	}
+
+	if (relocate) {
+		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
+		if (ret) {
+			dev_err(&rproc->dev, "unable to setup memory for image\n");
+			return -EINVAL;
+		}
+	}
+
+	fw_name_len = strlen(rproc->firmware);
+	if (fw_name_len <= 4)
+		return -EINVAL;
+
+	fw_name = kstrdup(rproc->firmware, GFP_KERNEL);
+	if (!fw_name)
+		return -ENOMEM;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		if ((phdr->p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH)
+			continue;
+
+		if (!phdr->p_memsz)
+			continue;
+
+		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
+			ptr = mem_region + phdr->p_paddr - min_addr;
+		else
+			ptr = mem_region + phdr->p_paddr - mem_phys;
+
+		if (ptr < mem_region || ptr + phdr->p_memsz > mem_region + mem_size) {
+			dev_err(&rproc->dev, "segment outside memory range\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		if (phdr->p_filesz) {
+			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
+			ret = request_firmware(&fw, fw_name, &rproc->dev);
+			if (ret) {
+				dev_err(&rproc->dev, "failed to load %s\n", fw_name);
+				break;
+			}
+
+			memcpy(ptr, fw->data, fw->size);
+
+			release_firmware(fw);
+		}
+
+		if (phdr->p_memsz > phdr->p_filesz)
+			memset(ptr + phdr->p_filesz, 0, phdr->p_memsz - phdr->p_filesz);
+	}
+
+	kfree(fw_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_mdt_load);
diff --git a/drivers/remoteproc/qcom_mdt_loader.h b/drivers/remoteproc/qcom_mdt_loader.h
new file mode 100644
index 000000000000..a72e3072dea1
--- /dev/null
+++ b/drivers/remoteproc/qcom_mdt_loader.h
@@ -0,0 +1,7 @@
+#ifndef __QCOM_MDT_LOADER_H__
+#define __QCOM_MDT_LOADER_H__
+
+struct resource_table *qcom_mdt_find_rsc_table(struct rproc *rproc, const struct firmware *fw, int *tablesz);
+int qcom_mdt_load(struct rproc *rproc, unsigned int pas_id, const struct firmware *fw, phys_addr_t mem_phys, void *mem_region, size_t mem_size);
+
+#endif
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
new file mode 100644
index 000000000000..1d2b82fa820b
--- /dev/null
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -0,0 +1,579 @@
+/*
+ * Qualcomm Peripheral Image Loader
+ *
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2014 Sony Mobile Communications AB
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/qcom_scm.h>
+#include <linux/regulator/consumer.h>
+#include <linux/remoteproc.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/smem_state.h>
+
+#include "qcom_mdt_loader.h"
+#include "remoteproc_internal.h"
+#include "qcom_wcnss.h"
+
+#define WCNSS_CRASH_REASON_SMEM		422
+#define WCNSS_FIRMWARE_NAME		"wcnss.mdt"
+#define WCNSS_PAS_ID			6
+
+#define WCNSS_SPARE_NVBIN_DLND		BIT(25)
+
+#define WCNSS_PMU_IRIS_XO_CFG		BIT(3)
+#define WCNSS_PMU_IRIS_XO_EN		BIT(4)
+#define WCNSS_PMU_GC_BUS_MUX_SEL_TOP	BIT(5)
+#define WCNSS_PMU_IRIS_XO_CFG_STS	BIT(6) /* 1: in progress, 0: done */
+
+#define WCNSS_PMU_IRIS_RESET		BIT(7)
+#define WCNSS_PMU_IRIS_RESET_STS	BIT(8) /* 1: in progress, 0: done */
+#define WCNSS_PMU_IRIS_XO_READ		BIT(9)
+#define WCNSS_PMU_IRIS_XO_READ_STS	BIT(10)
+
+#define WCNSS_PMU_XO_MODE_MASK		GENMASK(2, 1)
+#define WCNSS_PMU_XO_MODE_19p2		0
+#define WCNSS_PMU_XO_MODE_48		3
+
+static const struct rproc_ops wcnss_ops;
+
+struct wcnss_data {
+	size_t pmu_offset;
+	size_t spare_offset;
+
+	const struct wcnss_vreg_info *vregs;
+	size_t num_vregs;
+};
+
+struct qcom_wcnss {
+	struct device *dev;
+	struct rproc *rproc;
+
+	void __iomem *pmu_cfg;
+	void __iomem *spare_out;
+
+	bool use_48mhz_xo;
+
+	int wdog_irq;
+	int fatal_irq;
+	int ready_irq;
+	int handover_irq;
+	int stop_ack_irq;
+
+	struct qcom_smem_state *state;
+	unsigned int stop_bit;
+
+	struct mutex iris_lock;
+	struct qcom_iris *iris;
+
+	struct regulator_bulk_data *vregs;
+	size_t num_vregs;
+
+	struct completion start_done;
+	struct completion stop_done;
+
+	phys_addr_t mem_phys;
+	void *mem_region;
+	size_t mem_size;
+};
+
+static const struct wcnss_data riva_data = {
+	.pmu_offset = 0x28,
+	.spare_offset = 0xb4,
+
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddmx",  1050000, 1150000, 0 },
+		{ "vddcx",  1050000, 1150000, 0 },
+		{ "vddpx",  1800000, 1800000, 0 },
+	},
+	.num_vregs = 3,
+};
+
+static const struct wcnss_data pronto_v1_data = {
+	.pmu_offset = 0x1004,
+	.spare_offset = 0x1088,
+
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddmx", 950000, 1150000, 0 },
+		{ "vddcx", .super_turbo = true},
+		{ "vddpx", 1800000, 1800000, 0 },
+	},
+	.num_vregs = 3,
+};
+
+static const struct wcnss_data pronto_v2_data = {
+	.pmu_offset = 0x1004,
+	.spare_offset = 0x1088,
+
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddmx", 1287500, 1287500, 0 },
+		{ "vddcx", .super_turbo = true },
+		{ "vddpx", 1800000, 1800000, 0 },
+	},
+	.num_vregs = 3,
+};
+
+void qcom_wcnss_assign_iris(struct qcom_wcnss *wcnss,
+			    struct qcom_iris *iris,
+			    bool use_48mhz_xo)
+{
+	mutex_lock(&wcnss->iris_lock);
+
+	wcnss->iris = iris;
+	wcnss->use_48mhz_xo = use_48mhz_xo;
+
+	mutex_unlock(&wcnss->iris_lock);
+}
+
+static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+
+	return qcom_mdt_load(rproc, WCNSS_PAS_ID, fw, wcnss->mem_phys,
+			     wcnss->mem_region, wcnss->mem_size);
+}
+
+static const struct rproc_fw_ops wcnss_fw_ops = {
+	.find_rsc_table = qcom_mdt_find_rsc_table,
+	.load = wcnss_load,
+};
+
+static void wcnss_indicate_nv_download(struct qcom_wcnss *wcnss)
+{
+	u32 val;
+
+	/* Indicate NV download capability */
+	val = readl(wcnss->spare_out);
+	val |= WCNSS_SPARE_NVBIN_DLND;
+	writel(val, wcnss->spare_out);
+}
+
+static void wcnss_configure_iris(struct qcom_wcnss *wcnss)
+{
+	u32 val;
+
+	/* Clear PMU cfg register */
+	writel(0, wcnss->pmu_cfg);
+
+	val = WCNSS_PMU_GC_BUS_MUX_SEL_TOP | WCNSS_PMU_IRIS_XO_EN;
+	writel(val, wcnss->pmu_cfg);
+
+	/* Clear XO_MODE */
+	val &= ~WCNSS_PMU_XO_MODE_MASK;
+	if (wcnss->use_48mhz_xo)
+		val |= WCNSS_PMU_XO_MODE_48 << 1;
+	else
+		val |= WCNSS_PMU_XO_MODE_19p2 << 1;
+	writel(val, wcnss->pmu_cfg);
+
+	/* Reset IRIS */
+	val |= WCNSS_PMU_IRIS_RESET;
+	writel(val, wcnss->pmu_cfg);
+
+	/* Wait for PMU.iris_reg_reset_sts */
+	while (readl(wcnss->pmu_cfg) & WCNSS_PMU_IRIS_RESET_STS)
+		cpu_relax();
+
+	/* Clear IRIS reset */
+	val &= ~WCNSS_PMU_IRIS_RESET;
+	writel(val, wcnss->pmu_cfg);
+
+	/* Start IRIS XO configuration */
+	val |= WCNSS_PMU_IRIS_XO_CFG;
+	writel(val, wcnss->pmu_cfg);
+
+	/* Wait for XO configuration to finish */
+	while (readl(wcnss->pmu_cfg) & WCNSS_PMU_IRIS_XO_CFG_STS)
+		cpu_relax();
+
+	/* Stop IRIS XO configuration */
+	val &= ~WCNSS_PMU_GC_BUS_MUX_SEL_TOP;
+	val &= ~WCNSS_PMU_IRIS_XO_CFG;
+	writel(val, wcnss->pmu_cfg);
+
+	/* Add some delay for XO to settle */
+	msleep(20);
+}
+
+static int wcnss_start(struct rproc *rproc)
+{
+	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	int ret;
+
+	mutex_lock(&wcnss->iris_lock);
+	if (!wcnss->iris) {
+		dev_err(wcnss->dev, "no iris registered\n");
+		ret = -EINVAL;
+		goto release_iris_lock;
+	}
+
+	ret = regulator_bulk_enable(wcnss->num_vregs, wcnss->vregs);
+	if (ret)
+		goto release_iris_lock;
+
+	ret = qcom_iris_enable(wcnss->iris);
+	if (ret)
+		goto disable_regulators;
+
+	wcnss_indicate_nv_download(wcnss);
+	wcnss_configure_iris(wcnss);
+
+	ret = qcom_scm_pas_auth_and_reset(WCNSS_PAS_ID);
+	if (ret) {
+		dev_err(wcnss->dev,
+			"failed to authenticate image and release reset\n");
+		goto disable_iris;
+	}
+
+	ret = wait_for_completion_timeout(&wcnss->start_done,
+					  msecs_to_jiffies(5000));
+	if (wcnss->ready_irq > 0 && ret == 0) {
+		/* We have a ready_irq, but it didn't fire in time. */
+		dev_err(wcnss->dev, "start timed out\n");
+		qcom_scm_pas_shutdown(WCNSS_PAS_ID);
+		ret = -ETIMEDOUT;
+		goto disable_iris;
+	}
+
+	ret = 0;
+
+disable_iris:
+	qcom_iris_disable(wcnss->iris);
+disable_regulators:
+	regulator_bulk_disable(wcnss->num_vregs, wcnss->vregs);
+release_iris_lock:
+	mutex_unlock(&wcnss->iris_lock);
+
+	return ret;
+}
+
+static int wcnss_stop(struct rproc *rproc)
+{
+	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
+	int ret;
+
+	if (wcnss->state) {
+		qcom_smem_state_update_bits(wcnss->state,
+					    BIT(wcnss->stop_bit),
+					    BIT(wcnss->stop_bit));
+
+		ret = wait_for_completion_timeout(&wcnss->stop_done,
+						  msecs_to_jiffies(5000));
+		if (ret == 0)
+			dev_err(wcnss->dev, "timed out on wait\n");
+
+		qcom_smem_state_update_bits(wcnss->state,
+					    BIT(wcnss->stop_bit),
+					    0);
+	}
+
+	ret = qcom_scm_pas_shutdown(WCNSS_PAS_ID);
+	if (ret)
+		dev_err(wcnss->dev, "failed to shutdown: %d\n", ret);
+
+	return ret;
+}
+
+static const struct rproc_ops wcnss_ops = {
+	.start = wcnss_start,
+	.stop = wcnss_stop,
+};
+
+static irqreturn_t wcnss_wdog_interrupt(int irq, void *dev)
+{
+	struct qcom_wcnss *wcnss = dev;
+
+	rproc_report_crash(wcnss->rproc, RPROC_WATCHDOG);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wcnss_fatal_interrupt(int irq, void *dev)
+{
+	struct qcom_wcnss *wcnss = dev;
+	size_t len;
+	char *msg;
+
+	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, WCNSS_CRASH_REASON_SMEM, &len);
+	if (!IS_ERR(msg) && len > 0 && msg[0])
+		dev_err(wcnss->dev, "fatal error received: %s\n", msg);
+
+	rproc_report_crash(wcnss->rproc, RPROC_FATAL_ERROR);
+
+	if (!IS_ERR(msg))
+		msg[0] = '\0';
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wcnss_ready_interrupt(int irq, void *dev)
+{
+	struct qcom_wcnss *wcnss = dev;
+
+	complete(&wcnss->start_done);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wcnss_handover_interrupt(int irq, void *dev)
+{
+	/*
+	 * XXX: At this point we're supposed to release the resources that we
+	 * have been holding on behalf of the WCNSS. Unfortunately this
+	 * interrupt comes way before the other side seems to be done.
+	 *
+	 * So we're currently relying on the ready interrupt firing later then
+	 * this and we just disable the resources at the end of wcnss_start().
+	 */
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wcnss_stop_ack_interrupt(int irq, void *dev)
+{
+	struct qcom_wcnss *wcnss = dev;
+
+	complete(&wcnss->stop_done);
+	return IRQ_HANDLED;
+}
+
+static int wcnss_init_regulators(struct qcom_wcnss *wcnss,
+				 const struct wcnss_vreg_info *info,
+				 int num_vregs)
+{
+	struct regulator_bulk_data *bulk;
+	int ret;
+	int i;
+
+	bulk = devm_kcalloc(wcnss->dev,
+			    num_vregs, sizeof(struct regulator_bulk_data),
+			    GFP_KERNEL);
+	if (!bulk)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vregs; i++)
+		bulk[i].supply = info[i].name;
+
+	ret = devm_regulator_bulk_get(wcnss->dev, num_vregs, bulk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_vregs; i++) {
+		if (info[i].max_voltage)
+			regulator_set_voltage(bulk[i].consumer,
+					      info[i].min_voltage,
+					      info[i].max_voltage);
+
+		if (info[i].load_uA)
+			regulator_set_load(bulk[i].consumer, info[i].load_uA);
+	}
+
+	wcnss->vregs = bulk;
+	wcnss->num_vregs = num_vregs;
+
+	return 0;
+}
+
+static int wcnss_request_irq(struct qcom_wcnss *wcnss,
+			     struct platform_device *pdev,
+			     const char *name,
+			     bool optional,
+			     irq_handler_t thread_fn)
+{
+	int ret;
+
+	ret = platform_get_irq_byname(pdev, name);
+	if (ret < 0 && optional) {
+		dev_dbg(&pdev->dev, "no %s IRQ defined, ignoring\n", name);
+		return 0;
+	} else if (ret < 0) {
+		dev_err(&pdev->dev, "no %s IRQ defined\n", name);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, ret,
+					NULL, thread_fn,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"wcnss", wcnss);
+	if (ret)
+		dev_err(&pdev->dev, "request %s IRQ failed\n", name);
+	return ret;
+}
+
+static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
+{
+	struct device_node *node;
+	struct resource r;
+	int ret;
+
+	node = of_parse_phandle(wcnss->dev->of_node, "memory-region", 0);
+	if (!node) {
+		dev_err(wcnss->dev, "no memory-region specified\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(node, 0, &r);
+	if (ret)
+		return ret;
+
+	wcnss->mem_phys = r.start;
+	wcnss->mem_size = resource_size(&r);
+	wcnss->mem_region = devm_ioremap_wc(wcnss->dev, wcnss->mem_phys, wcnss->mem_size);
+	if (!wcnss->mem_region) {
+		dev_err(wcnss->dev, "unable to map memory region: %pa+%zx\n",
+			&r.start, wcnss->mem_size);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int wcnss_probe(struct platform_device *pdev)
+{
+	const struct wcnss_data *data;
+	struct qcom_wcnss *wcnss;
+	struct resource *res;
+	struct rproc *rproc;
+	void __iomem *mmio;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	if (!qcom_scm_pas_supported(WCNSS_PAS_ID)) {
+		dev_err(&pdev->dev, "PAS is not available for WCNSS\n");
+		return -ENXIO;
+	}
+
+	rproc = rproc_alloc(&pdev->dev, pdev->name, &wcnss_ops,
+			    WCNSS_FIRMWARE_NAME, sizeof(*wcnss));
+	if (!rproc) {
+		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
+		return -ENOMEM;
+	}
+
+	rproc->fw_ops = &wcnss_fw_ops;
+
+	wcnss = (struct qcom_wcnss *)rproc->priv;
+	wcnss->dev = &pdev->dev;
+	wcnss->rproc = rproc;
+	platform_set_drvdata(pdev, wcnss);
+
+	init_completion(&wcnss->start_done);
+	init_completion(&wcnss->stop_done);
+
+	mutex_init(&wcnss->iris_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (!mmio) {
+		ret = -ENOMEM;
+		goto free_rproc;
+	};
+
+	ret = wcnss_alloc_memory_region(wcnss);
+	if (ret)
+		goto free_rproc;
+
+	wcnss->pmu_cfg = mmio + data->pmu_offset;
+	wcnss->spare_out = mmio + data->spare_offset;
+
+	ret = wcnss_init_regulators(wcnss, data->vregs, data->num_vregs);
+	if (ret)
+		goto free_rproc;
+
+	ret = wcnss_request_irq(wcnss, pdev, "wdog", false, wcnss_wdog_interrupt);
+	if (ret < 0)
+		goto free_rproc;
+	wcnss->wdog_irq = ret;
+
+	ret = wcnss_request_irq(wcnss, pdev, "fatal", false, wcnss_fatal_interrupt);
+	if (ret < 0)
+		goto free_rproc;
+	wcnss->fatal_irq = ret;
+
+	ret = wcnss_request_irq(wcnss, pdev, "ready", true, wcnss_ready_interrupt);
+	if (ret < 0)
+		goto free_rproc;
+	wcnss->ready_irq = ret;
+
+	ret = wcnss_request_irq(wcnss, pdev, "handover", true, wcnss_handover_interrupt);
+	if (ret < 0)
+		goto free_rproc;
+	wcnss->handover_irq = ret;
+
+	ret = wcnss_request_irq(wcnss, pdev, "stop-ack", true, wcnss_stop_ack_interrupt);
+	if (ret < 0)
+		goto free_rproc;
+	wcnss->stop_ack_irq = ret;
+
+	if (wcnss->stop_ack_irq) {
+		wcnss->state = qcom_smem_state_get(&pdev->dev, "stop",
+						   &wcnss->stop_bit);
+		if (IS_ERR(wcnss->state)) {
+			ret = PTR_ERR(wcnss->state);
+			goto free_rproc;
+		}
+	}
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto free_rproc;
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+
+free_rproc:
+	rproc_put(rproc);
+
+	return ret;
+}
+
+static int wcnss_remove(struct platform_device *pdev)
+{
+	struct qcom_wcnss *wcnss = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+
+	qcom_smem_state_put(wcnss->state);
+	rproc_put(wcnss->rproc);
+
+	return 0;
+}
+
+static const struct of_device_id wcnss_of_match[] = {
+	{ .compatible = "qcom,riva-pil", &riva_data },
+	{ .compatible = "qcom,pronto-v1-pil", &pronto_v1_data },
+	{ .compatible = "qcom,pronto-v2-pil", &pronto_v2_data },
+	{ },
+};
+
+static struct platform_driver wcnss_driver = {
+	.probe = wcnss_probe,
+	.remove = wcnss_remove,
+	.driver = {
+		.name = "qcom-wcnss-pil",
+		.of_match_table = wcnss_of_match,
+	},
+};
+
+module_platform_driver(wcnss_driver);
diff --git a/drivers/remoteproc/qcom_wcnss.h b/drivers/remoteproc/qcom_wcnss.h
new file mode 100644
index 000000000000..9dc4a9fe41e1
--- /dev/null
+++ b/drivers/remoteproc/qcom_wcnss.h
@@ -0,0 +1,22 @@
+#ifndef __QCOM_WNCSS_H__
+#define __QCOM_WNCSS_H__
+
+struct qcom_iris;
+struct qcom_wcnss;
+
+struct wcnss_vreg_info {
+	const char * const name;
+	int min_voltage;
+	int max_voltage;
+
+	int load_uA;
+
+	bool super_turbo;
+};
+
+int qcom_iris_enable(struct qcom_iris *iris);
+void qcom_iris_disable(struct qcom_iris *iris);
+
+void qcom_wcnss_assign_iris(struct qcom_wcnss *wcnss, struct qcom_iris *iris, bool use_48mhz_xo);
+
+#endif
diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
new file mode 100644
index 000000000000..62a37583c0f8
--- /dev/null
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -0,0 +1,185 @@
+/*
+ * Qualcomm Peripheral Image Loader
+ *
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2014 Sony Mobile Communications AB
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/qcom_scm.h>
+#include <linux/regulator/consumer.h>
+
+#include "qcom_wcnss.h"
+
+struct qcom_iris {
+	struct device *dev;
+
+	struct clk *xo_clk;
+
+	struct regulator_bulk_data *vregs;
+	size_t num_vregs;
+};
+
+struct iris_data {
+	const struct wcnss_vreg_info *vregs;
+	size_t num_vregs;
+
+	bool use_48mhz_xo;
+};
+
+static const struct iris_data wcn3620_data = {
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddxo",  1800000, 1800000, 10000 },
+		{ "vddrfa", 1300000, 1300000, 100000 },
+		{ "vddpa",  3300000, 3300000, 515000 },
+		{ "vdddig", 1800000, 1800000, 10000 },
+	},
+	.num_vregs = 4,
+	.use_48mhz_xo = false,
+};
+
+static const struct iris_data wcn3660_data = {
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddxo",  1800000, 1800000, 10000 },
+		{ "vddrfa", 1300000, 1300000, 100000 },
+		{ "vddpa",  2900000, 3000000, 515000 },
+		{ "vdddig", 1200000, 1225000, 10000 },
+	},
+	.num_vregs = 4,
+	.use_48mhz_xo = true,
+};
+
+static const struct iris_data wcn3680_data = {
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddxo",  1800000, 1800000, 10000 },
+		{ "vddrfa", 1300000, 1300000, 100000 },
+		{ "vddpa",  3300000, 3300000, 515000 },
+		{ "vdddig", 1800000, 1800000, 10000 },
+	},
+	.num_vregs = 4,
+	.use_48mhz_xo = true,
+};
+
+int qcom_iris_enable(struct qcom_iris *iris)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(iris->num_vregs, iris->vregs);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(iris->xo_clk);
+	if (ret) {
+		dev_err(iris->dev, "failed to enable xo clk\n");
+		goto disable_regulators;
+	}
+
+	return 0;
+
+disable_regulators:
+	regulator_bulk_disable(iris->num_vregs, iris->vregs);
+
+	return ret;
+}
+
+void qcom_iris_disable(struct qcom_iris *iris)
+{
+	clk_disable_unprepare(iris->xo_clk);
+	regulator_bulk_disable(iris->num_vregs, iris->vregs);
+}
+
+static int qcom_iris_probe(struct platform_device *pdev)
+{
+	const struct iris_data *data;
+	struct qcom_wcnss *wcnss;
+	struct qcom_iris *iris;
+	int ret;
+	int i;
+
+	iris = devm_kzalloc(&pdev->dev, sizeof(struct qcom_iris), GFP_KERNEL);
+	if (!iris)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(&pdev->dev);
+	wcnss = dev_get_drvdata(pdev->dev.parent);
+
+	iris->xo_clk = devm_clk_get(&pdev->dev, "xo");
+	if (IS_ERR(iris->xo_clk)) {
+		if (PTR_ERR(iris->xo_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to acquire xo clk\n");
+		return PTR_ERR(iris->xo_clk);
+	}
+
+	iris->num_vregs = data->num_vregs;
+	iris->vregs = devm_kcalloc(&pdev->dev,
+				   iris->num_vregs,
+				   sizeof(struct regulator_bulk_data),
+				   GFP_KERNEL);
+	if (!iris->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < iris->num_vregs; i++)
+		iris->vregs[i].supply = data->vregs[i].name;
+
+	ret = devm_regulator_bulk_get(&pdev->dev, iris->num_vregs, iris->vregs);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get regulators\n");
+		return ret;
+	}
+
+	for (i = 0; i < iris->num_vregs; i++) {
+		if (data->vregs[i].max_voltage)
+			regulator_set_voltage(iris->vregs[i].consumer,
+					      data->vregs[i].min_voltage,
+					      data->vregs[i].max_voltage);
+
+		if (data->vregs[i].load_uA)
+			regulator_set_load(iris->vregs[i].consumer,
+					   data->vregs[i].load_uA);
+	}
+
+	qcom_wcnss_assign_iris(wcnss, iris, data->use_48mhz_xo);
+
+	return 0;
+}
+
+static int qcom_iris_remove(struct platform_device *pdev)
+{
+	struct qcom_wcnss *wcnss = dev_get_drvdata(pdev->dev.parent);
+
+	qcom_wcnss_assign_iris(wcnss, NULL, false);
+
+	return 0;
+}
+
+static const struct of_device_id iris_of_match[] = {
+	{ .compatible = "qcom,wcn3620", .data = &wcn3620_data },
+	{ .compatible = "qcom,wcn3660", .data = &wcn3660_data },
+	{ .compatible = "qcom,wcn3680", .data = &wcn3680_data },
+	{}
+};
+
+static struct platform_driver wcnss_driver = {
+	.probe = qcom_iris_probe,
+	.remove = qcom_iris_remove,
+	.driver = {
+		.name = "qcom-iris",
+		.of_match_table = iris_of_match,
+	},
+};
+
+module_platform_driver(wcnss_driver);
-- 
2.5.0

Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B491C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:17:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE112081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GKdGs5PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE112081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X6a/K6k8RvSNU7eGLdyudmnRkBMO4Ds6vX3+al9ZmWA=; b=GKdGs5PIc9Ihxj
	Y2T7raY0D5gjZA+gGqIHC06uhOPnb92r+FAHN6hZV8DTuC+xNG9KiiFXWZVDBCwJWBpgncw3KVHeq
	a8ZPKw2KTyhfvbnp6WyAKvGjg8l5iBq6U3a+N912a2F4l7nc+7dNYuUXsMqDvwfvJ5DJhi7vJHOTE
	D0otibBpojGNzaOSYEDpwoZMKVewGZEZ5p1eIhsd/a6/sD9gtoNUNVwfVcFVDmTswrPbYGTR6tkU5
	dpS+L3gwWmO7tC6yqcyVkrKBzmsoiCILKXFVR155I4Rnza+tQHxp5xsAjV5MLjZAOwz1NDbp4+AJb
	9gux7SksecYIPQU9FQCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqdBx-0004g6-Ih; Mon, 04 Feb 2019 12:17:37 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqdB7-0003rp-Lm
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 12:16:56 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 59DE0EA862AB0E863714;
 Mon,  4 Feb 2019 20:16:43 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Mon, 4 Feb 2019 20:16:35 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
Subject: [PATCH v6 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800
 quirk
Date: Mon, 4 Feb 2019 12:13:24 +0000
Message-ID: <20190204121324.11460-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_041647_660752_13E83603 
X-CRM114-Status: GOOD (  17.24  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, neil.m.leeder@gmail.com,
 jean-philippe.brucker@arm.com, pabba@codeaurora.org, john.garry@huawei.com,
 will.deacon@arm.com, rruigrok@codeaurora.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, guohanjun@huawei.com,
 andrew.murray@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HiSilicon erratum 162001800 describes the limitation of
SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.

On these platforms, the PMCG event counter registers
(SMMU_PMCG_EVCNTRn) are read only and as a result it
is not possible to set the initial counter period value
on event monitor start.

To work around this, the current value of the counter
is read and used for delta calculations. OEM information
from ACPI header is used to identify the affected hardware
platforms.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
 drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
 include/linux/acpi_iort.h     |  1 +
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e2c9b26..4dc68de 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1366,9 +1366,23 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 				       ACPI_EDGE_SENSITIVE, &res[2]);
 }
 
+static struct acpi_platform_list pmcg_plat_info[] __initdata = {
+	/* HiSilicon Hip08 Platform */
+	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,
+	 IORT_SMMU_V3_PMCG_HISI_HIP08},
+	{ }
+};
+
 static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
 {
-	u32 model = IORT_SMMU_V3_PMCG_GENERIC;
+	u32 model;
+	int idx;
+
+	idx = acpi_match_platform_list(pmcg_plat_info);
+	if (idx >= 0)
+		model = pmcg_plat_info[idx].data;
+	else
+		model = IORT_SMMU_V3_PMCG_GENERIC;
 
 	return platform_device_add_data(pdev, &model, sizeof(model));
 }
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index eeb9dee..95a3ed0 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -35,6 +35,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpuhotplug.h>
@@ -93,6 +94,8 @@
 
 #define SMMU_PMCG_PA_SHIFT              12
 
+#define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+
 static int cpuhp_state_num;
 
 struct smmu_pmu {
@@ -107,6 +110,7 @@ struct smmu_pmu {
 	struct device *dev;
 	void __iomem *reg_base;
 	void __iomem *reloc_base;
+	u32 options;
 	u64 counter_mask;
 	bool global_filter;
 	u32 global_filter_span;
@@ -222,15 +226,27 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
 	u32 idx = hwc->idx;
 	u64 new;
 
-	/*
-	 * We limit the max period to half the max counter value of the counter
-	 * size, so that even in the case of extreme interrupt latency the
-	 * counter will (hopefully) not wrap past its initial value.
-	 */
-	new = smmu_pmu->counter_mask >> 1;
+	if (smmu_pmu->options & SMMU_PMCG_EVCNTR_RDONLY) {
+		/*
+		 * On platforms that require this quirk, if the counter starts
+		 * at < half_counter value and wraps, the current logic of
+		 * handling the overflow may not work. It is expected that,
+		 * those platforms will have full 64 counter bits implemented
+		 * so that such a possibility is remote(eg: HiSilicon HIP08).
+		 */
+		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
+	} else {
+		/*
+		 * We limit the max period to half the max counter value
+		 * of the counter size, so that even in the case of extreme
+		 * interrupt latency the counter will (hopefully) not wrap
+		 * past its initial value.
+		 */
+		new = smmu_pmu->counter_mask >> 1;
+		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
+	}
 
 	local64_set(&hwc->prev_count, new);
-	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
 }
 
 static void smmu_pmu_set_event_filter(struct perf_event *event,
@@ -674,6 +690,22 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
 }
 
+static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
+{
+	u32 model;
+
+	model = *(u32 *)dev_get_platdata(smmu_pmu->dev);
+
+	switch (model) {
+	case IORT_SMMU_V3_PMCG_HISI_HIP08:
+		/* HiSilicon Erratum 162001800 */
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		break;
+	}
+
+	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
+}
+
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
@@ -752,6 +784,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	smmu_pmu_get_acpi_options(smmu_pmu);
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = get_cpu();
 	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 832bd6a..bdb6912 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -31,6 +31,7 @@
  * that, this is not part of the IORT specification.
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

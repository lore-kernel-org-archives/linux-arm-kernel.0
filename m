Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C06C282DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:05:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AA220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="StVDzOZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AA220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NjvJU/ztgfb6m3A309axX8MWFj7gbzCULAPy85YFmzY=; b=StVDzOZloV+1t8
	5RaoDLBwGT4/+t1mIr4lqONNa2MRyh7PlFQMgEyef7QPHCcKOeHaXXqXQBDB/IrjQ0t7CijcxFPAV
	++Qw9fwtpL+w9rOIv1vlob5JblG2p/XVYTaHxRtJvCmK9hxYmVD//9VTNLAlhBBrT26t06E3v8rLh
	gkP1nR2/E0rM/v6OVs07sEBH3XLe1dhRrTqQwmgiIRBQvaZih84a1zmh3QhJb90iegMkpMjlTfPwJ
	WowwmnRIrQS3pYWfhv6ItN99mBX+GJSIRcg62KCLf6j9T+0REKhRleqyUf2Mse0rwD5YI1VKpoC4O
	cN6jRavlbL+GPyM55jIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotIo-00053M-0g; Wed, 30 Jan 2019 17:05:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotIj-00052B-IO
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:05:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B18F315AD;
 Wed, 30 Jan 2019 09:05:24 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16823F589;
 Wed, 30 Jan 2019 09:05:22 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 nm@ti.com, sboyd@kernel.org, mka@chromium.org
Subject: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Date: Wed, 30 Jan 2019 17:05:02 +0000
Message-Id: <20190130170506.20450-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130170506.20450-1-quentin.perret@arm.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_090525_614049_51EB6363 
X-CRM114-Status: GOOD (  19.31  )
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
Cc: quentin.perret@arm.com, dietmar.eggemann@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Energy Model (EM) framework provides an API to let drivers register
the active power of CPUs. The drivers are expected to provide a callback
method which estimates the power consumed by a CPU at each available
performance levels. How exactly this should be implemented, however,
depends on the platform.

On some systems, PM_OPP knows the voltage and frequency at which CPUs
can run. When coupled with the CPU 'capacitance' (as provided by the
'dynamic-power-coefficient' devicetree binding), it is possible to
estimate the dynamic power consumption of a CPU as P = C * V^2 * f, with
C its capacitance and V and f respectively the voltage and frequency of
the OPP. The Intelligent Power Allocator (IPA) thermal governor already
implements that estimation method, in the thermal framework.

However, this power estimation method can be applied to any platform
where all the parameters are known (C, V and f), and not only those
suffering thermal issues. As such, the code implementing this feature
can be re-used to also populate the EM framework now used by EAS.

As a first step, introduce in PM_OPP a helper function which CPUFreq
drivers can use to register into the EM framework. This duplicates the
power estimation done in IPA until it can be migrated to using the EM
framework. This will be done later, once the EM framework has support
for at least all platforms currently supported by IPA.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---

Matthias: Given this patch changed a bit I dropped your Reviewed-by and
Tested-by, but let me know if you think they still hold.
---
 drivers/opp/of.c       | 88 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 +++
 2 files changed, 94 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..4c8bf172e9ed 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -20,6 +20,7 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/energy_model.h>
 
 #include "opp.h"
 
@@ -1047,3 +1048,90 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 	return of_node_get(opp->np);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
+
+/*
+ * Callback function provided to the Energy Model framework upon registration.
+ * This computes the power estimated by @CPU at the first OPP above @kHz (ceil),
+ * and updates @kHz and @mW accordingly. The power is estimated as
+ * P = C * V^2 * f with C being the CPU's capacitance and V and f respectively
+ * the voltage and frequency of the OPP.
+ *
+ * Returns -ENODEV if the CPU device cannot be found, -EINVAL if the power
+ * calculation failed because of missing parameters, 0 otherwise.
+ */
+static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
+					 int cpu)
+{
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	struct device_node *np;
+	unsigned long mV, Hz;
+	u32 cap;
+	u64 tmp;
+	int ret;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
+	of_node_put(np);
+	if (ret)
+		return -EINVAL;
+
+	Hz = *kHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	mV = dev_pm_opp_get_voltage(opp) / 1000;
+	dev_pm_opp_put(opp);
+	if (!mV)
+		return -EINVAL;
+
+	tmp = (u64)cap * mV * mV * (Hz / 1000000);
+	do_div(tmp, 1000000000);
+
+	*mW = (unsigned long)tmp;
+	*kHz = Hz / 1000;
+
+	return 0;
+}
+
+/**
+ * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
+ * @cpus	: CPUs for which an Energy Model has to be registered
+ * @nr_opp	: Number of OPPs to register in the Energy Model
+ *
+ * This checks whether the "dynamic-power-coefficient" devicetree binding has
+ * been specified, and tries to register an Energy Model with it if it has.
+ */
+void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
+{
+	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
+	int ret, cpu = cpumask_first(cpus);
+	struct device *cpu_dev;
+	struct device_node *np;
+	u32 cap;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np)
+		return;
+
+	/* Don't register an EM without the right DT binding */
+	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
+	of_node_put(np);
+	if (ret || !cap)
+		return;
+
+	em_register_perf_domain(cpus, nr_opp, &em_cb);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b895f4e79868..58ae08b024bd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
+void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
 }
+
+static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
+{
+}
+
 static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	return -ENOTSUPP;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

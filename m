Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F12EC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609332147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kp/MoPIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609332147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=80EXZ57zITYPYwsHXavCj2HxuuV7MuNdhfOwft9FC8k=; b=Kp/MoPIWXa8Itw
	r3kxYcfTZKFlwlZ1lGtLZyxirXR/CCnaIUY7oQ9vElpNhLR7TPGzK1+ah71y4Nj13i8uLvJwcr/1p
	TsSxy9GXT+3cm40QS4lTaNnfgENQDTBXKSMrPhMW5YKg70gN0h2KBwyy9lISzFH5CZnFAmOBrqj/D
	dA44/65BdPiPVaEBgZj+nDNKyrn/Wf2IMYcXVFvj7O84s8NZfb2HnDL2fUKMb+WD4eNE/4GMibFJx
	i2EoYFR5KGDbZ94ebKd1fvaCFmPmFUtf1wfZn9ZEbN4mutCNoDlVLMupFuFlP0tOLnAJ0cV6AyJN0
	g5TeLcZQryy7J0YQ4aMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goACX-0008JZ-JE; Mon, 28 Jan 2019 16:56:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goAC5-0007tY-G0
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:55:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B1B815AD;
 Mon, 28 Jan 2019 08:55:33 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD37B3F59C;
 Mon, 28 Jan 2019 08:55:30 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
 liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Subject: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Date: Mon, 28 Jan 2019 16:55:16 +0000
Message-Id: <20190128165522.31749-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128165522.31749-1-quentin.perret@arm.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_085533_541219_42E8BFED 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.perret@arm.com, mka@chromium.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
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
 drivers/opp/of.c       | 60 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  5 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..7572a2eb2fd4 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1047,3 +1047,63 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 	return of_node_get(opp->np);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
+
+/**
+ * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
+ * @mW:		pointer to the power estimate in milli-watts
+ * @KHz:	pointer to the OPP's frequency, in kilo-hertz
+ * @cpu:	CPU for which power needs to be estimated
+ *
+ * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
+ * and updates @KHz and @mW accordingly.
+ *
+ * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
+ * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
+ * respectively the voltage and frequency of the OPP.
+ *
+ * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
+ * calculation failed because of missing parameters, 0 otherwise.
+ */
+int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
+{
+	unsigned long mV, Hz, MHz;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	struct device_node *np;
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
+	Hz = *KHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	mV = dev_pm_opp_get_voltage(opp) / 1000;
+	dev_pm_opp_put(opp);
+	if (!mV)
+		return -EINVAL;
+
+	MHz = Hz / 1000000;
+	tmp = (u64)cap * mV * mV * MHz;
+	do_div(tmp, 1000000000);
+
+	*mW = (unsigned long)tmp;
+	*KHz = Hz / 1000;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0a2a88e5a383..fedde14f5187 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
+int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
 {
 	return -ENOTSUPP;
 }
+static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

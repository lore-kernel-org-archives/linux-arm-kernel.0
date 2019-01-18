Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC8EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:14:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2248E2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jek4O9XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2248E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YDWsMPKzMyxepfpwX7zlVXkMO1O42JHURKCVv8/rF5A=; b=jek4O9XJlFePTM
	mAzYkBpvXmqNi1qHAxa6skHy0PYeG98Kb7O5BEo/x0vZkGzXc88FjMF9VlaSkZRMDAkkBeWwK1M/v
	498vCMpnF5F3dAtb05RmiXkhtqkBdech4b289Tc2DfQRpdSws+16NZKjD5WeywQ1vKhjuMwYtAgOS
	NewgG0U1k3RCncJWS0bAMeRE5K4gJy2e+s1oYDoF4GBYpIgd3j+K+qGU3zuT4PlXWmzpE4mpBZonn
	mUtlfWGC7AOO+g+AQ9fW1byTheB8+URd1BYf1DuKm/TFfLFObA2b3lwG1a5gv8058sBRNFgWJrtYG
	A9ofwkoB6D3bAtPqa/Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUuK-0000P1-1S; Fri, 18 Jan 2019 14:14:04 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUtn-0008LD-8W
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:13:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EC2B9207B6; Fri, 18 Jan 2019 15:13:29 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 81B1B207A3;
 Fri, 18 Jan 2019 15:13:29 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v5 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Fri, 18 Jan 2019 15:11:40 +0100
Message-Id: <20190118141140.30352-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118141140.30352-1-gregory.clement@bootlin.com>
References: <20190118141140.30352-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_061331_569149_196E34EB 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add cpufreq driver for Marvell AP-806 found on Aramda 8K.
The AP-806 has DFS (Dynamic Frequency Scaling) with coupled
clock domain for two clusters, so this driver will directly
use generic cpufreq-dt driver as backend.

Based on the work of Omri Itach <omrii@marvell.com>.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/cpufreq/Kconfig.arm         |  11 ++
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/armada-8k-cpufreq.c | 203 ++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 688f10227793..10bc5c798d17 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -25,6 +25,17 @@ config ARM_ARMADA_37XX_CPUFREQ
 	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
 	  The Armada 37xx PMU supports 4 frequency and VDD levels.
 
+config ARM_ARMADA_8K_CPUFREQ
+	tristate "Armada 8K CPUFreq driver"
+	depends on ARCH_MVEBU && CPUFREQ_DT
+	help
+	  This enables the CPUFreq driver support for Marvell
+	  Armada8k SOCs.
+	  Armada8K device has the AP806 which supports scaling
+	  to any full integer divider.
+
+	  If in doubt, say N.
+
 # big LITTLE core layer and glue drivers
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 08c071be2491..689b26c6f949 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_X86_SFI_CPUFREQ)		+= sfi-cpufreq.o
 obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
 
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
+obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
new file mode 100644
index 000000000000..80375de4e149
--- /dev/null
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CPUFreq support for Armada 8K
+ *
+ * Copyright (C) 2018 Marvell
+ *
+ * Omri Itach <omrii@marvell.com>
+ * Gregory Clement <gregory.clement@bootlin.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+/*
+ * Setup the opps list with the divider for the max frequency, that
+ * will be filled at runtime.
+ */
+static const int opps_div[] __initconst = {1, 2, 3, 4};
+
+static struct platform_device *armada_8k_pdev;
+
+struct freq_table {
+	struct device *cpu_dev;
+	unsigned int freq[ARRAY_SIZE(opps_div)];
+};
+
+/* If the CPUs share the same clock, then they are in the same cluster. */
+static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
+					      struct cpumask *cpumask)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev;
+		struct clk *clk;
+
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_warn("Failed to get cpu%d device\n", cpu);
+			continue;
+		}
+
+		clk = clk_get(cpu_dev, 0);
+		if (IS_ERR(clk))
+			pr_warn("Cannot get clock for CPU %d\n", cpu);
+		else if (clk_is_match(clk, cur_clk))
+			cpumask_set_cpu(cpu, cpumask);
+
+		if (!IS_ERR(clk))
+			clk_put(clk);
+	}
+}
+
+static int __init armada_8k_add_opp(struct clk *clk, struct device *cpu_dev,
+				    struct freq_table *freq_tables,
+				    int opps_index)
+{
+	unsigned int cur_frequency;
+	unsigned int freq;
+	int i, ret;
+
+	/* Get nominal (current) CPU frequency. */
+	cur_frequency = clk_get_rate(clk);
+	if (!cur_frequency) {
+		dev_err(cpu_dev, "Failed to get clock rate for this CPU\n");
+		return -EINVAL;
+	}
+
+	freq_tables[opps_index].cpu_dev = cpu_dev;
+
+	for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
+		freq = cur_frequency / opps_div[i];
+
+		ret = dev_pm_opp_add(cpu_dev, freq, 0);
+		if (ret)
+			return ret;
+
+		freq_tables[opps_index].freq[i] = freq;
+	}
+
+	return 0;
+}
+
+static void armada_8k_cpufreq_free_table(struct freq_table *freq_tables)
+{
+	int opps_index, nb_cpus = num_possible_cpus();
+
+	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
+		int i;
+
+		/* If cpu_dev is NULL then we reached the end of the array */
+		if (!freq_tables[opps_index].cpu_dev)
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
+			/*
+			 * A 0Hz frequency is not valid, this meant
+			 * that it was not yet initialized so there is
+			 * no more opp to free
+			 */
+			if (freq_tables[opps_index].freq[i] == 0)
+				break;
+
+			dev_pm_opp_remove(freq_tables[opps_index].cpu_dev,
+					  freq_tables[opps_index].freq[i]);
+		}
+	}
+
+	kfree(freq_tables);
+}
+
+static int __init armada_8k_cpufreq_init(void)
+{
+	int ret = 0, opps_index = 0, cpu, nb_cpus;
+	struct freq_table *freq_tables;
+	struct device_node *node;
+	struct cpumask cpus;
+
+	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
+	if (!node || !of_device_is_available(node))
+		return -ENODEV;
+
+	nb_cpus = num_possible_cpus();
+	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
+	cpumask_copy(&cpus, cpu_possible_mask);
+
+	/*
+	 * For each CPU, this loop registers the operating points
+	 * supported (which are the nominal CPU frequency and full integer
+	 * divisions of it).
+	 */
+	for_each_cpu(cpu, &cpus) {
+		struct cpumask shared_cpus;
+		struct device *cpu_dev;
+		struct clk *clk;
+
+		cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev) {
+			pr_err("Cannot get CPU %d\n", cpu);
+			continue;
+		}
+
+		clk = clk_get(cpu_dev, 0);
+
+		if (IS_ERR(clk)) {
+			pr_err("Cannot get clock for CPU %d\n", cpu);
+			ret = PTR_ERR(clk);
+			goto remove_opp;
+		}
+
+		ret = armada_8k_add_opp(clk, cpu_dev, freq_tables, opps_index);
+		if (ret) {
+			clk_put(clk);
+			goto remove_opp;
+		}
+
+		opps_index++;
+		cpumask_clear(&shared_cpus);
+		armada_8k_get_sharing_cpus(clk, &shared_cpus);
+		dev_pm_opp_set_sharing_cpus(cpu_dev, &shared_cpus);
+		cpumask_andnot(&cpus, &cpus, &shared_cpus);
+		clk_put(clk);
+	}
+
+	armada_8k_pdev = platform_device_register_simple("cpufreq-dt", -1,
+							 NULL, 0);
+	ret = PTR_ERR_OR_ZERO(armada_8k_pdev);
+	if (ret)
+		goto remove_opp;
+
+	platform_set_drvdata(armada_8k_pdev, freq_tables);
+
+	return 0;
+
+remove_opp:
+	armada_8k_cpufreq_free_table(freq_tables);
+	return ret;
+}
+module_init(armada_8k_cpufreq_init);
+
+static void __exit armada_8k_cpufreq_exit(void)
+{
+	struct freq_table *freq_tables = platform_get_drvdata(armada_8k_pdev);
+
+	armada_8k_cpufreq_free_table(freq_tables);
+	platform_device_unregister(armada_8k_pdev);
+}
+module_exit(armada_8k_cpufreq_exit);
+
+MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
+MODULE_DESCRIPTION("Armada 8K cpufreq driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

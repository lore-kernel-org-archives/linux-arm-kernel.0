Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59073C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:44:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2835C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EtBvcW4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2835C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pw4xeePYjx2saApO1OqQXTdslUs+KV7DXJFp6Tf3s4c=; b=EtBvcW4fW1msok
	sK7I2RuChP1xdnGjLDp/HKzhXBQjgU8O5sIFbCQ56K9zob1sGgEcem/vnwoOGHapBTdmCox+ZlK0f
	5jMLOx4qX1yhGfLvwjClAJwjc1lRcoRYJiOQ4dWz4GVRQUkTJdz6TYLa5mmt3p+5AcaczhV/Z0XeZ
	CHl5WNKNol7Do8dxXOXyTXGaOQ798IIIVSU7IJ9qZDIzpLoQ1CixvyMIEXel3rH1vb7TcHEzmfBs9
	7dedzvXUrCET5tVJsrouP6W43JymyDXaqchbslUe9GtsTADmC7q4CwdhI9+KV7leYkFH/EfUhvf0D
	EoGhh9r8lP+fldaVrkuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl8w-0004CI-9R; Tue, 11 Dec 2018 16:44:22 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl8H-0003cS-8B
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:43:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9B8E320CE3; Tue, 11 Dec 2018 17:43:29 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4163720D92;
 Tue, 11 Dec 2018 17:43:01 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Tue, 11 Dec 2018 17:42:49 +0100
Message-Id: <20181211164249.26985-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211164249.26985-1-gregory.clement@bootlin.com>
References: <20181211164249.26985-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084341_577187_25B1F229 
X-CRM114-Status: GOOD (  19.32  )
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
 drivers/cpufreq/armada-8k-cpufreq.c | 186 ++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4e1131ef85ae..7e32a241760d 100644
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
index d5ee4562ed06..db1564b610ac 100644
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
index 000000000000..1db1953fb43e
--- /dev/null
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -0,0 +1,186 @@
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
+static struct freq_table *freq_tables;
+static int opps_index;
+
+struct freq_table {
+	struct device *cpu_dev;
+	struct clk *clk;
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
+		struct device *cpu_dev = get_cpu_device(cpu);
+		struct clk *clk = clk_get(cpu_dev, 0);
+
+		if (IS_ERR(clk))
+			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
+		else if (clk_is_match(clk, cur_clk))
+			cpumask_set_cpu(cpu, cpumask);
+
+		clk_put(clk);
+	}
+}
+
+static int armada_8k_add_opp(struct clk *clk, struct device *cpu_dev,
+			     struct freq_table *freq_tables, int opps_index)
+{
+	unsigned int cur_frequency;
+	unsigned int freq;
+	int i, ret;
+
+	/* Get nominal (current) CPU frequency. */
+	cur_frequency = clk_get_rate(clk);
+
+	if (!cur_frequency) {
+		dev_err(cpu_dev,
+			"Failed to get clock rate for this CPU\n");
+		return -EINVAL;
+	}
+
+	freq_tables[opps_index].cpu_dev = cpu_dev;
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
+static void armada_8k_cpufreq_free_table(void)
+{
+	opps_index--;
+	for (; opps_index >= 0; opps_index--) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(opps_div); i++)
+			dev_pm_opp_remove(freq_tables[opps_index].cpu_dev,
+					  freq_tables[opps_index].freq[i]);
+	}
+
+	kfree(freq_tables);
+}
+
+static int __init armada_8k_cpufreq_init(void)
+{
+	int ret = 0, cpu, nb_cpus;
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
+	if (!node || !of_device_is_available(node))
+		return -ENODEV;
+
+	nb_cpus = num_possible_cpus();
+	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
+	/*
+	 * For each CPU, this loop registers the operating points
+	 * supported (which are the nominal CPU frequency and full integer
+	 * divisions of it).
+	 */
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev;
+		struct cpumask cpus;
+		struct clk *clk;
+		int i, skip;
+
+		skip = 0;
+		cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev) {
+			dev_err(cpu_dev, "Cannot get CPU %d\n", cpu);
+			continue;
+		}
+
+		clk = devm_clk_get(cpu_dev, 0);
+
+		if (IS_ERR(clk)) {
+			dev_err(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
+			ret = PTR_ERR(clk);
+			goto remove_opp;
+		}
+
+		for (i = 0; i < nb_cpus; i++) {
+			if (clk_is_match(clk, freq_tables[i].clk)) {
+				skip = 1;
+				break;
+			}
+		}
+		if (skip) {
+			devm_clk_put(cpu_dev, clk);
+			continue;
+		}
+
+		freq_tables[opps_index].clk = clk;
+
+		ret = armada_8k_add_opp(clk, cpu_dev, freq_tables, opps_index);
+		if (ret)
+			goto remove_opp;
+
+		opps_index++;
+		cpumask_clear(&cpus);
+		armada_8k_get_sharing_cpus(clk, &cpus);
+		dev_pm_opp_set_sharing_cpus(cpu_dev, &cpus);
+	}
+
+	armada_8k_pdev = platform_device_register_simple("cpufreq-dt", -1,
+							 NULL, 0);
+	ret = PTR_ERR_OR_ZERO(armada_8k_pdev);
+	if (ret)
+		goto remove_opp;
+	return 0;
+
+remove_opp:
+	armada_8k_cpufreq_free_table();
+	return ret;
+}
+module_init(armada_8k_cpufreq_init);
+
+static void __exit armada_8k_cpufreq_exit(void)
+{
+	armada_8k_cpufreq_free_table();
+	platform_device_unregister(armada_8k_pdev);
+}
+module_exit(armada_8k_cpufreq_exit);
+
+MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
+MODULE_DESCRIPTION("Armada 8K cpufreq driver");
+MODULE_LICENSE("GPL");
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

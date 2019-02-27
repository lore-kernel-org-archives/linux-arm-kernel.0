Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D5DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:52:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDBE218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogARCcEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDBE218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9N11VZBKSEUGVOcOvjpd/9NMXx512L4m9zeqg6Nx/Tw=; b=ogA
	RCcEtW3N8Szw6NYqeHB5gYRozH+BWZkaZDq0/x85oJ7Ih1KeLecL5qY/YD2o/dYt25sgJH0P2MwKk
	JrBsC8eQRGhndbL+uLMyy9hbJ5L0JXb3pkyXOIGh81d+1je7PPqD1WnnSvOwqW0wSke6BuLzUyNBJ
	rDuixLr92IUQq4JmWaCPROeyqd0txpykmmxFSyQq0Fzg//4VtWQim+5tyQQqauMc4t7OF+y8WzCYa
	FN7WoaCPJVKGiQ7Sia+sjUXRfbQ3fLqnlS/5xuLK+ZDhi6OWJ9b9ygVGjjJMvQcpPMSz6axayoY0o
	/8OpZjsyIFEI1APU/UDbAmdnV5+kMjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrCS-0002dA-ON; Wed, 27 Feb 2019 04:52:08 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyrCJ-0002Up-EY
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 04:52:02 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 27 Feb 2019 13:51:57 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3EB8C180D46;
 Wed, 27 Feb 2019 13:51:57 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 27 Feb 2019 13:51:57 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id ED1B6403E2;
 Wed, 27 Feb 2019 13:51:56 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id B4B48121B6C;
 Wed, 27 Feb 2019 13:51:56 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org
Subject: [PATCH v4 04/10] ARM: milbeaut: Add basic support for Milbeaut m10v
 SoC
Date: Wed, 27 Feb 2019 13:52:33 +0900
Message-Id: <1551243153-10674-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_205200_185463_3ACC10E6 
X-CRM114-Status: GOOD (  22.53  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the basic M10V SoC support under arch/arm.
Since all cores are activated in the custom bootloader before booting
linux, it is necessary to wait for the secondary-cores using cpu-enable-
method and special sram.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/Kconfig                 |   2 +
 arch/arm/Makefile                |   1 +
 arch/arm/mach-milbeaut/Kconfig   |  20 ++++++
 arch/arm/mach-milbeaut/Makefile  |   1 +
 arch/arm/mach-milbeaut/platsmp.c | 143 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 26524b7..bf46372 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -750,6 +750,8 @@ source "arch/arm/mach-mediatek/Kconfig"
 
 source "arch/arm/mach-meson/Kconfig"
 
+source "arch/arm/mach-milbeaut/Kconfig"
+
 source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9db3c58..00000e9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -190,6 +190,7 @@ machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
 machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
+machine-$(CONFIG_ARCH_MILBEAUT)		+= milbeaut
 machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
diff --git a/arch/arm/mach-milbeaut/Kconfig b/arch/arm/mach-milbeaut/Kconfig
new file mode 100644
index 0000000..6a576fd
--- /dev/null
+++ b/arch/arm/mach-milbeaut/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig ARCH_MILBEAUT
+	bool "Socionext Milbeaut SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	help
+	  This enables support for Socionext Milbeaut SoCs
+
+if ARCH_MILBEAUT
+
+config ARCH_MILBEAUT_M10V
+	bool "Milbeaut SC2000/M10V platform"
+	select ARM_ARCH_TIMER
+	select MILBEAUT_TIMER
+	select PINCTRL
+	select PINCTRL_MILBEAUT
+	help
+	  Support for Socionext's MILBEAUT M10V based systems
+
+endif
diff --git a/arch/arm/mach-milbeaut/Makefile b/arch/arm/mach-milbeaut/Makefile
new file mode 100644
index 0000000..ce5ea06
--- /dev/null
+++ b/arch/arm/mach-milbeaut/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
new file mode 100644
index 0000000..591543c
--- /dev/null
+++ b/arch/arm/mach-milbeaut/platsmp.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright:	(C) 2018 Socionext Inc.
+ * Copyright:	(C) 2015 Linaro Ltd.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/of_address.h>
+#include <linux/suspend.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/idmap.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+#define M10V_MAX_CPU	4
+#define KERNEL_UNBOOT_FLAG	0x12345678
+
+static void __iomem *m10v_smp_base;
+
+static int m10v_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	if (!m10v_smp_base)
+		return -ENXIO;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	if (cpu >= M10V_MAX_CPU)
+		return -EINVAL;
+
+	pr_info("%s: cpu %u l_cpu %u cluster %u\n",
+			__func__, cpu, l_cpu, cluster);
+
+	writel(__pa_symbol(secondary_startup), m10v_smp_base + cpu * 4);
+	arch_send_wakeup_ipi_mask(cpumask_of(l_cpu));
+
+	return 0;
+}
+
+static void m10v_smp_init(unsigned int max_cpus)
+{
+	unsigned int mpidr, cpu, cluster;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "socionext,milbeaut-smp-sram");
+	if (!np)
+		return;
+
+	m10v_smp_base = of_iomap(np, 0);
+	if (!m10v_smp_base)
+		return;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_info("MCPM boot on cpu_%u cluster_%u\n", cpu, cluster);
+
+	for (cpu = 0; cpu < M10V_MAX_CPU; cpu++)
+		writel(KERNEL_UNBOOT_FLAG, m10v_smp_base + cpu * 4);
+}
+
+static void m10v_cpu_die(unsigned int l_cpu)
+{
+	gic_cpu_if_down(0);
+	v7_exit_coherency_flush(louis);
+	wfi();
+}
+
+static int m10v_cpu_kill(unsigned int l_cpu)
+{
+	unsigned int mpidr, cpu;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+
+	writel(KERNEL_UNBOOT_FLAG, m10v_smp_base + cpu * 4);
+
+	return 1;
+}
+
+static struct smp_operations m10v_smp_ops __initdata = {
+	.smp_prepare_cpus	= m10v_smp_init,
+	.smp_boot_secondary	= m10v_boot_secondary,
+	.cpu_die		= m10v_cpu_die,
+	.cpu_kill		= m10v_cpu_kill,
+};
+CPU_METHOD_OF_DECLARE(m10v_smp, "socionext,milbeaut-m10v-smp", &m10v_smp_ops);
+
+static int m10v_pm_valid(suspend_state_t state)
+{
+	return (state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM);
+}
+
+typedef void (*phys_reset_t)(unsigned long);
+static phys_reset_t phys_reset;
+
+static int m10v_die(unsigned long arg)
+{
+	setup_mm_for_reboot();
+	asm("wfi");
+	/* Boot just like a secondary */
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(virt_to_phys(cpu_resume));
+
+	return 0;
+}
+
+static int m10v_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		asm("wfi");
+		break;
+	case PM_SUSPEND_MEM:
+		cpu_pm_enter();
+		cpu_suspend(0, m10v_die);
+		cpu_pm_exit();
+		break;
+	}
+	return 0;
+}
+
+static const struct platform_suspend_ops m10v_pm_ops = {
+	.valid		= m10v_pm_valid,
+	.enter		= m10v_pm_enter,
+};
+
+struct clk *m10v_clclk_register(struct device *cpu_dev);
+
+static int __init m10v_pm_init(void)
+{
+	if (of_machine_is_compatible("socionext,milbeaut-evb"))
+		suspend_set_ops(&m10v_pm_ops);
+
+	return 0;
+}
+late_initcall(m10v_pm_init);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:04:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160382084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXvbCVsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160382084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=14oEP2cbdkprftreDAishbg96W+vw9XdCin2QBLiU8E=; b=kXvbCVsTaYxT0p
	+8whitIt2sU3MWXwvWpYCklTVxKUst3Dj+H4NdDqmzVWPFb2pli/Qdr1QsSzufN31FmzPgNkpf+hT
	1LS/DNZd+pFqYySicQBDWxUp5+AXDibmporrs4Xq7BKQjfph66cV6L2zvVAyAGz3x9tVZKgMylghz
	NOmHBUzKyjXHtI6yWopftdQBFGvQ2NCe/yWgz9NgbadATp5nDYMotaP0X9cks/cQBl9Jqyx0I++qM
	/+labm9ggcHPytrsYn4DVkEXRxGwKGmxHknLr0AOOJKUdFks3yN/xwS4vj7kTxWYqNjNk9ikbb1Xx
	L/FYHiVZEUFA1U8SGbmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX63f-0007ld-Rm; Wed, 12 Dec 2018 15:04:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62e-0006Rk-Fb
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54210EBD;
 Wed, 12 Dec 2018 07:03:11 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0FA3F59C;
 Wed, 12 Dec 2018 07:03:09 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 07/12] arm64: Retrieve stolen time as paravirtualized
 guest
Date: Wed, 12 Dec 2018 15:02:21 +0000
Message-Id: <20181212150226.38051-8-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070317_022401_15D6129E 
X-CRM114-Status: GOOD (  19.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable paravirtualization features when running under a hypervisor
supporting the PV_TIME_ST hypercall.

For each (v)CPU, we ask the hypervisor for the location of a shared
page which the hypervisor will use to report stolen time to us. We set
pv_time_ops to the stolen time function which simply reads the stolen
value from the shared page for a VCPU. We guarantee single-copy
atomicity using READ_ONCE which means we can also read the stolen
time for another VCPU than the currently running one while it is
potentially being updated by the hypervisor.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kernel/Makefile |   1 +
 arch/arm64/kernel/kvm.c    | 156 +++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h |   1 +
 3 files changed, 158 insertions(+)
 create mode 100644 arch/arm64/kernel/kvm.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4c8b13bede80..daaed14ed7a4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -57,6 +57,7 @@ arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 arm64-obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
 arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
+arm64-obj-$(CONFIG_PARAVIRT)		+= kvm.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/kvm.c b/arch/arm64/kernel/kvm.c
new file mode 100644
index 000000000000..f7bc1f069dc0
--- /dev/null
+++ b/arch/arm64/kernel/kvm.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Arm Ltd.
+
+#define pr_fmt(fmt) "kvmarm-pv: " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/cpuhotplug.h>
+#include <linux/io.h>
+#include <linux/printk.h>
+#include <linux/psci.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+
+#include <asm/paravirt.h>
+#include <asm/pvclock-abi.h>
+#include <asm/smp_plat.h>
+
+struct kvmarm_stolen_time_region {
+	struct pvclock_vcpu_stolen_time_info *kaddr;
+};
+
+static DEFINE_PER_CPU(struct kvmarm_stolen_time_region, stolen_time_region);
+
+static bool steal_acc = true;
+static int __init parse_no_stealacc(char *arg)
+{
+	steal_acc = false;
+	return 0;
+}
+early_param("no-steal-acc", parse_no_stealacc);
+
+/* return stolen time in ns by asking the hypervisor */
+static u64 kvm_steal_clock(int cpu)
+{
+	struct kvmarm_stolen_time_region *reg;
+
+	reg = per_cpu_ptr(&stolen_time_region, cpu);
+	if (!reg->kaddr) {
+		pr_warn_once("stolen time enabled but not configued for cpu %d\n",
+			     cpu);
+		return 0;
+	}
+
+	return le64_to_cpu(READ_ONCE(reg->kaddr->stolen_time));
+}
+
+static int disable_stolen_time_current_cpu(void)
+{
+	struct kvmarm_stolen_time_region *reg;
+
+	reg = this_cpu_ptr(&stolen_time_region);
+	if (!reg->kaddr)
+		return 0;
+
+	memunmap(reg->kaddr);
+	memset(reg, 0, sizeof(*reg));
+
+	return 0;
+}
+
+static int stolen_time_dying_cpu(unsigned int cpu)
+{
+	return disable_stolen_time_current_cpu();
+}
+
+static int init_stolen_time_cpu(unsigned int cpu)
+{
+	struct kvmarm_stolen_time_region *reg;
+	int ret;
+	struct arm_smccc_res res;
+
+	reg = this_cpu_ptr(&stolen_time_region);
+
+	if (reg->kaddr)
+		return 0;
+
+	ret = arm_smccc_1_1_call(ARM_SMCCC_HV_PV_TIME_ST, &res);
+
+	if ((long)res.a0 < 0)
+		return -EINVAL;
+
+	reg->kaddr = memremap(res.a0,
+			sizeof(struct pvclock_vcpu_stolen_time_info),
+			MEMREMAP_WB);
+
+	if (reg->kaddr == NULL) {
+		pr_warn("Failed to map stolen time data structure\n");
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(reg->kaddr->revision) != 0 ||
+			le32_to_cpu(reg->kaddr->attributes) != 0) {
+		pr_warn("Unexpected revision or attributes in stolen time data\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int kvm_arm_init_stolen_time(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ARM_KVMPV_STARTING,
+				"hypervisor/kvmarm/pv:starting",
+				init_stolen_time_cpu, stolen_time_dying_cpu);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static bool has_kvm_steal_clock(void)
+{
+	struct arm_smccc_res res;
+
+	/* To detect the presence of PV time support we require SMCCC 1.1+ */
+	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
+		return false;
+
+	arm_smccc_1_1_call(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			   ARM_SMCCC_HV_PV_FEATURES, &res);
+
+	if (res.a0 != SMCCC_RET_SUCCESS)
+		return false;
+
+	arm_smccc_1_1_call(ARM_SMCCC_HV_PV_FEATURES,
+			   ARM_SMCCC_HV_PV_TIME_ST, &res);
+
+	if (res.a0 != SMCCC_RET_SUCCESS)
+		return false;
+
+	return true;
+}
+
+static int __init kvm_guest_init(void)
+{
+	int ret = 0;
+
+	if (!has_kvm_steal_clock())
+		return 0;
+
+	ret = kvm_arm_init_stolen_time();
+	if (ret)
+		return ret;
+
+	pv_ops.time.steal_clock = kvm_steal_clock;
+
+	static_key_slow_inc(&paravirt_steal_enabled);
+	if (steal_acc)
+		static_key_slow_inc(&paravirt_steal_rq_enabled);
+
+	pr_info("using stolen time PV\n");
+
+	return 0;
+}
+early_initcall(kvm_guest_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e0cd2baa8380..5c176a31deb8 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -134,6 +134,7 @@ enum cpuhp_state {
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
+	CPUHP_AP_ARM_KVMPV_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

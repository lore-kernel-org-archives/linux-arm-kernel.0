Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA92C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A3121904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aroM4JHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A3121904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WDlizXIAjuOaosvVT2fHi8W7gTrTslf5a6n+Vfw3vHs=; b=aroM4JHh3qOlB1lwTNPF080xxy
	4x9mFheIr3Jz2REO/HUgZoW/Cff91xnlNfZYOJo5+5Ecmkbne5am7sBZuWd1C00mGvMy2vVTzxjoD
	dTAArGYr2zXgZrelNYjm/5gGjiJv54e1RB/hM8lVjRxSgSUXZxrZRnnAdRkU98XfjnZOZ4uyidgsu
	VUd0+fIEh2i0HYF2WcsmEpHiQaEMjHFCXrZeaTpDG577cwCbmPFS36wZLM2IhscvvEnwbjZ1iOEnZ
	LNRg9AHhhEaqf1K/AllU+2xQ7lIt2oteFn2RrVwnHdzwtSWBIQGp8uC3SemNjvIMe2F419TlF3b7r
	hQApdNsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjI9-00060P-3S; Mon, 18 Feb 2019 13:49:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjHn-0005ah-LN
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:48:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 144851684;
 Mon, 18 Feb 2019 05:48:43 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC17C3F915;
 Mon, 18 Feb 2019 05:48:32 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 4/6] KVM: arm/arm64: lazily create perf events on enable
Date: Mon, 18 Feb 2019 13:48:02 +0000
Message-Id: <1550497684-26046-5-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550497684-26046-1-git-send-email-andrew.murray@arm.com>
References: <1550497684-26046-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_054844_077445_0D89AED4 
X-CRM114-Status: GOOD (  18.40  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Julien Thierry <julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To prevent re-creating perf events everytime the counter registers
are changed, let's instead lazily create the event when the event
is first enabled and destroy it when it changes.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 virt/kvm/arm/pmu.c | 90 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index ae1e886..524b27f 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -24,7 +24,10 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
 
+static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu, u64 select_idx);
 static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
+static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
+
 /**
  * kvm_pmu_get_counter_value - get PMU counter value
  * @vcpu: The vcpu pointer
@@ -59,13 +62,15 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
 {
 	u64 reg;
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
 
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
 	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
 
-	/* Recreate the perf event to reflect the updated sample_period */
-	kvm_pmu_create_perf_event(vcpu, select_idx);
+	kvm_pmu_stop_counter(vcpu, pmc);
+	kvm_pmu_sync_counter_enable(vcpu, select_idx);
 }
 
 /**
@@ -83,6 +88,7 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
 
 /**
  * kvm_pmu_stop_counter - stop PMU counter
+ * @vcpu: The vcpu pointer
  * @pmc: The PMU counter pointer
  *
  * If this counter has been configured to monitor some event, release it here.
@@ -143,6 +149,24 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_pmu_enable_counter - create/enable a counter
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+
+	if (!pmc->perf_event)
+		kvm_pmu_create_perf_event(vcpu, select_idx);
+
+	perf_event_enable(pmc->perf_event);
+	if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
+		kvm_debug("failed to enable perf event\n");
+}
+
+/**
  * kvm_pmu_enable_counter_mask - enable selected PMU counters
  * @vcpu: The vcpu pointer
  * @val: the value guest writes to PMCNTENSET register
@@ -152,8 +176,6 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc;
 
 	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
 		return;
@@ -162,16 +184,39 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 		if (!(val & BIT(i)))
 			continue;
 
-		pmc = &pmu->pmc[i];
-		if (pmc->perf_event) {
-			perf_event_enable(pmc->perf_event);
-			if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
-				kvm_debug("fail to enable perf event\n");
-		}
+		kvm_pmu_enable_counter(vcpu, i);
 	}
 }
 
 /**
+ * kvm_pmu_sync_counter_enable - reenable a counter if it should be enabled
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu,
+					    u64 select_idx)
+{
+	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+
+	if (set & BIT(select_idx))
+		kvm_pmu_enable_counter_mask(vcpu, BIT(select_idx));
+}
+
+/**
+ * kvm_pmu_disable_counter - disable selected PMU counter
+ * @vcpu: The vcpu pointer
+ * @pmc: The counter to disable
+ */
+static void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+
+	if (pmc->perf_event)
+		perf_event_disable(pmc->perf_event);
+}
+
+/**
  * kvm_pmu_disable_counter_mask - disable selected PMU counters
  * @vcpu: The vcpu pointer
  * @val: the value guest writes to PMCNTENCLR register
@@ -181,8 +226,6 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc;
 
 	if (!val)
 		return;
@@ -191,9 +234,7 @@ void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 		if (!(val & BIT(i)))
 			continue;
 
-		pmc = &pmu->pmc[i];
-		if (pmc->perf_event)
-			perf_event_disable(pmc->perf_event);
+		kvm_pmu_disable_counter(vcpu, i);
 	}
 }
 
@@ -375,16 +416,12 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 	}
 }
 
-static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
-{
-	return (__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) &&
-	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(select_idx));
-}
-
 /**
- * kvm_pmu_create_perf_event - create a perf event for a counter
+ * kvm_pmu_counter_create_perf_event - create a perf event for a counter
  * @vcpu: The vcpu pointer
  * @select_idx: The number of selected counter
+ *
+ * Events are always created disabled and they are only enabled lazily.
  */
 static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 {
@@ -398,7 +435,6 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
 	data = __vcpu_sys_reg(vcpu, reg);
 
-	kvm_pmu_stop_counter(vcpu, pmc);
 	eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
 
 	/* Software increment event does't need to be backed by a perf event */
@@ -410,7 +446,7 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 	attr.type = PERF_TYPE_RAW;
 	attr.size = sizeof(attr);
 	attr.pinned = 1;
-	attr.disabled = !kvm_pmu_counter_is_enabled(vcpu, select_idx);
+	attr.disabled = 1;
 	attr.exclude_user = data & ARMV8_PMU_EXCLUDE_EL0 ? 1 : 0;
 	attr.exclude_kernel = data & ARMV8_PMU_EXCLUDE_EL1 ? 1 : 0;
 	attr.exclude_hv = 1; /* Don't count EL2 events */
@@ -446,13 +482,17 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx)
 {
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
 	u64 reg, event_type = data & ARMV8_PMU_EVTYPE_MASK;
 
+	kvm_pmu_stop_counter(vcpu, pmc);
+
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
 
 	__vcpu_sys_reg(vcpu, reg) = event_type;
-	kvm_pmu_create_perf_event(vcpu, select_idx);
+	kvm_pmu_sync_counter_enable(vcpu, select_idx);
 }
 
 bool kvm_arm_support_pmu_v3(void)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

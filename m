Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B183C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CDB20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RIadkzjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CDB20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uK8r1TVEWKLL28sUsPKZ2bcV+ZGDjbN9Xbx0GPSv5+A=; b=RIadkzjFiWt0j7P06cQw1RFfJY
	zN//A+U1ZBYfwmsjsbbIi12A6ZCuPxtPTfcvMNy0pPr5NC6mQsPxE+QMohxpeImh6n2ms1Etoh7Ph
	1nPNVU4vKb6I6uQqLVHNJKujKZliMlO287J0zQrvFeq+HdohSefzd9xslzr80rgmBfmm2Sf+qJW3q
	38npwoJ4ylq+X86nSsjCEh+gnansysL1i3njYh8BX/M4L7W2AAyNs5ksWf8fhzQYDHxVmQq2QwQ1/
	Ap1/SiN+9I4wXqcvhGnKR8HKv01MSbJQSbPUPsqtQ7gQoZZj9c8yeMa+6ngsq9sxTGTv9aBbsxIgB
	youJvs/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltdi-0002Ca-CQ; Tue, 22 Jan 2019 10:50:42 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltd9-0001aN-VK
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:50:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FCAA78;
 Tue, 22 Jan 2019 02:50:07 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126A93F6A8;
 Tue, 22 Jan 2019 02:50:05 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 3/4] KVM: arm/arm64: lazily create perf events on enable
Date: Tue, 22 Jan 2019 10:49:56 +0000
Message-Id: <1548154197-5470-4-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_025008_019427_5A93910D 
X-CRM114-Status: GOOD (  17.91  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com
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
 virt/kvm/arm/pmu.c | 114 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 36 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 4464899..1921ca9 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -24,8 +24,11 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
 
-static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
-				      u64 select_idx);
+static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu, u64 pair);
+static void kvm_pmu_counter_create_enabled_perf_event(struct kvm_vcpu *vcpu,
+						      u64 select_idx);
+static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
+
 /**
  * kvm_pmu_get_counter_value - get PMU counter value
  * @vcpu: The vcpu pointer
@@ -59,18 +62,16 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
  */
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
 {
-	u64 reg, data;
+	u64 reg;
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
 
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
 	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
 
-	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
-	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
-	data = __vcpu_sys_reg(vcpu, reg + select_idx);
-
-	/* Recreate the perf event to reflect the updated sample_period */
-	kvm_pmu_create_perf_event(vcpu, data, select_idx);
+	kvm_pmu_stop_counter(vcpu, pmc);
+	kvm_pmu_reenable_enabled_single(vcpu, select_idx);
 }
 
 /**
@@ -88,6 +89,7 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
 
 /**
  * kvm_pmu_stop_counter - stop PMU counter
+ * @vcpu: The vcpu pointer
  * @pmc: The PMU counter pointer
  *
  * If this counter has been configured to monitor some event, release it here.
@@ -150,6 +152,25 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 }
 
 /**
+ * kvm_pmu_enable_counter_single - create/enable a unpaired counter
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static void kvm_pmu_enable_counter_single(struct kvm_vcpu *vcpu, u64 select_idx)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+
+	if (!pmc->perf_event) {
+		kvm_pmu_counter_create_enabled_perf_event(vcpu, select_idx);
+	} else if (pmc->perf_event) {
+		perf_event_enable(pmc->perf_event);
+		if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
+			kvm_debug("fail to enable perf event\n");
+	}
+}
+
+/**
  * kvm_pmu_enable_counter - enable selected PMU counter
  * @vcpu: The vcpu pointer
  * @val: the value guest writes to PMCNTENSET register
@@ -159,8 +180,6 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc;
 
 	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
 		return;
@@ -169,16 +188,44 @@ void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
 		if (!(val & BIT(i)))
 			continue;
 
-		pmc = &pmu->pmc[i];
-		if (pmc->perf_event) {
-			perf_event_enable(pmc->perf_event);
-			if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
-				kvm_debug("fail to enable perf event\n");
-		}
+		kvm_pmu_enable_counter_single(vcpu, i);
 	}
 }
 
 /**
+ * kvm_pmu_reenable_enabled_single - reenable a counter if it should be enabled
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static void kvm_pmu_reenable_enabled_single(struct kvm_vcpu *vcpu,
+					    u64 select_idx)
+{
+	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
+	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
+
+	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
+		return;
+
+	if (set & BIT(select_idx))
+		kvm_pmu_enable_counter_single(vcpu, select_idx);
+}
+
+/**
+ * kvm_pmu_disable_counter - disable selected PMU counter
+ * @vcpu: The vcpu pointer
+ * @pmc: The counter to dissable
+ */
+static void kvm_pmu_disable_counter_single(struct kvm_vcpu *vcpu,
+					   u64 select_idx)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+
+	if (pmc->perf_event)
+		perf_event_disable(pmc->perf_event);
+}
+
+/**
  * kvm_pmu_disable_counter - disable selected PMU counter
  * @vcpu: The vcpu pointer
  * @val: the value guest writes to PMCNTENCLR register
@@ -188,8 +235,6 @@ void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
 void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc;
 
 	if (!val)
 		return;
@@ -198,9 +243,7 @@ void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val)
 		if (!(val & BIT(i)))
 			continue;
 
-		pmc = &pmu->pmc[i];
-		if (pmc->perf_event)
-			perf_event_disable(pmc->perf_event);
+		kvm_pmu_disable_counter_single(vcpu, i);
 	}
 }
 
@@ -382,28 +425,22 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
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
+ * kvm_pmu_counter_create_enabled_perf_event - create a perf event for a counter
  * @vcpu: The vcpu pointer
- * @data: Type of event as per PMXEVTYPER_EL0 format
  * @select_idx: The number of selected counter
  */
-static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
-				      u64 select_idx)
+static void kvm_pmu_counter_create_enabled_perf_event(struct kvm_vcpu *vcpu,
+						u64 select_idx)
 {
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
 	struct perf_event *event;
 	struct perf_event_attr attr;
-	u64 eventsel, counter;
+	u64 eventsel, counter, data;
+
+	data = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + select_idx);
 
-	kvm_pmu_stop_counter(vcpu, pmc);
 	eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
 
 	/* Software increment event does't need to be backed by a perf event */
@@ -415,7 +452,6 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
 	attr.type = PERF_TYPE_RAW;
 	attr.size = sizeof(attr);
 	attr.pinned = 1;
-	attr.disabled = !kvm_pmu_counter_is_enabled(vcpu, select_idx);
 	attr.exclude_user = data & ARMV8_PMU_EXCLUDE_EL0 ? 1 : 0;
 	attr.exclude_kernel = data & ARMV8_PMU_EXCLUDE_EL1 ? 1 : 0;
 	attr.exclude_hv = 1; /* Don't count EL2 events */
@@ -451,7 +487,13 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 data,
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx)
 {
-	kvm_pmu_create_perf_event(vcpu, data, select_idx);
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+	u64 event_type = data & ARMV8_PMU_EVTYPE_MASK;
+
+	kvm_pmu_stop_counter(vcpu, pmc);
+	__vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + select_idx) = event_type;
+	kvm_pmu_reenable_enabled_single(vcpu, select_idx);
 }
 
 bool kvm_arm_support_pmu_v3(void)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

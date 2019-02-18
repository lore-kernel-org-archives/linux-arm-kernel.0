Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF13DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CE521901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mj4GnoYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CE521901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6Fa/gPyahU62eMqPU78dxs43Es6XE2p5EthsUXeUOsw=; b=Mj4GnoYfUoftFUcw/qxnbIGxKA
	FXoVw6GyBEDte3HDoN0cLXZhP2Dus2cmJCmhr4OpXbI29ydfyZ9dzriOT1NibdYskGP1b18/1wWui
	J39UsPknnSSKL/11vjYA0KTvGBGlaeK9BccjjltKupNxgJWAUBXJOLott+fM5e0h295QCaj1CUKzN
	18kd1ZjoGAiQrAW+JBACvdLLztgHAQ1PrulJ7kOMVOLrci6WLiQKUUG6gyAR+Ogi1Q9eANZYt1132
	Sag1A4ifO43QBmRTmSZnGrLt7FSQ8XaEptvwj7ZrA2E9TfVg1rxzVu0tly4ZaC/dXFLTrWRe5xvex
	5SkZcIoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjIX-0006RE-2R; Mon, 18 Feb 2019 13:49:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjHt-0005i5-HR
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:48:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2AE116A3;
 Mon, 18 Feb 2019 05:48:47 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9123FA42;
 Mon, 18 Feb 2019 05:48:36 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 6/6] KVM: arm/arm64: support chained PMU counters
Date: Mon, 18 Feb 2019 13:48:04 +0000
Message-Id: <1550497684-26046-7-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550497684-26046-1-git-send-email-andrew.murray@arm.com>
References: <1550497684-26046-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_054849_789150_1028EEB2 
X-CRM114-Status: GOOD (  22.19  )
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

Emulate chained PMU counters by creating a single 64 bit event counter
for a pair of chained KVM counters.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/kvm/arm_pmu.h |   1 +
 virt/kvm/arm/pmu.c    | 322 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 270 insertions(+), 53 deletions(-)

diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index b73f31b..8e691ee 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -29,6 +29,7 @@ struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
 	struct perf_event *perf_event;
 	u64 bitmask;
+	u64 overflow_count;
 };
 
 struct kvm_pmu {
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 524b27f..2852dc4 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -24,9 +24,26 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
 
+static void kvm_pmu_stop_release_perf_event_pair(struct kvm_vcpu *vcpu,
+					    u64 pair_low);
+static void kvm_pmu_stop_release_perf_event(struct kvm_vcpu *vcpu,
+					      u64 select_idx);
+static void kvm_pmu_sync_counter_enable_pair(struct kvm_vcpu *vcpu, u64 pair_low);
 static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu, u64 select_idx);
 static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
-static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
+
+#define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
+
+/**
+ * kvm_pmu_counter_is_high_word - is select_idx high counter of 64bit event
+ * @pmc: The PMU counter pointer
+ * @select_idx: The counter index
+ */
+static inline bool kvm_pmu_counter_is_high_word(struct kvm_pmc *pmc)
+{
+	return ((pmc->perf_event->attr.config1 & PERF_ATTR_CFG1_KVM_PMU_CHAINED)
+		&& (pmc->idx % 2));
+}
 
 /**
  * kvm_pmu_get_counter_value - get PMU counter value
@@ -35,22 +52,70 @@ static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
  */
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
 {
-	u64 counter, reg, enabled, running;
+	u64 counter_idx, reg, enabled, running, incr;
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
 
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
-	counter = __vcpu_sys_reg(vcpu, reg);
+	counter_idx = __vcpu_sys_reg(vcpu, reg);
 
 	/* The real counter value is equal to the value of counter register plus
 	 * the value perf event counts.
 	 */
-	if (pmc->perf_event)
-		counter += perf_event_read_value(pmc->perf_event, &enabled,
+	if (pmc->perf_event) {
+		incr = perf_event_read_value(pmc->perf_event, &enabled,
 						 &running);
 
-	return counter & pmc->bitmask;
+		if (kvm_pmu_counter_is_high_word(pmc)) {
+			u64 counter_low, counter;
+
+			reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
+			      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx - 1;
+			counter_low = __vcpu_sys_reg(vcpu, reg);
+			counter = lower_32_bits(counter_low) | (counter_idx << 32);
+			counter_idx = upper_32_bits(counter + incr);
+		} else {
+			counter_idx += incr;
+		}
+	}
+
+	return counter_idx & pmc->bitmask;
+}
+
+/**
+ * kvm_pmu_counter_is_enabled - is a counter active
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
+{
+	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
+
+	return (__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) &&
+	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask & BIT(select_idx));
+}
+
+/**
+ * kvnm_pmu_event_is_chained - is a pair of counters chained and enabled
+ * @vcpu: The vcpu pointer
+ * @select_idx: The low counter index
+ */
+static bool kvm_pmu_event_is_chained(struct kvm_vcpu *vcpu, u64 pair_low)
+{
+	u64 eventsel, reg;
+
+	reg = (pair_low + 1 == ARMV8_PMU_CYCLE_IDX)
+	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + pair_low + 1;
+	eventsel = __vcpu_sys_reg(vcpu, reg) & ARMV8_PMU_EVTYPE_EVENT;
+	if (!armv8pmu_evtype_is_chain(eventsel))
+		return false;
+
+	if (kvm_pmu_counter_is_enabled(vcpu, pair_low) !=
+	    kvm_pmu_counter_is_enabled(vcpu, pair_low + 1))
+		return false;
+
+	return true;
 }
 
 /**
@@ -61,29 +126,45 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
  */
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
 {
-	u64 reg;
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+	u64 reg, pair_low;
 
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
 	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
 
-	kvm_pmu_stop_counter(vcpu, pmc);
-	kvm_pmu_sync_counter_enable(vcpu, select_idx);
+	pair_low = (select_idx % 2) ? select_idx - 1 : select_idx;
+
+	/* Recreate the perf event to reflect the updated sample_period */
+	if (kvm_pmu_event_is_chained(vcpu, pair_low)) {
+		kvm_pmu_stop_release_perf_event_pair(vcpu, pair_low);
+		kvm_pmu_sync_counter_enable_pair(vcpu, pair_low);
+	} else {
+		kvm_pmu_stop_release_perf_event(vcpu, select_idx);
+		kvm_pmu_sync_counter_enable(vcpu, select_idx);
+	}
 }
 
 /**
  * kvm_pmu_release_perf_event - remove the perf event
  * @pmc: The PMU counter pointer
  */
-static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
+static void kvm_pmu_release_perf_event(struct kvm_vcpu *vcpu,
+				       struct kvm_pmc *pmc)
 {
-	if (pmc->perf_event) {
-		perf_event_disable(pmc->perf_event);
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc_alt;
+	u64 pair_alt;
+
+	pair_alt = (pmc->idx % 2) ? pmc->idx - 1 : pmc->idx + 1;
+	pmc_alt = &pmu->pmc[pair_alt];
+
+	if (pmc->perf_event)
 		perf_event_release_kernel(pmc->perf_event);
-		pmc->perf_event = NULL;
-	}
+
+	if (pmc->perf_event == pmc_alt->perf_event)
+		pmc_alt->perf_event = NULL;
+
+	pmc->perf_event = NULL;
 }
 
 /**
@@ -91,22 +172,65 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
  * @vcpu: The vcpu pointer
  * @pmc: The PMU counter pointer
  *
- * If this counter has been configured to monitor some event, release it here.
+ * If this counter has been configured to monitor some event, stop it here.
  */
 static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
 {
 	u64 counter, reg;
 
 	if (pmc->perf_event) {
+		perf_event_disable(pmc->perf_event);
 		counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
 		reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX)
 		       ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
 		__vcpu_sys_reg(vcpu, reg) = counter;
-		kvm_pmu_release_perf_event(pmc);
 	}
 }
 
 /**
+ * kvm_pmu_stop_release_perf_event_pair - stop and release a pair of counters
+ * @vcpu: The vcpu pointer
+ * @pmc_low: The PMU counter pointer for lower word
+ * @pmc_high: The PMU counter pointer for higher word
+ *
+ * As chained counters share the underlying perf event, we stop them
+ * both first before discarding the underlying perf event
+ */
+static void kvm_pmu_stop_release_perf_event_pair(struct kvm_vcpu *vcpu,
+					    u64 idx_low)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc_low = &pmu->pmc[idx_low];
+	struct kvm_pmc *pmc_high = &pmu->pmc[idx_low + 1];
+
+	/* Stopping a counter involves adding the perf event value to the
+	 * vcpu sys register value prior to releasing the perf event. As
+	 * kvm_pmu_get_counter_value may depend on the low counter value we
+	 * must always stop the high counter first
+	 */
+	kvm_pmu_stop_counter(vcpu, pmc_high);
+	kvm_pmu_stop_counter(vcpu, pmc_low);
+
+	kvm_pmu_release_perf_event(vcpu, pmc_high);
+	kvm_pmu_release_perf_event(vcpu, pmc_low);
+}
+
+/**
+ * kvm_pmu_stop_release_perf_event - stop and release a counter
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static void kvm_pmu_stop_release_perf_event(struct kvm_vcpu *vcpu,
+					      u64 select_idx)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+
+	kvm_pmu_stop_counter(vcpu, pmc);
+	kvm_pmu_release_perf_event(vcpu, pmc);
+}
+
+/**
  * kvm_pmu_vcpu_reset - reset pmu state for cpu
  * @vcpu: The vcpu pointer
  *
@@ -117,7 +241,7 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 
 	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
-		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
+		kvm_pmu_stop_release_perf_event(vcpu, i);
 		pmu->pmc[i].idx = i;
 		pmu->pmc[i].bitmask = 0xffffffffUL;
 	}
@@ -134,7 +258,7 @@ void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 
 	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
-		kvm_pmu_release_perf_event(&pmu->pmc[i]);
+		kvm_pmu_release_perf_event(vcpu, &pmu->pmc[i]);
 }
 
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
@@ -167,53 +291,115 @@ static void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
 }
 
 /**
+ * kvm_pmu_sync_counter_enable - reenable a counter if it should be enabled
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu,
+					    u64 select_idx)
+{
+	kvm_pmu_enable_counter_mask(vcpu, BIT(select_idx));
+}
+
+/**
+ * kvm_pmu_sync_counter_enable_pair - reenable a pair if they should be enabled
+ * @vcpu: The vcpu pointer
+ * @pair_low: The low counter index
+ */
+static void kvm_pmu_sync_counter_enable_pair(struct kvm_vcpu *vcpu, u64 pair_low)
+{
+	kvm_pmu_enable_counter_mask(vcpu, BIT(pair_low) | BIT(pair_low + 1));
+}
+
+/**
+ * kvm_pmu_enable_counter_pair - enable counters pair at a time
+ * @vcpu: The vcpu pointer
+ * @val: counters to enable
+ * @pair_low: The low counter index
+ */
+static void kvm_pmu_enable_counter_pair(struct kvm_vcpu *vcpu, u64 val,
+					u64 pair_low)
+{
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc_low = &pmu->pmc[pair_low];
+	struct kvm_pmc *pmc_high = &pmu->pmc[pair_low + 1];
+
+	if (kvm_pmu_event_is_chained(vcpu, pair_low)) {
+		if (pmc_low->perf_event != pmc_high->perf_event)
+			kvm_pmu_stop_release_perf_event_pair(vcpu, pair_low);
+	}
+
+	if (val & BIT(pair_low))
+		kvm_pmu_enable_counter(vcpu, pair_low);
+
+	if (val & BIT(pair_low + 1))
+		kvm_pmu_enable_counter(vcpu, pair_low + 1);
+}
+
+/**
  * kvm_pmu_enable_counter_mask - enable selected PMU counters
  * @vcpu: The vcpu pointer
- * @val: the value guest writes to PMCNTENSET register
+ * @val: the value guest writes to PMCNTENSET register or a subset
  *
  * Call perf_event_enable to start counting the perf event
  */
 void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
+	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
+	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
 
 	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
 		return;
 
-	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
-		if (!(val & BIT(i)))
-			continue;
-
-		kvm_pmu_enable_counter(vcpu, i);
-	}
+	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i += 2)
+		kvm_pmu_enable_counter_pair(vcpu, val & set, i);
 }
 
 /**
- * kvm_pmu_sync_counter_enable - reenable a counter if it should be enabled
+ * kvm_pmu_disable_counter - disable selected PMU counter
  * @vcpu: The vcpu pointer
  * @select_idx: The counter index
  */
-static void kvm_pmu_sync_counter_enable(struct kvm_vcpu *vcpu,
-					    u64 select_idx)
+static void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
 {
-	u64 set = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
 
-	if (set & BIT(select_idx))
-		kvm_pmu_enable_counter_mask(vcpu, BIT(select_idx));
+	if (pmc->perf_event) {
+		perf_event_disable(pmc->perf_event);
+		if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
+			kvm_debug("fail to enable perf event\n");
+	}
 }
 
 /**
- * kvm_pmu_disable_counter - disable selected PMU counter
- * @vcpu: The vcpu pointer
- * @pmc: The counter to disable
+ * kvm_pmu_disable_counter_pair - disable counters pair at a time
+ * @val: counters to disable
+ * @pair_low: The low counter index
  */
-static void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 select_idx)
+static void kvm_pmu_disable_counter_pair(struct kvm_vcpu *vcpu, u64 val,
+					 u64 pair_low)
 {
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+	struct kvm_pmc *pmc_low = &pmu->pmc[pair_low];
+	struct kvm_pmc *pmc_high = &pmu->pmc[pair_low + 1];
+
+	if (!kvm_pmu_event_is_chained(vcpu, pair_low)) {
+		if (pmc_low->perf_event == pmc_high->perf_event) {
+			if (pmc_low->perf_event) {
+				kvm_pmu_stop_release_perf_event_pair(vcpu,
+								pair_low);
+				kvm_pmu_sync_counter_enable_pair(vcpu, pair_low);
+			}
+		}
+	}
 
-	if (pmc->perf_event)
-		perf_event_disable(pmc->perf_event);
+	if (val & BIT(pair_low))
+		kvm_pmu_disable_counter(vcpu, pair_low);
+
+	if (val & BIT(pair_low + 1))
+		kvm_pmu_disable_counter(vcpu, pair_low + 1);
 }
 
 /**
@@ -230,12 +416,8 @@ void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 	if (!val)
 		return;
 
-	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
-		if (!(val & BIT(i)))
-			continue;
-
-		kvm_pmu_disable_counter(vcpu, i);
-	}
+	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i += 2)
+		kvm_pmu_disable_counter_pair(vcpu, val, i);
 }
 
 static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
@@ -346,6 +528,17 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 
 	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(idx);
 
+	if (kvm_pmu_event_is_chained(vcpu, idx)) {
+		struct kvm_pmu *pmu = &vcpu->arch.pmu;
+		struct kvm_pmc *pmc_high = &pmu->pmc[idx + 1];
+
+		if (!(--pmc_high->overflow_count)) {
+			__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(idx + 1);
+			pmc_high->overflow_count = U32_MAX + 1UL;
+		}
+
+	}
+
 	if (kvm_pmu_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 		kvm_vcpu_kick(vcpu);
@@ -442,6 +635,10 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 	    select_idx != ARMV8_PMU_CYCLE_IDX)
 		return;
 
+	/* Handled by even event */
+	if (armv8pmu_evtype_is_chain(eventsel))
+		return;
+
 	memset(&attr, 0, sizeof(struct perf_event_attr));
 	attr.type = PERF_TYPE_RAW;
 	attr.size = sizeof(attr);
@@ -454,6 +651,9 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 	attr.config = (select_idx == ARMV8_PMU_CYCLE_IDX) ?
 		ARMV8_PMUV3_PERFCTR_CPU_CYCLES : eventsel;
 
+	if (kvm_pmu_event_is_chained(vcpu, select_idx))
+		attr.config1 |= PERF_ATTR_CFG1_KVM_PMU_CHAINED;
+
 	counter = kvm_pmu_get_counter_value(vcpu, select_idx);
 	/* The initial sample period (overflow count) of an event. */
 	attr.sample_period = (-counter) & pmc->bitmask;
@@ -466,6 +666,14 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 		return;
 	}
 
+	if (kvm_pmu_event_is_chained(vcpu, select_idx)) {
+		struct kvm_pmc *pmc_next = &pmu->pmc[select_idx + 1];
+
+		pmc_next->perf_event = event;
+		counter = kvm_pmu_get_counter_value(vcpu, select_idx + 1);
+		pmc_next->overflow_count = (-counter) & pmc->bitmask;
+	}
+
 	pmc->perf_event = event;
 }
 
@@ -482,17 +690,25 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx)
 {
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
-	u64 reg, event_type = data & ARMV8_PMU_EVTYPE_MASK;
-
-	kvm_pmu_stop_counter(vcpu, pmc);
+	u64 eventsel, event_type, pair_low, reg;
 
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
 
-	__vcpu_sys_reg(vcpu, reg) = event_type;
-	kvm_pmu_sync_counter_enable(vcpu, select_idx);
+	eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
+	event_type = data & ARMV8_PMU_EVTYPE_MASK;
+	pair_low = (select_idx % 2) ? select_idx - 1 : select_idx;
+
+	if (kvm_pmu_event_is_chained(vcpu, pair_low) ||
+	    armv8pmu_evtype_is_chain(eventsel)) {
+		kvm_pmu_stop_release_perf_event_pair(vcpu, pair_low);
+		__vcpu_sys_reg(vcpu, reg) = event_type;
+		kvm_pmu_sync_counter_enable_pair(vcpu, pair_low);
+	} else {
+		kvm_pmu_stop_release_perf_event(vcpu, pair_low);
+		__vcpu_sys_reg(vcpu, reg) = event_type;
+		kvm_pmu_sync_counter_enable(vcpu, pair_low);
+	}
 }
 
 bool kvm_arm_support_pmu_v3(void)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

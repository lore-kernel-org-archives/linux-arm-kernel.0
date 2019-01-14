Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C6EC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A972087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LnUlKG62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A972087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9svQatlzDPDnqCT0bmL/OMgXMt5KSeucKfPKzAzfWNc=; b=LnUlKG62MN/EKigw4KqCqixjsa
	bAxyih44epCTBSCqJyJGFEjohkyNybO7OfqsYt9JYYmZvSXm4aP8etW5mv/RFlEyscizhJ+4+oRoF
	04Ys5iG6j+UXMKmTQHlZXsaoTyyERkrIg1y89sudR76J2NNTFGIkrmtG3PPPF32J4mh9bdcXtuSSu
	H7Oy2vo4Rxcs5rUPOtahO63C2/SR+HgB8yt9P7fRWDBg/gGovJAt5w/ncZy/yNAa4GgIc3VD8f+Au
	0owvs0MQm9pPght71XYQKmMTBuTJPqCerFlXnRRqw3wmgij28z22iIwUxiHo+9WG/n46D8Ny2BlVL
	9lluUhHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4r0-0007SI-A9; Mon, 14 Jan 2019 16:12:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4qK-0006kI-IG
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:12:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C813C1596;
 Mon, 14 Jan 2019 08:12:03 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65AD3F5BD;
 Mon, 14 Jan 2019 08:12:01 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v10 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Date: Mon, 14 Jan 2019 16:11:47 +0000
Message-Id: <1547482308-29839-5-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547482308-29839-1-git-send-email-andrew.murray@arm.com>
References: <1547482308-29839-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_081205_086988_27BBC04C 
X-CRM114-Status: GOOD (  16.74  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the :G and :H attributes in perf by handling the
exclude_host/exclude_guest event attributes.

We notify KVM of counters that we wish to be enabled or disabled on
guest entry/exit and thus defer from starting or stopping :G events
as per the events exclude_host attribute.

With both VHE and non-VHE we switch the counters between host/guest
at EL2. We are able to eliminate counters counting host events on
the boundaries of guest entry/exit when using :G by filtering out
EL2 for exclude_host. However when using :H unless exclude_hv is set
on non-VHE then there is a small blackout window at the guest
entry/exit where host events are not captured.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/perf_event.c | 53 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 1c71796..21c6831 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -26,6 +26,7 @@
 
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
+#include <linux/kvm_host.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
@@ -528,11 +529,27 @@ static inline int armv8pmu_enable_counter(int idx)
 
 static inline void armv8pmu_enable_event_counter(struct perf_event *event)
 {
+	struct perf_event_attr *attr = &event->attr;
 	int idx = event->hw.idx;
+	int flags = 0;
+	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
 
-	armv8pmu_enable_counter(idx);
 	if (armv8pmu_event_is_chained(event))
-		armv8pmu_enable_counter(idx - 1);
+		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
+
+	if (!attr->exclude_host)
+		flags |= KVM_PMU_EVENTS_HOST;
+	if (!attr->exclude_guest)
+		flags |= KVM_PMU_EVENTS_GUEST;
+
+	kvm_set_pmu_events(counter_bits, flags);
+
+	/* We rely on the hypervisor switch code to enable guest counters */
+	if (!attr->exclude_host) {
+		armv8pmu_enable_counter(idx);
+		if (armv8pmu_event_is_chained(event))
+			armv8pmu_enable_counter(idx - 1);
+	}
 }
 
 static inline int armv8pmu_disable_counter(int idx)
@@ -545,11 +562,21 @@ static inline int armv8pmu_disable_counter(int idx)
 static inline void armv8pmu_disable_event_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event_attr *attr = &event->attr;
 	int idx = hwc->idx;
+	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
 
 	if (armv8pmu_event_is_chained(event))
-		armv8pmu_disable_counter(idx - 1);
-	armv8pmu_disable_counter(idx);
+		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
+
+	kvm_clr_pmu_events(counter_bits);
+
+	/* We rely on the hypervisor switch code to disable guest counters */
+	if (!attr->exclude_host) {
+		if (armv8pmu_event_is_chained(event))
+			armv8pmu_disable_counter(idx - 1);
+		armv8pmu_disable_counter(idx);
+	}
 }
 
 static inline int armv8pmu_enable_intens(int idx)
@@ -824,16 +851,25 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	 * Therefore we ignore exclude_hv in this configuration, since
 	 * there's no hypervisor to sample anyway. This is consistent
 	 * with other architectures (x86 and Power).
+	 *
+	 * To eliminate counting host events on the boundaries of
+	 * guest entry/exit we ensure EL2 is not included in hyp mode
+	 * with !exclude_host.
 	 */
 	if (is_kernel_in_hyp_mode()) {
-		if (!attr->exclude_kernel)
+		if (!attr->exclude_kernel && !attr->exclude_host)
 			config_base |= ARMV8_PMU_INCLUDE_EL2;
 	} else {
-		if (attr->exclude_kernel)
-			config_base |= ARMV8_PMU_EXCLUDE_EL1;
 		if (!attr->exclude_hv)
 			config_base |= ARMV8_PMU_INCLUDE_EL2;
 	}
+
+	/*
+	 * Filter out !VHE kernels and guest kernels
+	 */
+	if (attr->exclude_kernel)
+		config_base |= ARMV8_PMU_EXCLUDE_EL1;
+
 	if (attr->exclude_user)
 		config_base |= ARMV8_PMU_EXCLUDE_EL0;
 
@@ -863,6 +899,9 @@ static void armv8pmu_reset(void *info)
 		armv8pmu_disable_intens(idx);
 	}
 
+	/* Clear the counters we flip at guest entry/exit */
+	kvm_clr_pmu_events(U32_MAX);
+
 	/*
 	 * Initialize & Reset PMNC. Request overflow interrupt for
 	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

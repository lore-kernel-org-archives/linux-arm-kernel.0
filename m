Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:46:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0852082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WQfNH8e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0852082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gkrF7Gl1sox5LVsp20rVgMUrTdYrJbDf8J/fSwluG8c=; b=WQfNH8e4ltJ2I9Bwp7q+2M9XqI
	ovdUBV/oTd/bt2tf6+7YLJm9Ied6R3z77/L+K/jj0AYVLCF2DGshZVQJizCTsyzqTtkpqPkoW0leM
	sc0C+RIwiNeSHcT7gSN1bq6/QLlyaFfm5pDkVf23D6nio7xS8WSpGJGvefSyuHwnr4M9SEfms9SXd
	RiGGhXysLJjm9fUD61TP2lglhpBu6Cz89R1F5eYmAW8FyKVBHb/wO2etPHznhA0uVxRRHHYfCIv04
	PnZD5eL0LPlR3EZd0EjXBqe7iro0ZY7YvllerT70VbpqljTt6NXg1S11uoyZBKkFsqWIYB+KkNgI+
	E4l4hyug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWI9E-0001HU-Ef; Mon, 10 Dec 2018 09:46:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWI91-00012O-Il
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:46:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CB915BE;
 Mon, 10 Dec 2018 01:46:23 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FAD43F6A8;
 Mon, 10 Dec 2018 01:46:21 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 2/4] arm64: KVM: add accessors to track guest/host only
 counters
Date: Mon, 10 Dec 2018 09:45:57 +0000
Message-Id: <1544435159-54781-3-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544435159-54781-1-git-send-email-andrew.murray@arm.com>
References: <1544435159-54781-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_014631_699254_FF55B2E2 
X-CRM114-Status: GOOD (  10.37  )
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

In order to effeciently enable/disable guest/host only perf counters
at guest entry/exit we add bitfields to kvm_cpu_context for guest and
host events as well as accessors for updating them.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1550192..800c87b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -203,6 +203,8 @@ struct kvm_cpu_context {
 	};
 
 	struct kvm_vcpu *__hyp_running_vcpu;
+	u32 events_host;
+	u32 events_guest;
 };
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
@@ -467,11 +469,33 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
 
+#define KVM_PMU_EVENTS_HOST	1
+#define KVM_PMU_EVENTS_GUEST	2
+
 #ifdef CONFIG_KVM /* Avoid conflicts with core headers if CONFIG_KVM=n */
 static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	return kvm_arch_vcpu_run_map_fp(vcpu);
 }
+static inline void kvm_set_pmu_events(u32 set, int flags)
+{
+	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
+
+	if (flags & KVM_PMU_EVENTS_HOST)
+		ctx->events_host |= set;
+	if (flags & KVM_PMU_EVENTS_GUEST)
+		ctx->events_guest |= set;
+}
+static inline void kvm_clr_pmu_events(u32 clr)
+{
+	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
+
+	ctx->events_host &= ~clr;
+	ctx->events_guest &= ~clr;
+}
+#else
+static inline void kvm_set_pmu_events(u32 set, int flags) {}
+static inline void kvm_clr_pmu_events(u32 clr) {}
 #endif
 
 static inline void kvm_arm_vhe_guest_enter(void)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

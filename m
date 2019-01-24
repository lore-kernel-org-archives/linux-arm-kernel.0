Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973F8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6331E21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ke+fJqpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6331E21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=G9OJbahHKjbwjO6W0g+j9ZbLlWSrW8qK6ODAfHpgY+Q=; b=Ke+fJqprIhpuUEwztwDpgijsLd
	i4R+AHMD4PiMSzePaTMA82UMIqGoxiuPI+pHL/zbvQ6Ej9fGDm8fjO0d73m8BhXnpXngTeH7iaqXi
	lHKXZqRzOYOzuqpKaiEmnrTjjZlnQUsOm76ieX1E8N64vhOvT7ynw2wF3Qtt+HVA45stw7XAwthsy
	C32OwbO3655md2hptR4R6TZLWdXj1RthpAXGqH6c2EnmZSnxNeu25IEUqu4xeTqRF65YkCyjODg47
	Ue31a5v5NVaOSIhRZjB2s2fl4irglF8Dr4KDYgpPskeNISaJJGkGmas2GiLsggr/SabscR5pmAN/7
	zyW++ctA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfYy-00037i-0c; Thu, 24 Jan 2019 14:01:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfYf-0002nv-Dk
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:00:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28D831596;
 Thu, 24 Jan 2019 06:00:41 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B72E93F5C1;
 Thu, 24 Jan 2019 06:00:40 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/14] arm64: KVM: Allow for direct call of HYP functions when
 using VHE
Date: Thu, 24 Jan 2019 15:00:20 +0100
Message-Id: <20190124140032.8588-3-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190124140032.8588-1-christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060041_463697_4BB668B2 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When running VHE, there is no need to jump via some stub to perform
a "HYP" function call, as there is a single address space.

Let's thus change kvm_call_hyp() and co to perform a direct call
in this case. Although this results in a bit of code expansion,
it allows the compiler to check for type compatibility, something
that we are missing so far.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 32 +++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e54cb7c88a4e..8b7702bdb219 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -370,8 +370,36 @@ void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
 u64 __kvm_call_hyp(void *hypfn, ...);
-#define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
-#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
+
+/*
+ * The couple of isb() below are there to guarantee the same behaviour
+ * on VHE as on !VHE, where the eret to EL1 acts as a context
+ * synchronization event.
+ */
+#define kvm_call_hyp(f, ...)						\
+	do {								\
+		if (has_vhe()) {					\
+			f(__VA_ARGS__);					\
+			isb();						\
+		} else {						\
+			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+		}							\
+	} while(0)
+
+#define kvm_call_hyp_ret(f, ...)					\
+	({								\
+		typeof(f(__VA_ARGS__)) ret;				\
+									\
+		if (has_vhe()) {					\
+			ret = f(__VA_ARGS__);				\
+			isb();						\
+		} else {						\
+			ret = __kvm_call_hyp(kvm_ksym_ref(f),		\
+					     ##__VA_ARGS__);		\
+		}							\
+									\
+		ret;							\
+	})
 
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

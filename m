Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B98206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RY6O1PkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B98206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8tBjY2HaTMfyG0L8K6X5fPRaZV80qSXrX5SknsbG1bw=; b=RY6O1PkEextzhz
	D80zX7fcBS2OC34aHKLv9BX8TuxmBl95lWupKN8V+Ji1PDX96onPg44mEEy8PCwZSwBRbSrav8irP
	+qiqbPi3mdQr3vBpuRQuX12cDUAdlDCxtAemOaxxyb0RDsiDGUHbkf35GgMp6POogfYPo1Ljk4Seg
	sLc/4iryDZmAOJlyTldyMyf5ooqEz4bQ+bgB1o+wUgeM0R13+Vw9BqQvSRlzYc5l16iCRidSYoS3J
	QNCNZhgIRIQBIanNCoTvQMo5+7KwbGeegZDjfPDhN+vmJ+CnKjBrHJ2aetMOiYZMQvLlrBjueBwj+
	hCV9lze597bdMj0HrIxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEKa-0005Wg-OM; Wed, 09 Jan 2019 13:55:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEJr-0003Yr-5M
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:54:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C21F01650;
 Wed,  9 Jan 2019 05:54:54 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3CD83F6CF;
 Wed,  9 Jan 2019 05:54:53 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm64: KVM: Allow for direct call of HYP functions when
 using VHE
Date: Wed,  9 Jan 2019 13:54:34 +0000
Message-Id: <20190109135435.178664-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109135435.178664-1-marc.zyngier@arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_055455_207565_B2FC37EC 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When running VHE, there is no need to jump via some stub to perform
a "HYP" function call, as there is a single address space.

Let's thus change kvm_call_hyp() and co to perform a direct call
in this case. Although this results in a bit of code expansion,
it allows the compiler to check for type compatibility, something
that we are missing so far.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 32 +++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e54cb7c88a4e..df32edbadd69 100644
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
+		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
+			f(__VA_ARGS__);					\
+			isb();						\
+		} else {						\
+			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+		}							\
+	} while(0)
+
+#define kvm_call_hyp_ret(f, ...)					\
+	({								\
+		u64 ret;						\
+									\
+		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

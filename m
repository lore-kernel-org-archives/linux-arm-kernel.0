Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E17EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC0420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mnmENL0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC0420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=O1eUk0ag7qqhk6TIGEMl9nVTtCAlTlt6lbF0FPFbSXc=; b=mnmENL0/Q7bJhx14SZfOCNgWzh
	tyLjVV6XbQwSTMf0Vq2N3O+ntNTClw3e1Z73q+4ViBSQ+9kRQ9itSN04QjNam47SXcJNeUXhRqfOa
	Ui7XH0JdeO4+bZRZdy2MgtO/uY7iaiKzzhYocsgeFNG7GSgMMISnmuSmtWjJf+IHsplM/FNHW/JZU
	x8iKs5lsNxpo8Kh7cgIRn/XDRN/rPnjCAKm8WvBi/7XlxqkV5ao81GnsyQZcIw0IBF+RDBbgDP52z
	6vA9bKnSQYrsgJmgZ2lr84eCmGuWUsLgD1bxvWIFhDQIwAz5t1/q3P0911wJSM12uWsIWWQvINsvo
	IyQ2SzGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL3r-0005fl-Rd; Fri, 07 Dec 2018 18:41:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL2z-0004if-PA
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:40:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B8815AD;
 Fri,  7 Dec 2018 10:40:20 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0B33F5AF;
 Fri,  7 Dec 2018 10:40:16 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 05/13] arm64: Don't trap host pointer auth use to EL2
Date: Fri,  7 Dec 2018 18:39:23 +0000
Message-Id: <20181207183931.4285-6-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104022_963297_E303CB7D 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

To allow EL0 (and/or EL1) to use pointer authentication functionality,
we must ensure that pointer authentication instructions and accesses to
pointer authentication keys are not trapped to EL2.

This patch ensures that HCR_EL2 is configured appropriately when the
kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
ensuring that EL1 can access keys and permit EL0 use of instructions.
For VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
and it doesn't matter how we configure HCR_EL2.{API,APK}, so we don't
bother setting them.

This does not enable support for KVM guests, since KVM manages HCR_EL2
itself when running VMs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/include/asm/kvm_arm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index c8825c5a8dd0..f9123fe8fcf3 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -24,6 +24,8 @@
 
 /* Hyp Configuration Register (HCR) bits */
 #define HCR_FWB		(UL(1) << 46)
+#define HCR_API		(UL(1) << 41)
+#define HCR_APK		(UL(1) << 40)
 #define HCR_TEA		(UL(1) << 37)
 #define HCR_TERR	(UL(1) << 36)
 #define HCR_TLOR	(UL(1) << 35)
@@ -87,7 +89,7 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
-#define HCR_HOST_NVHE_FLAGS (HCR_RW)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

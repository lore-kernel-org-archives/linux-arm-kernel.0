Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0253C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89189206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQyVszOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89189206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GH/hPL5rNtsvwphjeUPLtSEUguTAN46Kcr20XlGz0PM=; b=VQyVszOLQ4TKvb
	yd3SDkr9A+6vfJ2jGo0e0pIyL3CNi7+3yDyJsdp409hO2NZeFKTR2b+FD1zCv73kNuR0F48P8vUR9
	ffwwfnBIQvPMfQqZMac6RSsVJS/4gu5YZlyLo8k4fWGdxWcCvlU+lTmOmV8a7ACK2pQOv30nRreY8
	lmUOBqLtak7xhVx4eQOrMIdXQFEl4QYZMcxTO7s2Cp9kSh/PbQR2jOOyGOO61KNrUhu4jbGTKrsai
	wtqj2rlXVfUz7zrE+MH1tsxWDzVuc3Vs6iBYF2L4v23RrU9ZLbIwmIpdddOxrIamD00uHWlqcTtUe
	HQEttr+kB/kD40dbz8Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEKM-0005FV-Jo; Wed, 09 Jan 2019 13:55:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEJs-0003ZW-3P
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:54:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBBC1165C;
 Wed,  9 Jan 2019 05:54:55 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093EB3F6CF;
 Wed,  9 Jan 2019 05:54:54 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: KVM: Drop VHE-specific HYP call stub
Date: Wed,  9 Jan 2019 13:54:35 +0000
Message-Id: <20190109135435.178664-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109135435.178664-1-marc.zyngier@arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_055456_140340_D2A74448 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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

We now call VHE code directly, without going through any central
dispatching function. Let's drop that code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S           |  3 ---
 arch/arm64/kvm/hyp/hyp-entry.S | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 952f6cb9cf72..2845aa680841 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -40,9 +40,6 @@
  * arch/arm64/kernel/hyp_stub.S.
  */
 ENTRY(__kvm_call_hyp)
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
 	hvc	#0
 	ret
-alternative_else_nop_endif
-	b	__vhe_hyp_call
 ENDPROC(__kvm_call_hyp)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 73c1b483ec39..2b1e686772bf 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -43,18 +43,6 @@
 	ldr	lr, [sp], #16
 .endm
 
-ENTRY(__vhe_hyp_call)
-	do_el2_call
-	/*
-	 * We used to rely on having an exception return to get
-	 * an implicit isb. In the E2H case, we don't have it anymore.
-	 * rather than changing all the leaf functions, just do it here
-	 * before returning to the rest of the kernel.
-	 */
-	isb
-	ret
-ENDPROC(__vhe_hyp_call)
-
 el1_sync:				// Guest trapped into EL2
 
 	mrs	x0, esr_el2
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43223C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAA720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZM1gjZ28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAA720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kED1pT5VFHdsVBVrAJ/mh9tUOCzgOkPylgXDIjhRT1I=; b=ZM1gjZ28rZhNg061D0q4xa6hVT
	Y9gnnkPnwW9GRzLR1Ao3rEFL3LfZVgrvcbx2Oh2dHconvKRTTyi9cgbBnpL/yD+RCS3Lb1u03/3Rb
	qgxsFn9IvxfMV46Lmncr2QpId31T801qOS6vr+siBEJ446mfk0RH7yK4h687IoQElq/qRJXh6Vvwd
	6CUQIHWWjPxfws6Tea+Ky5Rs0/wVfwBkfQfUcCuO6+nBSbLIlzJFdjTOTZf4uArH7KPfPO+hhMFTU
	zGDhROoEmlAsRly6dX+uBWInHyJ3l96YwSlqalfA/ckRFb3ti01b0eTvH62PQr7caG40lu4ZiuW9t
	X3VA9YtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWqa-0007sl-Vk; Fri, 18 Jan 2019 16:18:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWo1-0005dy-Ei
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:16:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1951B168F;
 Fri, 18 Jan 2019 08:15:41 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 290E43F557;
 Fri, 18 Jan 2019 08:15:39 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 12/12] arm64: [HACK] Check that out-of-range SVE register
 IDs can't be dumped
Date: Fri, 18 Jan 2019 16:14:21 +0000
Message-Id: <1547828061-20462-13-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
References: <1547828061-20462-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_081542_398289_92FBFF9B 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As a sanity-check that invalid SVE register IDs can't be accessed
via KVM_GET_ONE_REG, this patch adds code to attempt to do just
that (at the expense of making dumping even slower).

Because of the way the register IDs are encoded, out-of-range slice
IDs may still result in a valid register encoding, so there is
nothing to test for that case.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch64/kvm-cpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
index 28c5010..6b1580c 100644
--- a/arm/aarch64/kvm-cpu.c
+++ b/arm/aarch64/kvm-cpu.c
@@ -247,7 +247,7 @@ static void show_sve_zn_slice(int debug_fd, struct kvm_cpu const *vcpu,
 	sappendf(&strp, &strsz, " Z%.2u/%.2u:", n, i);
 	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
 		dprintf(debug_fd, "%s(%s)\n", str, strerror(errno));
-		if (vcpu->kvm->cfg.arch.has_sve)
+		if (n < 32 && vcpu->kvm->cfg.arch.has_sve)
 			die("Z-reg unexpectedly absent on SVE vcpu");
 
 		return;
@@ -256,6 +256,9 @@ static void show_sve_zn_slice(int debug_fd, struct kvm_cpu const *vcpu,
 	if (!vcpu->kvm->cfg.arch.has_sve)
 		die("Z-reg unexpectedly present on non-SVE vcpu");
 
+	if (n >= 32)
+		die("Out-of-range Z-reg unexpectedly present");
+
 	sappend_bytes(&strp, &strsz, bytes, sizeof bytes);
 	dprintf(debug_fd, "%s\n", str);
 }
@@ -292,7 +295,7 @@ static void show_sve_pn_slice(int debug_fd, struct kvm_cpu const *vcpu,
 
 	if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0) {
 		dprintf(debug_fd, "%s(%s)\n", str, strerror(errno));
-		if (vcpu->kvm->cfg.arch.has_sve)
+		if (n < 16 + 1 /* FFR */ && vcpu->kvm->cfg.arch.has_sve)
 			die("P-reg unexpectedly absent on SVE vcpu");
 
 		return;
@@ -301,6 +304,9 @@ static void show_sve_pn_slice(int debug_fd, struct kvm_cpu const *vcpu,
 	if (!vcpu->kvm->cfg.arch.has_sve)
 		die("P-reg unexpectedly present on non-SVE vcpu");
 
+	if (n >= 16 && reg.id != KVM_REG_ARM64_SVE_FFR(i))
+		die("Out-of-range P-reg unexpectedly present");
+
 	sappend_bytes(&strp, &strsz, bytes, sizeof bytes);
 	dprintf(debug_fd, "%s\n", str);
 }
@@ -406,9 +412,9 @@ void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
 		dprintf(debug_fd, " ZCR_EL1:0x%lx\n", data);
 	}
 
-	for (i = 0; i < 32; ++i)
+	for (i = 0; i < 32 + 1 /* should fail */; ++i)
 		show_sve_zn(debug_fd, vcpu, i);
 
-	for (i = 0; i < 16 + 1 /*FFR*/; ++i)
+	for (i = 0; i < 16 + 1 /* FFR */ + 1 /* should fail */; ++i)
 		show_sve_pn(debug_fd, vcpu, i);
 }
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

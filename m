Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F314C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406772082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OXMJNCZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406772082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7uEkrKWRawDCLlRKajjmy3AM21f3q7OrMyFF20V1XUo=; b=OXMJNCZfci5asG4tPUirbZX+h1
	e11XlrXZ3GscJ6q3aehE/XrQ3CkIdyT1aGNyw22rxhm5Xas0XfIkia5se/TsqTDKbn/Dd2e+b+CRt
	r4xEhjzwI9xNaqWFVEECTMp+sSQZNYXokGw24vKhRUwnSZbh9MHPlIkry18B/NAnaP1YLY8peUi91
	gimBoNk0Z8tkTfzFYwpu9IabpvGnHD1O6Rv0bXOgyz+BTSVcfRO3d27SNy0JJrqzT7NKR465XOOcI
	sm8jRq+xIBqHHHY3pjYU1gebPnHnlN8Hv1OVbVFBMQnZxjavEIoPWbSJUqFzRH3CpNP+Qp73DTulV
	vgp2xXtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmy5u-0004RE-Ry; Fri, 25 Jan 2019 09:48:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmy4u-0003Ja-Sx
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:47:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA9F165C;
 Fri, 25 Jan 2019 01:47:12 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8463F589;
 Fri, 25 Jan 2019 01:47:12 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] arm/arm64: KVM: Don't panic on failure to properly reset
 system registers
Date: Fri, 25 Jan 2019 10:46:56 +0100
Message-Id: <20190125094656.5026-6-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125094656.5026-1-christoffer.dall@arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014713_505663_A1E7060D 
X-CRM114-Status: GOOD (  11.17  )
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

Failing to properly reset system registers is pretty bad. But not
quite as bad as bringing the whole machine down... So warn loudly,
but slightly more gracefully.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm/kvm/coproc.c     | 4 ++--
 arch/arm64/kvm/sys_regs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 222c1635bc7a..e8bd288fd5be 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -1450,6 +1450,6 @@ void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
 	reset_coproc_regs(vcpu, table, num);
 
 	for (num = 1; num < NR_CP15_REGS; num++)
-		if (vcpu_cp15(vcpu, num) == 0x42424242)
-			panic("Didn't reset vcpu_cp15(vcpu, %zi)", num);
+		WARN(vcpu_cp15(vcpu, num) == 0x42424242,
+		     "Didn't reset vcpu_cp15(vcpu, %zi)", num);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 86096774abcd..4f067545c7d2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2609,6 +2609,6 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	reset_sys_reg_descs(vcpu, table, num);
 
 	for (num = 1; num < NR_SYS_REGS; num++)
-		if (__vcpu_sys_reg(vcpu, num) == 0x4242424242424242)
-			panic("Didn't reset __vcpu_sys_reg(%zi)", num);
+		WARN(__vcpu_sys_reg(vcpu, num) == 0x4242424242424242,
+		     "Didn't reset __vcpu_sys_reg(%zi)\n", num);
 }
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

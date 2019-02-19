Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:26:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38B921905
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qy025dbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38B921905
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hrbOaPn7XP0nB3qat4JHXNhwMOUyg+n/LalTs3YD+Q0=; b=qy025dbTD3as6AHMqo2WQ6PpeO
	f9xadfwIWf1zvMYXGTzb7baqLYk52iAQCw3+7MLXSIL3Ypk1vVwPiGXU3aytWc4dskct0ZfODxtXY
	iyGBN0kgLfw/OTwGeKFY22YsyEpRDfle3F+EFUomm1ffrGrI0jIMAEx9GldSRBdtG4Znu+w2WeBJF
	8x7aWf8bpJ4ZT5ZYoeN7li2v8rXKSHPNf39gro14qWwjI9e3GeOJWJ0VZ6n7nr/ASJ1RlU4IzC8pc
	IBhyS6OcNrsQkIY0fYO0hZzl4QDqPDW8vqwEBSVBuHtH1F2jesxWOuxP2GagnEwnP+ewEUqj+oLLw
	LGphFVpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1fj-0006Ge-WE; Tue, 19 Feb 2019 09:26:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1ea-00051L-Hj
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:25:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4EE1596;
 Tue, 19 Feb 2019 01:25:25 -0800 (PST)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E45713F675;
 Tue, 19 Feb 2019 01:25:15 -0800 (PST)
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 5/6] arm64/kvm: control accessibility of ptrauth key
 registers
Date: Tue, 19 Feb 2019 14:54:30 +0530
Message-Id: <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_012529_161891_E9773BC7 
X-CRM114-Status: GOOD (  13.14  )
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
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 James Morse <james.morse@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to userspace settings, ptrauth key registers are conditionally
present in guest system register list based on user specified flag
KVM_ARM_VCPU_PTRAUTH.

Reset routines still sets these registers to default values but they are
left like that as they are conditionally accessible (set/get).

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
This patch needs patch [1] by Dave Martin and adds feature to manage accessibility in a scalable way.

[1]: https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send-email-Dave.Martin@arm.com/ 

 Documentation/arm64/pointer-authentication.txt | 4 ++++
 arch/arm64/kvm/sys_regs.c                      | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
index 0529a7d..996e435 100644
--- a/Documentation/arm64/pointer-authentication.txt
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -87,3 +87,7 @@ created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
 to be enabled. Without this flag, pointer authentication is not enabled
 in KVM guests and attempted use of the feature will result in an UNDEFINED
 exception being injected into the guest.
+
+Additionally, when KVM_ARM_VCPU_PTRAUTH is not set then KVM will filter
+out the Pointer Authentication system key registers from KVM_GET/SET_REG_*
+ioctls.
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f7bcc60..c2f4974 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1005,8 +1005,13 @@ static bool trap_ptrauth(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static bool check_ptrauth(const struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
+{
+	return kvm_arm_vcpu_ptrauth_allowed(vcpu);
+}
+
 #define __PTRAUTH_KEY(k)						\
-	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k }
+	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k , .check_present = check_ptrauth}
 
 #define PTRAUTH_KEY(k)							\
 	__PTRAUTH_KEY(k ## KEYLO_EL1),					\
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

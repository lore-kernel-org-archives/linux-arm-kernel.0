Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D394C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:05:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAC220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bVKtSVmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAC220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2lcInDVU2pOSHoPY+AjcIT8dD0jb9b3XhFxvkQr3Tlw=; b=bVKtSVmEvlC2Vttmpxjus1w7vg
	Qp+wgsGGAXVUjd0BfnS46z1FTOcxcX66yk8CWEQDSwR9jmE0w5xATnKgNiPHHLhtujE2glS8Uc19X
	MftBAAWlq+88jy6yCEzXnJSIr6gqHxcpHf8iqfxa8YXMo9EebYEvQlIrbUmW5pwbk7tpnaI2KxzSZ
	WKsQwX7oG+DFMBukAiC4Lfi0m3vkS4p7K2tmaVW07GOWrIPqUPvigaqvF4LbPBvx1m5oBzMj4XNQj
	cx/wxtl2xJ0tbfzFiLwOKbdrxsUVgM6wPEn+ZMu1c7t70jA4nJFkvS4eTpHqOalojKLf/62GOy4iO
	tI7n1olw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEdg-0003Sk-Mf; Thu, 17 Jan 2019 20:51:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENK-0000A1-WA
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A910A1650;
 Thu, 17 Jan 2019 12:34:54 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCED43F819;
 Thu, 17 Jan 2019 12:34:52 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 12/25] KVM: arm64: Support runtime sysreg filtering for
 KVM_GET_REG_LIST
Date: Thu, 17 Jan 2019 20:33:26 +0000
Message-Id: <1547757219-19439-13-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_123455_580396_155FFBA0 
X-CRM114-Status: GOOD (  16.59  )
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KVM_GET_REG_LIST should only enumerate registers that are actually
accessible, so it is necessary to filter out any register that is
not exposed to the guest.  For features that are configured at
runtime, this will require a dynamic check.

For example, ZCR_EL1 and ID_AA64ZFR0_EL1 would need to be hidden
if SVE is not enabled for the guest.

Special-casing walk_one_sys_reg() for specific registers will make
the code unnecessarily messy, so this patch adds a new sysreg
method check_present() that, if defined, indicates whether the
sysreg should be enumerated.  If the guest runtime configuration
may require a particular system register to be hidden,
check_present should point to a function that returns true or false
to enable or disable enumeration of that register respectively.

Currently check_present() is not used for any other purpose, but it
may be a useful foundation for abstracting other parts of the code
to handle conditionally-present sysregs, if required.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 10 +++++++---
 arch/arm64/kvm/sys_regs.h |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 71c5825..bca32d5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2447,7 +2447,8 @@ static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
 	return true;
 }
 
-static int walk_one_sys_reg(const struct sys_reg_desc *rd,
+static int walk_one_sys_reg(const struct kvm_vcpu *vcpu,
+			    const struct sys_reg_desc *rd,
 			    u64 __user **uind,
 			    unsigned int *total)
 {
@@ -2458,6 +2459,9 @@ static int walk_one_sys_reg(const struct sys_reg_desc *rd,
 	if (!(rd->reg || rd->get_user))
 		return 0;
 
+	if (rd->check_present && !rd->check_present(vcpu, rd))
+		return 0;
+
 	if (!copy_reg_to_user(rd, uind))
 		return -EFAULT;
 
@@ -2486,9 +2490,9 @@ static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
 		int cmp = cmp_sys_reg(i1, i2);
 		/* target-specific overrides generic entry. */
 		if (cmp <= 0)
-			err = walk_one_sys_reg(i1, &uind, &total);
+			err = walk_one_sys_reg(vcpu, i1, &uind, &total);
 		else
-			err = walk_one_sys_reg(i2, &uind, &total);
+			err = walk_one_sys_reg(vcpu, i2, &uind, &total);
 
 		if (err)
 			return err;
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 174ffc0..472e8f1 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -69,6 +69,10 @@ struct sys_reg_desc {
 			const struct kvm_one_reg *reg, void __user *uaddr);
 	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			const struct kvm_one_reg *reg, void __user *uaddr);
+
+	/* Return true iff the register exists; assume present if NULL */
+	bool (*check_present)(const struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *rd);
 };
 
 static inline void print_sys_reg_instr(const struct sys_reg_params *p)
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

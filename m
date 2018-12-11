Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ABFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:31:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831AB20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CZN8stoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831AB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bySMW1RZc1lK4yTPTcO8rJlpy8ccvGeXHrV6oNGJ5Ck=; b=CZN8stoLs5Hb/aK3s9M/JD0dLc
	DfVCFKI516jEsBnLhAwn8mung6DhlffmndvoultkvTb7f28yy7IkLk7EQFgyshPmf0fVJGbw/5Xlz
	xmrNdr83hDXsVgDbL91imfQuFfNY7GoZOa9g/0Z4etrG+8aUo87J0BYBuPSEbsVM6WGByj8FLCsTN
	YBu7tgHzLa4bKyItz0Fb9sVe4MZSVXCLyg7odlAcCvB4l1Eq4mzY0sL30DctPCi2mJgdFlwdR/cS0
	xurS4fwTeyT2MgBoOyy/mxt99U4acw74qddRtaw2gvTGglXeENlZbwuCkVkwhz/OWfds8+ewbZ0Qj
	S8ZH2xmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWrVH-0006XU-5y; Tue, 11 Dec 2018 23:31:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWrTh-0004aU-RK
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:30:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721BA1596;
 Tue, 11 Dec 2018 15:30:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C85203F614;
 Tue, 11 Dec 2018 15:30:07 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 10/24] KVM: arm64: Extend reset_unknown() to handle
 mixed RES0/UNKNOWN registers
Date: Tue, 11 Dec 2018 23:28:47 +0000
Message-Id: <1544570941-7377-11-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
References: <1544570941-7377-1-git-send-email-Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_153014_632997_B3C23F6F 
X-CRM114-Status: GOOD (  13.50  )
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
 Will Deacon <will.deacon@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The reset_unknown() system register helper initialises a guest
register to a distinctive junk value on vcpu reset, to help expose
and debug deficient register initialisation within the guest.

Some registers such as the SVE control register ZCR_EL1 contain a
mixture of UNKNOWN fields and RES0 bits.  For these,
reset_unknown() does not work at present, since it sets all bits to
junk values instead of just the wanted bits.

There is no need to craft another special helper just for that,
since reset_unknown() almost does the appropriate thing anyway.
This patch takes advantage of the ununused val field in struct
sys_reg_desc to specify a mask of bits that should be initialised
to zero instead of junk.

All existing users of reset_unknown() do not (and should not)
define a value for val, so they will implicitly set it to zero,
resulting in all bits being made UNKNOWN by this function: thus,
this patch makes no functional change for currently defined
registers.

Future patches will make use of non-zero val.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since RFC v2:

 * Document the reset_unknown() semantics of val in the struct
   sys_reg_desc definition in sys_regs.h.
---
 arch/arm64/kvm/sys_regs.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index cd710f8..add27cc 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -53,7 +53,12 @@ struct sys_reg_desc {
 	/* Index into sys_reg[], or 0 if we don't need to save it. */
 	int reg;
 
-	/* Value (usually reset value) */
+	/*
+	 * Value (usually reset value)
+	 * For reset_unknown, each bit set to 1 in val is treated as
+	 * RES0 in the register: the corresponding register bit is
+	 * reset to 0 instead of "unknown".
+	 */
 	u64 val;
 
 	/* Custom get/set_user functions, fallback to generic if NULL */
@@ -89,7 +94,9 @@ static inline void reset_unknown(struct kvm_vcpu *vcpu,
 {
 	BUG_ON(!r->reg);
 	BUG_ON(r->reg >= NR_SYS_REGS);
-	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
+
+	/* If non-zero, r->val specifies which register bits are RES0: */
+	__vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL & ~r->val;
 }
 
 static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B361DC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B2F21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQtMRaLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B2F21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q3Vjt3LBk2ap6iGSzQlNBmkUriVlSa3iYiIWGOosGsE=; b=fQtMRaLX610FuNXO7HpUrOp3Ao
	3t4qPZ0Q3LTDiG+NzQHRSYYinvoEgt5iJrLIryUol18WNsN2I3c1UlFVGNnlfyVKOhQwNgNWqpdLu
	qH//FQGq+BLqIucR2WrW48a8Pn3QRpZoJXdov57HM1aLqwwnvtU3XVoRDSRvYh9CpyQlxuCEAnk32
	nSeY9oeAEWefkx78ojLgmDrc36H350K3kBTndAGZ65l/uiizEZ6b59bgCvj3l5KvnXacXLUqO4U+v
	zTn8wSgAxS3nhhsUIsZRLKSaunmSvOk59OLe/G3kSqOJTIBgbhJyNpGUCk8QI8i2oicfZGC4O3lFo
	+bNMeEpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfbQ-0005OR-Ch; Thu, 24 Jan 2019 14:03:32 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfYw-000375-KT
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:01:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5358CA78;
 Thu, 24 Jan 2019 06:00:58 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8E863F614;
 Thu, 24 Jan 2019 06:00:57 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/14] KVM: arm64: Reuse sys_reg() macro when searching the
 trap table
Date: Thu, 24 Jan 2019 15:00:27 +0100
Message-Id: <20190124140032.8588-10-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190124140032.8588-1-christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060058_681386_D40DEB23 
X-CRM114-Status: GOOD (  11.04  )
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

Instead of having an open-coded macro, reuse the sys_reg() macro
that does the exact same thing.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e3e37228ae4e..1a5bea4285e4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -965,6 +965,10 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+#define reg_to_encoding(x)						\
+	sys_reg((u32)(x)->Op0, (u32)(x)->Op1,				\
+		(u32)(x)->CRn, (u32)(x)->CRm, (u32)(x)->Op2);
+
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
 #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
 	{ SYS_DESC(SYS_DBGBVRn_EL1(n)),					\
@@ -1820,30 +1824,19 @@ static const struct sys_reg_desc *get_target_table(unsigned target,
 	}
 }
 
-#define reg_to_match_value(x)						\
-	({								\
-		unsigned long val;					\
-		val  = (x)->Op0 << 14;					\
-		val |= (x)->Op1 << 11;					\
-		val |= (x)->CRn << 7;					\
-		val |= (x)->CRm << 3;					\
-		val |= (x)->Op2;					\
-		val;							\
-	 })
-
 static int match_sys_reg(const void *key, const void *elt)
 {
 	const unsigned long pval = (unsigned long)key;
 	const struct sys_reg_desc *r = elt;
 
-	return pval - reg_to_match_value(r);
+	return pval - reg_to_encoding(r);
 }
 
 static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
 					 const struct sys_reg_desc table[],
 					 unsigned int num)
 {
-	unsigned long pval = reg_to_match_value(params);
+	unsigned long pval = reg_to_encoding(params);
 
 	return bsearch((void *)pval, table, num, sizeof(table[0]), match_sys_reg);
 }
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

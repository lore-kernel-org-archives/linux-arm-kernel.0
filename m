Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3E9C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:06:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD412054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GzVOKE+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD412054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bkQLT36JQKq0eDU1zBRkZLQKC7egURf3Zd/Fccbbzps=; b=GzV
	OKE+MMUYMNCQ5Rpx2y5hGpgJDqlGoF9dGNPLWDMh2fpBJoZ5SyAvGNs6E58DMjfV3nes38PsFjAPq
	j2J6NOAgoJQen5Ui1Qf7G/NNBwrfnIWGKxEN+PU5tHqUFk8R2dUV1JOtk0m4h8d8yzGqJrXsL1fKC
	5Ro8oSlfrBz2C8wjBxVJu8+TWRQqsfSO/rZkgfekKi/bTurXCjo5ErtwKx6H9cYBbk7SrR/EK5ds4
	mTmXjY0T/QGPm9MAUcwB1PsRnko3zJ8NUfgsWTctkYmiX3HzVBIfuH7ChscsCsRV2PBQdgiNo+DjA
	rCL1EZdlQPdPg3byxU9kEZM81FfLZjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTV0-0002Qn-0c; Thu, 13 Dec 2018 16:06:06 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTUx-0002Q5-7b
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:06:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C62880D;
 Thu, 13 Dec 2018 08:05:52 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C1FA3F614;
 Thu, 13 Dec 2018 08:05:52 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id E53451AE0F54; Thu, 13 Dec 2018 16:06:15 +0000 (GMT)
From: Will Deacon <will.deacon@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH] arm64: kvm: Avoid setting the upper 32 bits of VTCR_EL2 to 1
Date: Thu, 13 Dec 2018 16:06:14 +0000
Message-Id: <1544717174-15116-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_080603_277946_FA0935CC 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Christoffer Dall <christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Although bit 31 of VTCR_EL2 is RES1, we inadvertently end up setting all
of the upper 32 bits to 1 as well because we define VTCR_EL2_RES1 as
signed, which is sign-extended when assigning to kvm->arch.vtcr.

Lucky for us, the architecture currently treats these upper bits as RES0
so, whilst we've been naughty, we haven't set fire to anything yet.

Cc: <stable@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6f602af5263c..2dafd936d84d 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -104,7 +104,7 @@
 			 TCR_EL2_ORGN0_MASK | TCR_EL2_IRGN0_MASK | TCR_EL2_T0SZ_MASK)
 
 /* VTCR_EL2 Registers bits */
-#define VTCR_EL2_RES1		(1 << 31)
+#define VTCR_EL2_RES1		(1U << 31)
 #define VTCR_EL2_HD		(1 << 22)
 #define VTCR_EL2_HA		(1 << 21)
 #define VTCR_EL2_PS_SHIFT	TCR_EL2_PS_SHIFT
-- 
2.1.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

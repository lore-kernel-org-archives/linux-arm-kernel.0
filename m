Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62302C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3250C20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cd56ZKkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3250C20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=qgHPwIw+SMeSBJx2omOiW8FCMUTW/Sjrqc1rSXerCiM=; b=cd56ZKklH2rB9w4ODYn6Dhe/H0
	i2fXjmSCGKzoZ8SUUOt+SWrUlCUvbJaxf7HGgWvLZ6uFjorW93fr1Nx1JruBsgq/khdAt3mzyeg9f
	u2lNdnopbwkwsXrQVV/yDF0nb00jCGeBYe/0eK9E3+IWRC9k/CzQ+UDy+1x2N3DmiAfuFGIHC61cg
	NcDbfIDgY/Xvphd5UEa+wXoRWP3rILEmZ26DbbQ9Ei2X1AAEOzUpPPEnDq5lg3dV1JBR6lG935RRp
	6xuRgY3Ejg5WL10YqDwXn5oSQB7MjI3fcN1y2tSnF62DQJMIv8ZN9qs7sa04sHYZepdTflSSaltB4
	0ArTMPug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNIo-00035Y-E9; Wed, 06 Feb 2019 13:31:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNIk-000348-Gb
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 13:31:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2855215AB;
 Wed,  6 Feb 2019 05:31:40 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D493F557;
 Wed,  6 Feb 2019 05:31:38 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/6] arm64: Handle trapped DC CVADP
Date: Wed,  6 Feb 2019 13:31:03 +0000
Message-Id: <1549459868-45992-2-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
References: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_053142_550762_BDF94081 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The ARMv8.5 DC CVADP instruction may be trapped to EL1 via
SCTLR_EL1.UCI therefore let's provide a handler for it.

Just like the CVAP instruction we use a 'sys' instruction instead of
the 'dc' alias to avoid build issues with older toolchains.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/esr.h | 3 ++-
 arch/arm64/kernel/traps.c    | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 52233f0..07d5c02 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -198,9 +198,10 @@
 /*
  * User space cache operations have the following sysreg encoding
  * in System instructions.
- * op0=1, op1=3, op2=1, crn=7, crm={ 5, 10, 11, 12, 14 }, WRITE (L=0)
+ * op0=1, op1=3, op2=1, crn=7, crm={ 5, 10, 11, 12, 13, 14 }, WRITE (L=0)
  */
 #define ESR_ELx_SYS64_ISS_CRM_DC_CIVAC	14
+#define ESR_ELx_SYS64_ISS_CRM_DC_CVADP	13
 #define ESR_ELx_SYS64_ISS_CRM_DC_CVAP	12
 #define ESR_ELx_SYS64_ISS_CRM_DC_CVAU	11
 #define ESR_ELx_SYS64_ISS_CRM_DC_CVAC	10
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4e2fb87..d1299b6 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -459,6 +459,9 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAC:	/* DC CVAC, gets promoted */
 		__user_cache_maint("dc civac", address, ret);
 		break;
+	case ESR_ELx_SYS64_ISS_CRM_DC_CVADP:	/* DC CVADP */
+		__user_cache_maint("sys 3, c7, c13, 1", address, ret);
+		break;
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAP:	/* DC CVAP */
 		__user_cache_maint("sys 3, c7, c12, 1", address, ret);
 		break;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

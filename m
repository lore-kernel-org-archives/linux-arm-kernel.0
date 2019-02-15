Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:06:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2488D21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZaLwBoY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2488D21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Rk3T3+9QvEVeiMoK8+UpOVp4gmSbaymuU1CX0enp+3o=; b=ZaLwBoY6G9IlDO
	qbSZtBgafvhIm3r1eP0W+vM/Tq25wOyVuWHnRytJCTHH3UrnyHdJg0f+46v3tVvRJj4V/UwBLy4Q/
	l8txiYzh6YfhNP2xIUNsi35sWZnKDzfLsDMZrXwxZZJim83yQutKrAJ7VP++cWcqcHgLGK9cVEhUD
	jFzlNbhlJM+7cLd1UBrwoEJlfl5MvT+RfhcL+SxcPBcuZ8Yi7FoIiewbgZPIAi5sLxLtgIjX2v00C
	vxQb87avCyvHALVti4McWVJm7rDDhV9elT4GB3wVb8iRVNOEWe9S5CbCATSnTqdQSXpl5OIbO0Y+N
	Dh6b2KEfK1mwDMtWA/AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guaNe-0003Zb-7s; Fri, 15 Feb 2019 10:06:02 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guaNa-0003ZD-Fs
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 10:05:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65ABFA78
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 02:05:55 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D729E3F557
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 02:05:54 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: NOMMU: Fix encodings for PMSAv8's PRBAR4/PRLAR4
Date: Fri, 15 Feb 2019 10:05:45 +0000
Message-Id: <1550225145-9571-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_020558_535913_8EE6080C 
X-CRM114-Status: GOOD (  10.98  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To access PRBARn, where n is referenced as a binary number:

MRC p15, 0, <Rt>, c6, c8+n[3:1], 4*n[0] ; Read PRBARn into Rt
MCR p15, 0, <Rt>, c6, c8+n[3:1], 4*n[0] ; Write Rt into PRBARn

To access PRLARn, where n is referenced as a binary number:

MRC p15, 0, <Rt>, c6, c8+n[3:1], 4*n[0]+1 ; Read PRLARn into Rt
MCR p15, 0, <Rt>, c6, c8+n[3:1], 4*n[0]+1 ; Write Rt into PRLARn

For PR{B,L}AR4, n is 4, n[0] is 0, n[3:1] is 2, while current encoding
done with n[0] set to 1 which is wrong. Use proper encoding instead.

Fixes: 046835b4aa22b9ab6aa0bb274e3b71047c4b887d ("ARM: 8757/1: NOMMU: Support PMSAv8 MPU")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index ec29de2..c08d2d8 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -439,8 +439,8 @@ M_CLASS(str	r6, [r12, #PMSAv8_RLAR_A(3)])
 	str	r5, [r12, #PMSAv8_RBAR_A(0)]
 	str	r6, [r12, #PMSAv8_RLAR_A(0)]
 #else
-	mcr	p15, 0, r5, c6, c10, 1			@ PRBAR4
-	mcr	p15, 0, r6, c6, c10, 2			@ PRLAR4
+	mcr	p15, 0, r5, c6, c10, 0			@ PRBAR4
+	mcr	p15, 0, r6, c6, c10, 1			@ PRLAR4
 #endif
 #endif
 	ret	lr
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

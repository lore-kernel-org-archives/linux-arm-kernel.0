Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63944C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E6C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7CoozCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E6C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XU+cvUiMd/9Uy0lJjbLv6qsJVyNM6QINAG+GJ0PDiW0=; b=p7CoozCUa9yLTWB5Z/Nvmh9NPP
	nuP510LN3vm2q0ok4Xa5CagYJs6iej6U5+gCF1VhuqfA3LfVc1WLY0THjA0GPcsVH8VTQxd8N58De
	tw6wmdSlPCYa52jQRFEMcsiqq4kSRoO6m801FtR6eyEI0tVQZaZedTAlFWv054+8RbETPeEBDD9sw
	wfcI9AOcFzkU8QaqM8XzFghNE2YfvNUUfWVyvTNOZmz3lYKo/1v5vNuYfhm6m0SEKo0TYORfHobCp
	Dg1GVwCutw4/oQoASZb3n1qm2IXxKhi9RooN0kXogMj5VaRxpId0UpY0vWRwOWGT735KhuDlqVnMh
	erxmvkMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXJB-0000fS-VO; Fri, 18 Jan 2019 16:47:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXI4-00085o-SP
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:46:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE6451684;
 Fri, 18 Jan 2019 08:46:44 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A483F7BE;
 Fri, 18 Jan 2019 08:46:42 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 4/8] arm64/fpsimdmacros: Introduce a macro to update
 ZCR_EL1.LEN
Date: Fri, 18 Jan 2019 16:46:06 +0000
Message-Id: <20190118164610.8123-5-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190118164610.8123-1-julien.grall@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084645_008832_21709612 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, Julien Grall <julien.grall@arm.com>,
 alex.bennee@linaro.org, Dave.Martin@arm.com, Daniel.Kiss@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A follow-up patch will need to update ZCR_EL1.LEN.

Add a macro that could be re-used in the current and new place to avoid
code duplication.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/include/asm/fpsimdmacros.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index e2ab77dd9b4f..5e291d9c1ba0 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -198,6 +198,17 @@
 	.purgem _for__body
 .endm
 
+/* Update ZCR_EL1.LEN with the new VQ */
+.macro sve_load_vq xvqminus1, xtmp, xtmp2
+		mrs_s		\xtmp, SYS_ZCR_EL1
+		bic		\xtmp2, \xtmp, ZCR_ELx_LEN_MASK
+		orr		\xtmp2, \xtmp2, \xvqminus1
+		cmp		\xtmp2, \xtmp
+		b.eq		921f
+		msr_s		SYS_ZCR_EL1, \xtmp2	//self-synchronising
+921:
+.endm
+
 .macro sve_save nxbase, xpfpsr, nxtmp
  _for n, 0, 31,	_sve_str_v	\n, \nxbase, \n - 34
  _for n, 0, 15,	_sve_str_p	\n, \nxbase, \n - 16
@@ -212,13 +223,7 @@
 .endm
 
 .macro sve_load nxbase, xpfpsr, xvqminus1, nxtmp, xtmp2
-		mrs_s		x\nxtmp, SYS_ZCR_EL1
-		bic		\xtmp2, x\nxtmp, ZCR_ELx_LEN_MASK
-		orr		\xtmp2, \xtmp2, \xvqminus1
-		cmp		\xtmp2, x\nxtmp
-		b.eq		921f
-		msr_s		SYS_ZCR_EL1, \xtmp2	// self-synchronising
-921:
+		sve_load_vq	\xvqminus1, x\nxtmp, \xtmp2
  _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
 		_sve_ldr_p	0, \nxbase
 		_sve_wrffr	0
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

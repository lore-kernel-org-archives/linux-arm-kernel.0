Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:05:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71082087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vb0wvfJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71082087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xZ0HfIbvWtBXfMSD3foBoZQuFjggnF5UGcxAShtIzPE=; b=Vb0wvfJvUUNmBIqqmGDaWvkcP4
	qNlZlF1DWXm1xpcBt0nuAyL2DWvVZj/sVUXhrmaY/EWteM4+RNq3WWLOID/ThSj6Ly6+clymZHrgI
	lr2xGBGCPMc9RKFgkNPLHTSnKPiBZ8e502aLgQ3huDqgFkJxfPS5F8/rRLnwuItoay2G+z6zlvDR2
	dvuduPu70yVxSFR3f1GOlYx528NsLjN0vDlPi43xQLZ8vymt0fp0jZTUJk7pzXdnqR5cy47lUbkac
	qFwJ2Qo5SdNfEDiZJ31zjnAue7qWgBTgwywSVwoj7OtCJht5leibAlaE23GBzBYepKHi2N2LYIj1h
	v/ehumSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy8Rt-0007AQ-Sm; Mon, 25 Feb 2019 05:05:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy8RA-0006Hv-G3
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 05:04:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C3C80D;
 Sun, 24 Feb 2019 21:04:19 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.42.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C1763F5C1;
 Sun, 24 Feb 2019 21:04:16 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 5/6] arm64/mm: Enable page table page accounting for user
 space
Date: Mon, 25 Feb 2019 10:33:58 +0530
Message-Id: <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_210420_852876_BF2523A2 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: mark.rutland@arm.com, yuzhao@google.com, Steve.Capper@arm.com,
 marc.zyngier@arm.com, Catalin.Marinas@arm.com, suzuki.poulose@arm.com,
 will.deacon@arm.com, james.morse@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Page table pages created for user space processes must be accounted against
their memory control groups if initialized. This just introduces a helper
function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
table page allocations but adds __GFP_ACCOUNT for user page table pages.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgalloc.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 076764f66fb0..a02a4d1d967d 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -100,12 +100,24 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 	return (pte_t *)pte_alloc_one_virt(mm);
 }
 
+extern struct mm_struct efi_mm;
+
+static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm)
+{
+	if (unlikely((mm == &init_mm) || (mm == &efi_mm)))
+		return PGALLOC_GFP;
+	else
+		return PGALLOC_GFP | __GFP_ACCOUNT;
+}
+
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
+	gfp_t gfp;
 
-	pte = alloc_pages(PGALLOC_GFP, 0);
+	gfp = pgtable_gfp_flags(mm);
+	pte = alloc_pages(gfp, 0);
 	if (!pte)
 		return NULL;
 	if (!pgtable_page_ctor(pte)) {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

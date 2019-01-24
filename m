Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B599C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:22:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97DB217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eDpkBJq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97DB217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=x0HXROOQaY45Q76N5L5PpTQyaBtsJHyBW45WVL+i/TY=; b=eDpkBJq1GY1HlAnCpCAmsAdkSG
	J3IkCz0oeJDYlgqiTiFjZXuc/JYjQYJ+f5igLXuodAnq/a0wTIf08OfzjvlLTna+g0bvb9sjfhlJt
	L/R0PPNfSRKi5weIQVcqm3o5ZZBmfHDHAKCpviQ5OL/7fAwGpZrmxNt3tPe7tFfdWxzA6JkgDMcGW
	mNYUtiRy4tCuzly8ONHGWA1vt2uS1AicqznKvDIcQ+Ry+GM0bHENh/lMNaLj5xMt7mKDRSYFHWhzN
	2x04cspx16yqsWrS6Pp/6CAwdhaF342EGsky7oLe995btoKPM+UfiAwpCUqWkyoc+xnjffRp3e0NC
	dlrG7Www==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmXTA-0003pV-D8; Thu, 24 Jan 2019 05:22:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmXRg-0002c8-25
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 05:21:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9665CA78;
 Wed, 23 Jan 2019 21:20:55 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.40.157])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7B973F5C1;
 Wed, 23 Jan 2019 21:20:52 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] arm64/mm: Enable page table page accounting for user space
Date: Thu, 24 Jan 2019 10:50:20 +0530
Message-Id: <1548307220-19756-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_212056_677620_D5C1DE98 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, Steve.Capper@arm.com, will.deacon@arm.com,
 james.morse@arm.com
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
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 076764f..775cde9 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -100,12 +100,22 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 	return (pte_t *)pte_alloc_one_virt(mm);
 }
 
+static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm)
+{
+	if (unlikely(mm == &init_mm))
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
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

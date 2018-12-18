Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEA5214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lEyRxmG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEA5214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TU3z9sagU4MvL2o+BUet+R+bpJKtasdLoZmqFhz8FCg=; b=lEyRxmG5tS0m1JJwfGoVCvdLpA
	ZP+sR9W+3eJaxueTLROBdlVuck8k8qHkjG5cFo27gmTnbI8DJ8irfG7uIP9Rb+tklJoiOBAl55V7J
	BiNwMF/J8+C4NMzqPFfQNtPqZJesGXWgOnAglPnUPBgMMihvCesl8wiL66VvGYo1s8r0VtknVrLEz
	j8iOUEnUjdlVNvd8AnA3vn/HNYUXJh9d0nktwbsS/D4cAfP8emmFOen+P2DOPy7XOKmD8rl2BtPLt
	cTs3v7e9yxt91wB4QZreoK876bN2tLnXFF7fC1Lwzo6Ls3nsPB1e8NMFrlCzm8TnBHLKN1IqRdvZ6
	1ZJeaAlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAg4-0001Hd-Dz; Tue, 18 Dec 2018 08:24:32 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAfp-00012r-2Q
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:24:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0123C15BF;
 Tue, 18 Dec 2018 00:24:13 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.41.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BAF93F575;
 Tue, 18 Dec 2018 00:24:09 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH V3 2/5] mm/hugetlb: Enable PUD level huge page migration
Date: Tue, 18 Dec 2018 13:54:07 +0530
Message-Id: <1545121450-1663-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
References: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_002417_302373_C94372A5 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: steve.capper@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com,
 will.deacon@arm.com, mhocko@kernel.org, akpm@linux-foundation.org,
 Steven.Price@arm.com, n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Architectures like arm64 have PUD level HugeTLB pages for certain configs
(1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
enabled for migration. It can be achieved through checking for PUD_SHIFT
order based HugeTLB pages during migration.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Steve Capper <steve.capper@arm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/hugetlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1b858d7..70bcd89 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -497,7 +497,8 @@ static inline bool hugepage_migration_supported(struct hstate *h)
 {
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 	if ((huge_page_shift(h) == PMD_SHIFT) ||
-		(huge_page_shift(h) == PGDIR_SHIFT))
+		(huge_page_shift(h) == PUD_SHIFT) ||
+			(huge_page_shift(h) == PGDIR_SHIFT))
 		return true;
 	else
 		return false;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

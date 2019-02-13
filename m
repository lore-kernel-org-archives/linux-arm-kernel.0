Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820A9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517E5222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fBoMVl97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517E5222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6v6VHFXFCiRe9eoNj2FLlBwBnWgaCndKTTPL2fJFwhc=; b=fBoMVl97KRNGF2
	jwl/hgY9mQ54V1hIyqgFWuxH7c3eUwtdlCzqpLFgSrlqM9HYiWnYeZ/MJofhMX1Y7VRCGwJKIsxbu
	qmUBmCSj3mlfWwwB9GnG1sEbqfUqDFAurHvx8oSAdjus1qzDF9JlmO39B2KX7LOC8BINyKIcZL/Q2
	Ds+E6yGLxI/0x6dwnkcg1W89P//FzxLiTA2W+XxDiHwxeV8PYhiwWsJUdSRd//rLSArMGfIAvhQy6
	kqNSo1zDvK+fOuFQlDdceEZ0hau9xtN8mqzIFf1yXE27YuqY8px2FWYWgsAB7AJsJ4bg8N/KCUKtX
	5Oi+PYoIo/pjsSqsUEdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuS0-0006qm-8g; Wed, 13 Feb 2019 13:19:44 +0000
Received: from outbound-smtp12.blacknight.com ([46.22.139.17])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuRm-0006ba-V4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:19:33 +0000
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
 by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id
 B28FF1C23FD for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:19:25 +0000 (GMT)
Received: (qmail 25019 invoked from network); 13 Feb 2019 13:19:25 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[37.228.225.79])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 13 Feb 2019 13:19:25 -0000
Date: Wed, 13 Feb 2019 13:19:23 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm, page_alloc: Fix a division by zero error when boosting
 watermarks
Message-ID: <20190213131923.GQ9565@techsingularity.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_051931_147166_98A3C94A 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yury Norov <yury.norov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Yury Norov reported that an arm64 KVM instance could not boot since after
v5.0-rc1 and could addressed by reverting the patches

1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")

The problem is that a division by zero error is possible if boosting occurs
either very early in boot or if the high watermark is very small. This
patch checks for the conditions and avoids boosting in those cases.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Reported-and-tested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..ae7e4ba5b9f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);
+
+	/* high watermark be be uninitialised or very small */
+	if (!max_boost)
+		return;
+
 	max_boost = max(pageblock_nr_pages, max_boost);
 
 	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,

-- 
Mel Gorman
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

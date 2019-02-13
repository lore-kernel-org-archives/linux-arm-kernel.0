Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F094C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:30:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBA2222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OnDzWJxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBA2222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xcaDn8wEMxYnSKGYgJxRZ4aXTtBk/nbZz4+I3x64kk=; b=OnDzWJxIy7kKrY
	Hbzt3y2BLmk9vOVIrEgEKOGDNdXpmhpTmhVkMZsAthfFB3nBPdVbQJnztS0DPx4uyV38lUW/i2var
	689dNzeZDX0s42q9NeAZQJfSg1jb7TfSegAWgMEbIATPuEa91FeSn03TPgzW2c4Y1F+b7gN4L+BVm
	mg05PC+lEPZ8Bn2koN78TVWx8wZbGd11kq01dZT2Vx/QxDgL6OgOVnXuKwHIg0j/beim0ZZBVZ78H
	XX7fgKIfvOxygHBeu3lcR7JqCZwnjQ54EOQYCgJjByWoVn5kCmuCN4gBor6LAcOl6rQjoI2kolqbO
	7Wb2EMgF1LZl5cC1bzSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvYM-00059a-1l; Wed, 13 Feb 2019 14:30:22 +0000
Received: from outbound-smtp04.blacknight.com ([81.17.249.35])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvYI-00058e-0u
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:30:19 +0000
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
 by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 9211998A96
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:30:14 +0000 (UTC)
Received: (qmail 2776 invoked from network); 13 Feb 2019 14:30:14 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[37.228.225.79])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 13 Feb 2019 14:30:14 -0000
Date: Wed, 13 Feb 2019 14:30:13 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm, page_alloc: Fix a division by zero error when boosting
 watermarks v2
Message-ID: <20190213143012.GT9565@techsingularity.net>
References: <20190213131923.GQ9565@techsingularity.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213131923.GQ9565@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_063018_199249_46123896 
X-CRM114-Status: GOOD (  12.59  )
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

The problem is that a division by zero error is possible if boosting
occurs very early in boot if the system has very little memory. This
patch avoids the division by zero error.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Reported-and-tested-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..bb1c7d843ebf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2170,6 +2170,18 @@ static inline void boost_watermark(struct zone *zone)
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);
+
+	/*
+	 * high watermark may be uninitialised if fragmentation occurs
+	 * very early in boot so do not boost. We do not fall
+	 * through and boost by pageblock_nr_pages as failing
+	 * allocations that early means that reclaim is not going
+	 * to help and it may even be impossible to reclaim the
+	 * boosted watermark resulting in a hang.
+	 */
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

Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B504DC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:42:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C951218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDsQYH95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C951218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=76s0nwu61pQcE22HyWTG0QJz7n2JL2gzcqlL2sT7pTI=; b=TDsQYH95pn2HT7
	kKpZtjZOHV7TfdKUcUj2jTs5HELzaQ5n9pnGPBz4rHpDH1TL0RFkiQ8ETc8QcZueNhJqCNlhWjQzo
	6NBry29AY+BAPilLdom53uwq6QJ0Edsqgszk0mG2zXdySKLE0OALDcm6Pnce02/cX7ZULlMfVrvcr
	qQLp90XTiMJ/rRzFPO5y1G3MOliW7CJQAo6PuifdqGKq5lFcEjSi+qjLfVg6mJUbrkLLpF3KA/ETj
	2DEGFCe0l4W/PWdLQy1oe+QImmr0acEdwgviuvyiK8gEEZ0iJeA0ETKYePkmKbhz6bcpYL2m1r8qH
	q3sgSTx5ZvwN6GSy6bOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuoE-0005eY-3j; Wed, 13 Feb 2019 13:42:42 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuoA-0005eB-LC
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:42:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F33BAAEBC;
 Wed, 13 Feb 2019 13:42:36 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: Fix a division by zero error when
 boosting watermarks
To: Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20190213131923.GQ9565@techsingularity.net>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <295be99c-d09a-5572-fa49-2673a62c295b@suse.cz>
Date: Wed, 13 Feb 2019 14:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213131923.GQ9565@techsingularity.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_054238_841889_2746F482 
X-CRM114-Status: GOOD (  20.72  )
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
 linux-mm@kvack.org, David Rientjes <rientjes@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/13/19 2:19 PM, Mel Gorman wrote:
> Yury Norov reported that an arm64 KVM instance could not boot since after
> v5.0-rc1 and could addressed by reverting the patches
> 
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> 
> The problem is that a division by zero error is possible if boosting occurs
> either very early in boot or if the high watermark is very small. This
> patch checks for the conditions and avoids boosting in those cases.

Hmm is it really a division by zero? The following line sets max_boost to
pageblock_nr_pages if it's zero. And where would the division happen anyway?

So I wonder what's going on, your patch should AFAICS only take effect when
zone->_watermark[WMARK_HIGH] is 0 or 1 to begin with, otherwise max_boost is at
least 2?

Also upon closer look, I think that (prior to the patch), boost_watermark()
could be reduced (thanks to the max+min capping) to

zone->watermark_boost = pageblock_nr_pages

?

> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Reported-and-tested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..ae7e4ba5b9f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
>  
>  	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
>  			watermark_boost_factor, 10000);
> +
> +	/* high watermark be be uninitialised or very small */
> +	if (!max_boost)
> +		return;
> +
>  	max_boost = max(pageblock_nr_pages, max_boost);
>  
>  	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

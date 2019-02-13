Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D1C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A217222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VctTgMar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A217222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q8/cs7Qp007OSIDe+8LnkGzk7HV1f2Z8Iopu8aHttxg=; b=VctTgMarhFm2L1
	PGqQQKaqTj59u7ntOAJWZscix81wLuYmqm+8+kqL/jAHvNBceP/+8bxohKFKkp7KpAIBZ5YWH5oqg
	wltUqxFVGHOzjTKiQs1O/+uYneZmViovGV0yuwUD6C6zgaumE9McJaFKMG6NMlpBl4bfx3wcTaEJI
	vMsu9S0EDShGsU3vP5WhKqhitRhxZbRtbb5AMn32anMl1Npkx7GQwDeiQo5J/h3J3pcCCQSZAI/6F
	33Ndriu8/+TiitTC9e5iZWpOSZB/U80He5dQGSu7CrgH+zGWY4BRWpBQdBQi6Rvx5zyxelm+9sSYI
	Crh2+eR0ui7aS83vLyAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtva1-0005jz-Fr; Wed, 13 Feb 2019 14:32:05 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvZy-0005iw-Et
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:32:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EDC5AAF27;
 Wed, 13 Feb 2019 14:32:00 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: Fix a division by zero error when
 boosting watermarks v2
To: Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20190213131923.GQ9565@techsingularity.net>
 <20190213143012.GT9565@techsingularity.net>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7c0d323f-cad8-205b-5a8a-60da180a4ed0@suse.cz>
Date: Wed, 13 Feb 2019 15:31:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213143012.GT9565@techsingularity.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_063202_642751_B1271336 
X-CRM114-Status: GOOD (  20.90  )
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

On 2/13/19 3:30 PM, Mel Gorman wrote:
> Yury Norov reported that an arm64 KVM instance could not boot since after
> v5.0-rc1 and could addressed by reverting the patches
> 
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> 
> The problem is that a division by zero error is possible if boosting
> occurs very early in boot if the system has very little memory. This
> patch avoids the division by zero error.
> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Reported-and-tested-by: Yury Norov <yury.norov@gmail.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, sorry for the noise before.

> ---
>  mm/page_alloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..bb1c7d843ebf 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2170,6 +2170,18 @@ static inline void boost_watermark(struct zone *zone)
>  
>  	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
>  			watermark_boost_factor, 10000);
> +
> +	/*
> +	 * high watermark may be uninitialised if fragmentation occurs
> +	 * very early in boot so do not boost. We do not fall
> +	 * through and boost by pageblock_nr_pages as failing
> +	 * allocations that early means that reclaim is not going
> +	 * to help and it may even be impossible to reclaim the
> +	 * boosted watermark resulting in a hang.
> +	 */
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

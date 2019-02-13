Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA999C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:15:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB35D222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JP7y4HkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB35D222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RcFx/IZVUzFakM70dgdE2v0KJBTZoZzvVeMau14zvTQ=; b=JP7y4HkYN32WJj
	+T0tssRNxUp6K/wNEMHS8vfvnoU1BqjfeUWL69I/uRSEu8JEtox0gVGB7es6TpvKIRzVc60fMnJUj
	KJuphXxBOXYoCYCAkLwh9+qsYsMm4VqghnKxTU6eJFbLQiFYuZ938lu4bbFC4BKUtmhXjkmsGOXr8
	PcQow0sPUjA3wsfAP2Bsvv8E0OgGIQED/t2r2UiEmqtlNr5RaUZg62VqDcFhryy2uNTp1F48S7Yqi
	7ZUSgUc/TcYWeDz+YKjesCmh+MoNcgIBQOD4BFehk2m4zGaibvPZeiPhAI4YuJxIknvqSSUjojLtG
	MqNotqfhwbE5Ay/oUG0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvJv-00061Z-1q; Wed, 13 Feb 2019 14:15:27 +0000
Received: from outbound-smtp13.blacknight.com ([46.22.139.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvJq-000605-Gx
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:15:24 +0000
Received: from mail.blacknight.com (unknown [81.17.254.26])
 by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 2870F1C18B1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:15:20 +0000 (GMT)
Received: (qmail 20426 invoked from network); 13 Feb 2019 14:15:20 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[37.228.225.79])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 13 Feb 2019 14:15:20 -0000
Date: Wed, 13 Feb 2019 14:15:18 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, page_alloc: Fix a division by zero error when
 boosting watermarks
Message-ID: <20190213141518.GS9565@techsingularity.net>
References: <20190213131923.GQ9565@techsingularity.net>
 <295be99c-d09a-5572-fa49-2673a62c295b@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <295be99c-d09a-5572-fa49-2673a62c295b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_061522_699982_C60D4A50 
X-CRM114-Status: GOOD (  16.61  )
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
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 02:42:36PM +0100, Vlastimil Babka wrote:
> On 2/13/19 2:19 PM, Mel Gorman wrote:
> > Yury Norov reported that an arm64 KVM instance could not boot since after
> > v5.0-rc1 and could addressed by reverting the patches
> > 
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > 
> > The problem is that a division by zero error is possible if boosting occurs
> > either very early in boot or if the high watermark is very small. This
> > patch checks for the conditions and avoids boosting in those cases.
> 
> Hmm is it really a division by zero? The following line sets max_boost to
> pageblock_nr_pages if it's zero. And where would the division happen anyway?
> 
> So I wonder what's going on, your patch should AFAICS only take effect when
> zone->_watermark[WMARK_HIGH] is 0 or 1 to begin with, otherwise max_boost is at
> least 2?
> 

The issue can occur if pageblock_nr_pages is also zero or not yet
initialised. It means the changelog is misleading because it  has to
trigger very early in boot as happened with Yury.

> Also upon closer look, I think that (prior to the patch), boost_watermark()
> could be reduced (thanks to the max+min capping) to
> 
> zone->watermark_boost = pageblock_nr_pages
> 

I don't think it's worth being fancy about it if we're hitting
fragmentation issues that early in boot.

-- 
Mel Gorman
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

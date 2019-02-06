Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:28:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B8A2073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NkW8jbqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B8A2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VVMEFby3kXmQvn7ICncm/wmrba1QAMgqrCNItNENIaM=; b=NkW8jbqWdIhOuk1T8u6CMJIQ+
	VJeaVVXfnhFsnEh58LR9c39yezjoDovq8Up53Gw1Bsu1hL9bXMRGElWzTtT5smnCePNXnIm4ZHafA
	M95C0pJigg2e+too7TbOj9c08+L+FJTZKNbdR1W5BEAJIOUS/LuH6XSIjokc8N/DBFZpXfdyUobCr
	CvRMfzBJM2FjQ/U2tqy//aMXk/96+DNhaqTqdYz+0TUxSU7eKOMofEvDG7EOVgfkjh8krzOspRz99
	9NhYyG1PTjdLjg0aUwBDljdH6FRD6S0qO7xT+DQ1CqsPRc+r2RGDTTkNNZ3jiTLec7H6Otkm5QdEw
	mQMYLASOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grP7x-0001Ga-55; Wed, 06 Feb 2019 15:28:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grP7n-0001Ax-CC
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:28:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA71780D;
 Wed,  6 Feb 2019 07:28:30 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B053F675;
 Wed,  6 Feb 2019 07:28:29 -0800 (PST)
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
To: Christoph Hellwig <hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
 <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com> <20190201161638.GJ6532@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
Date: Wed, 6 Feb 2019 15:28:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161638.GJ6532@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_072831_750148_F0ADB6D6 
X-CRM114-Status: GOOD (  17.78  )
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/02/2019 16:16, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 03:24:45PM +0000, Robin Murphy wrote:
>> On 14/01/2019 09:41, Christoph Hellwig wrote:
>>> Directly iterating over the pages makes the code a bit simpler and
>>> prepares for the following changes.
>>
>> It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm not
>> really buying the simplification angle - you've *seen* that code, right? ;)
> 
> How does it defeat the purpose of __iommu_dma_alloc_pages?

Because if iommu_map() only gets called at PAGE_SIZE granularity, then 
the IOMMU PTEs will be created at PAGE_SIZE (or smaller) granularity, so 
any effort to get higher-order allocations matching larger IOMMU block 
sizes is wasted, and we may as well have just done this:

	for (i = 0; i < count; i++) {
		struct page *page = alloc_page(gfp);
		...
		iommu_map(..., page_to_phys(page), PAGE_SIZE, ...);
	}

Really, it's a shame we have to split huge pages for the CPU remap, 
since in the common case the CPU MMU will have a matching block size, 
but IIRC there was something in vmap() or thereabouts that explicitly 
chokes on them.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B704C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0301620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ApyqVJzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0301620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TUN7aEst5kD//Zm1qM34Sev8uQyuTHurSjMNSPnW4S8=; b=ApyqVJzxPK+7sErIRkLMdq5pp
	vPBJw148t04Fb7iNOTljxDRTBMe0LsTsC0Pk1OfGLLOpa4amSEDXjspNeEF1PD2mfnOPoDwRAdod2
	ipQrcNqgDA58NrZOMD+2kpZGNUTaMq4jCP0DSPpBLrYnbKSK1IUqgdAK2rnVmlH/EEdE6SMS7l8up
	sYGRAAQyfOMeE8T4XhZk/hB8Sb4II0K73CWSII3sYboqGy9zCm6OBjZ2YDCjpcWIwz1CtrnpVo2iW
	y5NTgW46Z0rD40QgrHALp+i6zmDsw9zB3wldn5u6kglj72QSNIIYGBnqnwE5Tx6T9PeYBZgJAj9Za
	x9laa99rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYLj-0006Od-0n; Wed, 05 Dec 2018 14:40:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYLf-0005nL-EB
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:40:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FD2380D;
 Wed,  5 Dec 2018 06:40:12 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4E63F59C;
 Wed,  5 Dec 2018 06:40:08 -0800 (PST)
Subject: Re: [PATCH v4 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
To: Christoph Hellwig <hch@infradead.org>,
 Nicolas Boichat <drinkcat@chromium.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-4-drinkcat@chromium.org>
 <20181205135406.GA29031@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d211576-9153-cca1-5cd0-8c9881bd3fa4@arm.com>
Date: Wed, 5 Dec 2018 14:40:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205135406.GA29031@infradead.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_064023_484215_3B5F1EB3 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 Yong Wu <yong.wu@mediatek.com>, David Rientjes <rientjes@google.com>,
 yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/12/2018 13:54, Christoph Hellwig wrote:
> On Wed, Dec 05, 2018 at 01:48:28PM +0800, Nicolas Boichat wrote:
>> IOMMUs using ARMv7 short-descriptor format require page tables
>> (level 1 and 2) to be allocated within the first 4GB of RAM, even
>> on 64-bit systems.
> 
>> +#ifdef CONFIG_ZONE_DMA32
>> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
>> +#else
>> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
>> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
>> +#endif
> 
> How does using GFP_DMA make sense based on the above?  If the system
> has more than 32-bits worth of RAM it should be using GFP_DMA32, else
> GFP_KERNEL, not GFP_DMA for an arch defined small addressability pool.

32-bit Arm doesn't have ZONE_DMA32, but has (or at least had at the 
time) a 2GB ZONE_DMA. Whether we actually need that or not depends on 
how this all interacts with LPAE and highmem, but I'm not sure of those 
details off-hand.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

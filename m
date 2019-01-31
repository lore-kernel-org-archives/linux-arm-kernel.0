Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:55:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2817A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kHP87c2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2817A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OQ3gT7b/5rtmYJlqKO4amja3jNR4J0/5WIab3C68zMY=; b=kHP87c2VG2+G5u
	Dsel9XvsdYjQXaxejxuPlx8ISuOhj+UXkifYZ6r7JgvyAIhyhnM8ub8xB55weTstDpfrFYHIi41sW
	uo7z+rLgrkTFmP2a5QQ8qyEtmhtp3/Q4E7YhVQtVbPlBf66xKXlURucFnmVhXM6335FReUwqsLVUr
	PU4yvK4wapjWtwyKY2DLxdDbYD7338eT0pOKD1b5zNhFnD7S21i7KkIeiK8D9YtHas3LDqWrtainQ
	FI3oSrYQ+cZ2w5gt5RwhLtt9IRtEK456JUC8CyykPJLZhBgC/6mqCuW6vK3ldPuddwCVXgDCctZGD
	vj1E+1GuXiHKu4hM+IoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpDkj-0005Jw-02; Thu, 31 Jan 2019 14:55:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDke-0005IO-DV
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 14:55:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2A4C80D;
 Thu, 31 Jan 2019 06:55:33 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1B43F59C;
 Thu, 31 Jan 2019 06:55:32 -0800 (PST)
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
To: Zhen Lei <thunder.leizhen@huawei.com>, John Garry
 <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
Date: Thu, 31 Jan 2019 14:55:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131135211.6732-1-thunder.leizhen@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_065536_463220_02C17885 
X-CRM114-Status: GOOD (  22.21  )
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
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 31/01/2019 13:52, Zhen Lei wrote:
> Currently, many peripherals are faster than before. For example, the top
> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
> when iommu page-table mapping enabled, it's hard to reach the top speed
> in strict mode, because of frequently map and unmap operations. In order
> to keep abreast of the times, I think it's better to set non-strict as
> default.

Most users won't be aware of this relaxation and will have their system
vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
Invalidation in
http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf

Why not keep the policy to secure by default, as we do for
iommu.passthrough? And maybe add something similar to
CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
command-line argument or change the default config.

Thanks,
Jean

> 
> Below it's our iperf performance data of 25Gb netcard:
> strict mode: 18-20 Gb/s
> non-strict mode: 23.5 Gb/s
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>  drivers/iommu/iommu.c                           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b799bcf..667221f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1779,13 +1779,13 @@
> 
>  	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>  			Format: { "0" | "1" }
> -			0 - Lazy mode.
> +			0 - Lazy mode (default).
>  			  Request that DMA unmap operations use deferred
>  			  invalidation of hardware TLBs, for increased
>  			  throughput at the cost of reduced device isolation.
>  			  Will fall back to strict mode if not supported by
>  			  the relevant IOMMU driver.
> -			1 - Strict mode (default).
> +			1 - Strict mode.
>  			  DMA unmap operations invalidate IOMMU hardware TLBs
>  			  synchronously.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3ed4db3..10e0b49 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,7 @@
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> -static bool iommu_dma_strict __read_mostly = true;
> +static bool iommu_dma_strict __read_mostly;
> 
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> --
> 1.8.3
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

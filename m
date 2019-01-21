Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6333DC2F3C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DD42063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ss+q+Z8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DD42063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CEeSiryhJB1yU5Me9Nh31lvSH+MnJpTNAVsEL9S97qU=; b=Ss+q+Z8cmw051a3jqDRs5tnwt
	zzk64xeTpsxyoq8FHWIOMjlflzh/OOKY10WCTrV9tFIuSGR/SU2YeZPiePqr249ri5CpcfdJBBe9l
	Qtged3U/xS/qYszT/Y1p77uyWja10mWppJaBXf5F9HozC7+3IuzuoNevuAxST6E9yloWE/K7Zcytz
	31hzQk9OUM/X5Cmz/9Xh/rttxgY6QcMBVf39IeEvj4BVZ8zsNgS8sxwJUbnyRzXxYJY+Rd6NlJQ8L
	SJ2MDRek84I5liNlq6ozX84KaexJx72DnHTLQv9kfy31EHt53Yp7DzlZU+51DEAd+DUdhUbsRaC2s
	TYmwKhSng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZzW-0002hk-L8; Mon, 21 Jan 2019 13:51:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZzT-0002gx-Ks
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:51:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2D2EBD;
 Mon, 21 Jan 2019 05:51:51 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DE13F614;
 Mon, 21 Jan 2019 05:51:49 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Move to bitmap for arm_smmu_domain
 atrributes
To: Vivek Gautam <vivek.gautam@codeaurora.org>, will.deacon@arm.com,
 joro@8bytes.org, iommu@lists.linux-foundation.org
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <20190121055335.15430-2-vivek.gautam@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
Date: Mon, 21 Jan 2019 13:51:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121055335.15430-2-vivek.gautam@codeaurora.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_055151_691395_D5582630 
X-CRM114-Status: GOOD (  20.05  )
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
Cc: pdaly@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org,
 pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21/01/2019 05:53, Vivek Gautam wrote:
> A number of arm_smmu_domain's attributes can be assigned based
> on the iommu domains's attributes. These local attributes better
> be managed by a bitmap.
> So remove boolean flags and move to a 32-bit bitmap, and enable
> each bits separtely.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7ebbcf1b2eb3..52b300dfc096 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -257,10 +257,11 @@ struct arm_smmu_domain {
>   	const struct iommu_gather_ops	*tlb_ops;
>   	struct arm_smmu_cfg		cfg;
>   	enum arm_smmu_domain_stage	stage;
> -	bool				non_strict;
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>   	struct iommu_domain		domain;
> +#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
> +	unsigned int			attr;
>   };
>   
>   struct arm_smmu_option_prop {
> @@ -901,7 +902,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>   
> -	if (smmu_domain->non_strict)
> +	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_NON_STRICT)
>   		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>   
>   	/* Non coherent page table mappings only for Stage-1 */
> @@ -1598,7 +1599,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			*(int *)data = smmu_domain->non_strict;
> +			*(int *)data = !!(smmu_domain->attr &
> +					  ARM_SMMU_DOMAIN_ATTR_NON_STRICT);
>   			return 0;
>   		default:
>   			return -ENODEV;
> @@ -1638,7 +1640,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			smmu_domain->non_strict = *(int *)data;
> +			smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_NON_STRICT;

But what if *data == 0?

Robin.

>   			break;
>   		default:
>   			ret = -ENODEV;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

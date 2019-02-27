Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5332133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DaVEnjFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5332133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k+/telzqeM2rGXe+rm8O9aEEIIy5Czt8IWs3eL/COXM=; b=DaVEnjFFgsOVZgqzuELeoA6PH
	U0UgJHuFOx08brzJ57776WL8+RHdM6k+QYbmiMAYtXG7JpzWCeAxbpnSiuHRUI6md3bJBzaiwQxY1
	WijIja80XuPWoWLWAacFn431ihYRsPOFqZORgvOkVQBI9JIdEAx8RFJq1mJiVOmrFv1dZIl3hcg67
	ejsXsXsDgWQK/gzO42WvsLPBHzlr5uRU3U32LFemIIRQnaheVTtcn7NERhWbvDIFlauYOfI04Rbfw
	Nk0P1HdNmN9gR4iHnyaAfZgOvBRR4co3xNkCR5aXtQUhU16Vj81/LQkLzPS0ks5OtBn4ihM8RwRSc
	zRG8e0JsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz4uK-0007jm-0E; Wed, 27 Feb 2019 19:30:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz4uF-0007iw-Ud; Wed, 27 Feb 2019 19:30:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78898A78;
 Wed, 27 Feb 2019 11:30:14 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5F43F703;
 Wed, 27 Feb 2019 11:30:11 -0800 (PST)
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <709d7d66-9610-eeb3-128e-e2156bcfb616@arm.com>
Date: Wed, 27 Feb 2019 19:30:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_113016_001695_A1EC675D 
X-CRM114-Status: GOOD (  25.49  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/01/2019 04:51, Yong Wu wrote:
> MediaTek IOMMU don't have its power-domain. all the consumer connect
> with smi-larb, then connect with smi-common.
> 
>          M4U
>           |
>      smi-common
>           |
>    -------------
>    |         |    ...
>    |         |
> larb1     larb2
>    |         |
> vdec       venc
> 
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
> 
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
> 
> This patch adds device_link between the consumer and the larbs.
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
>   drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
>   2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 202e41b..735ae8d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   	struct mtk_smi_larb_iommu    *larb_mmu;
>   	unsigned int                 larbid, portid;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device_link *link;
>   	int i;
>   
>   	for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   		dev_dbg(dev, "%s iommu port: %d\n",
>   			enable ? "enable" : "disable", portid);
>   
> -		if (enable)
> +		if (enable) {
>   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -		else
> +			/* Link the consumer with the larb device(supplier) */
> +			link = device_link_add(dev, larb_mmu->dev,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);

This looks technically wrong, since we get here from 
mtk_iommu_attach_device(), and in theory a device could get attached to 
any number of domains over its lifetime, so adding a link at this point 
when there's no corresponding cleanup on detach is definitely 
unbalanced. If you want this layer to manage the link on behalf of the 
consumer, it would probably be better to do it at the point of 
mtk_iommu_add_device(), and either track it for manual cleanup in 
mtk_iommu_remove_device() or rely on AUTOREMOVE_SUPPLIER.

Robin.

> +			if (!link) {
> +				dev_err(dev, "Unable to link %s\n",
> +					dev_name(larb_mmu->dev));
> +				return;
> +			}
> +		} else {
>   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +		}
>   	}
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 9386aee..022bad9 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   	struct mtk_smi_larb_iommu    *larb_mmu;
>   	unsigned int                 larbid, portid;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device_link *link;
>   	int i;
>   
>   	for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   		dev_dbg(dev, "%s iommu port: %d\n",
>   			enable ? "enable" : "disable", portid);
>   
> -		if (enable)
> +		if (enable) {
>   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -		else
> +			link = device_link_add(dev, larb_mmu->dev,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);
> +			if (!link) {
> +				dev_err(dev, "Unable to link %s\n",
> +					dev_name(larb_mmu->dev));
> +				return;
> +			}
> +		} else {
>   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +		}
>   	}
>   }
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

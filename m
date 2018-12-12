Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0548C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D4120849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOpNauC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D4120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JzSWosxID2k+y44lXQqCybUfN5c4B08jhD0GRzhJkbw=; b=nOpNauC9GcQpJGUOjigMwjMB7
	m30F5k6D5sxojQicp+HCMU3GCJPtzHCHAGhOv7DQqYgWHGuS8ML62goiKt3W7GpIBBB59PB89wN0l
	p+PKNO+Q5NesmphsFTy8G4L4pcqvpVPrusRrEpgoIrk1C22YhnL4jeZZgOKj4d26V7A5ktupQDKJK
	Z0YcLZP47lgu9fXq7fSKrqjbdpodEqizOYSNixFdDIzyBZPWzbY5/Os2G/1GXyIBYBgcx9N6TvcoD
	rVFuNKuHswV+4/OXbcLkJnf24gk36iMV9HoSKk6IuoIR3oRfbJxi3EgBiuy7NBVUvftIdJzARTSwm
	nvhu0hg+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4kI-0006ec-D0; Wed, 12 Dec 2018 13:40:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4kD-0005OV-RH; Wed, 12 Dec 2018 13:40:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B527880D;
 Wed, 12 Dec 2018 05:39:58 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FFB83F614;
 Wed, 12 Dec 2018 05:39:56 -0800 (PST)
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Don't check PHYS_OFFSET if
 RAMDOMIZE_BASE is enabled
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will.deacon@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <50292758-47b1-1d08-5827-f7bdb3c33e1c@arm.com>
Date: Wed, 12 Dec 2018 13:39:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_054009_894382_23B28257 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 13:02, Yong Wu wrote:
> If CONFIG_RANDOMIZE_BASE is enabled, the "memstart_addr" will be updated
> randomly, then the PHYS_OFFSET may be random.

Oh, I hadn't ever realised that, good catch. However, since 29859aeb8a6e 
I think we should probably just remove this check altogether.

> Fixes: 82db33dc5e49 ("iommu/io-pgtable-arm: Check for v7s-incapable
> systems")

Note that this alone wouldn't be sufficient for stable prior to 4.18, 
since CONFIG_RANDOMIZE_BASE would then allow the original crash to 
happen again.

Robin.

> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bd..70941e6 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -709,7 +709,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   {
>   	struct arm_v7s_io_pgtable *data;
>   
> -#ifdef PHYS_OFFSET
> +#if defined(PHYS_OFFSET) && !defined(CONFIG_RANDOMIZE_BASE)
>   	if (upper_32_bits(PHYS_OFFSET))
>   		return NULL;
>   #endif
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

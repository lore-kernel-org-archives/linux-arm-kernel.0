Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A9BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:09:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A6420666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qf/cmqxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A6420666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sOCCCJDosf4dWVL7/yzIEHt3S0HlFWMrBd3wg/PF0F8=; b=qf/cmqxyYZefXBuMazOvGAFl6p
	uoFhuI4xNMc9DmglckHZ7UJ5ZbvhVgocVXKIUGnvuJ6jSVRX0C+TDaJi+7dH3CHD8BtsbdtNruuML
	tcsrEWOLvn9Yi8EiNAwBT1p64f12FUK4vASwWQWhgGaZNRqPBKuumyks7/akFi955gE71zBWwAOZH
	o3ViQO5lGOsOhdPpHMmkMeqGBPpKzx88VqwntTYslsxwX490p0Aqt9rnOjF0aelO33VFN/6mtcX+h
	t86rXx9WpYB+XU+v/QFR+jL17ql3pn2vH1cxqJ0zmMNpmCjZ33aEFvit5thyvs3pqq6hFf/Ka2Bwd
	YC5uTvuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6iD-0006TC-Nq; Tue, 04 Dec 2018 09:09:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6hw-0006SQ-VZ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:09:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F19A1688;
 Tue,  4 Dec 2018 01:09:20 -0800 (PST)
Received: from [10.1.35.148] (e121487-lin.cambridge.arm.com [10.1.35.148])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706093F5AF;
 Tue,  4 Dec 2018 01:09:19 -0800 (PST)
Subject: Re: [PATCH v3] ARM: dma-mapping: fix potential uninitialized return
To: Nathan Jones <nathanj439@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <20181128185910.5778-1-nathanj439@gmail.com>
 <20181130130712.1307-1-nathanj439@gmail.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <d0585506-ca9a-fde7-2f60-166427424c27@arm.com>
Date: Tue, 4 Dec 2018 09:09:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130130712.1307-1-nathanj439@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_010933_018511_D47B3F2B 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/30/18 1:07 PM, Nathan Jones wrote:
> While trying to use the dma_mmap_*() interface, it was noticed that this
> interface returns strange values when passed an incorrect length.
> 
> If neither of the if() statements fire then the return value is
> uninitialized. In the worst case it returns 0 which means the caller
> will think the function succeeded.
> 
> Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
> Signed-off-by: Nathan Jones <nathanj439@gmail.com>
> Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48ab78d..78de138aa66d 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -829,7 +829,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		 unsigned long attrs)
>  {
> -	int ret;
> +	int ret = -ENXIO;
>  	unsigned long nr_vma_pages = vma_pages(vma);
>  	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	unsigned long pfn = dma_to_pfn(dev, dma_addr);
> 

FYI, it is now in Russell's tracker [1] as patch 8816/1

[1] http://www.armlinux.org.uk/developer/patches/

Thanks
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

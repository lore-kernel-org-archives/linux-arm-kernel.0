Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B47AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8DA20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4YSY5+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8DA20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KhH792sFS8mnHrH6k1Vc+BVOJeriZD+W0fciy6B3lus=; b=Q4YSY5+8IyrPJZv1zlPRoIY3N
	gVTgm+Njb5UEaGJWj6xu2mYWZ8E1ulT3uJ0S5/zSROBrUOJUsarlFoPDFYfhwxFRvuYiaah6kDV0I
	kI6iaDXZM5I736q/v9RMaWruek90HkQ1qUU3+BdLutuEhkqmgEwwAtiLOYkLguax3CMXSGKTbqlHZ
	j9zruUmKWRT+X/qlBCj8qZEzBSqmY5gPBhuetGpGiss+gblQPA0DOJjruQQUImsEdarlqLpGMeFhL
	m5EthlVzM1SJ4ZuKzkxVteVxGYpyWzA5rCF5yt7h81+k8YPmrcJqfPl08bLKlb6HoDvfIPIlgYxOE
	aLrnuoW9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHSw-0002F0-ED; Fri, 07 Dec 2018 14:50:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHSc-0001sG-JT; Fri, 07 Dec 2018 14:50:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3306415AB;
 Fri,  7 Dec 2018 06:50:24 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6817A3F575;
 Fri,  7 Dec 2018 06:50:21 -0800 (PST)
Subject: Re: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
 willy@infradead.org, mhocko@suse.com, hjc@rock-chips.com, heiko@sntech.de,
 airlied@linux.ie
References: <20181206184227.GA28656@jordon-HP-15-Notebook-PC>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
Date: Fri, 7 Dec 2018 14:50:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206184227.GA28656@jordon-HP-15-Notebook-PC>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065035_119784_C40EAED9 
X-CRM114-Status: GOOD (  20.93  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 18:42, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index a8db758..2cb83bb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>   					      struct vm_area_struct *vma)
>   {
>   	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> -	unsigned int i, count = obj->size >> PAGE_SHIFT;
>   	unsigned long user_count = vma_pages(vma);
> -	unsigned long uaddr = vma->vm_start;
> -	unsigned long offset = vma->vm_pgoff;
> -	unsigned long end = user_count + offset;
> -	int ret;
> -
> -	if (user_count == 0)
> -		return -ENXIO;
> -	if (end > count)
> -		return -ENXIO;
>   
> -	for (i = offset; i < end; i++) {
> -		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> -		if (ret)
> -			return ret;
> -		uaddr += PAGE_SIZE;
> -	}
> -
> -	return 0;
> +	return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
> +				user_count);

We're losing vm_pgoff handling here, which given the implication in 
57de50af162b, may well be a regression for at least some combination of 
GPU and userspace driver (I assume that commit was in the context of 
some version of the Arm Mali driver, possibly on RK3288).

Robin.

>   }
>   
>   static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

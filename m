Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0151FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A8F2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hALH3aYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A8F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LaOpUJcpptrlUp2dqQpTifGl97MPEWf4AjRe2RHvMa4=; b=hALH3aYw0CY4NmtVFqYn3jfzo
	Q+wQqcBJsKLOM3m7NKS0UnfRmQ+ZNGjpgVyRIzBux3gJkI7b3kHSyVqnq+z2uMJH6VGa/UwimfwiV
	ioEiZ84tIt7W4x28zmKRucxCgvmAicS3YXjVn+z4fpepabqQxkkiggiMP5ZDrJq5YZO3/4s60jLUY
	IAWYpXGTpMC8JJG28b8Z1sjY1lWhze0rkl1fLI/WL+9RWzdXXwOxV+gqmZRomMeRjnR45Ne/Oxg0i
	KKM70cFU5IMnnVPKOQpQ5j8eUXk6hfYeKFYfwgzLidWzHRp1PhkUEqmBhf6SpR4QnD35sBL85zM3d
	slFA3UcOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVNXE-0001Us-E1; Fri, 07 Dec 2018 21:19:44 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVNXA-0001Tn-GU; Fri, 07 Dec 2018 21:19:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E35B15AB;
 Fri,  7 Dec 2018 13:19:29 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D3E3F575;
 Fri,  7 Dec 2018 13:19:26 -0800 (PST)
Subject: Re: [PATCH v3 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Souptick Joarder <jrdr.linux@gmail.com>
References: <20181206184227.GA28656@jordon-HP-15-Notebook-PC>
 <ca1779ea-7a87-971c-24c4-4a1c77a72e92@arm.com>
 <CAFqt6zbMbvB1ckwhSsBATrq5M-HQ6qk95sCWCoTTFFnwzBAnng@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fd6b10d7-de66-f16a-f500-29a13b909f46@arm.com>
Date: Fri, 7 Dec 2018 21:19:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbMbvB1ckwhSsBATrq5M-HQ6qk95sCWCoTTFFnwzBAnng@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_131940_561868_5F6D507D 
X-CRM114-Status: GOOD (  21.49  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, hjc@rock-chips.com,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-07 8:30 pm, Souptick Joarder wrote:
> On Fri, Dec 7, 2018 at 8:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 06/12/2018 18:42, Souptick Joarder wrote:
>>> Convert to use vm_insert_range() to map range of kernel
>>> memory to user vma.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
>>>    drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
>>>    1 file changed, 2 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> index a8db758..2cb83bb 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>>>                                              struct vm_area_struct *vma)
>>>    {
>>>        struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
>>> -     unsigned int i, count = obj->size >> PAGE_SHIFT;
>>>        unsigned long user_count = vma_pages(vma);
>>> -     unsigned long uaddr = vma->vm_start;
>>> -     unsigned long offset = vma->vm_pgoff;
>>> -     unsigned long end = user_count + offset;
>>> -     int ret;
>>> -
>>> -     if (user_count == 0)
>>> -             return -ENXIO;
>>> -     if (end > count)
>>> -             return -ENXIO;
>>>
>>> -     for (i = offset; i < end; i++) {
>>> -             ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
>>> -             if (ret)
>>> -                     return ret;
>>> -             uaddr += PAGE_SIZE;
>>> -     }
>>> -
>>> -     return 0;
>>> +     return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
>>> +                             user_count);
>>
>> We're losing vm_pgoff handling here, which given the implication in
>> 57de50af162b, may well be a regression for at least some combination of
>> GPU and userspace driver (I assume that commit was in the context of
>> some version of the Arm Mali driver, possibly on RK3288).
> 
> In commit  57de50af162b, vma->vm_pgoff = 0 for GEM mmap handler context
> and removing it from common path which means if call stack looks like
> rockchip_gem_mmap_buf() -> rockchip_drm_gem_object_mmap() ->
> rockchip_drm_gem_object_mmap_iommu(), then we might have a non zero
> vma->vm_pgoff context which is not handled.
> 
> This is the problem you are pointing ? right ?

Exactly - if unconditionally zeroing the offset in the PRIME mmap() path 
was a problem, then the implication is that there are callers of that 
path who expect the offset to be honoured here.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

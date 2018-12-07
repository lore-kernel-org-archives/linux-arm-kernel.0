Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FD120673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E9OsRRlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FD120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jBy3WTaovVAyaMgbJoRu9+6U9YY/tIJbdqBMf5t697o=; b=E9OsRRlX7q27Q63rOdsDE/Q5p
	Q1sfnm5AdcPQ4ynmimbeiBCKkijs/v4LSXLqr/vd8FfeaSBJrLPv7r0ILtMFmjmszVtcmeANg2h2g
	jPPRLeWSESeWU6V5AnMBztsvr/3d+swECNvMiKKLxhaR8U1UhYJBcRYT2nb35mKwrrWf3870lDdUJ
	fYGOyPQpjD/WuamUwKqXeGOyL3Bt7s5Ro50NYubfql4MykZQC/Sz2GwcvP2GzO3+ldATajrzejIct
	K7ImJ/aOH6xccs5eSx8LqW1sDBONxH+NfLHNJZnhNd35jc0C5a/K/qTyRXhxOrymzdcEJszdWC0C6
	flB6o+9Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI9x-0002jm-4L; Fri, 07 Dec 2018 15:35:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI9q-0001Vo-9z; Fri, 07 Dec 2018 15:35:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A59A15AB;
 Fri,  7 Dec 2018 07:35:03 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1847A3F575;
 Fri,  7 Dec 2018 07:34:57 -0800 (PST)
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
To: Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
 willy@infradead.org, mhocko@suse.com, kirill.shutemov@linux.intel.com,
 vbabka@suse.cz, riel@surriel.com, sfr@canb.auug.org.au,
 rppt@linux.vnet.ibm.com, peterz@infradead.org, linux@armlinux.org.uk,
 iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
 m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
 heiko@sntech.de, airlied@linux.ie, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, pawel@osciak.com, kyungmin.park@samsung.com,
 mchehab@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
Date: Fri, 7 Dec 2018 15:34:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_073514_357140_A90BA63E 
X-CRM114-Status: GOOD (  30.24  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 18:39, Souptick Joarder wrote:
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
> 
> As this pattern is common across different drivers, it can
> be generalized by creating a new function and use it across
> the drivers.
> 
> vm_insert_range is the new API which will be used to map a
> range of kernel memory/pages to user vma.
> 
> This API is tested by Heiko for Rockchip drm driver, on rk3188,
> rk3288, rk3328 and rk3399 with graphics.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   include/linux/mm.h |  2 ++
>   mm/memory.c        | 38 ++++++++++++++++++++++++++++++++++++++
>   mm/nommu.c         |  7 +++++++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fcf9cc9..2bc399f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2506,6 +2506,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>   int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>   			unsigned long pfn, unsigned long size, pgprot_t);
>   int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count);
>   vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>   			unsigned long pfn);
>   vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 15c417e..84ea46c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>   }
>   
>   /**
> + * vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pages: pointer to array of source kernel pages
> + * @page_count: number of pages need to insert into user vma
> + *
> + * This allows drivers to insert range of kernel pages they've allocated
> + * into a user vma. This is a generic function which drivers can use
> + * rather than using their own way of mapping range of kernel pages into
> + * user vma.
> + *
> + * If we fail to insert any page into the vma, the function will return
> + * immediately leaving any previously-inserted pages present.  Callers
> + * from the mmap handler may immediately return the error as their caller
> + * will destroy the vma, removing any successfully-inserted pages. Other
> + * callers should make their own arrangements for calling unmap_region().
> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise
> + */
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count)
> +{
> +	unsigned long uaddr = addr;
> +	int ret = 0, i;

Some of the sites being replaced were effectively ensuring that vma and 
pages were mutually compatible as an initial condition - would it be 
worth adding something here for robustness, e.g.:

+	if (page_count != vma_pages(vma))
+		return -ENXIO;

?

(then you could also clean up a couple more places where you're not 
already removing such checks)

Robin.

> +
> +	for (i = 0; i < page_count; i++) {
> +		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		if (ret < 0)
> +			return ret;
> +		uaddr += PAGE_SIZE;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
> +/**
>    * vm_insert_page - insert single page into user vma
>    * @vma: user vma to map to
>    * @addr: target user address of this page
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 749276b..d6ef5c7 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>   }
>   EXPORT_SYMBOL(vm_insert_page);
>   
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
>   /*
>    *  sys_brk() for the most part doesn't need the global kernel
>    *  lock, except when an application is doing something nasty
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

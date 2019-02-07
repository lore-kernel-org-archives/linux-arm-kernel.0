Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:47:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C9B218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kdkHWgpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C9B218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n9pmjRSl7wmz/7WCfxZBX+3u7rQ7s00CQf6/8x0c4r4=; b=kdkHWgpzHefayN
	7C1AxIwvIODC6aznNbMJPQFc7lTeYsT3hKr/gKDHhnfoA/Fc/PDnq8R527T6ry3eK4Cl28Xelz10u
	NrsMiWwCmw4wpkK2WbvhkudemNkpPB44TIipdsbP9JeMwrYM4XnzWfx7pStoHFVxN8D4xVnMVb8L2
	CfrvJQ+mR1ETxngYFwHYAqSZJSCZEdilFtpXjPqaMXD895HfTBJHB3sLVzaI6/thyW3W+KGEb5aFg
	ajU6Ik9npmGBYbXep8ZKPehoUYHIDyb6vWi0yfkm+1cmovria2/v7YtCPp+eU4S9bPOpB4XucA9hx
	uO8W2MkfFn7CZOz8Bm5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grmq4-00038p-0f; Thu, 07 Feb 2019 16:47:48 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1grmpv-00037s-JZ; Thu, 07 Feb 2019 16:47:39 +0000
Date: Thu, 7 Feb 2019 08:47:39 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Message-ID: <20190207164739.GX21860@bombadil.infradead.org>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <20190131083842.GE28876@rapoport-lnx>
 <CAFqt6za9xA_8OKiaaHXcO9go+RtPdjLY5Bz_fgQL+DZbermNhA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFqt6za9xA_8OKiaaHXcO9go+RtPdjLY5Bz_fgQL+DZbermNhA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
 airlied@linux.ie, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, treding@nvidia.com,
 linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 pawel@osciak.com, Rik van Riel <riel@surriel.com>, rppt@linux.vnet.ibm.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, Juergen Gross <jgross@suse.com>,
 hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 09:19:47PM +0530, Souptick Joarder wrote:
> Just thought to take opinion for documentation before placing it in v3.
> Does it looks fine ?
> 
> +/**
> + * __vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + * @offset: user's requested vm_pgoff
> + *
> + * This allow drivers to insert range of kernel pages into a user vma.
> + *
> + * Return: 0 on success and error code otherwise.
> + */
> +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num, unsigned long offset)

For static functions, I prefer to leave off the second '*', ie make it
formatted like a docbook comment, but not be processed like a docbook
comment.  That avoids cluttering the html with descriptions of internal
functions that people can't actually call.

> +/**
> + * vm_insert_range - insert range of kernel pages starts with non zero offset
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + *
> + * Maps an object consisting of `num' `pages', catering for the user's

Rather than using `num', you should use @num.

> + * requested vm_pgoff
> + *
> + * If we fail to insert any page into the vma, the function will return
> + * immediately leaving any previously inserted pages present.  Callers
> + * from the mmap handler may immediately return the error as their caller
> + * will destroy the vma, removing any successfully inserted pages. Other
> + * callers should make their own arrangements for calling unmap_region().
> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise.
> + */
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num)
> 
> 
> +/**
> + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + *
> + * Similar to vm_insert_range(), except that it explicitly sets @vm_pgoff to

But vm_pgoff isn't a parameter, so it's misleading to format it as such.

> + * 0. This function is intended for the drivers that did not consider
> + * @vm_pgoff.
> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise.
> + */
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +                               unsigned long num)

I don't think we should call it 'buggy'.  'zero' would make more sense
as a suffix.

Given how this interface has evolved, I'm no longer sure than
'vm_insert_range' makes sense as the name for it.  Is it perhaps
'vm_map_object' or 'vm_map_pages'?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

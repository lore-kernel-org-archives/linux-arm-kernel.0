Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13217C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD77A2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WhbNacUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD77A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8BoEtjg3ONzHwM0yQJAlnXD3UmSCacFf2v5Av3hIS8I=; b=WhbNacUStCtAvT
	PuzSE9jVTRUBV4KLBLyJbdXEjwg1UuQ4Z3pm7vNILrkxu2AQwqDObCWTUvhRfEI41r9EIKVSoBIql
	bLNDLBgesfRwOMwx/HPaRtL0hN9DG//blEPNfnKeITaKPisvw5AS9vP/h0/t8cZLYGmjvX0Mkpo8f
	lgp+JPFf53KzQ7ZYITv7IwmdjreOsVRr5uGrMecxhrnrGufgpamTOOwtx6l02xg3QQTgeDJ9r7fB9
	/IfgRrEHUgCZyRvBb5oypoPz0rI1qv1pMiGzvAXTfuhFMGDV81RMzl1VLdcWsrIh14Mi+LJTZXBgc
	0INn9npLc9M0LoQyEAwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJew-0000gb-Vs; Fri, 07 Dec 2018 17:11:26 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gVJem-0000g7-K8; Fri, 07 Dec 2018 17:11:16 +0000
Date: Fri, 7 Dec 2018 09:11:16 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
Message-ID: <20181207171116.GA29923@bombadil.infradead.org>
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
 <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
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
Cc: mhocko@suse.com, heiko@sntech.de, peterz@infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 m.szyprowski@samsung.com, sfr@canb.auug.org.au,
 oleksandr_andrushchenko@epam.com, joro@8bytes.org, linux@armlinux.org.uk,
 iommu@lists.linux-foundation.org, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org, keescook@chromium.org,
 pawel@osciak.com, riel@surriel.com, rppt@linux.vnet.ibm.com,
 boris.ostrovsky@oracle.com, mchehab@kernel.org, iamjoonsoo.kim@lge.com,
 vbabka@suse.cz, jgross@suse.com, hjc@rock-chips.com, xen-devel@lists.xen.org,
 kyungmin.park@samsung.com, stefanr@s5r6.in-berlin.de,
 Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 03:34:56PM +0000, Robin Murphy wrote:
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +			struct page **pages, unsigned long page_count)
> > +{
> > +	unsigned long uaddr = addr;
> > +	int ret = 0, i;
> 
> Some of the sites being replaced were effectively ensuring that vma and
> pages were mutually compatible as an initial condition - would it be worth
> adding something here for robustness, e.g.:
> 
> +	if (page_count != vma_pages(vma))
> +		return -ENXIO;

I think we want to allow this to be used to populate part of a VMA.
So perhaps:

	if (page_count > vma_pages(vma))
		return -ENXIO;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

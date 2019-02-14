Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2C9222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qgXJvTly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2C9222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=47P00UI3zEKYzkoz8VJ9+FCcy96azcZ6H6CDLr+ABM4=; b=qgXJvTlyvMbq2j
	qqx02KbW1yxHIasgvjz0awVayFJNbWfRI7FuiCnKVQF7AeQc9jcJxRccsisGDqgELmznUN2IwlV0e
	4qfLcOCdzaDTndfGcqNcsgUSTH7tyn9iMlfv27P1MRCAVyriFs3Dmu9XMXTyuJ0i6KiUUYLK/AQiR
	UKXOLlgyb9A79sVUd6zCmbdZ9yAniL0GTV8ZaXh2c9CBD/AVaLvU4a30ZHsCQtQ3LJjVowLRy1GHI
	dwjXNMmWqAA5qK9JaJKFhdudUF7qAlCe3JXisYue/C5qME0Px4VphU74trx9L829wcbZY+/U9H7zd
	lCsU97E23INJOsqktB0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEh5-00037Q-Qd; Thu, 14 Feb 2019 10:56:39 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEgz-00036v-MJ; Thu, 14 Feb 2019 10:56:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id DB8A220298375; Thu, 14 Feb 2019 11:56:31 +0100 (CET)
Date: Thu, 14 Feb 2019 11:56:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
Message-ID: <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mhocko@suse.com, Tycho Andersen <tycho@docker.com>,
 kernel-hardening@lists.openwall.com, catalin.marinas@arm.com,
 will.deacon@arm.com, dave.hansen@intel.com, deepa.srinivasan@oracle.com,
 steven.sistare@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, kirill.shutemov@linux.intel.com, x86@kernel.org,
 jmorris@namei.org, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 labbott@redhat.com, pradeep.vincent@oracle.com, konrad.wilk@oracle.com,
 jcm@redhat.com, liran.alon@oracle.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 Marco Benatto <marco.antonio.780@gmail.com>, linux-mm@kvack.org,
 juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>, oao.m.martins@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 05:01:26PM -0700, Khalid Aziz wrote:
>  static inline void *kmap_atomic(struct page *page)
>  {
> +	void *kaddr;
> +
>  	preempt_disable();
>  	pagefault_disable();
> +	kaddr = page_address(page);
> +	xpfo_kmap(kaddr, page);
> +	return kaddr;
>  }
>  #define kmap_atomic_prot(page, prot)	kmap_atomic(page)
>  
>  static inline void __kunmap_atomic(void *addr)
>  {
> +	xpfo_kunmap(addr, virt_to_page(addr));
>  	pagefault_enable();
>  	preempt_enable();
>  }

How is that supposed to work; IIRC kmap_atomic was supposed to be
IRQ-safe.

> +/* Per-page XPFO house-keeping data */
> +struct xpfo {
> +	unsigned long flags;	/* Page state */
> +	bool inited;		/* Map counter and lock initialized */

What's sizeof(_Bool) ? Why can't you use a bit in that flags word?

> +	atomic_t mapcount;	/* Counter for balancing map/unmap requests */
> +	spinlock_t maplock;	/* Lock to serialize map/unmap requests */
> +};

Without that bool, the structure would be 16 bytes on 64bit, which seems
like a good number.

> +void xpfo_kmap(void *kaddr, struct page *page)
> +{
> +	struct xpfo *xpfo;
> +
> +	if (!static_branch_unlikely(&xpfo_inited))
> +		return;
> +
> +	xpfo = lookup_xpfo(page);
> +
> +	/*
> +	 * The page was allocated before page_ext was initialized (which means
> +	 * it's a kernel page) or it's allocated to the kernel, so nothing to
> +	 * do.
> +	 */
> +	if (!xpfo || unlikely(!xpfo->inited) ||
> +	    !test_bit(XPFO_PAGE_USER, &xpfo->flags))
> +		return;
> +
> +	spin_lock(&xpfo->maplock);
> +
> +	/*
> +	 * The page was previously allocated to user space, so map it back
> +	 * into the kernel. No TLB flush required.
> +	 */
> +	if ((atomic_inc_return(&xpfo->mapcount) == 1) &&
> +	    test_and_clear_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags))
> +		set_kpte(kaddr, page, PAGE_KERNEL);
> +
> +	spin_unlock(&xpfo->maplock);
> +}
> +EXPORT_SYMBOL(xpfo_kmap);
> +
> +void xpfo_kunmap(void *kaddr, struct page *page)
> +{
> +	struct xpfo *xpfo;
> +
> +	if (!static_branch_unlikely(&xpfo_inited))
> +		return;
> +
> +	xpfo = lookup_xpfo(page);
> +
> +	/*
> +	 * The page was allocated before page_ext was initialized (which means
> +	 * it's a kernel page) or it's allocated to the kernel, so nothing to
> +	 * do.
> +	 */
> +	if (!xpfo || unlikely(!xpfo->inited) ||
> +	    !test_bit(XPFO_PAGE_USER, &xpfo->flags))
> +		return;
> +
> +	spin_lock(&xpfo->maplock);
> +
> +	/*
> +	 * The page is to be allocated back to user space, so unmap it from the
> +	 * kernel, flush the TLB and tag it as a user page.
> +	 */
> +	if (atomic_dec_return(&xpfo->mapcount) == 0) {
> +		WARN(test_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags),
> +		     "xpfo: unmapping already unmapped page\n");
> +		set_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
> +		set_kpte(kaddr, page, __pgprot(0));
> +		xpfo_flush_kernel_tlb(page, 0);
> +	}
> +
> +	spin_unlock(&xpfo->maplock);
> +}
> +EXPORT_SYMBOL(xpfo_kunmap);

And these here things are most definitely not IRQ-safe.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

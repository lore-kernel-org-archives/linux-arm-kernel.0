Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC459C10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:12:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4DB2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dN4Sjl70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4DB2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SfuvTagwKy3OCmOnuk/7l/Fa6/rJ4s0PaFUWGQYpAxA=; b=dN4Sjl70GMpJjS
	20gGQLkJohxkALJ+LLjcj6Do42loucMHAff0Tsi420k2+S9RASXRZCaHYq9DZk6Q0mbjPJfvZ/UD8
	kYLn79UgsZlzMHU/Rk4VT9fGoKj0HBAZjVgoF4Ht0ezltoALtGkmlLpakRRKCK8qFgfTXEZHM6lQT
	T0gQBmJKKX7/qFKe1ksmeilraqFMv3nQJ7w/GAWILa/YaUhTx1YaX7V1oPfTNS7Px8gVUs+TS/jR0
	VvBVlC239mg8034WA7CXluFm1RDmqtiX5RKDGH62P9WolXkImqWNVJ69H6cjDf9Z6ZOxj8Ts4/62F
	wtvS6BXpLaX/DP5SQ5QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyePU-0005vJ-5p; Tue, 26 Feb 2019 15:12:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyePQ-0005ut-4r
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:12:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953BBA78;
 Tue, 26 Feb 2019 07:12:39 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32803F575;
 Tue, 26 Feb 2019 07:12:36 -0800 (PST)
Date: Tue, 26 Feb 2019 15:12:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190226151230.GA20230@lakrids.cambridge.arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_071240_204419_223D638A 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: linux-arch@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Feb 18, 2019 at 04:13:17PM -0700, Yu Zhao wrote:
> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> p4d and pgd), don't use any.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)

[...]

> -static phys_addr_t pgd_pgtable_alloc(void)
> +static phys_addr_t pgd_pgtable_alloc(int shift)
>  {
>  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
> -		BUG();
> +	BUG_ON(!ptr);
> +
> +	/*
> +	 * Initialize page table locks in case later we need to
> +	 * call core mm functions like apply_to_page_range() on
> +	 * this pre-allocated page table.
> +	 */
> +	if (shift == PAGE_SHIFT)
> +		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
> +	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
> +		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));

IIUC, this is for nopmd kernels, where we only have real PGD and PTE
levels of table. From my PoV, that would be clearer if we did:

	else if (shift == PMD_SHIFT && !is_defined(__PAGETABLE_PMD_FOLDED))

... though IMO it would be a bit nicer if the generic
pgtable_pmd_page_ctor() were nop'd out for __PAGETABLE_PMD_FOLDED
builds, so that callers don't have to be aware of folding.

I couldn't think of a nicer way of distinguishing levels of table, and
having separate function pointers for each level seems over-the-top, so
otehr than that this looks good to me.

Assuming you're happy with the above change:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

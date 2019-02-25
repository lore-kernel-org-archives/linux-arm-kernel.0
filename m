Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B6CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:08:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4654C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBJ6zt0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4654C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pLBX2b0O0AzhWnDgdyoeSMNfwwrsSQkFwreCRXU/X4I=; b=HBJ6zt0n3FO8P7
	IUHGpG7FPBjRzgEQS5Z93qLczJc9jlSwUZuK3iw3CqkcKTxPeBcp0cwx7vqNWA1p4eJneelQMuf0N
	vC7HIgcPgf2HEFfvPuaIAHLMSIwqgLQLpLILi9jpeSk8+XDN5XSdQFMjsTkkl38CDLdTO1SkQ/ZXl
	GLr+JX+JB5K4i/hUk8YoiuNau7x66t6VfpGlu/J2nK/RS/6UtPd3Z0/U9tfTFDOJT8Fscb6rbgN+R
	3j1q993IMIVeuUWr4TkOdQvPd7o41zqxjSSAqSOg3VEX9AgETUc3efD787CdUPf/W/g0/W6awKTLL
	Za3k65nmpqxkQHRXO9uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyE7R-0005o2-SP; Mon, 25 Feb 2019 11:08:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyE7P-0005nh-24
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 11:08:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54897A78;
 Mon, 25 Feb 2019 03:08:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAE543F703;
 Mon, 25 Feb 2019 03:08:16 -0800 (PST)
Date: Mon, 25 Feb 2019 11:08:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 2/6] arm64/mm: Make pgd_pgtable_alloc() call
 pte_alloc_one() always
Message-ID: <20190225110813.GC26236@lakrids.cambridge.arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551071039-20192-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_030819_102382_180442E5 
X-CRM114-Status: GOOD (  25.26  )
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
Cc: yuzhao@google.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 10:33:55AM +0530, Anshuman Khandual wrote:
> pgd_pgtable_alloc() provides page allocation function while creating all
> levels of page table (PGD, PUD, CONT PMD etc) for various kernel mappings.
> It calls __get_free_page() and initializes page with pagetable_page_ctor().
> pte_alloc_one() already provides a standard interface for allocating a page
> table page and initializes it with pagetable_page_ctor(). This removes the
> redundancy and instead make it call pte_alloc_one() directly.

I see we also have pte_alloc_one_kernel(), which does not call
pgtable_page_ctor().

Was it deliberate that we don't call the ctor on kernel mappings?

> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b6f5aa52ac67..2dbd72319152 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -372,13 +372,22 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  
>  static phys_addr_t pgd_pgtable_alloc(void)
>  {
> -	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
> -		BUG();
> +
> +	pgtable_t ptr;
> +
> +	/*
> +	 * pgd_pgtable_alloc() is called while creating kernel mappings
> +	 * through __create_pgd_mapping() might not install it through
> +	 * swapper_pg_dir (&init_mm). Even then init_mm is passed here
> +	 * just to indicate that the allocation is kernel specific not
> +	 * for the user space page tables.
> +	 */

I'm not sure what this is trying to convey. I guess we also use this for
creating the EFI mappings?

No other architecture seems to use pte_alloc_one() for kernel tables,
and it's not clear to me how the mm argument is intended to be used by
the implementation.

Thanks,
Mark.

> +	ptr = pte_alloc_one(&init_mm);
> +	BUG_ON(!ptr);
>  
>  	/* Ensure the zeroed page is visible to the page table walker */
>  	dsb(ishst);
> -	return __pa(ptr);
> +	return page_to_phys(ptr);
>  }
>  
>  /*
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

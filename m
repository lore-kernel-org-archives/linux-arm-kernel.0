Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CBC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:11:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAAF222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="am3jgWa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAAF222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lX8LG05LOAPgHgsQUzo9JPsJHPTiSfpTOVOTBkXA0iw=; b=am3jgWa9EVDclo
	t2NpxRZmf4o4vd3DSzlswTQRRYQCFAiTdTe1qTYQMl65DNWm4NYAgg/f6Uaeg0G48Q/eD3KhM5MYi
	xEkn2STHnw7zaqyABJsMTpm/J/wIJ2CpMGp+rPTKSWW1Om2INrMUR2psMYhpJz2j+YHyWsSdrfVRZ
	MZky/0tJXrJpB+SaMpraVU3zeUndIBlXnp2NfElZwaDPMrvw6rWciyC1eIv6LysNiUmrEVP90hagr
	pU+MHyPjIzx1K9OF/PSpyxAr3XiI3eMuCzar7fllzpCr8iM/Hq1mz3jjQNPMuhgzJoys5QYlKkxax
	Yy3fseKfaLsHw8nsi57Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKXX-0004QY-ED; Thu, 14 Feb 2019 17:11:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKXT-0004Jl-2B
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:11:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0579EBD;
 Thu, 14 Feb 2019 09:11:04 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7691E3F589;
 Thu, 14 Feb 2019 09:11:03 -0800 (PST)
Date: Thu, 14 Feb 2019 17:11:01 +0000
From: Will Deacon <will.deacon@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 3/6] arm64/mm: Make pgd_pgtable_alloc() call
 pte_alloc_one() always
Message-ID: <20190214171101.GD2475@fuggles.cambridge.arm.com>
References: <1548307220-19756-1-git-send-email-anshuman.khandual@arm.com>
 <1548307220-19756-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548307220-19756-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_091107_315373_F7D85916 
X-CRM114-Status: GOOD (  20.37  )
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
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 10:50:17AM +0530, Anshuman Khandual wrote:
> pgd_pgtable_alloc() provides page allocation function while creating all
> levels of page table (e.g PGD, PUD, CONT PMD) for various kernel mappings.
> It calls __get_free_page() and initializes page with pagetable_page_ctor().
> pte_alloc_one() already provides a standard interface for allocating a page
> table page and initializes it with pagetable_page_ctor(). This removes the
> redundancy and instead make it call pte_alloc_one() directly.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b6f5aa5..2dbd723 100644
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
> +	ptr = pte_alloc_one(&init_mm);
> +	BUG_ON(!ptr);
>  
>  	/* Ensure the zeroed page is visible to the page table walker */
>  	dsb(ishst);
> -	return __pa(ptr);
> +	return page_to_phys(ptr);

Are you sure this is safe? afaict, this code is used to set up the linear
mapping which happens before the mem_map is initialised. I don't think
page_to_phys() can be used at this point. What am I missing?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

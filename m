Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:13:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A6B2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UYbuSwYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A6B2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=97RxuK8T+EpIsqN98Cr7TyCLY7PqZvn63mjpRyIsMDc=; b=UYbuSwYfUmIuKD
	Lobp7/0AwSvGqSuUeNz+mzGpKaMsUrcf/Mpmk2nE4Uf+WMrKrb374D0gGrprFDonvgZZ9aXD90A8q
	YbjEsFnus2vWlTUJEOBILAJ2t4kHbK08j5EJ2OMxp2N/1DHVVaQdIir3C0m+MkMKZgdXZpdT05kX6
	nwgMo5SpX4FUuKmmIVAuJhYvorkEpvvhaDNqZ2MSkQDx85xw9JknQAANzd+6ssd6oTEiy79jZg3p7
	vpic1+wf6MyYfPT7l+V8m/ExwpIc0ueblJk5SXC6D1c7RM6ych6PDX7nEh07qF5SuGv+9R0qwAmHZ
	nUd3DpcuoMxqHpBsDeOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyeQ0-0006F2-Pg; Tue, 26 Feb 2019 15:13:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyePx-0006Eg-SZ
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:13:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B9CAA78;
 Tue, 26 Feb 2019 07:13:13 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B5A83F575;
 Tue, 26 Feb 2019 07:13:10 -0800 (PST)
Date: Tue, 26 Feb 2019 15:13:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 2/3] arm64: mm: don't call page table ctors for init_mm
Message-ID: <20190226151307.GB20230@lakrids.cambridge.arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <20190218231319.178224-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218231319.178224-2-yuzhao@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_071313_929111_61B7D310 
X-CRM114-Status: GOOD (  20.87  )
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

On Mon, Feb 18, 2019 at 04:13:18PM -0700, Yu Zhao wrote:
> init_mm doesn't require page table lock to be initialized at
> any level. Add a separate page table allocator for it, and the
> new one skips page table ctors.

Just to check, in a previous reply you mentioned we need to call the
ctors for our efi_mm, since we use apply_to_page_range() on that. Is
that only because apply_to_pte_range() tries to take the ptl for non
init_mm?

... or did I miss something else?

> The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
> calling them avoids memory leak in case we call pte_free_kernel()
> on init_mm.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Assuming that was all, this patch makes sense to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/mm/mmu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index fa7351877af3..e8bf8a6300e8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  	} while (pgdp++, addr = next, addr != end);
>  }
>  
> +static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
> +{
> +	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> +	BUG_ON(!ptr);
> +
> +	/* Ensure the zeroed page is visible to the page table walker */
> +	dsb(ishst);
> +	return __pa(ptr);
> +}
> +
>  static phys_addr_t pgd_pgtable_alloc(int shift)
>  {
>  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> @@ -591,7 +601,7 @@ static int __init map_entry_trampoline(void)
>  	/* Map only the text into the trampoline page table */
>  	memset(tramp_pg_dir, 0, PGD_SIZE);
>  	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> -			     prot, pgd_pgtable_alloc, 0);
> +			     prot, pgd_kernel_pgtable_alloc, 0);
>  
>  	/* Map both the text and data into the kernel page table */
>  	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
> @@ -1067,7 +1077,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
> +			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
> +			     flags);
>  
>  	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>  			   altmap, want_memblock);
> -- 
> 2.21.0.rc0.258.g878e2cd30e-goog
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

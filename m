Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1112147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sNMQ6uc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1112147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EDShROBOLhSuS3iDz/M+TAdtzoZMAvS4O+R7Uy8JgtU=; b=sNMQ6uc/Zp44w3
	7MXCAwq39mAw0mMCxVDAGe1Si8T+wXMbaf617v86+Q9xqRkAwM6WKyzguhjDiVgT0n4786vKzkpiC
	SA1fhj+sZNxOtqxYrjTxKG/I7kIPqGzEWfm3fAmTvTFd2qA7wPy52af0lFY9dadCftD8Nr+7EvkdQ
	58UL9ZZiuH6/nyIQ5BcyuggRXpjjUjkULy8MGIBrKWywnZGONCvqLXI+3sz/n/XLtDLhtvmT5MGq6
	fP9vKzS9hEU8KZSKwSi1apL14GqEVfbay4SaRTJihcw3FRO+T41roZbGZ+g/AEtEEbOVj/ncDUk6t
	gL3UyWyWiSBhp6rJ/zZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyEAG-0007W7-Dr; Mon, 25 Feb 2019 11:11:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyEAD-0007TD-GR
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 11:11:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6044DA78;
 Mon, 25 Feb 2019 03:11:12 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B689B3F5C1;
 Mon, 25 Feb 2019 03:11:10 -0800 (PST)
Date: Mon, 25 Feb 2019 11:11:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 5/6] arm64/mm: Enable page table page accounting for
 user space
Message-ID: <20190225111108.GD26236@lakrids.cambridge.arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_031113_549767_6201672E 
X-CRM114-Status: GOOD (  17.36  )
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

On Mon, Feb 25, 2019 at 10:33:58AM +0530, Anshuman Khandual wrote:
> Page table pages created for user space processes must be accounted against
> their memory control groups if initialized. This just introduces a helper
> function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
> table page allocations but adds __GFP_ACCOUNT for user page table pages.

Can't we have pte_alloc_one_kernel() and pte_alloc_one() explicitly pass
the GFP flags down to a __pte_alloc_one() helper, and consistently use
pte_alloc_one_kernel() for kernel mappings?

That would seem less surprising than hiding that detail in another
function.

Thanks,
Mark.

> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/pgalloc.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 076764f66fb0..a02a4d1d967d 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -100,12 +100,24 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>  	return (pte_t *)pte_alloc_one_virt(mm);
>  }
>  
> +extern struct mm_struct efi_mm;
> +
> +static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm)
> +{
> +	if (unlikely((mm == &init_mm) || (mm == &efi_mm)))
> +		return PGALLOC_GFP;
> +	else
> +		return PGALLOC_GFP | __GFP_ACCOUNT;
> +}
> +
>  static inline pgtable_t
>  pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *pte;
> +	gfp_t gfp;
>  
> -	pte = alloc_pages(PGALLOC_GFP, 0);
> +	gfp = pgtable_gfp_flags(mm);
> +	pte = alloc_pages(gfp, 0);
>  	if (!pte)
>  		return NULL;
>  	if (!pgtable_page_ctor(pte)) {
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

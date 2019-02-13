Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF573C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:31:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C092073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eH+4dq5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C092073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=naHNtT/H0NTS5gV8EML6dh5eAXYe19zsqJAMJzw6etY=; b=eH+4dq5DEbYmwA
	S05nOru1l0z/NIcS6CU0K9V21CdHht6DOUl5GI0CrL+FPHi7iUihTLhd5L+wjG8o9beMhd/OExS4P
	4EOuBBUQWqBqgKFwUBbbGBEYg/ha+RudNL2Mm7QSYVtzh3t6hQY2AzRK5unE3QXQY+XQMdNIRwbmM
	++mZKKCj7cFP6VXEgeixEndu2J7ylf8DmRmHzFvx49OPZAui3YaZsAfpAHZArz/E/V1vl5pKPFtd2
	ZUMCUgziFUu/KsfOPTVRGgG96gJDEaNMR4E9lSqYW6Jsf3J4v5pb/5czp5uBxO9oaSYy0NvDvSDiF
	gZouc23DCZvrfzcc/+mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtskl-0006y5-Vm; Wed, 13 Feb 2019 11:30:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtski-0006xi-Te
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:30:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F933A78;
 Wed, 13 Feb 2019 03:30:55 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E053F557;
 Wed, 13 Feb 2019 03:30:53 -0800 (PST)
Date: Wed, 13 Feb 2019 11:30:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] arm64: mmu: pgd_pgtable_alloc: drop barrier
Message-ID: <20190213113050.GC22119@lakrids.cambridge.arm.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-3-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213094831.7292-3-peng.fan@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_033056_961722_E3DFDA5B 
X-CRM114-Status: GOOD (  21.65  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
 "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 09:37:38AM +0000, Peng Fan wrote:
> The barriers are added for empty_zero_page, however the
> empty zero page has been moved to bss area by
> commit 5227cfa71f9e ("arm64: mm: place empty_zero_page in bss"),
> and it alreay added "dsb     ishst" in head.S to make sure
> the empty zero page visible to PTW.

The "zeroed page" the comment refers to is not empty_zero_page.

The page
the comment refers to is an arbitrary page returned by
__get_free_page(), which has been filled with zeroed at some point
thanks to PGALLOC_GFP containing __GFP_ZERO.

> pgd_pgtable_alloc is only called by __create_pgd_mapping, and
> there are implicit barriers in __create_pgd_mapping, so we
> could remove the barrier pgd_pgtable_alloc

I don't think this is true.

Consider:

  create_pgd_mapping()
  -> __create_pgd_mapping()
     -> alloc_init_pud()
        -> pgtable_alloc() // pgd_pgtable_alloc()
	-> __pgd_populate()

... where AFAICT there is no barrier between pgtable_alloc() and
__pgd_populate().

Where is the barrier between the page zeroing and the update of the pgd
entry?

Thanks,
Mark.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> Note: this patch tested on qemu-system-aarch64, not real hardware.
> 
>  arch/arm64/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f61fa7c8fd2e..04e3d4d070ce 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -371,8 +371,6 @@ static phys_addr_t pgd_pgtable_alloc(void)
>  	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
>  		BUG();
>  
> -	/* Ensure the zeroed page is visible to the page table walker */
> -	dsb(ishst);
>  	return __pa(ptr);
>  }
>  
> -- 
> 2.16.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

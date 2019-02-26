Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B63C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:37:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFE92184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/gFyMKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFE92184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yw/wiTgSCsrOrD3qpt4cWyW6MRavIWhEJ9mCUdJd/pk=; b=Y/gFyMKxSbE4x9
	lAnkdCEHGjzvw40QimF+rU7A9Kjn1PBe1EuR//j7vjXHwuIrkgsE9WyPANs5XvDWI57dJ0dk7+e44
	AjqTPJCAiDWLcxh8PtkCEs9SKpGvZ7tXeexJDQm75tsycO6+2+KCMXiGALgeTkABka2RH03khF6sq
	cdQcozn1oq5K5lR/jaJYkKdJ2rtM61t10G9DiZ5IpPsTqvQ7yTx93CL3KKk4WNLXRB+lRhSXO+7S6
	IBueip/iZoC+BL5qY7aRhiUioddT3F09MEiOEDMF4Nb7zaQn7kBmGvuEia1Wp4VH+A+8pnRCn7ZXi
	luukUqpxoaTMhl1j9MAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyWNH-0005sk-Ev; Tue, 26 Feb 2019 06:37:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyWND-0005sR-MH
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 06:37:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F0C7A78;
 Mon, 25 Feb 2019 22:37:47 -0800 (PST)
Received: from [10.162.40.137] (p8cg001049571a15.blr.arm.com [10.162.40.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 A6E433F5C1; Mon, 25 Feb 2019 22:37:44 -0800 (PST)
Subject: Re: [PATCH V2 5/6] arm64/mm: Enable page table page accounting for
 user space
To: linux-arm-kernel@lists.infradead.org
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <284d8375-27c5-9198-f961-dde834340e69@arm.com>
Date: Tue, 26 Feb 2019 12:07:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1551071039-20192-6-git-send-email-anshuman.khandual@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_223751_729717_6414968E 
X-CRM114-Status: GOOD (  18.52  )
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
Cc: mark.rutland@arm.com, yuzhao@google.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, Catalin.Marinas@arm.com, Steve.Capper@arm.com,
 will.deacon@arm.com, james.morse@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/25/2019 10:33 AM, Anshuman Khandual wrote:
> Page table pages created for user space processes must be accounted against
> their memory control groups if initialized. This just introduces a helper
> function pgtable_gfp_flags() which returns PGALLOC_GFP for all kernel page
> table page allocations but adds __GFP_ACCOUNT for user page table pages.
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

Hello Will,

Checking for efi_mm is not necessary here as we just pass init_mm into
pte_alloc_one() from pgd_pgtable_alloc() which is used for all runtime
allocations for kernel mappings including init_mm and efi_mm. If we
really want to differentiate them, the helper pgtable_alloc() has to be
changed to include mm_struct. That might be some amount of code churn.
Wondering what will be preferred here.

- Anshuman  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

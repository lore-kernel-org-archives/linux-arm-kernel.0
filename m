Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB66C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:37:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD13420659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DhKqCUdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD13420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rM5/iDC5bx0eDWnVVwDEQO1oVBA6HDL65LfzSoj0L+w=; b=DhKqCUdl40JQee
	vjUVw4sDfbYW2XxlJtijcZVoIbtOCNOwSzWqJ21anI9RiP5fUr/CJ7nK2/sH5h5GkmGP8n2oHgpQ8
	ZzsCW1ygw0kMZ0WjCozmYFMKmnEEGnrj7+Wq3VDHETFhuLeoLOo/5LLYqBYOWdCl5hmF6qePRrRos
	lHewtvIl2QdDa4nRk/OX5MOXC0BV3acu+TFffTZytqC3cScWJ0mnp8uRyCrZI2dW+9tYCuEeZWBYO
	DTaq9xK+uYKDQ4G4Wppp3Mg6Cd14bSVuQ0M+MzjStuiO58TaT2T1NfF74QIfMBcMkDl8xj2ELgiNq
	sEgHWe76xb2CSd6qsCrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpLd-00058f-7Y; Mon, 03 Dec 2018 14:37:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpLZ-00058F-RN
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:37:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6653D1682;
 Mon,  3 Dec 2018 06:37:07 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6C83F5AF;
 Mon,  3 Dec 2018 06:37:05 -0800 (PST)
Subject: Re: [PATCH v9 5/8] KVM: arm64: Support PUD hugepage in
 stage2_is_exec()
To: Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-6-punit.agrawal@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ab23d99f-32fe-99d1-a255-89ef9028d660@arm.com>
Date: Mon, 3 Dec 2018 20:07:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-6-punit.agrawal@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_063717_898802_5BD69856 
X-CRM114-Status: GOOD (  24.78  )
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
Cc: suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 punitagrawal@gmail.com, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> In preparation for creating PUD hugepages at stage 2, add support for
> detecting execute permissions on PUD page table entries. Faults due to
> lack of execute permissions on page table entries is used to perform
> i-cache invalidation on first execute.
> 
> Provide trivial implementations of arm32 helpers to allow sharing of
> code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h         |  6 +++
>  arch/arm64/include/asm/kvm_mmu.h       |  5 +++
>  arch/arm64/include/asm/pgtable-hwdef.h |  2 +
>  virt/kvm/arm/mmu.c                     | 53 +++++++++++++++++++++++---
>  4 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 37bf85d39607..839a619873d3 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -102,6 +102,12 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
>  	return false;
>  }
>  
> +static inline bool kvm_s2pud_exec(pud_t *pud)
> +{
> +	BUG();
> +	return false;
> +}
> +
>  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
>  {
>  	pte_val(pte) |= L_PTE_S2_RDWR;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 8da6d1b2a196..c755b37b3f92 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -261,6 +261,11 @@ static inline bool kvm_s2pud_readonly(pud_t *pudp)
>  	return kvm_s2pte_readonly((pte_t *)pudp);
>  }
>  
> +static inline bool kvm_s2pud_exec(pud_t *pudp)
> +{
> +	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
> +}
> +
>  #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
>  
>  #ifdef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 1d7d8da2ef9b..336e24cddc87 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -193,6 +193,8 @@
>  #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
>  #define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
>  
> +#define PUD_S2_XN		(_AT(pudval_t, 2) << 53)  /* XN[1:0] */
> +
>  /*
>   * Memory Attribute override for Stage-2 (MemAttr[3:0])
>   */
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1c669c3c1208..8e44dccd1b47 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1083,23 +1083,66 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>  	return 0;
>  }
>  
> -static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
> +/*
> + * stage2_get_leaf_entry - walk the stage2 VM page tables and return
> + * true if a valid and present leaf-entry is found. A pointer to the
> + * leaf-entry is returned in the appropriate level variable - pudpp,
> + * pmdpp, ptepp.
> + */
> +static bool stage2_get_leaf_entry(struct kvm *kvm, phys_addr_t addr,
> +				  pud_t **pudpp, pmd_t **pmdpp, pte_t **ptepp)
>  {
> +	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep;
>  
> -	pmdp = stage2_get_pmd(kvm, NULL, addr);
> +	*pudpp = NULL;
> +	*pmdpp = NULL;
> +	*ptepp = NULL;
> +
> +	pudp = stage2_get_pud(kvm, NULL, addr);
> +	if (!pudp || stage2_pud_none(kvm, *pudp) || !stage2_pud_present(kvm, *pudp))
> +		return false;
> +
> +	if (stage2_pud_huge(kvm, *pudp)) {
> +		*pudpp = pudp;
> +		return true;
> +	}
> +
> +	pmdp = stage2_pmd_offset(kvm, pudp, addr);
>  	if (!pmdp || pmd_none(*pmdp) || !pmd_present(*pmdp))
>  		return false;
>  
> -	if (pmd_thp_or_huge(*pmdp))
> -		return kvm_s2pmd_exec(pmdp);
> +	if (pmd_thp_or_huge(*pmdp)) {
> +		*pmdpp = pmdp;
> +		return true;
> +	}
>  
>  	ptep = pte_offset_kernel(pmdp, addr);
>  	if (!ptep || pte_none(*ptep) || !pte_present(*ptep))
>  		return false;
>  
> -	return kvm_s2pte_exec(ptep);
> +	*ptepp = ptep;
> +	return true;
> +}
> +
> +static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
> +{
> +	pud_t *pudp;
> +	pmd_t *pmdp;
> +	pte_t *ptep;
> +	bool found;
> +
> +	found = stage2_get_leaf_entry(kvm, addr, &pudp, &pmdp, &ptep);
> +	if (!found)
> +		return false;
> +
> +	if (pudp)
> +		return kvm_s2pud_exec(pudp);
> +	else if (pmdp)
> +		return kvm_s2pmd_exec(pmdp);
> +	else
> +		return kvm_s2pte_exec(ptep);
>  }

stage2_get_leaf_entry() is not really necessary as a separate function.
It determines leaf entry and just return a true/false. At those 'true'
return points it can just return kvm_s2XXX_exec() directly. Passing
three  different pointers as arguments and checking for them being
non-NULL upon return and doing a simple return then seems like a lot
without much reason. stage2_is_exec() can just be expanded to add PUD
support.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

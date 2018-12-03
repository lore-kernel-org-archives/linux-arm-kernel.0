Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F6DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E1620848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qV90qQzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E1620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XAYGkQYieYaPkMiJ7eGlxLygaYS1J4p/j9GQf1YmriU=; b=qV90qQzLj0Ml+g
	aXp/afXV7wCRmzaOeVzQfr1TRxCm6CUsn08i0s4Nk2ckV2q+6XuQmt3JHFBtlyn4/+CZ7ZLW6NqGv
	RjE00qhQb3QizRZSFSf1EVUtlAT4ZVK9U1WLpCRlUORFQvkJnTHdjjNul77sHdZozpWXXzBo/YVve
	7G65beyLrH7M1qklA50q0rcsIMI98zFcNTxvY2Xjyf5ofVsccHeZZ8QwLrxDh0gMXWugztiKvSiy5
	wd4UzoQacKBSUTcxdbuRxhB9eIgofnQN4BdH1qL5wu315/Fu6xW8W2c0i+hKz2GYFiXp8xnLHxt2F
	KK/P7YPPqzMQzPs1zdsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTq68-0005bo-Ko; Mon, 03 Dec 2018 15:25:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTps4-0007Jy-M5
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:11:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA0C1682;
 Mon,  3 Dec 2018 07:10:42 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C37F43F5AF;
 Mon,  3 Dec 2018 07:10:39 -0800 (PST)
Subject: Re: [PATCH v9 6/8] KVM: arm64: Support handling access faults for PUD
 hugepages
To: Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-7-punit.agrawal@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <26fcfc2c-219a-ce04-457b-cc157301c7d3@arm.com>
Date: Mon, 3 Dec 2018 20:40:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-7-punit.agrawal@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_071053_006876_93D6FD79 
X-CRM114-Status: GOOD (  21.51  )
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
> In preparation for creating larger hugepages at Stage 2, extend the
> access fault handling at Stage 2 to support PUD hugepages when
> encountered.
> 
> Provide trivial helpers for arm32 to allow sharing of code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h   |  9 +++++++++
>  arch/arm64/include/asm/kvm_mmu.h |  7 +++++++
>  arch/arm64/include/asm/pgtable.h |  6 ++++++
>  virt/kvm/arm/mmu.c               | 22 +++++++++++-----------
>  4 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 839a619873d3..fea5e723e3ac 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -85,6 +85,9 @@ void kvm_clear_hyp_idmap(void);
>  #define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
>  #define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
>  
> +#define kvm_pud_pfn(pud)	({ BUG(); 0; })
> +
> +
>  #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
>  
>  /*
> @@ -108,6 +111,12 @@ static inline bool kvm_s2pud_exec(pud_t *pud)
>  	return false;
>  }
>  
> +static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
> +{
> +	BUG();
> +	return pud;
> +}
> +
>  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
>  {
>  	pte_val(pte) |= L_PTE_S2_RDWR;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index c755b37b3f92..612032bbb428 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -187,6 +187,8 @@ void kvm_clear_hyp_idmap(void);
>  #define kvm_pfn_pte(pfn, prot)		pfn_pte(pfn, prot)
>  #define kvm_pfn_pmd(pfn, prot)		pfn_pmd(pfn, prot)
>  
> +#define kvm_pud_pfn(pud)		pud_pfn(pud)
> +
>  #define kvm_pmd_mkhuge(pmd)		pmd_mkhuge(pmd)
>  
>  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
> @@ -266,6 +268,11 @@ static inline bool kvm_s2pud_exec(pud_t *pudp)
>  	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
>  }
>  
> +static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
> +{
> +	return pud_mkyoung(pud);
> +}
> +
>  #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
>  
>  #ifdef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 50b1ef8584c0..f51e2271e6a3 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -314,6 +314,11 @@ static inline pte_t pud_pte(pud_t pud)
>  	return __pte(pud_val(pud));
>  }
>  
> +static inline pud_t pte_pud(pte_t pte)
> +{
> +	return __pud(pte_val(pte));
> +}
> +

Yeah these would be required for PUD based THP when enabled.

>  static inline pmd_t pud_pmd(pud_t pud)
>  {
>  	return __pmd(pud_val(pud));
> @@ -381,6 +386,7 @@ static inline int pmd_protnone(pmd_t pmd)
>  #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
>  
> +#define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
>  #define pud_write(pud)		pte_write(pud_pte(pud))
>  
>  #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 8e44dccd1b47..bd749601195f 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1698,6 +1698,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   */
>  static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>  {
> +	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
>  	kvm_pfn_t pfn;
> @@ -1707,24 +1708,23 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>  
>  	spin_lock(&vcpu->kvm->mmu_lock);
>  
> -	pmd = stage2_get_pmd(vcpu->kvm, NULL, fault_ipa);
> -	if (!pmd || pmd_none(*pmd))	/* Nothing there */
> +	if (!stage2_get_leaf_entry(vcpu->kvm, fault_ipa, &pud, &pmd, &pte))
>  		goto out;
>  
> -	if (pmd_thp_or_huge(*pmd)) {	/* THP, HugeTLB */
> +	if (pud) {		/* HugeTLB */
> +		*pud = kvm_s2pud_mkyoung(*pud);
> +		pfn = kvm_pud_pfn(*pud);
> +		pfn_valid = true;
> +	} else	if (pmd) {	/* THP, HugeTLB */
>  		*pmd = pmd_mkyoung(*pmd);
>  		pfn = pmd_pfn(*pmd);
>  		pfn_valid = true;
> -		goto out;
> +	} else {
> +		*pte = pte_mkyoung(*pte);	/* Just a page... */
> +		pfn = pte_pfn(*pte);
> +		pfn_valid = true;
>  	}

As mentioned before stage2_get_leaf_entry() is not required for the previous
patch and handle_access_fault() can definitely do without it. The existing
page table walker flow is better than this helper which takes like three
different arguments and makes semantics more complicated than required.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

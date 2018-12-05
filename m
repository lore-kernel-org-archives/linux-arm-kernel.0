Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E987C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C870213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERb3F4s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C870213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oDQdPbcD14xErPUbNIA/wdSk+h3+UuQxw+nlwE6ZWKs=; b=ERb3F4s8zFPw1UtEs6HAdsyhp
	yohfwcazRZCqfLGf0kfqZ/0UCHqXQIp1Zt3Qt4aqliiWu0uSTu9eJsS8lqIBFnRuvpFqSDNaAl+KE
	wGLbLrfVOPDuVT7ZJAFPsD+UsudAdxuCguQ/ym4YwvJyNb7RXXP8FssJyGT0mkot6En95GJCXHB43
	lSoPZkb90cGMVLL/H8gqFGXB+h2FUESINL5BK5UC9L4ovKcD2htXE6kGOzRLyvqI6SqNSf40AgV6K
	yFw9rzSHmArHbZOgMf8A6q24LSH+XPRR7v1GI4MpfbJWl9SIm1tgkUEKQ28rXD+spL2agKKAEtlP9
	fMMbG/DAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbR2-00032S-1k; Wed, 05 Dec 2018 17:58:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbQz-00031K-Ix
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:58:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA34880D;
 Wed,  5 Dec 2018 09:57:54 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A3033F575;
 Wed,  5 Dec 2018 09:57:53 -0800 (PST)
Subject: Re: [PATCH v9 5/8] KVM: arm64: Support PUD hugepage in
 stage2_is_exec()
To: Christoffer Dall <christoffer.dall@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-6-punit.agrawal@arm.com>
 <20181101133848.GL12057@e113682-lin.lund.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5fddc14d-f6b6-bb97-5f5d-8e1e05e5da95@arm.com>
Date: Wed, 5 Dec 2018 17:57:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101133848.GL12057@e113682-lin.lund.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_095805_636513_03215BB8 
X-CRM114-Status: GOOD (  24.72  )
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
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, punitagrawal@gmail.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/11/2018 13:38, Christoffer Dall wrote:
> On Wed, Oct 31, 2018 at 05:57:42PM +0000, Punit Agrawal wrote:
>> In preparation for creating PUD hugepages at stage 2, add support for
>> detecting execute permissions on PUD page table entries. Faults due to
>> lack of execute permissions on page table entries is used to perform
>> i-cache invalidation on first execute.
>>
>> Provide trivial implementations of arm32 helpers to allow sharing of
>> code.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm/include/asm/kvm_mmu.h         |  6 +++
>>   arch/arm64/include/asm/kvm_mmu.h       |  5 +++
>>   arch/arm64/include/asm/pgtable-hwdef.h |  2 +
>>   virt/kvm/arm/mmu.c                     | 53 +++++++++++++++++++++++---
>>   4 files changed, 61 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 37bf85d39607..839a619873d3 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -102,6 +102,12 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
>>   	return false;
>>   }
>>   
>> +static inline bool kvm_s2pud_exec(pud_t *pud)
>> +{
>> +	BUG();
> 
> nit: I think this should be WARN() now :)
> 
>> +	return false;
>> +}
>> +
>>   static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
>>   {
>>   	pte_val(pte) |= L_PTE_S2_RDWR;
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 8da6d1b2a196..c755b37b3f92 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -261,6 +261,11 @@ static inline bool kvm_s2pud_readonly(pud_t *pudp)
>>   	return kvm_s2pte_readonly((pte_t *)pudp);
>>   }
>>   
>> +static inline bool kvm_s2pud_exec(pud_t *pudp)
>> +{
>> +	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
>> +}
>> +
>>   #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
>>   
>>   #ifdef __PAGETABLE_PMD_FOLDED
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 1d7d8da2ef9b..336e24cddc87 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -193,6 +193,8 @@
>>   #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
>>   #define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
>>   
>> +#define PUD_S2_XN		(_AT(pudval_t, 2) << 53)  /* XN[1:0] */
>> +
>>   /*
>>    * Memory Attribute override for Stage-2 (MemAttr[3:0])
>>    */
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 1c669c3c1208..8e44dccd1b47 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1083,23 +1083,66 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>   	return 0;
>>   }
>>   
>> -static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
>> +/*
>> + * stage2_get_leaf_entry - walk the stage2 VM page tables and return
>> + * true if a valid and present leaf-entry is found. A pointer to the
>> + * leaf-entry is returned in the appropriate level variable - pudpp,
>> + * pmdpp, ptepp.
>> + */
>> +static bool stage2_get_leaf_entry(struct kvm *kvm, phys_addr_t addr,
>> +				  pud_t **pudpp, pmd_t **pmdpp, pte_t **ptepp)
> 
> Do we need this type madness or could this just return a u64 pointer
> (NULL if nothing is found) and pass that to kvm_s2pte_exec (because we
> know it's the same bit we need to check regardless of the pgtable level
> on both arm and arm64)?
> 
> Or do we consider that bad for some reason?

Practically, yes the bit positions are same and thus we should be able
to do this assuming that it is just a pte. When we get to independent stage2
pgtable implementation which treats all page table entries as a single type
with a level information, we should be able to get rid of these.
But since we have followed the Linux way of page-table manipulation where we
have "level" specific accessors. The other option is open code the walking
sequence from the pgd to the leaf entry everywhere.

I am fine with changing this code, if you like.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

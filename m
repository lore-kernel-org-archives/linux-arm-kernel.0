Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828FAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0362084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nDl34CPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0362084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zx8e7WxrCQVIqs3fsn8+q29lqIEVQHPzXi76jg1NkpU=; b=nDl34CPIdSiLftFHsnJ1F3vzc
	UL68oUF0Rut1xlW/rFQ2hHqk1BEt117T49C32zE1H9DE9pDO2fopFKi1Z5U5m2nsx2prFnzisfJDt
	nO7C8nQ6wr5COps8X0tRjLLaloUZqqSSjYo3zmIHuJSYDi8JlIX675ia7xB4i8J4ZcmnMbiSqSs1v
	Tg6KM9LhnFoNlMOWj9MneD5u8m6WDSAt2lYS0waLLg8DfKhywDZebO8MaifM20rqcIk+75J1rJq51
	4NtfQcu0LFxKjE5tBYj0cFTkwRPd31/3+NhbN4AWLilPY9DNRHqHRycsVPlCjy2TN7JP9lKCkyIS+
	OwdjBx+Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJ6W-0008Ou-FD; Mon, 10 Dec 2018 10:48:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ6S-0008OG-G8
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:47:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30EA61596;
 Mon, 10 Dec 2018 02:47:45 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE903F6A8;
 Mon, 10 Dec 2018 02:47:43 -0800 (PST)
Subject: Re: [PATCH v9 1/8] KVM: arm/arm64: Share common code in
 user_mem_abort()
To: Christoffer Dall <christoffer.dall@arm.com>
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-2-punit.agrawal@arm.com>
 <ad4b316a-054f-24d9-d32d-8fbe7972b5ad@arm.com>
 <8fd34e5f-7d75-4de2-3fee-d6d70805685c@arm.com>
 <20181210085616.GB30263@e113682-lin.lund.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f6410472-9af7-4b41-3809-3cf691e795e6@arm.com>
Date: Mon, 10 Dec 2018 10:47:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210085616.GB30263@e113682-lin.lund.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_024756_553802_24D43DD2 
X-CRM114-Status: GOOD (  27.57  )
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
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, punitagrawal@gmail.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 10/12/2018 08:56, Christoffer Dall wrote:
> On Mon, Dec 03, 2018 at 01:37:37PM +0000, Suzuki K Poulose wrote:
>> Hi Anshuman,
>>
>> On 03/12/2018 12:11, Anshuman Khandual wrote:
>>>
>>>
>>> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
>>>> The code for operations such as marking the pfn as dirty, and
>>>> dcache/icache maintenance during stage 2 fault handling is duplicated
>>>> between normal pages and PMD hugepages.
>>>>
>>>> Instead of creating another copy of the operations when we introduce
>>>> PUD hugepages, let's share them across the different pagesizes.
>>>>
>>>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>   virt/kvm/arm/mmu.c | 49 ++++++++++++++++++++++++++++------------------
>>>>   1 file changed, 30 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>> index 5eca48bdb1a6..59595207c5e1 100644
>>>> --- a/virt/kvm/arm/mmu.c
>>>> +++ b/virt/kvm/arm/mmu.c
>>>> @@ -1475,7 +1475,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>   			  unsigned long fault_status)
>>>>   {
>>>>   	int ret;
>>>> -	bool write_fault, exec_fault, writable, hugetlb = false, force_pte = false;
>>>> +	bool write_fault, exec_fault, writable, force_pte = false;
>>>>   	unsigned long mmu_seq;
>>>>   	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
>>>>   	struct kvm *kvm = vcpu->kvm;
>>>> @@ -1484,7 +1484,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>   	kvm_pfn_t pfn;
>>>>   	pgprot_t mem_type = PAGE_S2;
>>>>   	bool logging_active = memslot_is_logging(memslot);
>>>> -	unsigned long flags = 0;
>>>> +	unsigned long vma_pagesize, flags = 0;
>>>
>>> A small nit s/vma_pagesize/pagesize. Why call it VMA ? Its implicit.
>>
>> May be we could call it mapsize. pagesize is confusing.
>>
> 
> I'm ok with mapsize.  I see the vma_pagesize name coming from the fact
> that this is initially set to the return value from vma_kernel_pagesize.
> 
> I have not problems with either vma_pagesize or mapsize.
> 
>>>
>>>>   	write_fault = kvm_is_write_fault(vcpu);
>>>>   	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
>>>> @@ -1504,10 +1504,16 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>   		return -EFAULT;
>>>>   	}
>>>> -	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
>>>> -		hugetlb = true;
>>>> +	vma_pagesize = vma_kernel_pagesize(vma);
>>>> +	if (vma_pagesize == PMD_SIZE && !logging_active) {
>>>>   		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>>>   	} else {
>>>> +		/*
>>>> +		 * Fallback to PTE if it's not one of the Stage 2
>>>> +		 * supported hugepage sizes
>>>> +		 */
>>>> +		vma_pagesize = PAGE_SIZE;
>>>
>>> This seems redundant and should be dropped. vma_kernel_pagesize() here either
>>> calls hugetlb_vm_op_pagesize (via hugetlb_vm_ops->pagesize) or simply returns
>>> PAGE_SIZE. The vm_ops path is taken if the QEMU VMA covering any given HVA is
>>> backed either by HugeTLB pages or simply normal pages. vma_pagesize would
>>> either has a value of PMD_SIZE (HugeTLB hstate based) or PAGE_SIZE. Hence if
>>> its not PMD_SIZE it must be PAGE_SIZE which should not be assigned again.
>>
>> We may want to force using the PTE mappings when logging_active (e.g, migration
>> ?) to prevent keep tracking of huge pages. So the check is still valid.
>>
>>
> 
> Agreed, and let's not try additionally change the logic and flow with
> this patch.
> 
>>>
>>>> +
>>>>   		/*
>>>>   		 * Pages belonging to memslots that don't have the same
>>>>   		 * alignment for userspace and IPA cannot be mapped using
>>>> @@ -1573,23 +1579,33 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>   	if (mmu_notifier_retry(kvm, mmu_seq))
>>>>   		goto out_unlock;
>>>> -	if (!hugetlb && !force_pte)
>>>> -		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>>>> +	if (vma_pagesize == PAGE_SIZE && !force_pte) {
>>>> +		/*
>>>> +		 * Only PMD_SIZE transparent hugepages(THP) are
>>>> +		 * currently supported. This code will need to be
>>>> +		 * updated to support other THP sizes.
>>>> +		 */
>>>
>>> This comment belongs to transparent_hugepage_adjust() but not here.
>>
>> I think this is relevant here than in thp_adjust, unless we rename
>> the function below to something generic, handle_hugepage_adjust().
>>
> 
> Agreed.
> 
>>>> +		if (transparent_hugepage_adjust(&pfn, &fault_ipa))
>>>> +			vma_pagesize = PMD_SIZE;
>>>
>>> IIUC transparent_hugepage_adjust() is only getting called here. Instead of
>>> returning 'true' when it is able to detect a huge page backing and doing
>>> an adjustment there after, it should rather return THP size (PMD_SIZE) to
>>> accommodate probable multi size THP support in future .
>>
>> That makes sense.
>>
> 
> That's fine.
> 

Btw, after a further thought, since we don't have any THP support for anything
other than PMD_SIZE, I am dropping the above suggestion. We need to make changes
in our stage2 page table manipulation code anyway to support the new sizes. So
this could be addressed when we get there, to keep the changes minimal and
specific to the PUD huge page support.


Cheers
Suzuki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

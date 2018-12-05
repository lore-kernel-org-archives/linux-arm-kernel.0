Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BC8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:47:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B8B20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/PLqRre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B8B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=llAdCsZ8Pxyk0i8jmqhCIx+AbdgFHM+dN4Po2CB6VRg=; b=X/PLqRre1MWAEHhSC2DNNK0hf
	k+0AveKKc11RsZkifNA4ncgxJ9EWDsW4RvLU5WCDhfEvE8mXsUBGrAWVVju/r/7KWzySXHjNWhVy8
	R/aMDZ9CexhLyWS3ddJxCY8fjJV8uQ6XRew9j+kEmAfgVjKziCcSUP2IG2+qY07ebDWDZJVAXs25k
	uagNMOSxjv5V/ibiJQZHjTHBE9pxlpaoylFHuEO5dG6d2pnp3PSMHPySmTqU1YqHEc0XF3axyMyT5
	FZ6CGjxe0p6ADrnt45rBA8k0tK1WeZmMP0gVqCaIl8Cd4iMYwfbODXstuRLE+53PRff89u0Vm289g
	KIuDB9C9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUiF-0006t8-2o; Wed, 05 Dec 2018 10:47:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUiC-0006sS-5f
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:47:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9BE80D;
 Wed,  5 Dec 2018 02:47:13 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20FFC3F575;
 Wed,  5 Dec 2018 02:47:11 -0800 (PST)
Subject: Re: [PATCH v9 2/8] KVM: arm/arm64: Re-factor setting the Stage 2
 entry to exec on fault
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-3-punit.agrawal@arm.com>
 <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f078ae84-9906-4394-957f-8f041b08827f@arm.com>
Date: Wed, 5 Dec 2018 10:47:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_024724_270830_24715FF3 
X-CRM114-Status: GOOD (  18.95  )
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
Cc: marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Christoffer Dall <christoffer.dall@arm.com>, punitagrawal@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 03/12/2018 13:32, Anshuman Khandual wrote:
> 
> 
> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
>> Stage 2 fault handler marks a page as executable if it is handling an
>> execution fault or if it was a permission fault in which case the
>> executable bit needs to be preserved.
>>
>> The logic to decide if the page should be marked executable is
>> duplicated for PMD and PTE entries. To avoid creating another copy
>> when support for PUD hugepages is introduced refactor the code to
>> share the checks needed to mark a page table entry as executable.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   virt/kvm/arm/mmu.c | 28 +++++++++++++++-------------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 59595207c5e1..6912529946fb 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1475,7 +1475,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   			  unsigned long fault_status)
>>   {
>>   	int ret;
>> -	bool write_fault, exec_fault, writable, force_pte = false;
>> +	bool write_fault, writable, force_pte = false;
>> +	bool exec_fault, needs_exec;
> 
> New line not required, still within 80 characters.
> 
>>   	unsigned long mmu_seq;
>>   	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
>>   	struct kvm *kvm = vcpu->kvm;
>> @@ -1598,19 +1599,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (exec_fault)
>>   		invalidate_icache_guest_page(pfn, vma_pagesize);
>>   
>> +	/*
>> +	 * If we took an execution fault we have made the
>> +	 * icache/dcache coherent above and should now let the s2
> 
> Coherent or invalidated with invalidate_icache_guest_page ?

We also do clean_dcache above if needed. So that makes sure
the data is coherent. Am I missing something here ?

> 
>> +	 * mapping be executable.
>> +	 *
>> +	 * Write faults (!exec_fault && FSC_PERM) are orthogonal to
>> +	 * execute permissions, and we preserve whatever we have.
>> +	 */
> 
> Otherwise looks good.
> 


Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

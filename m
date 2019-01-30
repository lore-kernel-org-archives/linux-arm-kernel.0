Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C238C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:40:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409C7218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jJw1MWU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409C7218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MvJ8mTV51SMnfB8Y779pbE9qTPm1tpohxFGG2WQrvzE=; b=jJw1MWU/SPyioWsWZVWj+22np
	9/ymTPV3ezQmQE+TkVzSGdmdk3oTt9YMkXa+iP2zVQSm4mC4vA6G4uJxb9lYwNuh++JgictJxPVXH
	aPTKif5Cuz/7O9tcZYXl6yYYRG7i2Fjw7jGjbFVeBAYJ45saFSRRrqs2rweyNOWlg8Sbb7xkp27Vh
	AH3BrcObODKNAqtr4swpVtT9svqYZJDjjLASMQ5Jk9pI5BcVrnq/wGdMn8jK8Sfw+ji3nUJ6KuYNP
	IlQoRf4shhYHRWk9F5rXvFN+K8wJS9nRpXPCsmnhxuUM6lYB23pRD2GeRLOKN31xTBGS0yFDxKE6s
	aXh50y8XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonHk-0006Fd-JG; Wed, 30 Jan 2019 10:40:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonHh-0006Ec-9k
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:39:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84113A78;
 Wed, 30 Jan 2019 02:39:50 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5D3A3F59C;
 Wed, 30 Jan 2019 02:39:48 -0800 (PST)
Subject: Re: [PATCH] kvm: arm64: Relax the restriction on using stage2 PUD
 huge mapping
To: marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org
References: <1548789137-4446-1-git-send-email-suzuki.poulose@arm.com>
 <ddff61a6-bc43-564e-c1ee-ed2c2764fad6@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <64c7a684-3e4b-381e-2223-f3db99963613@arm.com>
Date: Wed, 30 Jan 2019 10:39:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ddff61a6-bc43-564e-c1ee-ed2c2764fad6@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_023957_446639_34C3AFCA 
X-CRM114-Status: GOOD (  25.88  )
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
Cc: christoffer.dall@arm.com, cdall@kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Marc,

On 30/01/2019 10:21, Marc Zyngier wrote:
> On 29/01/2019 19:12, Suzuki K Poulose wrote:
>> We restrict mapping the PUD huge pages in stage2 to only when the
>> stage2 has 4 level page table, leaving the feature unused with
>> the default IPA size. But we could use it even with a 3
>> level page table, i.e, when the PUD level is folded into PGD,
>> just like the stage1. Relax the condition to allow using the
>> PUD huge page mappings at stage2 when it is possible.
>>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   virt/kvm/arm/mmu.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index fbdf3ac..30251e2 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1695,11 +1695,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   
>>   	vma_pagesize = vma_kernel_pagesize(vma);
>>   	/*
>> -	 * PUD level may not exist for a VM but PMD is guaranteed to
>> -	 * exist.
>> +	 * The stage2 has a minimum of 2 level table (For arm64 see
>> +	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
>> +	 * use PMD_SIZE huge mappings (even when the PMD is folded into PGD).
>> +	 * As for PUD huge maps, we must make sure that we have at least
>> +	 * 3 levels, i.e, PMD is not folded.
>>   	 */
>>   	if ((vma_pagesize == PMD_SIZE ||
>> -	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pud(kvm))) &&
>> +	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
>>   	    !force_pte) {
>>   		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
>>   	}
>>
> 
> For the record, it took a 10 minute discussion with Suzuki  to
> understand that the above is actually correct, even if massively
> confusing. Why is it correct:
> 
> - In a 4 level stage-2, each of PGD/PUD/PMD exists on its own, and start
> level is 0
> - In a 3 level stage-2, PGD and PUD are fused as the start level is 1,
> and PMD exists on its own
> - In a 2 level stage-2, both PGD, PUD and PMD are fused, and start level
> is 2.
> 
>  From the above, we can extract that you can always have a block mapping
> at the PUD level if you have a standalone PMD, and that's the logic this
> patch is using.

Thanks for writing it up ! :-)

> 
> Now, the *real* reason is that you can map a given size in your S2PT,
> not that some level is fused or not. What we want is probably a helper
> that says:
> 
> bool kvm_stage2_can_map_block_size(struct kvm *kvm, size_t sz)
> {
> 	return sz >= PMD_SIZE && stage2_pgdir_size(kvm) >= sz);
> }
> 
> and the above becomes:
> 
> if (kvm_stage2_can_map_block_size(kvm, vma_pagesize)) && !force_pte)
> 
> which I find much nicer.
> 
> I guess I can still take the above as a fix if Christoffer is happy with
> it, but if you think my above hack is correct, I'd like things to be
> cleaned-up in the near future.

Sure, as we discussed that makes it much simpler and generic. I could
address that.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0931C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:46:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5182084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+uvhsl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5182084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DHtelfIO3brYHPfshKdmsCPxlejIdVp8dS4NaUMaqos=; b=K+uvhsl9jyafEp
	lyxW0wJYseOOt6eRmCUm0RGAbXSISXfFW/WWyOjJO+jNWJ55cAl4yfh/mG+ZnoyPkYZ310aXDjtWB
	UflDyOk17XQoXjGuTyIte7Sb/B8KowkEH+HFNfxH7M8/OLL+xA0S/QTS/acdKcdF96HoJ1hfW/VlL
	JGPd+ccBncu8OcKLTR/p6VzdGqCzhgZOLnSHBj1NkPB/+jTE6V0grmaap9IwlkHCBG0ErvdWjfusF
	OMqgwEDsvu3d4qY2p2nSGCSyMI07+/kIJeQK+fbaw3bdFSVZKrTDA+BM7WIOQ2NO4c+TJfwAo31tq
	Dcy+LJcaBCqFMCDB49Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJ59-00088N-MP; Mon, 10 Dec 2018 10:46:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ56-00087q-3U
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:46:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA62C1596;
 Mon, 10 Dec 2018 02:46:21 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4C2103F6A8; Mon, 10 Dec 2018 02:46:20 -0800 (PST)
Subject: Re: [PATCH v3 7/8] arm64: KVM: Handle ARM erratum 1165522 in TLB
 invalidation
To: Christoffer Dall <christoffer.dall@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-8-marc.zyngier@arm.com>
 <20181210101912.GK30263@e113682-lin.lund.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <50e6a07d-868b-db43-fd4e-4b6359a5128e@arm.com>
Date: Mon, 10 Dec 2018 10:46:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210101912.GK30263@e113682-lin.lund.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_024632_149373_5DE95F1C 
X-CRM114-Status: GOOD (  20.79  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 James Morse <james.morse@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/12/2018 10:19, Christoffer Dall wrote:
> On Thu, Dec 06, 2018 at 05:31:25PM +0000, Marc Zyngier wrote:
>> In order to avoid TLB corruption whilst invalidating TLBs on CPUs
>> affected by erratum 1165522, we need to prevent S1 page tables
>> from being usable.
>>
>> For this, we set the EL1 S1 MMU on, and also disable the page table
>> walker (by setting the TCR_EL1.EPD* bits to 1).
>>
>> This ensures that once we switch to the EL1/EL0 translation regime,
>> speculated AT instructions won't be able to parse the page tables.
>>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/hyp/tlb.c | 66 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 51 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
>> index 7fcc9c1a5f45..ec157543d5a9 100644
>> --- a/arch/arm64/kvm/hyp/tlb.c
>> +++ b/arch/arm64/kvm/hyp/tlb.c
>> @@ -21,12 +21,36 @@
>>  #include <asm/kvm_mmu.h>
>>  #include <asm/tlbflush.h>
>>  
>> +struct tlb_inv_context {
>> +	unsigned long	flags;
>> +	u64		tcr;
>> +	u64		sctlr;
>> +};
>> +
>>  static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
>> -						 unsigned long *flags)
>> +						 struct tlb_inv_context *cxt)
>>  {
>>  	u64 val;
>>  
>> -	local_irq_save(*flags);
>> +	local_irq_save(cxt->flags);
>> +
>> +	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
>> +		/*
>> +		 * For CPUs that are affected by ARM erratum 1165522, we
>> +		 * cannot trust stage-1 to be in a correct state at that
>> +		 * point. Since we do not want to force a full load of the
>> +		 * vcpu state, we prevent the EL1 page-table walker to
>> +		 * allocate new TLBs. This is done by setting the EPD bits
>> +		 * in the TCR_EL1 register. We also need to prevent it to
>> +		 * allocate IPA->PA walks, so we enable the S1 MMU...
>> +		 */
>> +		val = cxt->tcr = read_sysreg_el1(tcr);
>> +		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
>> +		write_sysreg_el1(val, tcr);
>> +		val = cxt->sctlr = read_sysreg_el1(sctlr);
>> +		val |= SCTLR_ELx_M;
>> +		write_sysreg_el1(val, sctlr);
>> +	}
>>  
>>  	/*
>>  	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}, and
>> @@ -34,6 +58,11 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
>>  	 * guest TLBs (EL1/EL0), we need to change one of these two
>>  	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
>>  	 * let's flip TGE before executing the TLB operation.
>> +	 *
>> +	 * ARM erratum 1165522 requires some special handling (again),
>> +	 * as we need to make sure both stages of translation are in
>> +	 * place before clearing TGE. __load_guest_stage2() already
>> +	 * has an ISB in order to deal with this.
>>  	 */
>>  	__load_guest_stage2(kvm);
>>  	val = read_sysreg(hcr_el2);
>> @@ -43,7 +72,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
>>  }
>>  
>>  static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
>> -						  unsigned long *flags)
>> +						  struct tlb_inv_context *cxt)
>>  {
>>  	__load_guest_stage2(kvm);
>>  	isb();
>> @@ -55,7 +84,7 @@ static hyp_alternate_select(__tlb_switch_to_guest,
>>  			    ARM64_HAS_VIRT_HOST_EXTN);
>>  
>>  static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
>> -						unsigned long flags)
>> +						struct tlb_inv_context *cxt)
>>  {
>>  	/*
>>  	 * We're done with the TLB operation, let's restore the host's
>> @@ -64,11 +93,18 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
>>  	write_sysreg(0, vttbr_el2);
>>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>>  	isb();
>> -	local_irq_restore(flags);
>> +
>> +	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
>> +		/* Restore the guest's registers to what they were */
> 
> host's ?

Hum... Yes, silly thinko.

[...]

> 
> Otherwise:
> 
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

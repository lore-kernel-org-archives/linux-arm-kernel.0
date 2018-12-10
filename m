Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:20:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A234020821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qw2fZjkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A234020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iFHQIpdgqtovd8stFo3mZ8qgLAc3nhcryHsxkM0NGYo=; b=qw2fZjkmAigsty
	t4MglnhF/fE3CxLqwTWvufEVV2WNIMrBidjnuiYvULIWNG+6s3F1UufUEG1balOE4W/qbRTKioBgu
	Upk3PDtP2dAsKhd+aipwo7UgZ9AV2ARDssbL8Cdyg3KnCxLQtUhIk3HzZfzkVl0p081GHAlb9F5Cx
	q+65+NJqL2Ap/BA0qS9xhJSchknqXOVJCSlwfqQrjxKbf36iFTCaarc8asxskeY5H8Bqqy1QLRTAE
	SNdZxgVgQacMAkIsbdKDZC3/rkx6V2cM3MulzKlA6lF4Qn9Sfl+zNsGp9PdLCaRQAFIte4Xan/VeA
	hgPzIxvPJuNfB3F1Yypg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIfJ-0000iv-R2; Mon, 10 Dec 2018 10:19:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIer-0000FE-Sa
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:19:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDB4E1596;
 Mon, 10 Dec 2018 02:19:14 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DDC13F6A8;
 Mon, 10 Dec 2018 02:19:14 -0800 (PST)
Date: Mon, 10 Dec 2018 11:19:12 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 7/8] arm64: KVM: Handle ARM erratum 1165522 in TLB
 invalidation
Message-ID: <20181210101912.GK30263@e113682-lin.lund.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-8-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206173126.139877-8-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_021925_935705_33D03871 
X-CRM114-Status: GOOD (  26.66  )
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

On Thu, Dec 06, 2018 at 05:31:25PM +0000, Marc Zyngier wrote:
> In order to avoid TLB corruption whilst invalidating TLBs on CPUs
> affected by erratum 1165522, we need to prevent S1 page tables
> from being usable.
> 
> For this, we set the EL1 S1 MMU on, and also disable the page table
> walker (by setting the TCR_EL1.EPD* bits to 1).
> 
> This ensures that once we switch to the EL1/EL0 translation regime,
> speculated AT instructions won't be able to parse the page tables.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/hyp/tlb.c | 66 +++++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index 7fcc9c1a5f45..ec157543d5a9 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -21,12 +21,36 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/tlbflush.h>
>  
> +struct tlb_inv_context {
> +	unsigned long	flags;
> +	u64		tcr;
> +	u64		sctlr;
> +};
> +
>  static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
> -						 unsigned long *flags)
> +						 struct tlb_inv_context *cxt)
>  {
>  	u64 val;
>  
> -	local_irq_save(*flags);
> +	local_irq_save(cxt->flags);
> +
> +	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
> +		/*
> +		 * For CPUs that are affected by ARM erratum 1165522, we
> +		 * cannot trust stage-1 to be in a correct state at that
> +		 * point. Since we do not want to force a full load of the
> +		 * vcpu state, we prevent the EL1 page-table walker to
> +		 * allocate new TLBs. This is done by setting the EPD bits
> +		 * in the TCR_EL1 register. We also need to prevent it to
> +		 * allocate IPA->PA walks, so we enable the S1 MMU...
> +		 */
> +		val = cxt->tcr = read_sysreg_el1(tcr);
> +		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
> +		write_sysreg_el1(val, tcr);
> +		val = cxt->sctlr = read_sysreg_el1(sctlr);
> +		val |= SCTLR_ELx_M;
> +		write_sysreg_el1(val, sctlr);
> +	}
>  
>  	/*
>  	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}, and
> @@ -34,6 +58,11 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
>  	 * guest TLBs (EL1/EL0), we need to change one of these two
>  	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
>  	 * let's flip TGE before executing the TLB operation.
> +	 *
> +	 * ARM erratum 1165522 requires some special handling (again),
> +	 * as we need to make sure both stages of translation are in
> +	 * place before clearing TGE. __load_guest_stage2() already
> +	 * has an ISB in order to deal with this.
>  	 */
>  	__load_guest_stage2(kvm);
>  	val = read_sysreg(hcr_el2);
> @@ -43,7 +72,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
>  }
>  
>  static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
> -						  unsigned long *flags)
> +						  struct tlb_inv_context *cxt)
>  {
>  	__load_guest_stage2(kvm);
>  	isb();
> @@ -55,7 +84,7 @@ static hyp_alternate_select(__tlb_switch_to_guest,
>  			    ARM64_HAS_VIRT_HOST_EXTN);
>  
>  static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
> -						unsigned long flags)
> +						struct tlb_inv_context *cxt)
>  {
>  	/*
>  	 * We're done with the TLB operation, let's restore the host's
> @@ -64,11 +93,18 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
>  	write_sysreg(0, vttbr_el2);
>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
>  	isb();
> -	local_irq_restore(flags);
> +
> +	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
> +		/* Restore the guest's registers to what they were */

host's ?

> +		write_sysreg_el1(cxt->tcr, tcr);
> +		write_sysreg_el1(cxt->sctlr, sctlr);
> +	}
> +
> +	local_irq_restore(cxt->flags);
>  }
>  
>  static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
> -						 unsigned long flags)
> +						 struct tlb_inv_context *cxt)
>  {
>  	write_sysreg(0, vttbr_el2);
>  }
> @@ -80,13 +116,13 @@ static hyp_alternate_select(__tlb_switch_to_host,
>  
>  void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  {
> -	unsigned long flags;
> +	struct tlb_inv_context cxt;
>  
>  	dsb(ishst);
>  
>  	/* Switch to requested VMID */
>  	kvm = kern_hyp_va(kvm);
> -	__tlb_switch_to_guest()(kvm, &flags);
> +	__tlb_switch_to_guest()(kvm, &cxt);
>  
>  	/*
>  	 * We could do so much better if we had the VA as well.
> @@ -129,39 +165,39 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  	if (!has_vhe() && icache_is_vpipt())
>  		__flush_icache_all();
>  
> -	__tlb_switch_to_host()(kvm, flags);
> +	__tlb_switch_to_host()(kvm, &cxt);
>  }
>  
>  void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
>  {
> -	unsigned long flags;
> +	struct tlb_inv_context cxt;
>  
>  	dsb(ishst);
>  
>  	/* Switch to requested VMID */
>  	kvm = kern_hyp_va(kvm);
> -	__tlb_switch_to_guest()(kvm, &flags);
> +	__tlb_switch_to_guest()(kvm, &cxt);
>  
>  	__tlbi(vmalls12e1is);
>  	dsb(ish);
>  	isb();
>  
> -	__tlb_switch_to_host()(kvm, flags);
> +	__tlb_switch_to_host()(kvm, &cxt);
>  }
>  
>  void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
> -	unsigned long flags;
> +	struct tlb_inv_context cxt;
>  
>  	/* Switch to requested VMID */
> -	__tlb_switch_to_guest()(kvm, &flags);
> +	__tlb_switch_to_guest()(kvm, &cxt);
>  
>  	__tlbi(vmalle1);
>  	dsb(nsh);
>  	isb();
>  
> -	__tlb_switch_to_host()(kvm, flags);
> +	__tlb_switch_to_host()(kvm, &cxt);
>  }
>  
>  void __hyp_text __kvm_flush_vm_context(void)
> -- 
> 2.19.2
> 

Otherwise:

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

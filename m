Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3D22086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eDI6uc1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3D22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XOLv+rshHvKWlpLqYUJFas5aFzRW2Dd89tPthtj6k9g=; b=eDI6uc1F5te+Ga
	QXSLVYDVSJKZNFz3sC7snUBVk7Lz37PjDo/G+i2xXYd+f82SFSZ3YTO4JLe5z2rRCc2Vt8rrjFeLF
	6IJwxW6aMk2fq7LelLv7ZFXzRfqwk//gA/3PcuHxl4zGzkI3vYDRnunkEiYmDH23eqOOdUIqfol5V
	TQjDyncK6yeVSQEHOdiqawfqOH0UjNNCbVrQxAuzGxAJwcOO9TzGrJRX4FTNd9adKZ3J8oxwx1l++
	T2gpywfdm+UEas10MAyI17yMM6AZh91B6mz6Q1EQzEDZ9vpKhcfFJldzzf/cFlREPxpzGeJFvC8VW
	fDn3iY5CB55shm6K/GdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIQC-0000XM-3p; Mon, 10 Dec 2018 10:04:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIQ6-0000KO-V4
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:04:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F9E1596;
 Mon, 10 Dec 2018 02:03:59 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE113F6A8;
 Mon, 10 Dec 2018 02:03:58 -0800 (PST)
Date: Mon, 10 Dec 2018 11:03:56 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 1/8] arm64: KVM: Make VHE Stage-2 TLB invalidation
 operations non-interruptible
Message-ID: <20181210100356.GG30263@e113682-lin.lund.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206173126.139877-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_020411_024826_0ACF6069 
X-CRM114-Status: GOOD (  23.32  )
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

On Thu, Dec 06, 2018 at 05:31:19PM +0000, Marc Zyngier wrote:
> Contrary to the non-VHE version of the TLB invalidation helpers, the VHE
> code  has interrupts enabled, meaning that we can take an interrupt in
> the middle of such a sequence, and start running something else with
> HCR_EL2.TGE cleared.

Do we have to clear TGE to perform the TLB invalidation, or is that just
a side-effect of re-using code?

Also, do we generally perform TLB invalidations in the kernel with
interrupts disabled, or is this just a result of clearing TGE?

Somehow I feel like this should look more like just another TLB
invalidation in the kernel, but if there's a good reason why it can't
then this is fine.

Thanks,

    Christoffer

> 
> That's really not a good idea.
> 
> Take the heavy-handed option and disable interrupts in
> __tlb_switch_to_guest_vhe, restoring them in __tlb_switch_to_host_vhe.
> The latter also gain an ISB in order to make sure that TGE really has
> taken effect.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/hyp/tlb.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index 4dbd9c69a96d..7fcc9c1a5f45 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -15,14 +15,19 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/irqflags.h>
> +
>  #include <asm/kvm_hyp.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/tlbflush.h>
>  
> -static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
> +static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
> +						 unsigned long *flags)
>  {
>  	u64 val;
>  
> +	local_irq_save(*flags);
> +
>  	/*
>  	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}, and
>  	 * most TLB operations target EL2/EL0. In order to affect the
> @@ -37,7 +42,8 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
>  	isb();
>  }
>  
> -static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
> +static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
> +						  unsigned long *flags)
>  {
>  	__load_guest_stage2(kvm);
>  	isb();
> @@ -48,7 +54,8 @@ static hyp_alternate_select(__tlb_switch_to_guest,
>  			    __tlb_switch_to_guest_vhe,
>  			    ARM64_HAS_VIRT_HOST_EXTN);
>  
> -static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm)
> +static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
> +						unsigned long flags)
>  {
>  	/*
>  	 * We're done with the TLB operation, let's restore the host's
> @@ -56,9 +63,12 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm)
>  	 */
>  	write_sysreg(0, vttbr_el2);
>  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
> +	isb();
> +	local_irq_restore(flags);
>  }
>  
> -static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm)
> +static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
> +						 unsigned long flags)
>  {
>  	write_sysreg(0, vttbr_el2);
>  }
> @@ -70,11 +80,13 @@ static hyp_alternate_select(__tlb_switch_to_host,
>  
>  void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  {
> +	unsigned long flags;
> +
>  	dsb(ishst);
>  
>  	/* Switch to requested VMID */
>  	kvm = kern_hyp_va(kvm);
> -	__tlb_switch_to_guest()(kvm);
> +	__tlb_switch_to_guest()(kvm, &flags);
>  
>  	/*
>  	 * We could do so much better if we had the VA as well.
> @@ -117,36 +129,39 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>  	if (!has_vhe() && icache_is_vpipt())
>  		__flush_icache_all();
>  
> -	__tlb_switch_to_host()(kvm);
> +	__tlb_switch_to_host()(kvm, flags);
>  }
>  
>  void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
>  {
> +	unsigned long flags;
> +
>  	dsb(ishst);
>  
>  	/* Switch to requested VMID */
>  	kvm = kern_hyp_va(kvm);
> -	__tlb_switch_to_guest()(kvm);
> +	__tlb_switch_to_guest()(kvm, &flags);
>  
>  	__tlbi(vmalls12e1is);
>  	dsb(ish);
>  	isb();
>  
> -	__tlb_switch_to_host()(kvm);
> +	__tlb_switch_to_host()(kvm, flags);
>  }
>  
>  void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
> +	unsigned long flags;
>  
>  	/* Switch to requested VMID */
> -	__tlb_switch_to_guest()(kvm);
> +	__tlb_switch_to_guest()(kvm, &flags);
>  
>  	__tlbi(vmalle1);
>  	dsb(nsh);
>  	isb();
>  
> -	__tlb_switch_to_host()(kvm);
> +	__tlb_switch_to_host()(kvm, flags);
>  }
>  
>  void __hyp_text __kvm_flush_vm_context(void)
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

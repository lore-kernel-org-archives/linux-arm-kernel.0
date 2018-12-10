Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:13:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23BB20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X3Fakg+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23BB20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i897gM25G58VrLlDDbvQ/mERMEtatml5QCJIJQ5CbkE=; b=X3Fakg+2b6tDXb
	4vg9zFM41CevQcyX0B5vmFwrcoqm/6DRPiA8Y6mTMmM01EdAI9cZgpcJyNPCK2jcPr7Tm176kfZqZ
	nZGGm9C3GGEbDAWpv0YpXIsD/nSeUnXeQ0MulurFTqyvhhuRk4NXyQctQR5YuV4BUTatdZIAZPRR6
	aSS6B0A4PpiQ1D3ISvuEmU5q16os6nZtNVQLFtey/5BjrCTCg1mVIWxuichqoGRVpVJwlGyQWUBlW
	vjOhP0+yHQIPvojvtbEM9Y+ppoEWXZa3P4Zj326+XNVASmRbZC7qusdwuLIaGDYtr/rm0AHu/mkhk
	ybBkUfpq3LRM+awS4x1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIZ1-0005Q9-6g; Mon, 10 Dec 2018 10:13:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIYw-0005PD-Gb
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:13:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AC481596;
 Mon, 10 Dec 2018 02:13:07 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFBCC3F6A8;
 Mon, 10 Dec 2018 02:13:06 -0800 (PST)
Date: Mon, 10 Dec 2018 11:13:05 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 2/8] KVM: arm64: Rework detection of SVE, !VHE systems
Message-ID: <20181210101305.GH30263@e113682-lin.lund.arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
 <20181206173126.139877-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206173126.139877-3-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_021318_565643_9A10896D 
X-CRM114-Status: GOOD (  23.45  )
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

On Thu, Dec 06, 2018 at 05:31:20PM +0000, Marc Zyngier wrote:
> An SVE system is so far the only case where we mandate VHE. As we're
> starting to grow this requirements, let's slightly rework the way we
> deal with that situation, allowing for easy extension of this check.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   | 2 +-
>  arch/arm64/include/asm/kvm_host.h | 6 +++---
>  virt/kvm/arm/arm.c                | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 5ca5d9af0c26..2184d9ddb418 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -285,7 +285,7 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>  
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
> -static inline bool kvm_arch_check_sve_has_vhe(void) { return true; }
> +static inline bool kvm_arch_requires_vhe(void) { return false; }
>  static inline void kvm_arch_hardware_unsetup(void) {}
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 52fbc823ff8c..d6d9aa76a943 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -422,7 +422,7 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>  	}
>  }
>  
> -static inline bool kvm_arch_check_sve_has_vhe(void)
> +static inline bool kvm_arch_requires_vhe(void)
>  {
>  	/*
>  	 * The Arm architecture specifies that implementation of SVE
> @@ -430,9 +430,9 @@ static inline bool kvm_arch_check_sve_has_vhe(void)
>  	 * relies on this when SVE is present:
>  	 */
>  	if (system_supports_sve())
> -		return has_vhe();
> -	else
>  		return true;
> +
> +	return false;
>  }
>  
>  static inline void kvm_arch_hardware_unsetup(void) {}
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 23774970c9df..1db4c15edcdd 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1640,8 +1640,10 @@ int kvm_arch_init(void *opaque)
>  		return -ENODEV;
>  	}
>  
> -	if (!kvm_arch_check_sve_has_vhe()) {
> -		kvm_pr_unimpl("SVE system without VHE unsupported.  Broken cpu?");
> +	in_hyp_mode = is_kernel_in_hyp_mode();
> +
> +	if (!in_hyp_mode && kvm_arch_requires_vhe()) {
> +		kvm_pr_unimpl("CPU requiring VHE was booted in non-VHE mode");

nit: The error message feels weird to me (are we reporting CPU bugs?)
and I'm not sure about the unimpl and I think there's a linse space
missing.

How about:

	kvm_err("Cannot support this CPU in non-VHE mode, not initializing\n");

If we wanted to be super helpful, we could expand
kvm_arch_requires_vhe() with a print statement saying:
		
	kvm_err("SVE detected, requiring VHE mode\n");

But thay may be overkill.


>  		return -ENODEV;
>  	}
>  
> @@ -1657,8 +1659,6 @@ int kvm_arch_init(void *opaque)
>  	if (err)
>  		return err;
>  
> -	in_hyp_mode = is_kernel_in_hyp_mode();
> -
>  	if (!in_hyp_mode) {
>  		err = init_hyp_mode();
>  		if (err)
> -- 
> 2.19.2
> 

Otherwise:

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

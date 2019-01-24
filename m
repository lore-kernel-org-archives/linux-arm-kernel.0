Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93350C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6231C218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J1sVmhus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6231C218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=//YDU0wCrmWgtZzlpXGi1950K+0Jlxmls4uhVyp621M=; b=J1sVmhus0wTAbP
	aG8mGm73lcbpAuE+iyTXLz+EgH8MzQ+uZZJrdly1Eo+VGdRbheNDLrVEdNQo/qqrL40ACkdbJ/r+l
	atQFv2wWDa0eTIyT689ShonluLfLecGffwn05bX29065HaLJhkt0mEDX02H9N37RtSVajzN5pG0Uk
	UKzQ+J+WuzLxrFNcHAWiv4sHj6PY8ylnjJeTBu6mxufmMZ7c4f0760lae/sK1NMSzFCaG+RPLpaxa
	kNdncdvXgeqdRsCfm94Q19fnb2VTOtP5BRn8bM9eQrGUn3c9fzA7n50eet0BQG4cG6Dsj8VSQh3UH
	bSpDu10mYvAQryPtNp3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmkGN-0007Lz-Ci; Thu, 24 Jan 2019 19:02:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmkGK-0007LP-6H
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:02:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBAF0EBD;
 Thu, 24 Jan 2019 11:02:01 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9F53F237;
 Thu, 24 Jan 2019 11:01:59 -0800 (PST)
Subject: Re: [PATCH 06/14] KVM: arm/arm64: Factor out VMID into struct kvm_vmid
To: Christoffer Dall <christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-7-christoffer.dall@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <9ec36462-5a93-8246-85d3-a3c528959341@arm.com>
Date: Thu, 24 Jan 2019 19:01:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124140032.8588-7-christoffer.dall@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_110204_238597_271DE6B1 
X-CRM114-Status: GOOD (  26.50  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

(CC: +Suzuki)

On 24/01/2019 14:00, Christoffer Dall wrote:
> In preparation for nested virtualization where we are going to have more
> than a single VMID per VM, let's factor out the VMID data into a
> separate VMID data structure and change the VMID allocator to operate on
> this new structure instead of using a struct kvm.
> 
> This also means that udate_vttbr now becomes update_vmid, and that the
> vttbr itself is generated on the fly based on the stage 2 page table
> base address and the vmid.
> 
> We cache the physical address of the pgd when allocating the pgd to
> avoid doing the calculation on every entry to the guest and to avoid
> calling into potentially non-hyp-mapped code from hyp/EL2.
> 
> If we wanted to merge the VMID allocator with the arm64 ASID allocator
> at some point in the future, it should actually become easier to do that
> after this patch.

> Note that to avoid mapping the kvm_vmid_bits variable into hyp, we
> simply forego the masking of the vmid value in kvm_get_vttbr and rely on
> update_vmid to always assign a valid vmid value (within the supported
> range).


> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 8af4b1befa42..189d93461d33 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -596,5 +596,16 @@ static inline bool kvm_cpu_has_cnp(void)
>  	return system_supports_cnp();
>  }
>  
> +static __always_inline u64 kvm_get_vttbr(struct kvm *kvm)
> +{
> +	struct kvm_vmid *vmid = &kvm->arch.vmid;
> +	u64 vmid_field, baddr;
> +	u64 cnp = kvm_cpu_has_cnp() ? VTTBR_CNP_BIT : 0;
> +
> +	baddr = kvm->arch.pgd_phys;
> +	vmid_field = (u64)vmid->vmid << VTTBR_VMID_SHIFT;
> +	return kvm_phys_to_vttbr(baddr) | vmid_field | cnp;
> +}

(32bits version is the same ... but I guess there is nowhere to put it!)


> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 3dd240ea9e76..b77db673bb03 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -536,18 +529,12 @@ static void update_vttbr(struct kvm *kvm)
>  		kvm_call_hyp(__kvm_flush_vm_context);
>  	}
>  
> -	kvm->arch.vmid = kvm_next_vmid;
> +	vmid->vmid = kvm_next_vmid;
>  	kvm_next_vmid++;
> -	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
> -
> -	/* update vttbr to be used with the new vmid */
> -	pgd_phys = virt_to_phys(kvm->arch.pgd);

> -	BUG_ON(pgd_phys & ~kvm_vttbr_baddr_mask(kvm));

Where did this go? (escaped during a turbulent rebase?)

This removes the only caller of kvm_vttbr_baddr_mask()... It looks like this is
a safety check that the stage2-pgd is correctly aligned when the IPA size, and
thus size of the top level entry can by set by user-space.

... or is it unnecessary if alloc_pages_exact() can only return naturally
aligned groups of pages? (which I haven't checked)

Keeping it sounds like a good thing to have in case we accidentally merge
stage2/host-stage1 pgd's somewhere down the line.

(Suzuki suggested it would make more sense in kvm_alloc_stage2_pgd(), where we
could fail vm creation, instead of BUG()ing).

(this was added by e55cac5bf2a9c ("kvm: arm/arm64: Prepare for VM specific
stage2 translations"), the bulk of the logic is in 595583306434c ("kvm: arm64:
Dynamic configuration of VTTBR mask"))


> -	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
> -	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
> +	kvm_next_vmid &= (1 << kvm_get_vmid_bits()) - 1;
>  
>  	smp_wmb();
> -	WRITE_ONCE(kvm->arch.vmid_gen, atomic64_read(&kvm_vmid_gen));
> +	WRITE_ONCE(vmid->vmid_gen, atomic64_read(&kvm_vmid_gen));
>  
>  	spin_unlock(&kvm_vmid_lock);
>  }


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

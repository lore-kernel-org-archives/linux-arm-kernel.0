Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C02C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:05:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D85C2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q7bc+DkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D85C2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fj4eHF+XeOg1XsRQS3VMAQcctKNTzmvOTfpFESJjT3k=; b=Q7bc+DkOg+lPzj
	ieZ2w8ewlYkz4MtbMV/l6yC+YDoJ9Y6QyZBu31Q4x8d4P9w/FEUW3Vw5qD+cAfBoC0uGjO9Uex+if
	20tM09odMHKGLXVYJgaTMsCN11QIgjM4//QUtoF+LSGzBltH2DGWRnMRThZ/mY3pM5aQl8GPPQc1C
	HzvfTTpuZ2vUTwyZJZRIIOyyiGO+nGszOoIwBqaBOAB7mbeeyr/QvErxv5hurXTNfweWsZspgxBdJ
	3cTiZDUxDa+OuDu+qA9IxCheGyaBLDKIQ7G6atnGy0bRPj8PQnUQvAJTa+KLspFxaY6IMHrf/LnU1
	M8340M6LQniSMXYz/u4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzIS-00032G-V3; Fri, 25 Jan 2019 11:05:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzIP-00031f-4R
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:05:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33989EBD;
 Fri, 25 Jan 2019 03:05:07 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1903F5AF;
 Fri, 25 Jan 2019 03:05:06 -0800 (PST)
Subject: Re: [PATCH 06/14] KVM: arm/arm64: Factor out VMID into struct kvm_vmid
To: Christoffer Dall <christoffer.dall@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-7-christoffer.dall@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <b0606f1e-b39a-0ec9-b706-f60832acaced@arm.com>
Date: Fri, 25 Jan 2019 11:05:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124140032.8588-7-christoffer.dall@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_030513_186168_986B9CD8 
X-CRM114-Status: GOOD (  25.86  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Christoffer,

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
> 
> Note that to avoid mapping the kvm_vmid_bits variable into hyp, we
> simply forego the masking of the vmid value in kvm_get_vttbr and rely on
> update_vmid to always assign a valid vmid value (within the supported
> range).
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   | 13 ++++---
>  arch/arm/include/asm/kvm_mmu.h    | 11 ++++++
>  arch/arm/kvm/hyp/switch.c         |  2 +-
>  arch/arm/kvm/hyp/tlb.c            |  4 +--
>  arch/arm64/include/asm/kvm_host.h |  9 +++--
>  arch/arm64/include/asm/kvm_hyp.h  |  3 +-
>  arch/arm64/include/asm/kvm_mmu.h  | 11 ++++++
>  virt/kvm/arm/arm.c                | 57 +++++++++++--------------------
>  virt/kvm/arm/mmu.c                |  2 ++
>  9 files changed, 63 insertions(+), 49 deletions(-)
> 

[...]

> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 3a875fc1b63c..fadbd9ad3a90 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -426,6 +426,17 @@ static inline bool kvm_cpu_has_cnp(void)
>  	return false;
>  }
>  
> +static __always_inline u64 kvm_get_vttbr(struct kvm *kvm)
> +{
> +	struct kvm_vmid *vmid = &kvm->arch.vmid;
> +	u64 vmid_field, baddr;
> +	u64 cnp = kvm_cpu_has_cnp() ? VTTBR_CNP_BIT : 0;
> +

Nit:
As James pointed out, we're not merging this one with the 64-bit
version. The question is, since we don't merge it, can't we simplify
this one by removing the CNP related code from it? (we know CNP is
always false for 32-bit ARM).

> +	baddr = kvm->arch.pgd_phys;
> +	vmid_field = (u64)vmid->vmid << VTTBR_VMID_SHIFT;
> +	return kvm_phys_to_vttbr(baddr) | vmid_field | cnp;
> +}
> +
>  #endif	/* !__ASSEMBLY__ */

Otherwise, things look good to me:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

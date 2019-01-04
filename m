Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:30:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA8E218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mr59GL/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA8E218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6VHU4k40EWf9+SQ5fiVyVC6qoqHhoaBJ1obI2PC2MKk=; b=Mr59GL/bACK40h
	RuZYOt/YvVIpld5jSvUKe0WjYWz9hGeyVh6DTqqIiQ+am488ywkoK0e0s1dIDsmYdUP1tRQ3ynO8N
	88mEd90yqvwSBeMIgxIigy6xmGJTm5l1AX8nsqTYd8GpQueaEWycVDNOXsZ+SCZdYvP+ybDTgUh3j
	agEKNZR6bgLgw0vC+dmzbN6vFGMhxjQPrf/FJj7qDbXSCxektdIRn4Tc+ly33cMYxC8QswGpYj8TI
	5KBHrVlgkGyOk4PcX1ByCnnmErmHzjId1VUYNmKkctG8ESg3VrlQFPFCpdadh9akBnsffIwdXbC9x
	EsJfbXzshsOVdP77OsEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfSMp-00074j-Vq; Fri, 04 Jan 2019 16:30:39 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfSMn-00074J-5a
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 16:30:38 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jan 2019 08:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; d="scan'208";a="124112789"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.154])
 by orsmga001.jf.intel.com with ESMTP; 04 Jan 2019 08:30:35 -0800
Date: Fri, 4 Jan 2019 08:30:35 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: lantianyu1986@gmail.com
Subject: Re: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
Message-ID: <20190104163035.GC11288@linux.intel.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_083037_255639_6008A9FA 
X-CRM114-Status: GOOD (  19.32  )
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
Cc: , kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, benh@kernel.crashing.org,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 04:54:00PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> This patch is to flush tlb via flush list function.

More explanation of why this is beneficial would be nice.  Without the
context of the overall series it's not immediately obvious what
kvm_flush_remote_tlbs_with_list() does without a bit of digging.

> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> index 833e8855bbc9..866ccdea762e 100644
> --- a/arch/x86/kvm/paging_tmpl.h
> +++ b/arch/x86/kvm/paging_tmpl.h
> @@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  	bool host_writable;
>  	gpa_t first_pte_gpa;
>  	int set_spte_ret = 0;
> +	LIST_HEAD(flush_list);
>  
>  	/* direct kvm_mmu_page can not be unsync. */
>  	BUG_ON(sp->role.direct);
> @@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
>  
>  	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
> +		int tmp_spte_ret = 0;
>  		unsigned pte_access;
>  		pt_element_t gpte;
>  		gpa_t pte_gpa;
> @@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  
>  		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
>  
> -		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
> +		tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
>  					 pte_access, PT_PAGE_TABLE_LEVEL,
>  					 gfn, spte_to_pfn(sp->spt[i]),
>  					 true, false, host_writable);
> +
> +		if (kvm_available_flush_tlb_with_range()
> +		    && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
> +			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
> +					& PT64_BASE_ADDR_MASK);
> +			list_add(&leaf_sp->flush_link, &flush_list);
> +		}
> +
> +		set_spte_ret |= tmp_spte_ret;
> +
>  	}
>  
>  	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
> -		kvm_flush_remote_tlbs(vcpu->kvm);
> +		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);

This is a bit confusing and potentially fragile.  It's not obvious that
kvm_flush_remote_tlbs_with_list() is guaranteed to call
kvm_flush_remote_tlbs() when kvm_available_flush_tlb_with_range() is
false, and you're relying on the kvm_flush_remote_tlbs_with_list() call
chain to never optimize away the empty list case.  Rechecking
kvm_available_flush_tlb_with_range() isn't expensive.

>  
>  	return nr_present;
>  }
> -- 
> 2.14.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

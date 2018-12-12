Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E084BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:38:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C2120873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="niIHd1KI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C2120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IIhoUooKVPxUz8KnD1abnERb/JeD6tZdUqty4cNj2KY=; b=niIHd1KIIiei1OmbmATzJYTng
	dbkpREBD0rghAm7J5MVb2LhJWWdtxctnZ/WtlTJzZ5evBTMfcwVhqo2DZFI5ljHf+ra0BazR39eDj
	3lWZm8IU3LbxdPeYcP1zfUw3s0JoQyZnEIfwEQ9N8pk1tw+WmJim29mqpLsnYI4tpJy9jMvC7uO6Y
	mj3SFI+6DqxT+2drlzcjVgVl2/bvTCiC6UmP4synlUS36FIvK1czHWznAzNu4SH0GazDzEtLYQFyP
	YQKuvV1QoJOQqKm+QrtM2H1m3X/xA1XcmCS4MiyuryJe1fG346vlCdAkB/JFGl0inp2hu7dOwn67F
	urjGGS8/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1u8-0002Uo-LA; Wed, 12 Dec 2018 10:38:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1u3-0002TL-M0
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:38:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 549F0A78;
 Wed, 12 Dec 2018 02:37:57 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EEF63F575;
 Wed, 12 Dec 2018 02:37:55 -0800 (PST)
Subject: Re: [PATCH v8 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-3-git-send-email-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c31a1e2b-511a-4441-1fb2-8bf32691656f@arm.com>
Date: Wed, 12 Dec 2018 10:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544610573-28446-3-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_023807_729425_35BDBAAB 
X-CRM114-Status: GOOD (  19.37  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Julien Thierry <julien.thierry@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On 12/12/2018 10:29, Andrew Murray wrote:
> The virt/arm core allocates a kvm_cpu_context_t percpu, at present this is
> a typedef to kvm_cpu_context and is used to store host cpu context. The
> kvm_cpu_context structure is also used elsewhere to hold vcpu context.
> In order to use the percpu to hold additional future host information we
> encapsulate kvm_cpu_context in a new structure and rename the typedef and
> percpu to match.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm/include/asm/kvm_host.h   |  8 ++++++--
>   arch/arm64/include/asm/kvm_asm.h  |  4 ++--
>   arch/arm64/include/asm/kvm_host.h | 15 ++++++++++-----
>   arch/arm64/kernel/asm-offsets.c   |  2 +-
>   virt/kvm/arm/arm.c                | 10 ++++++----
>   5 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 79906ce..71645ba 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -145,7 +145,11 @@ struct kvm_cpu_context {
>   	u32 cp15[NR_CP15_REGS];
>   };
>   
> -typedef struct kvm_cpu_context kvm_cpu_context_t;
> +struct kvm_host_data {
> +	struct kvm_cpu_context host_ctxt;
> +};
> +
> +typedef struct kvm_host_data kvm_host_data_t;
>   
>   struct kvm_vcpu_arch {
>   	struct kvm_cpu_context ctxt;
> @@ -163,7 +167,7 @@ struct kvm_vcpu_arch {
>   	struct kvm_vcpu_fault_info fault;
>   
>   	/* Host FP context */
> -	kvm_cpu_context_t *host_cpu_context;
> +	struct kvm_cpu_context *host_cpu_context;
>   
>   	/* VGIC state */
>   	struct vgic_cpu vgic_cpu;
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 102b5a5..6a9bfd4 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -102,12 +102,12 @@ extern u32 __init_stage2_translation(void);
>   .endm
>   
>   .macro get_host_ctxt reg, tmp
> -	hyp_adr_this_cpu \reg, kvm_host_cpu_state, \tmp
> +	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
>   .endm
>   
>   .macro get_vcpu_ptr vcpu, ctxt
>   	get_host_ctxt \ctxt, \vcpu
> -	ldr	\vcpu, [\ctxt, #HOST_CONTEXT_VCPU]
> +	ldr	\vcpu, [\ctxt, #HOST_DATA_VCPU]
>   	kern_hyp_va	\vcpu
>   .endm
>   
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1550192..1d3ca91 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -205,7 +205,12 @@ struct kvm_cpu_context {
>   	struct kvm_vcpu *__hyp_running_vcpu;
>   };
>   
> -typedef struct kvm_cpu_context kvm_cpu_context_t;
> +struct kvm_host_data {
> +	struct kvm_cpu_context host_ctxt;
> +	struct kvm_pmu_events pmu_events;
> +};
> +

Unfortunately this would fail to build as we don't have the kvm_pmu_events
defined in this patch and will break the git bisects.

Otherwise looks good to me.


Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

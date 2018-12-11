Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6E0C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:41:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528452084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQY28mmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528452084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=py+mRoy/Sl0ZKkV74ElP2KKU6mlmPOHZMSdGhI3NDbM=; b=NQY28mmXFrwhWYqke95vS0eCN
	AtV0qCdLxWVM1WocExdr1K4xCxEqHJJySXtB3Q2iHsoQwan5dKfia/hnLdmrQ3Ug0a60k3Yw/Gny8
	soHX9Cxt70dFNGurDFKNqCK2ktzhpksBEkbZncganFz6gRC1zKncwWT7OzBFgWhXMzxJhC1zUGig+
	xXgt8elgbh9nWnKAfxeBg5Jx5evmh2pplRB6ZAezFVGnodVtQJlt9iFvqd7luKCR3THB2qoS8KNdr
	2uh/y4uATFPSeCY5zcnEIB41AyQO/hwbQxGwHoDWsktQY8Bi9mE+CQZnqj+k3kGF9DkfED/Xd8J3+
	Xb6b+ww4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhLa-0007IF-U1; Tue, 11 Dec 2018 12:41:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhLX-0007Hg-Tl
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:41:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B28EBD;
 Tue, 11 Dec 2018 04:40:55 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0EB63F6A8;
 Tue, 11 Dec 2018 04:40:52 -0800 (PST)
Subject: Re: [PATCH v7 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1544530420-1477-1-git-send-email-andrew.murray@arm.com>
 <1544530420-1477-3-git-send-email-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <525c5c2f-5d09-6e36-8802-457791f93ac5@arm.com>
Date: Tue, 11 Dec 2018 12:40:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544530420-1477-3-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_044107_967490_0D0E108F 
X-CRM114-Status: GOOD (  18.88  )
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



On 11/12/2018 12:13, Andrew Murray wrote:
> The virt/arm core allocates a percpu structure as per the kvm_cpu_context_t
> type, at present this is typedef'd to kvm_cpu_context and used to store
> host cpu context. The kvm_cpu_context structure is also used elsewhere to
> hold vcpu context. In order to use the percpu to hold additional future
> host information we encapsulate kvm_cpu_context in a new structure.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm64/include/asm/kvm_host.h | 8 ++++++--
>   arch/arm64/kernel/asm-offsets.c   | 3 ++-
>   virt/kvm/arm/arm.c                | 4 +++-
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1550192..bcf9d60 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -205,7 +205,11 @@ struct kvm_cpu_context {
>   	struct kvm_vcpu *__hyp_running_vcpu;
>   };
>   
> -typedef struct kvm_cpu_context kvm_cpu_context_t;
> +struct kvm_host_data {
> +	struct kvm_cpu_context __kvm_cpu_state;
> +};
> +
> +typedef struct kvm_host_data kvm_cpu_context_t;
>   
>   struct kvm_vcpu_arch {
>   	struct kvm_cpu_context ctxt;
> @@ -241,7 +245,7 @@ struct kvm_vcpu_arch {
>   	struct kvm_guest_debug_arch external_debug_state;
>   
>   	/* Pointer to host CPU context */
> -	kvm_cpu_context_t *host_cpu_context;
> +	struct kvm_cpu_context *host_cpu_context;
>   
>   	struct thread_info *host_thread_info;	/* hyp VA */
>   	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 323aeb5..da34022 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -142,7 +142,8 @@ int main(void)
>     DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
>     DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
>     DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
> -  DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
> +  DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu)
> +				+ offsetof(struct kvm_host_data, __kvm_cpu_state));

nit: You could fold the member field in the offsetof(). i.e,
      DEFINE(HOST_CONTEXT_VCPU, offsetof(struct kvm_host_data, 
__kvm_cpu_state.__hyp_running_vcpu)

like the VCPU_HOST_CONTEXT above ?

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

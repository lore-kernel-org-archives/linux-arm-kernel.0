Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOX5RmBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnuE3+euEh/edKCw2WuUqDK6kduWQAEvFq5ixdFFcF4=; b=qOX5RmBm2ouME+
	XG+Huc4StHWNpsvXVhb9tmmAZs3ObAXUMt8z0vAu5qob0lJMRuk6BVpOCCSY/AnvuJZWIMIIGGc3E
	B/pYeRN6SsXw30cnAQCOCLYneRmT7JQWN8mcERRe3gkwQnIxTKTScR77/fIVfSMrNBu1OYj192JD0
	LbRBvOthqckcbjbsB5oJSaYzLWpuNbYBALQ+gnDYkDFjQRvt4BvYjuGL6s6JEWwCHektiNCi57HMV
	wYhE2kBMUtZrczGI38k/iLAbY8jhMhue7i++3kpgTZp2O2XR1sLL5vU6sJarIODzxX5FKJ3knSNHM
	QXuFpNwb7OfuxP4IjY3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwn7b-0005SK-Gi; Thu, 21 Feb 2019 12:06:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwn7Y-0005Rk-Ug
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:06:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8661480D;
 Thu, 21 Feb 2019 04:06:30 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914373F5C1;
 Thu, 21 Feb 2019 04:06:26 -0800 (PST)
Subject: Re: [PATCH v5 17/26] KVM: arm64: Reject ioctl access to FPSIMD V-regs
 on SVE vcpus
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-18-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <696ae744-c016-9cc2-d393-fd321d341df4@arm.com>
Date: Thu, 21 Feb 2019 12:06:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-18-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_040633_001394_AF85FEF7 
X-CRM114-Status: GOOD (  22.51  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/02/2019 19:52, Dave Martin wrote:
> In order to avoid the pointless complexity of maintaining two ioctl
> register access views of the same data, this patch blocks ioctl
> access to the FPSIMD V-registers on vcpus that support SVE.
> 
> This will make it more straightforward to add SVE register access
> support.
> 
> Since SVE is an opt-in feature for userspace, this will not affect
> existing users.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> ---
>  arch/arm64/kvm/guest.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index f83fe22..f491456 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -95,7 +95,14 @@ static int core_reg_size_from_offset(u64 off)
>  	return -EINVAL;
>  }
>  
> -static int validate_core_offset(const struct kvm_one_reg *reg)
> +static bool core_reg_offset_is_vreg(u64 off)
> +{
> +	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
> +		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
> +}
> +
> +static int validate_core_offset(const struct kvm_vcpu *vcpu,
> +				const struct kvm_one_reg *reg)
>  {
>  	u64 off = core_reg_offset_from_id(reg->id);
>  	int size = core_reg_size_from_offset(off);
> @@ -103,10 +110,18 @@ static int validate_core_offset(const struct kvm_one_reg *reg)
>  	if (size < 0)
>  		return -EINVAL;
>  
> -	if (KVM_REG_SIZE(reg->id) == size)
> -		return 0;
> +	if (KVM_REG_SIZE(reg->id) != size)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	/*
> +	 * The KVM_REG_ARM64_SVE regs must be used instead of
> +	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
> +	 * SVE-enabled vcpus:
> +	 */
> +	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
> +		return -EINVAL;
> +
> +	return 0;
>  }
>  
>  static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> @@ -128,7 +143,7 @@ static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
>  		return -ENOENT;
>  
> -	if (validate_core_offset(reg))
> +	if (validate_core_offset(vcpu, reg))
>  		return -EINVAL;
>  
>  	if (copy_to_user(uaddr, ((u32 *)regs) + off, KVM_REG_SIZE(reg->id)))
> @@ -153,7 +168,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
>  		return -ENOENT;
>  
> -	if (validate_core_offset(reg))
> +	if (validate_core_offset(vcpu, reg))
>  		return -EINVAL;
>  
>  	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
> @@ -206,7 +221,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	return -EINVAL;
>  }
>  
> -static int copy_core_reg_indices(u64 __user **uind)
> +static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
> +				 u64 __user **uind)
>  {
>  	unsigned int i;
>  	int n = 0;
> @@ -248,9 +264,9 @@ static int copy_core_reg_indices(u64 __user **uind)
>  	return n;
>  }
>  
> -static unsigned long num_core_regs(void)
> +static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
>  {
> -	return copy_core_reg_indices(NULL);
> +	return copy_core_reg_indices(vcpu, NULL);
>  }
>  
>  /**
> @@ -315,7 +331,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long res = 0;
>  
> -	res += num_core_regs();
> +	res += num_core_regs(vcpu);
>  	res += kvm_arm_num_sys_reg_descs(vcpu);
>  	res += kvm_arm_get_fw_num_regs(vcpu);
>  	res += NUM_TIMER_REGS;
> @@ -332,7 +348,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>  {
>  	int ret;
>  
> -	ret = copy_core_reg_indices(&uindices);
> +	ret = copy_core_reg_indices(vcpu, &uindices);
>  	if (ret < 0)
>  		return ret;
>  
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

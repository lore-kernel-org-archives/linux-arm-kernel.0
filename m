Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF05C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:33:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6162183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YY9gjmJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6162183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YSArjAhcBNt7bmWJGPqsKxxjgSU2rHnUluJ98b15Ubg=; b=YY9gjmJjrwk7id
	tFYJ6ZysddCa0NAVj8GrFChmzwplm1zlDqYEjyH3cwxg4BH9uAww0BxEFyazE+Le4Fr1+0MbN00My
	PJBJ1qy611ooITpRhv9cp5eYls6UAjApKeYRLB4aVg3F1z587h1xfnpnxWxU07+EI9rPpYTRYgwvF
	HS2ADDb9lVen0aye7q7CycYqZZHpZO/VYiX62milMIUt8EZtCsieF6N4FG8JmQuq85uijHSJgzKsG
	X4OWMZN9LncXTmIjCe+UcG9fZ1UnhWJbw5ZnH5XB7WUeRsSW6tz1VWALoH0jfN/qIQYgenoXqd0v0
	Em2fIihRpLhKwSwwEvLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSwe-0001VL-Ot; Wed, 20 Feb 2019 14:33:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSwb-0001Uy-74
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:33:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527CDEBD;
 Wed, 20 Feb 2019 06:33:51 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F96F3F690;
 Wed, 20 Feb 2019 06:33:46 -0800 (PST)
Subject: Re: [PATCH v5 12/26] KVM: arm64: Support runtime sysreg visibility
 filtering
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-13-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <2819c91f-3a28-b878-0ea1-d20afcf05895@arm.com>
Date: Wed, 20 Feb 2019 14:33:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-13-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_063353_271895_43DD16FE 
X-CRM114-Status: GOOD (  29.50  )
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
> Some optional features of the Arm architecture add new system
> registers that are not present in the base architecture.
> 
> Where these features are optional for the guest, the visibility of
> these registers may need to depend on some runtime configuration,
> such as a flag passed to KVM_ARM_VCPU_INIT.
> 
> For example, ZCR_EL1 and ID_AA64ZFR0_EL1 need to be hidden if SVE
> is not enabled for the guest, even though these registers may be
> present in the hardware and visible to the host at EL2.
> 
> Adding special-case checks all over the place for individual
> registers is going to get messy as the number of conditionally-
> visible registers grows.
> 
> In order to help solve this problem, this patch adds a new sysreg
> method restrictions() that can be used to hook in any needed
> runtime visibility checks.  This method can currently return
> REG_NO_USER to inhibit enumeration and ioctl access to the register
> for userspace, and REG_NO_GUEST to inhibit runtime access by the
> guest using MSR/MRS.
> 
> This allows a conditionally modified view of individual system
> registers such as the CPU ID registers, in addition to completely
> hiding register where appropriate.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> 
> ---
> 
> Changes since v4:
> 
>  * Move from a boolean sysreg property that just suppresses register
>    enumeration via KVM_GET_REG_LIST, to a multi-flag property that
>    allows independent runtime control of MRS/MSR and user ioctl access.
> 
>    This allows registers to be either hidden completely, or to have
>    hybrid behaviours (such as the not-enumerated, RAZ, WAZ behaviour of
>    "non-present" CPU ID regs).
> ---
>  arch/arm64/kvm/sys_regs.c | 24 +++++++++++++++++++++---
>  arch/arm64/kvm/sys_regs.h | 13 +++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 71c5825..3f1243e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1863,6 +1863,12 @@ static void perform_access(struct kvm_vcpu *vcpu,
>  {
>  	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
>  
> +	/* Check for regs disabled by runtime config */
> +	if (restrictions(vcpu, r) & REG_NO_GUEST) {
> +		kvm_inject_undefined(vcpu);
> +		return;
> +	}
> +
>  	/*
>  	 * Not having an accessor means that we have configured a trap
>  	 * that we don't know how to handle. This certainly qualifies
> @@ -2370,6 +2376,10 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
>  	if (!r)
>  		return get_invariant_sys_reg(reg->id, uaddr);
>  
> +	/* Check for regs disabled by runtime config */
> +	if (restrictions(vcpu, r) & REG_NO_USER)
> +		return -ENOENT;
> +
>  	if (r->get_user)
>  		return (r->get_user)(vcpu, r, reg, uaddr);
>  
> @@ -2391,6 +2401,10 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
>  	if (!r)
>  		return set_invariant_sys_reg(reg->id, uaddr);
>  
> +	/* Check for regs disabled by runtime config */
> +	if (restrictions(vcpu, r) & REG_NO_USER)
> +		return -ENOENT;
> +
>  	if (r->set_user)
>  		return (r->set_user)(vcpu, r, reg, uaddr);
>  
> @@ -2447,7 +2461,8 @@ static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
>  	return true;
>  }
>  
> -static int walk_one_sys_reg(const struct sys_reg_desc *rd,
> +static int walk_one_sys_reg(const struct kvm_vcpu *vcpu,
> +			    const struct sys_reg_desc *rd,
>  			    u64 __user **uind,
>  			    unsigned int *total)
>  {
> @@ -2458,6 +2473,9 @@ static int walk_one_sys_reg(const struct sys_reg_desc *rd,
>  	if (!(rd->reg || rd->get_user))
>  		return 0;
>  
> +	if (restrictions(vcpu, rd) & REG_NO_USER)
> +		return 0;
> +
>  	if (!copy_reg_to_user(rd, uind))
>  		return -EFAULT;
>  
> @@ -2486,9 +2504,9 @@ static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
>  		int cmp = cmp_sys_reg(i1, i2);
>  		/* target-specific overrides generic entry. */
>  		if (cmp <= 0)
> -			err = walk_one_sys_reg(i1, &uind, &total);
> +			err = walk_one_sys_reg(vcpu, i1, &uind, &total);
>  		else
> -			err = walk_one_sys_reg(i2, &uind, &total);
> +			err = walk_one_sys_reg(vcpu, i2, &uind, &total);
>  
>  		if (err)
>  			return err;
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index 174ffc0..12f196f 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -69,8 +69,15 @@ struct sys_reg_desc {
>  			const struct kvm_one_reg *reg, void __user *uaddr);
>  	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  			const struct kvm_one_reg *reg, void __user *uaddr);
> +
> +	/* Return mask of REG_* runtime restriction flags */
> +	unsigned int (*restrictions)(const struct kvm_vcpu *vcpu,
> +				     const struct sys_reg_desc *rd);
>  };
>  
> +#define REG_NO_USER	(1 << 0) /* hidden from userspace ioctl interface */
> +#define REG_NO_GUEST	(1 << 1) /* hidden from guest */
> +
>  static inline void print_sys_reg_instr(const struct sys_reg_params *p)
>  {
>  	/* Look, we even formatted it for you to paste into the table! */
> @@ -109,6 +116,12 @@ static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r
>  	__vcpu_sys_reg(vcpu, r->reg) = r->val;
>  }
>  
> +static inline unsigned int restrictions(const struct kvm_vcpu *vcpu,
> +					const struct sys_reg_desc *r)
> +{
> +	return unlikely(r->restrictions) ? r->restrictions(vcpu, r) : 0;
> +}
> +
>  static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
>  			      const struct sys_reg_desc *i2)
>  {
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

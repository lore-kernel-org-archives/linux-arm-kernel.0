Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A93EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156472184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WAoi+7GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156472184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/nQ5tS/BPYzVZaredljQRr54ht0vaAJUyeai8cPwn9U=; b=WAoi+7GUrZL69WvSikFb4T95n
	yJ0gUH/q/SAenv1oqP7CWh5ImQMy4IHulHOe0xJC/zqUHLtIYoGfRuZdrZ6xPDw70WU0UjMj2HZJ9
	2XoP6Uoq9vctowQ2Zw3P334YcDurbfSaJj+HE2xpwsRNtphEW1uLdGXSFn8tY9mCVjIJ1vH/xRqMB
	uioosy308MmyHoywrD+wY/M3b9+eXr4mWebj8buoQu9EDX1cyyYlLLfVvktfDyDtl+YJL7As0rT8s
	sZ4jmJEQFm02qGsQd4Uqz8WwNiSpd28NY2KLsbBr1upxr3vMKJXtHwslH6+ycl08ZzVkCt5P7D/uk
	fXmH3fiaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfen-0005lT-RZ; Tue, 26 Feb 2019 16:32:37 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfek-0005kw-K0
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:32:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 135BD80D;
 Tue, 26 Feb 2019 08:32:34 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D212D3F738;
 Tue, 26 Feb 2019 08:32:31 -0800 (PST)
Subject: Re: [PATCH v5 13/26] KVM: arm64/sve: System register context switch
 and access support
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-14-git-send-email-Dave.Martin@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <8a0e6089-b77b-151b-eacd-34ad13f39ac6@arm.com>
Date: Tue, 26 Feb 2019 16:32:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-14-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_083234_664725_500CE2F1 
X-CRM114-Status: GOOD (  17.78  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 18/02/2019 19:52, Dave Martin wrote:
> @@ -1091,6 +1088,95 @@ static int reg_from_user(u64 *val, const void __user *uaddr, u64 id);
>   static int reg_to_user(void __user *uaddr, const u64 *val, u64 id);
>   static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
>   
> +static unsigned int sve_restrictions(const struct kvm_vcpu *vcpu,
> +				     const struct sys_reg_desc *rd)
> +{
> +	return vcpu_has_sve(vcpu) ? 0 : REG_NO_USER | REG_NO_GUEST;
> +}
> +
> +static unsigned int sve_id_restrictions(const struct kvm_vcpu *vcpu,
> +					const struct sys_reg_desc *rd)
> +{
> +	return vcpu_has_sve(vcpu) ? 0 : REG_NO_USER;
> +}
> +
> +static int get_zcr_el1(struct kvm_vcpu *vcpu,
> +		       const struct sys_reg_desc *rd,
> +		       const struct kvm_one_reg *reg, void __user *uaddr)
> +{
> +	if (WARN_ON(!vcpu_has_sve(vcpu)))
> +		return -ENOENT;
> +
> +	return reg_to_user(uaddr, &vcpu->arch.ctxt.sys_regs[ZCR_EL1],
> +			   reg->id);
> +}
> +
> +static int set_zcr_el1(struct kvm_vcpu *vcpu,
> +		       const struct sys_reg_desc *rd,
> +		       const struct kvm_one_reg *reg, void __user *uaddr)
> +{
> +	if (WARN_ON(!vcpu_has_sve(vcpu)))
> +		return -ENOENT;
> +
> +	return reg_from_user(&vcpu->arch.ctxt.sys_regs[ZCR_EL1], uaddr,
> +			     reg->id);
> +}
> +
> +/* Generate the emulated ID_AA64ZFR0_EL1 value exposed to the guest */
> +static u64 guest_id_aa64zfr0_el1(const struct kvm_vcpu *vcpu)
> +{
> +	if (!vcpu_has_sve(vcpu))
> +		return 0;
> +
> +	return read_sanitised_ftr_reg(SYS_ID_AA64ZFR0_EL1);
> +}
> +
> +static bool access_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
> +				   struct sys_reg_params *p,
> +				   const struct sys_reg_desc *rd)
> +{
> +	if (p->is_write)
> +		return write_to_read_only(vcpu, p, rd);
> +
> +	p->regval = guest_id_aa64zfr0_el1(vcpu);
> +	return true;
> +}
> +
> +static int get_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
> +		const struct sys_reg_desc *rd,
> +		const struct kvm_one_reg *reg, void __user *uaddr)
> +{
> +	u64 val;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		return -ENOENT;
> +
> +	val = guest_id_aa64zfr0_el1(vcpu);
> +	return reg_to_user(uaddr, &val, reg->id);
> +}
> +
> +static int set_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
> +		const struct sys_reg_desc *rd,
> +		const struct kvm_one_reg *reg, void __user *uaddr)
> +{
> +	const u64 id = sys_reg_to_index(rd);
> +	int err;
> +	u64 val;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		return -ENOENT;
> +
> +	err = reg_from_user(&val, uaddr, id);
> +	if (err)
> +		return err;
> +
> +	/* This is what we mean by invariant: you can't change it. */
> +	if (val != guest_id_aa64zfr0_el1(vcpu))
> +		return -EINVAL;
> +
> +	return 0;
> +}

We seem to already have code for handling invariant registers as well as reading 
ID register. I guess the only reason you can't use them is because of the check 
the vcpu is using SVE.

However, AFAICT the restrictions callback would prevent you to enter the {get, 
set}_id if the vCPU does not support SVE. So the check should not be reachable.

Did I miss anything?

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

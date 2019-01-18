Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80042C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:42:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491CB20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sSDB0cml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491CB20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f1uoUlaEG8N/LfU98SpxUZ2C3Uvu/2pogGCoFRyr28o=; b=sSDB0cmlf+bJQa
	UGdgVcLIt1ww1lhjWHU0TxUTAu4zWPLoOpcUbuVRIMFUb3KKdS9KfBj3PkU6+kQPeJN+G7f/I6gi5
	hJlYWU1fVU3OANK302hnzd8fS0fc2GASk6yPmgtNJAxnGChQ6/0H0O7UpAzSYGNlJtBOYGQflNwax
	/UWBE//IMTWRbZXoLriN2y4EMWpliws/y+386rhbg4MWBy8TF+H1uphfflE7omJxl+IQfcvi5UNaE
	G6h/3R/4ULPHloUkEnCK4CXVPpomAMt5fXoGx8JtWhHGEkG5DGnrprKLbQE8R1Dt21KheCGNc3t35
	b0Ii2rODubKkj3e4mGkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXDk-00053I-9o; Fri, 18 Jan 2019 16:42:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXDg-00052o-2D
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:42:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6F880D;
 Fri, 18 Jan 2019 08:42:10 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 A1FB43F7BE; Fri, 18 Jan 2019 08:42:08 -0800 (PST)
Subject: Re: [PATCH v4 13/25] KVM: arm64/sve: System register context switch
 and access support
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
 <1547757219-19439-14-git-send-email-Dave.Martin@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <3d6da606-d7ae-5232-8317-4c550370b469@arm.com>
Date: Fri, 18 Jan 2019 16:42:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547757219-19439-14-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084212_117976_3F350DB3 
X-CRM114-Status: GOOD (  37.08  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/01/2019 20:33, Dave Martin wrote:
> This patch adds the necessary support for context switching ZCR_EL1
> for each vcpu.
> 
> ZCR_EL1 is trapped alongside the FPSIMD/SVE registers, so it makes
> sense for it to be handled as part of the guest FPSIMD/SVE context
> for context switch purposes instead of handling it as a general
> system register.  This means that it can be switched in lazily at
> the appropriate time.  No effort is made to track host context for
> this register, since SVE requires VHE: thus the hosts's value for
> this register lives permanently in ZCR_EL2 and does not alias the
> guest's value at any time.
> 
> The Hyp switch and fpsimd context handling code is extended
> appropriately.
> 
> Accessors are added in sys_regs.c to expose the SVE system
> registers and ID register fields.  Because these need to be
> conditionally visible based on the guest configuration, they are
> implemented separately for now rather than by use of the generic
> system register helpers.  This may be abstracted better later on
> when/if there are more features requiring this model.
> 
> ID_AA64ZFR0_EL1 is RO-RAZ for MRS/MSR when SVE is disabled for the
> guest, but for compatibility with non-SVE aware KVM implementations
> the register should not be enumerated at all for KVM_GET_REG_LIST
> in this case.  For consistency we also reject ioctl access to the
> register.  This ensures that a non-SVE-enabled guest looks the same
> to userspace, irrespective of whether the kernel KVM implementation
> supports SVE.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |   1 +
>  arch/arm64/include/asm/sysreg.h   |   3 ++
>  arch/arm64/kvm/fpsimd.c           |   8 ++-
>  arch/arm64/kvm/hyp/switch.c       |   3 ++
>  arch/arm64/kvm/sys_regs.c         | 111 ++++++++++++++++++++++++++++++++++++--
>  5 files changed, 121 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index af625a8..c32f195 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -112,6 +112,7 @@ enum vcpu_sysreg {
>  	SCTLR_EL1,	/* System Control Register */
>  	ACTLR_EL1,	/* Auxiliary Control Register */
>  	CPACR_EL1,	/* Coprocessor Access Control */
> +	ZCR_EL1,	/* SVE Control */
>  	TTBR0_EL1,	/* Translation Table Base Register 0 */
>  	TTBR1_EL1,	/* Translation Table Base Register 1 */
>  	TCR_EL1,	/* Translation Control Register */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 72dc4c0..da38491 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -449,6 +449,9 @@
>  #define SYS_ICH_LR14_EL2		__SYS__LR8_EL2(6)
>  #define SYS_ICH_LR15_EL2		__SYS__LR8_EL2(7)
>  
> +/* VHE encodings for architectural EL0/1 system registers */
> +#define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
> +
>  /* Common SCTLR_ELx flags. */
>  #define SCTLR_ELx_DSSBS	(_BITUL(44))
>  #define SCTLR_ELx_ENIA	(_BITUL(31))
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 1cf4f02..5ff2d90 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -103,6 +103,8 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
>  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long flags;
> +	bool host_has_sve = system_supports_sve();
> +	bool guest_has_sve = vcpu_has_sve(vcpu);
>  
>  	local_irq_save(flags);
>  
> @@ -110,7 +112,11 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>  		/* Clean guest FP state to memory and invalidate cpu view */
>  		fpsimd_save();
>  		fpsimd_flush_cpu_state();
> -	} else if (system_supports_sve()) {
> +
> +		if (guest_has_sve)
> +			vcpu->arch.ctxt.sys_regs[ZCR_EL1] =
> +				read_sysreg_s(SYS_ZCR_EL12);

nit: Please keep assignments on a single line.

> +	} else if (host_has_sve) {
>  		/*
>  		 * The FPSIMD/SVE state in the CPU has not been touched, and we
>  		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index b0b1478..9f07403 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -347,6 +347,9 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
>  
>  	__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
>  
> +	if (vcpu_has_sve(vcpu))
> +		write_sysreg_s(vcpu->arch.ctxt.sys_regs[ZCR_EL1], SYS_ZCR_EL12);
> +
>  	/* Skip restoring fpexc32 for AArch64 guests */
>  	if (!(read_sysreg(hcr_el2) & HCR_RW))
>  		write_sysreg(vcpu->arch.ctxt.sys_regs[FPEXC32_EL2],
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index bca32d5..c8df730 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1036,10 +1036,7 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
>  	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
>  
> -	if (id == SYS_ID_AA64PFR0_EL1) {
> -		if (val & (0xfUL << ID_AA64PFR0_SVE_SHIFT))
> -			kvm_debug("SVE unsupported for guests, suppressing\n");
> -
> +	if (id == SYS_ID_AA64PFR0_EL1 && !vcpu_has_sve(vcpu)) {
>  		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>  	} else if (id == SYS_ID_AA64ISAR1_EL1) {
>  		const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> @@ -1091,6 +1088,105 @@ static int reg_from_user(u64 *val, const void __user *uaddr, u64 id);
>  static int reg_to_user(void __user *uaddr, const u64 *val, u64 id);
>  static u64 sys_reg_to_index(const struct sys_reg_desc *reg);
>  
> +#ifdef CONFIG_ARM64_SVE
> +static bool sve_check_present(const struct kvm_vcpu *vcpu,
> +			      const struct sys_reg_desc *rd)
> +{
> +	return vcpu_has_sve(vcpu);
> +}
> +
> +static bool access_zcr_el1(struct kvm_vcpu *vcpu,
> +			   struct sys_reg_params *p,
> +			   const struct sys_reg_desc *rd)
> +{
> +	/*
> +	 * ZCR_EL1 access is handled directly in Hyp as part of the FPSIMD/SVE
> +	 * context, so we should only arrive here for non-SVE guests:
> +	 */
> +	WARN_ON(vcpu_has_sve(vcpu));
> +
> +	kvm_inject_undefined(vcpu);
> +	return false;
> +}
> +
> +static int get_zcr_el1(struct kvm_vcpu *vcpu,
> +		       const struct sys_reg_desc *rd,
> +		       const struct kvm_one_reg *reg, void __user *uaddr)
> +{
> +	if (!vcpu_has_sve(vcpu))
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
> +	if (!vcpu_has_sve(vcpu))
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
> +#endif /* CONFIG_ARM64_SVE */
> +
>  /*
>   * cpufeature ID register user accessors
>   *
> @@ -1278,7 +1374,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	ID_SANITISED(ID_AA64PFR1_EL1),
>  	ID_UNALLOCATED(4,2),
>  	ID_UNALLOCATED(4,3),
> +#ifdef CONFIG_ARM64_SVE
> +	{ SYS_DESC(SYS_ID_AA64ZFR0_EL1), access_id_aa64zfr0_el1, .get_user = get_id_aa64zfr0_el1, .set_user = set_id_aa64zfr0_el1, .check_present = sve_check_present },
> +#else
>  	ID_UNALLOCATED(4,4),
> +#endif

Can't we always have this code present and fallback to the "unallocated"
behaviour at runtime?

>  	ID_UNALLOCATED(4,5),
>  	ID_UNALLOCATED(4,6),
>  	ID_UNALLOCATED(4,7),
> @@ -1315,6 +1415,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  
>  	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
>  	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
> +#ifdef CONFIG_ARM64_SVE
> +	{ SYS_DESC(SYS_ZCR_EL1), access_zcr_el1, reset_unknown, ZCR_EL1, ~0xfUL, .get_user = get_zcr_el1, .set_user = set_zcr_el1, .check_present = sve_check_present },
> +#endif
>  	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
>  	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
>  	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

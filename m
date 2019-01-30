Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D929C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE7E21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FfAIeRU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE7E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JrIPH3wVOPKY5oXq72RqRuGCaRExdyWfoU+Rem71uhs=; b=FfAIeRU/+kj6qK
	OidlMbdiT1SU0OiE5D6zeZqslo25EbQOYirsTPEVsq3lNNyZFw/LaB1xmha8G8sFbQP6xuUrfLzOt
	YSVcZaaZsQM/VbzoXAJs+ZEm9U7L9/82Oq75zsaIxAsv9xu5NGtD2pjLkJwdpSV6ezIVG2+LXURTV
	RLhnLkqCrwo3JtfLp0uNOR7nmSCFQzRtrc065O+Qz8GNkv2Vo8Rr03XEA6G9PLaKu/0Cnx3rZz/2N
	D7G1EvZ37SF4tYLT5wiRJ0Gtm0RY7bO8CHUhbIduo82ZBo3rIA7qDfCR/pVhyY6qvotr5aNSGstvc
	kK+HSLIrow6+bVvgoBAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotof-0006nQ-Q4; Wed, 30 Jan 2019 17:38:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotoc-0006Xu-7Z
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:38:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AD2280D;
 Wed, 30 Jan 2019 09:38:19 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C79443F557; Wed, 30 Jan 2019 09:38:17 -0800 (PST)
Subject: Re: [PATCH 10/14] KVM: arm/arm64: consolidate arch timer trap handlers
To: Julien Thierry <julien.thierry@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
References: <20190124140032.8588-1-christoffer.dall@arm.com>
 <20190124140032.8588-11-christoffer.dall@arm.com>
 <d9e59695-bc87-e2b5-f0d0-7bc172d2d83c@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <b1e1a5e5-0abe-4a41-315d-526212caacd4@arm.com>
Date: Wed, 30 Jan 2019 17:38:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d9e59695-bc87-e2b5-f0d0-7bc172d2d83c@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_093822_285524_1B22D9B5 
X-CRM114-Status: GOOD (  23.34  )
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
Cc: Andre Przywara <andre.przywara@arm.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/01/2019 12:33, Julien Thierry wrote:
> Hi,
> 
> I'm wondering, could this patch be split in two? One for the
> introduction of kvm_arm_timer_read_sysreg() +
> kvm_arm_timer_write_sysreg() and the other for merging the handlers into
> a single function?

Maybe. I'm not sure it brings us much though.

> 
> 
> 
> On 24/01/2019 14:00, Christoffer Dall wrote:
>> From: Andre Przywara <andre.przywara@arm.com>
>>
>> At the moment we have separate system register emulation handlers for
>> each timer register. Actually they are quite similar, and we rely on
>> kvm_arm_timer_[gs]et_reg() for the actual emulation anyways, so let's
>> just merge all of those handlers into one function, which just marshalls
>> the arguments and then hands off to a set of common accessors.
>> This makes extending the emulation to include EL2 timers much easier.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> [Fixed 32-bit VM breakage and reduced to reworking existing code]
>> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
>> [Fixed 32bit host, general cleanup]
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/coproc.c           |  23 +++---
>>  arch/arm64/include/asm/sysreg.h |   4 +
>>  arch/arm64/kvm/sys_regs.c       |  80 +++++++++++---------
>>  include/kvm/arm_arch_timer.h    |  23 ++++++
>>  virt/kvm/arm/arch_timer.c       | 129 +++++++++++++++++++++++++++-----
>>  5 files changed, 196 insertions(+), 63 deletions(-)
>>
>> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
>> index 222c1635bc7a..51863364f8d1 100644
>> --- a/arch/arm/kvm/coproc.c
>> +++ b/arch/arm/kvm/coproc.c
>> @@ -293,15 +293,16 @@ static bool access_cntp_tval(struct kvm_vcpu *vcpu,
>>  			     const struct coproc_params *p,
>>  			     const struct coproc_reg *r)
>>  {
>> -	u64 now = kvm_phys_timer_read();
>> -	u64 val;
>> +	u32 val;
>>  
>>  	if (p->is_write) {
>>  		val = *vcpu_reg(vcpu, p->Rt1);
>> -		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val + now);
>> +		kvm_arm_timer_write_sysreg(vcpu,
>> +					   TIMER_PTIMER, TIMER_REG_TVAL, val);
>>  	} else {
>> -		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
>> -		*vcpu_reg(vcpu, p->Rt1) = val - now;
>> +		val = kvm_arm_timer_read_sysreg(vcpu,
>> +						TIMER_PTIMER, TIMER_REG_TVAL);
>> +		*vcpu_reg(vcpu, p->Rt1) = val;
>>  	}
>>  
>>  	return true;
>> @@ -315,9 +316,11 @@ static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
>>  
>>  	if (p->is_write) {
>>  		val = *vcpu_reg(vcpu, p->Rt1);
>> -		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CTL, val);
>> +		kvm_arm_timer_write_sysreg(vcpu,
>> +					   TIMER_PTIMER, TIMER_REG_CTL, val);
>>  	} else {
>> -		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CTL);
>> +		val = kvm_arm_timer_read_sysreg(vcpu,
>> +						TIMER_PTIMER, TIMER_REG_CTL);
>>  		*vcpu_reg(vcpu, p->Rt1) = val;
>>  	}
>>  
>> @@ -333,9 +336,11 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
>>  	if (p->is_write) {
>>  		val = (u64)*vcpu_reg(vcpu, p->Rt2) << 32;
>>  		val |= *vcpu_reg(vcpu, p->Rt1);
>> -		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val);
>> +		kvm_arm_timer_write_sysreg(vcpu,
>> +					   TIMER_PTIMER, TIMER_REG_CVAL, val);
>>  	} else {
>> -		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
>> +		val = kvm_arm_timer_read_sysreg(vcpu,
>> +						TIMER_PTIMER, TIMER_REG_CVAL);
>>  		*vcpu_reg(vcpu, p->Rt1) = val;
>>  		*vcpu_reg(vcpu, p->Rt2) = val >> 32;
>>  	}
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 3e5650903d6d..6482e8bcf1b8 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -392,6 +392,10 @@
>>  #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
>>  #define SYS_CNTP_CVAL_EL0		sys_reg(3, 3, 14, 2, 2)
>>  
>> +#define SYS_AARCH32_CNTP_TVAL		sys_reg(0, 0, 14, 2, 0)
>> +#define SYS_AARCH32_CNTP_CTL		sys_reg(0, 0, 14, 2, 1)
>> +#define SYS_AARCH32_CNTP_CVAL		sys_reg(0, 2, 0, 14, 0)
>> +
>>  #define __PMEV_op2(n)			((n) & 0x7)
>>  #define __CNTR_CRm(n)			(0x8 | (((n) >> 3) & 0x3))
>>  #define SYS_PMEVCNTRn_EL0(n)		sys_reg(3, 3, 14, __CNTR_CRm(n), __PMEV_op2(n))
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 1a5bea4285e4..65ea63366c67 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -990,44 +990,51 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>>  	{ SYS_DESC(SYS_PMEVTYPERn_EL0(n)),					\
>>  	  access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
>>  
>> -static bool access_cntp_tval(struct kvm_vcpu *vcpu,
>> -		struct sys_reg_params *p,
>> -		const struct sys_reg_desc *r)
>> +static bool access_arch_timer(struct kvm_vcpu *vcpu,
>> +			      struct sys_reg_params *p,
>> +			      const struct sys_reg_desc *r)
>>  {
>> -	u64 now = kvm_phys_timer_read();
>> -	u64 cval;
>> +	enum kvm_arch_timers tmr;
>> +	enum kvm_arch_timer_regs treg;
>> +	u64 reg = reg_to_encoding(r);
>>  
>> -	if (p->is_write) {
>> -		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL,
>> -				      p->regval + now);
>> -	} else {
>> -		cval = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
>> -		p->regval = cval - now;
>> +	switch (reg) {
>> +	case SYS_CNTP_TVAL_EL0:
>> +	case SYS_CNTP_CTL_EL0:
>> +	case SYS_CNTP_CVAL_EL0:
>> +	case SYS_AARCH32_CNTP_TVAL:
>> +	case SYS_AARCH32_CNTP_CTL:
>> +	case SYS_AARCH32_CNTP_CVAL:
>> +		tmr = TIMER_PTIMER;
>> +		break;
>> +	default:
>> +		BUG();
>>  	}
>>  
>> -	return true;
>> -}
>> +	switch (reg) {
> 
> I find having two consecutive switch on the same element a bit weird
> (and takes a lot of space).
> 
> Either I'd merge the two since the valid cases are the same, or I'd put
> them in separate function "reg_get_timer(reg)",
> "reg_get_timer_reg(reg)". (Can probably fit those in
> include/kvm/arm_arch_timer.h)

Nah, I'll just merge them. I wrote it this way as it was just easier to
reason about one thing at a time, but in the end this is (as you
noticed) fairly pointless.

I guess I'll have more fun rebasing the NV stuff on top! ;-)

[...]

>> +static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>> +			      struct arch_timer_context *timer,
>> +			      enum kvm_arch_timer_regs treg)
>> +{
>> +	u64 val;
>> +
>> +	switch (treg) {
>> +	case TIMER_REG_TVAL:
>> +		val = kvm_phys_timer_read() - timer->cntvoff - timer->cnt_cval;
>> +		break;
>> +
>> +	case TIMER_REG_CTL:
>> +		val = read_timer_ctl(timer);
>> +		break;
>> +
>> +	case TIMER_REG_CVAL:
>> +		val = timer->cnt_cval;
>> +		break;
>> +
>> +	case TIMER_REG_CNT:
>> +		val = kvm_phys_timer_read() - timer->cntvoff;
> 
> Unless you really don't want people to read this register, you might
> want to add a "break;" here :) .

Timers are for wimps. Real hax0rz use a calibrated loop with interrupts
disabled! ;-)

Thanks for the heads up!

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

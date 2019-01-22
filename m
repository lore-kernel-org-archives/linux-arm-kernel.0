Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044F92085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U/SlDhjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044F92085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qQzOswOANuQ6OOwgQZP46Dyy8A9XmhmmwwK/wOWChMM=; b=U/SlDhjZs7EZ0e
	BV+GxwJsI3EH4rq2dpPSomNeF6rsh/B9EdFwTFA54E7dJPp5KvK1pNoGn8nPXOZfJU2nkTrbwOeGb
	b5B4uzlUSdeu6dsI9VmnFzltuN99Hvo/3cGMKWcVAR7w35nPkpz++JGf3bW9hzKIlIW51KMCXoUk/
	2X8HVT+qk08MRzoIcg6ijPCeE5vDwwhAPuixpJkpVD4JCn3Iq+nMqhPFDjwvpCF88+sQ5Y4d0I93H
	AWFlPOmwo075IdqapbwlFbxSja3cTFqlDS27FVGSxZ9CNVVwEA/bhKwH+ke6CAXZ37//udLZcs0Jr
	9qe6iSOkLZNit9Mz8t4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzb5-0001NC-Al; Tue, 22 Jan 2019 17:12:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzat-000175-2J
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:12:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BCA4A78;
 Tue, 22 Jan 2019 09:12:10 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D486B3F6A8;
 Tue, 22 Jan 2019 09:12:08 -0800 (PST)
Date: Tue, 22 Jan 2019 17:12:06 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 14/25] KVM: arm64/sve: Context switch the SVE registers
Message-ID: <20190122171205.GJ3578@e103592.cambridge.arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
 <1547757219-19439-15-git-send-email-Dave.Martin@arm.com>
 <3bb2407f-a28d-6a6b-79ba-eda4c4194c80@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3bb2407f-a28d-6a6b-79ba-eda4c4194c80@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_091211_409158_09F374E7 
X-CRM114-Status: GOOD (  33.94  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 05:15:07PM +0000, Marc Zyngier wrote:
> On 17/01/2019 20:33, Dave Martin wrote:
> > In order to give each vcpu its own view of the SVE registers, this
> > patch adds context storage via a new sve_state pointer in struct
> > vcpu_arch.  An additional member sve_max_vl is also added for each
> > vcpu, to determine the maximum vector length visible to the guest
> > and thus the value to be configured in ZCR_EL2.LEN while the is
> > active.  This also determines the layout and size of the storage in
> > sve_state, which is read and written by the same backend functions
> > that are used for context-switching the SVE state for host tasks.
> > 
> > On SVE-enabled vcpus, SVE access traps are now handled by switching
> > in the vcpu's SVE context and disabling the trap before returning
> > to the guest.  On other vcpus, the trap is not handled and an exit
> > back to the host occurs, where the handle_sve() fallback path
> > reflects an undefined instruction exception back to the guest,
> > consistently with the behaviour of non-SVE-capable hardware (as was
> > done unconditionally prior to this patch).
> > 
> > No SVE handling is added on non-VHE-only paths, since VHE is an
> > architectural and Kconfig prerequisite of SVE.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Changes since RFC v3:
> > 
> >  * Ensure guest_has_sve is initialised before use.  Previously the
> >    order of the code allowed this to be used before initilaisation
> >    on some paths.  Mysteriously the compiler failed to warn.
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  6 ++++
> >  arch/arm64/kvm/fpsimd.c           |  5 +--
> >  arch/arm64/kvm/hyp/switch.c       | 70 ++++++++++++++++++++++++++++++---------
> >  3 files changed, 64 insertions(+), 17 deletions(-)

[...]

> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index 9f07403..f7a8e3b 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -98,7 +98,10 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
> >  	val = read_sysreg(cpacr_el1);
> >  	val |= CPACR_EL1_TTA;
> >  	val &= ~CPACR_EL1_ZEN;
> > -	if (!update_fp_enabled(vcpu)) {
> > +	if (update_fp_enabled(vcpu)) {
> > +		if (vcpu_has_sve(vcpu))
> > +			val |= CPACR_EL1_ZEN;
> > +	} else {
> >  		val &= ~CPACR_EL1_FPEN;
> >  		__activate_traps_fpsimd32(vcpu);
> >  	}
> > @@ -313,26 +316,59 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
> >  	return true;
> >  }
> >  
> > -static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> > +/*
> > + * if () with a gating check for SVE support to minimise branch
> > + * mispredictions in non-SVE systems.
> > + * (system_supports_sve() is resolved at build time or via a static key.)
> > + */
> > +#define if_sve(cond) if (system_supports_sve() && (cond))
> 
> I really hate this kind of construct, as while it provides an apparent
> benefit, it actually leads to code that is harder to read. Do we have
> any data showing that this adversely impacts any known workload on
> non-SVE systems, given how rarely this exception is triggered?
> 
> At any rate, I'd rather see system_supports_sve() as part of the condition.

The alternative was to have a lot of if (system_supports_sve() && foo),
which makes for more branchy code.

But I'll agree that we don't have good evidence to justify this
if_sve () thing either.


I'll see if I can come up with something saner.

Is it worth at least annotating paths with likely/unlikely, or is that
again something we shouldn't do without some benchmarking that backs
it up?

> > +
> > +/* Check for an FPSIMD/SVE trap and handle as appropriate */
> > +static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
> >  {
> > -	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
> > +	u8 trap_class;
> > +	bool guest_has_sve;
> >  
> > -	if (has_vhe())
> > -		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
> > -			     cpacr_el1);
> > -	else
> > +	if (!system_supports_fpsimd())
> > +		return false;
> > +
> > +	guest_has_sve = vcpu_has_sve(vcpu);
> > +	trap_class = kvm_vcpu_trap_get_class(vcpu);
> > +
> > +	if (trap_class == ESR_ELx_EC_FP_ASIMD)
> > +		goto handle;
> > +
> > +	if_sve (guest_has_sve && trap_class == ESR_ELx_EC_SVE)
> > +		goto handle;
> > +
> > +	return false;
> 
> In the end, this is the stuff we want to handle quickly: nothing to do
> at all. Given that vcpu_has_sve() is already gated by

True -- would it be worth renaming the function __try_handle_fpsimd() or
similar, to make it clearer that the function may actually not handle
FPSIMD (or do anything material) in the common case?

I may have led myself astray with the current naming.

> system_supports_sve(), I'm pretty sure that there is no difference in
> code generation between your if_sve() construct and a simple if().

Maybe so.  At least, if_sve () may make the code more obscure in
practice for no good reason.

> > +
> > +handle:
> > +	/* The trap is an FPSIMD/SVE trap: switch the context */
> > +
> > +	if (has_vhe()) {
> > +		u64 reg = read_sysreg(cpacr_el1) | CPACR_EL1_FPEN;
> > +
> > +		if_sve (guest_has_sve)
> > +			reg |= CPACR_EL1_ZEN;
> > +
> > +		write_sysreg(reg, cpacr_el1);
> > +	} else {
> >  		write_sysreg(read_sysreg(cptr_el2) & ~(u64)CPTR_EL2_TFP,
> >  			     cptr_el2);
> > +	}
> >  
> >  	isb();
> >  
> >  	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
> > +		struct user_fpsimd_state *host_fpsimd =
> > +			vcpu->arch.host_fpsimd_state;
> > +
> 
> Single line, please. Or split declaration and assignment.

Can do.

> >  		/*
> >  		 * In the SVE case, VHE is assumed: it is enforced by
> >  		 * Kconfig and kvm_arch_init().
> >  		 */
> > -		if (system_supports_sve() &&
> > -		    (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE)) {
> > +		if_sve (vcpu->arch.flags & KVM_ARM64_HOST_SVE_IN_USE) {
> >  			struct thread_struct *thread = container_of(
> >  				host_fpsimd,
> >  				struct thread_struct, uw.fpsimd_state);
> > @@ -345,10 +381,14 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> >  		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
> >  	}

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

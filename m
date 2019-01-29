Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C554C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:49:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3254220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2AicuSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3254220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7ak9YZGgxBgfFHVRv1k/5RwJxV3PA+Oo5zad+tCO2/E=; b=u2AicuSh7ynCT7
	9BjUfwPKevY+sqL4EKBluxS06ZKfaSMqjHXY4pzQh+Dr6/vILf7qG70EEs74XQkwrPL2wfxwLLZvJ
	fNArqCN8qaY2Ajv6ZhHtfYPj8RFEIfTSxxiLCVcdmM7vXp6oyQ9yMhcQwbfKgaz2I5I7r9O2IeUFj
	TkGDWPm/4y2dgqdMNy2iFSxLM4NjGc+IEALhhyWnEP3K6A2JteHftUADsBIka+i8v8fYRsKZeT3sS
	QfYS0GvDVS2ud3kr6U4RXVd8/zI3Rhq/zSzZeQgC5Iszdyp7myC10W0rcF3uZeGIFnEdIuKgul9Vw
	NPri9iDvn5BWUkveSWQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVdL-0000f4-Bs; Tue, 29 Jan 2019 15:49:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVdG-0000eS-Rv
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:49:05 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 058B6811D8;
 Tue, 29 Jan 2019 15:49:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC5821059598;
 Tue, 29 Jan 2019 15:49:00 +0000 (UTC)
Date: Tue, 29 Jan 2019 16:48:58 +0100
From: Andrew Jones <drjones@redhat.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 1/5] KVM: arm/arm64: Reset the VCPU without preemption
 and vcpu state loaded
Message-ID: <20190129154858.docsos3ncoyuld7m@kamzik.brq.redhat.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
 <20190125094656.5026-2-christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125094656.5026-2-christoffer.dall@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 15:49:02 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_074902_938065_EBB8BC86 
X-CRM114-Status: GOOD (  26.64  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Christoffer,

On Fri, Jan 25, 2019 at 10:46:52AM +0100, Christoffer Dall wrote:
> Resetting the VCPU state modifies the system register state in memory,
> but this may interact with vcpu_load/vcpu_put if running with preemption
> disabled, which in turn may lead to corrupted system register state.
  ^ enabled
> 
> Address this by disabling preemption and doing put/load if required
> around the reset logic.

I'm having trouble understanding how disabling preemption helps here.
There shouldn't be an issue with the KVM_ARM_VCPU_INIT case, since the
target vcpu is guaranteed not to be loaded and therefore it doesn't
have preempt notifiers registered either. Also, KVM_ARM_VCPU_INIT holds
the vcpu mutex, so there's no chance for a load to occur until it's
complete.

For the PSCI case it makes sense to force a vcpu load after the reset,
otherwise the sleeping target vcpu won't have the correct state loaded.
The initial put also makes sense in case we're not resetting everything.
I don't understand how we're ensuring the target vcpu thread's preemption
is disabled though. This modified kvm_reset_vcpu would need to be run
from the target vcpu thread to work, but that's not how the PSCI code
currently does it.

> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/reset.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b72a3dd56204..f21a2a575939 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -105,16 +105,33 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   * This function finds the right table above and sets the registers on
>   * the virtual CPU struct to their architecturally defined reset
>   * values.
> + *
> + * Note: This function can be called from two paths: The KVM_ARM_VCPU_INIT
> + * ioctl or as part of handling a request issued by another VCPU in the PSCI
> + * handling code.  In the first case, the VCPU will not be loaded, and in the
> + * second case the VCPU will be loaded.  Because this function operates purely
> + * on the memory-backed valus of system registers, we want to do a full put if
                           ^ values
> + * we were loaded (handling a request) and load the values back at the end of
> + * the function.  Otherwise we leave the state alone.  In both cases, we
> + * disable preemption around the vcpu reset as we would otherwise race with
> + * preempt notifiers which also call put/load.
>   */
>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	const struct kvm_regs *cpu_reset;
> +	int ret = -EINVAL;
> +	bool loaded;
> +
> +	preempt_disable();
> +	loaded = (vcpu->cpu != -1);
> +	if (loaded)
> +		kvm_arch_vcpu_put(vcpu);
>  
>  	switch (vcpu->arch.target) {
>  	default:
>  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
>  			if (!cpu_has_32bit_el1())
> -				return -EINVAL;
> +				goto out;
>  			cpu_reset = &default_regs_reset32;
>  		} else {
>  			cpu_reset = &default_regs_reset;
> @@ -137,7 +154,12 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
>  
>  	/* Reset timer */
> -	return kvm_timer_vcpu_reset(vcpu);
> +	ret = kvm_timer_vcpu_reset(vcpu);
> +out:
> +	if (loaded)
> +		kvm_arch_vcpu_load(vcpu, smp_processor_id());
> +	preempt_enable();
> +	return ret;
>  }
>  
>  void kvm_set_ipa_limit(void)
> -- 
> 2.18.0
>

Thanks,
drew 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

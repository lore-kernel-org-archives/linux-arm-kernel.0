Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5736C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:17:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8588D21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n75Bt+EI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dCiP6PbWozpogsLJ6bGtIpS1JMtlClDZvxoMUs8LoGo=; b=n75Bt+EI7FqCNF
	kakrqmeusZxCcqvnRyhdPpsWseA2n7baXjGroKl0rGSvrKzKdQipzOICUC5aKmb9Kvm2pYW7rCq1+
	RMxBQVVbnFnqCi0Otu4z7yY1BM6AkzvwD8mf2tEmokhbhx8Ty8O/+E773sQ1tYJbB4GVoUa6kw500
	p9iKDaNwdG+xNAWJceXStcxPMbyPw1ypzXj2MggM7D+3p0T90oMs5S2awBeFD3uNFfLC6qfVcr4RN
	Hau4Bztv6kouCBtq1BUds/GcnRy9EUOOYaKjg8agTv5imgdXtO76onqCUXUhlXOZNYI3cDxRnZhpv
	W793JrgEdyUYm5E6s9tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtakK-0003Iq-VX; Tue, 12 Feb 2019 16:17:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtakH-0003IA-3q
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 16:17:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3562880D;
 Tue, 12 Feb 2019 08:17:15 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 462ED3F675;
 Tue, 12 Feb 2019 08:17:14 -0800 (PST)
Subject: Re: [PATCH] KVM: arm/arm64: arch_timer: Mark physical interrupt
 active when a virtual interrupt is pending
To: Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20190208144300.75299-1-marc.zyngier@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e64905da-3ea2-0ad3-ab02-ecc6dd0999bd@arm.com>
Date: Tue, 12 Feb 2019 16:17:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208144300.75299-1-marc.zyngier@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_081717_171283_00BB03E1 
X-CRM114-Status: GOOD (  28.90  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 08/02/2019 14:43, Marc Zyngier wrote:
> When a guest gets scheduled, KVM performs a "load" operation,
> which for the timer includes evaluating the virtual "active" state
> of the interrupt, and replicating it on the physical side. This
> ensures that the deactivation in the guest will also take place
> in the physical GIC distributor.
> 
> If the interrupt is not yet active, we flag it as inactive on the
> physical side.  This means that on restoring the timer registers,
> if the timer has expired, we'll immediately take an interrupt.
> That's absolutely fine, as the interrupt will then be flagged as
> active on the physical side. What this assumes though is that we'll
> enter the guest right after having taken the interrupt, and that
> the guest will quickly ACK the interrupt, making it active at on

Nit: "at on" -> pick one

> the virtual side.
> 
> It turns out that quite often, this assumption doesn't really hold.
> The guest may be preempted on the back on this interrupt, either

on the back of*

> from kernel space or whilst running at EL1 when a host interrupt
> fires. When this happens, we repeat the whole sequence on the
> next load (interrupt marked as inactive, timer registers restored,
> interrupt fires). And if it takes a really long time for a guest
> to activate the interrupt (as it does with nested virt), we end-up
> with many such events in quick succession, leading to the guest only
> making very slow progress.
> 
> This can also be seen with the number of virtual timer interrupt on the
> host being far greater than the same number in the guest.
> 
> An easy way to fix this is to evaluate the timer state when performing
> the "load" operation, just like we do when the interrupt actually fires.
> If the timer has a pending virtual interrupt at this stage, then we
> can safely flag the physical interrupt as being active, which prevents
> spurious exits.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Otherwise, I think the change makes sense:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

> ---
>  virt/kvm/arm/arch_timer.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 7449651ae2e5..70c18479ccd5 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -487,12 +487,21 @@ static inline void set_timer_irq_phys_active(struct arch_timer_context *ctx, boo
>  static void kvm_timer_vcpu_load_gic(struct arch_timer_context *ctx)
>  {
>  	struct kvm_vcpu *vcpu = ctx->vcpu;
> -	bool phys_active;
> +	bool phys_active = false;
> +
> +	/*
> +	 * Update the timer output so that it is likely to match the
> +	 * state we're about to restore. If the timer expires between
> +	 * this point and the register restoration, we'll take the
> +	 * interrupt anyway.
> +	 */
> +	kvm_timer_update_irq(ctx->vcpu, kvm_timer_should_fire(ctx), ctx);
>  
>  	if (irqchip_in_kernel(vcpu->kvm))
>  		phys_active = kvm_vgic_map_is_active(vcpu, ctx->irq.irq);
> -	else
> -		phys_active = ctx->irq.level;
> +
> +	phys_active |= ctx->irq.level;
> +
>  	set_timer_irq_phys_active(ctx, phys_active);
>  }
>  
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

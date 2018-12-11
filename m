Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADF5C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8EA20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MGVDi9X5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8EA20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pEUJx3jsWneGILjZMY/0PsR1lhujdXe9BfbZoXekspc=; b=MGVDi9X5ISHW4f
	n7Mr4sWRhdGxuLbZ40i0vsn+XCIRh6oJuTJL1W8CW2Yx13zuU3qWzwo1jxvZl/6w8/RPwr8X9JRPj
	w1dIF3ANYXvIkb65WPQD3ZePmw2PdkQrD4g101LJqEywx0BWLNKlzkF3kS6D58bnKD3ijIKP5J/aK
	tgLzMgcZl/E4PEGoNbh5NYyomdM6GtVVzrN7E+v5Rdlm1wEeFen63R4xhu5gwy1i3I9qlRbcX1qAP
	ucM4RVa2LYao2OfoqvCzMLMjYIz+Ixh27+z1PJ9PPmx9I5ess95mTOWaXU0VvwOV35EEjvuFgh1e7
	mVInb64HWAM6rbrWChhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWf9V-0003QB-Nq; Tue, 11 Dec 2018 10:20:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWf9S-0003OJ-CW
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:20:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD3C15AD;
 Tue, 11 Dec 2018 02:20:17 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B510C3F6A8;
 Tue, 11 Dec 2018 02:20:16 -0800 (PST)
Date: Tue, 11 Dec 2018 11:20:15 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2 1/4] KVM: arm/arm64: vgic: Do not cond_resched_lock()
 with IRQs disabled
Message-ID: <20181211102015.GV30263@e113682-lin.lund.arm.com>
References: <1543256807-9768-1-git-send-email-julien.thierry@arm.com>
 <1543256807-9768-2-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543256807-9768-2-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_022030_429934_C288CA1E 
X-CRM114-Status: GOOD (  25.75  )
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
Cc: linux-rt-users@vger.kernel.org, marc.zyngier@arm.com, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, stable@vger.kernel.org,
 tglx@linutronix.de, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 06:26:44PM +0000, Julien Thierry wrote:
> To change the active state of an MMIO, halt is requested for all vcpus of
> the affected guest before modifying the IRQ state. This is done by calling
> cond_resched_lock() in vgic_mmio_change_active(). However interrupts are
> disabled at this point and we cannot reschedule a vcpu.
> 
> Solve this by waiting for all vcpus to be halted after emmiting the halt
> request.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: stable@vger.kernel.org
> ---
>  virt/kvm/arm/vgic/vgic-mmio.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> index f56ff1c..5c76a92 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> @@ -313,27 +313,6 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
>  
>  	spin_lock_irqsave(&irq->irq_lock, flags);
>  
> -	/*
> -	 * If this virtual IRQ was written into a list register, we
> -	 * have to make sure the CPU that runs the VCPU thread has
> -	 * synced back the LR state to the struct vgic_irq.
> -	 *
> -	 * As long as the conditions below are true, we know the VCPU thread
> -	 * may be on its way back from the guest (we kicked the VCPU thread in
> -	 * vgic_change_active_prepare)  and still has to sync back this IRQ,
> -	 * so we release and re-acquire the spin_lock to let the other thread
> -	 * sync back the IRQ.
> -	 *
> -	 * When accessing VGIC state from user space, requester_vcpu is
> -	 * NULL, which is fine, because we guarantee that no VCPUs are running
> -	 * when accessing VGIC state from user space so irq->vcpu->cpu is
> -	 * always -1.
> -	 */
> -	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
> -	       irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
> -	       irq->vcpu->cpu != -1) /* VCPU thread is running */
> -		cond_resched_lock(&irq->irq_lock);
> -
>  	if (irq->hw) {
>  		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
>  	} else {
> @@ -368,8 +347,21 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
>   */
>  static void vgic_change_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
>  {
> -	if (intid > VGIC_NR_PRIVATE_IRQS)
> +	if (intid > VGIC_NR_PRIVATE_IRQS) {
> +		struct kvm_vcpu *tmp;
> +		int i;
> +
>  		kvm_arm_halt_guest(vcpu->kvm);
> +
> +		/* Wait for each vcpu to be halted */
> +		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> +			if (tmp == vcpu)
> +				continue;
> +
> +			while (tmp->cpu != -1)
> +				cond_resched();
> +		}

I'm actually thinking we don't need this loop at all after the requet
rework which causes:

 1. kvm_arm_halt_guest() to use kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP), and
 2. KVM_REQ_SLEEP uses REQ_WAIT, and
 3. REQ_WAIT requires the VCPU to respond to IPIs before returning, and
 4. a VCPU thread can only respond when it enables interrupt, and
 5. enabling interrupts when running a VCPU only happens after syncing
    the VGIC hwstate.

Does that make sense?

It would be good if someone can validate this, but if it holds this
patch just becomes a nice deletion of the logic in
vgic-mmio_change_active.


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

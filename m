Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973F7217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+ysBmzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973F7217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8blYCqob8EdwHa71yjBzMq1E7FPBf568wBQxYzwDng=; b=f+ysBmzI9P9rvV
	s0B9tdAhPUbWB23fnHZJOlOCmLyX0h3Nq+qYyq8u52JrTmhfbfQXxYGgPCVing3rj3lB1o/IpXFM4
	IOWni7QTm1gc3FmhCL/PH+AzaV4xgcFh3Roo/4VaMufTRSKQ642rMTyIeRj1dW2ELt44nCiBOjuen
	MV++m+DvipkR+qBJPL25Y4n4XuCUH0mq7Vw0WDdAcnHSLVetB9A4N5ECNfk1pGu9R387TqDKzieDL
	iZoGd7mQ3WPPwxbY+kt6hpu1uCINdqSDjt2XHWg0X1flDZRjlvNZoJ34Cq1d6QMb6q/GaVAY0eZ41
	lHEl3TX11D2tzyP1tfwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgGP-00026J-QL; Wed, 19 Dec 2018 18:08:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDF-0006HI-5P
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F5611650;
 Wed, 19 Dec 2018 10:04:48 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E42493F675;
 Wed, 19 Dec 2018 10:04:45 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 14/28] KVM: arm/arm64: vgic: Do not cond_resched_lock() with
 IRQs disabled
Date: Wed, 19 Dec 2018 18:03:35 +0000
Message-Id: <20181219180349.242681-15-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100454_148055_A835EC95 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Julien Thierry <julien.thierry@arm.com>

To change the active state of an MMIO, halt is requested for all vcpus of
the affected guest before modifying the IRQ state. This is done by calling
cond_resched_lock() in vgic_mmio_change_active(). However interrupts are
disabled at this point and we cannot reschedule a vcpu.

We actually don't need any of this, as kvm_arm_halt_guest ensures that
all the other vcpus are out of the guest. Let's just drop that useless
code.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 2b450d49a046..7c2231950c33 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -313,27 +313,6 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 
 	spin_lock_irqsave(&irq->irq_lock, flags);
 
-	/*
-	 * If this virtual IRQ was written into a list register, we
-	 * have to make sure the CPU that runs the VCPU thread has
-	 * synced back the LR state to the struct vgic_irq.
-	 *
-	 * As long as the conditions below are true, we know the VCPU thread
-	 * may be on its way back from the guest (we kicked the VCPU thread in
-	 * vgic_change_active_prepare)  and still has to sync back this IRQ,
-	 * so we release and re-acquire the spin_lock to let the other thread
-	 * sync back the IRQ.
-	 *
-	 * When accessing VGIC state from user space, requester_vcpu is
-	 * NULL, which is fine, because we guarantee that no VCPUs are running
-	 * when accessing VGIC state from user space so irq->vcpu->cpu is
-	 * always -1.
-	 */
-	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
-	       irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
-	       irq->vcpu->cpu != -1) /* VCPU thread is running */
-		cond_resched_lock(&irq->irq_lock);
-
 	if (irq->hw) {
 		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
 	} else {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

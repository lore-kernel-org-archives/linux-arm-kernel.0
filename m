Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C594EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:20:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945A82175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z7D0lbM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945A82175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QNaDTEiXx+baHw/mUypkeIvPYSZ3Q28s14vursGrrBE=; b=Z7D0lbM5Qya02c
	v68sgzhZwTr69EpRzapR15cgwLN1VvwQfvFZ+1UDVqYYb7xDNubUPnN+jb/NVHvp+TCveIVPbPdIp
	0LEAeit4pfrxl1C8L+SsovwIs+H0Q9X54JDezranzF9vQ2bChJltzkwDAjs+2HKBleRdUc0gJOqzJ
	sPbbjkBo4ZspOEcOjg+DNx25l5/S3BBp6Q7B9lgV8wgPAz8HRlyUtXyCRcl7NWutf8jtvDBTT2AXp
	Z1nYJ8OKR2/UaUzxey7jCOL7jhPr4Pkayr6YT/F9uMd57z4xLrNYxuPHl1q33Y+lIaBpjRhqKOFIB
	5j1GyJTkLgkpQMGGCBIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjar-0002vI-Fh; Thu, 07 Feb 2019 13:19:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grja6-000256-0Z
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:19:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF45B1596;
 Thu,  7 Feb 2019 05:19:05 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 797C13F675;
 Thu,  7 Feb 2019 05:19:03 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 03/11] KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a
 raw_spinlock
Date: Thu,  7 Feb 2019 13:18:35 +0000
Message-Id: <20190207131843.157210-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207131843.157210-1-marc.zyngier@arm.com>
References: <20190207131843.157210-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_051906_602678_6E720ED5 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Julien Thierry <julien.thierry@arm.com>

vgic_cpu->ap_list_lock must always be taken with interrupts disabled as
it is used in interrupt context.

For configurations such as PREEMPT_RT_FULL, this means that it should
be a raw_spinlock since RT spinlocks are interruptible.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 include/kvm/arm_vgic.h        |  2 +-
 virt/kvm/arm/vgic/vgic-init.c |  2 +-
 virt/kvm/arm/vgic/vgic.c      | 37 ++++++++++++++++++-----------------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 32954e115796..c36c86f1ec9a 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -307,7 +307,7 @@ struct vgic_cpu {
 	unsigned int used_lrs;
 	struct vgic_irq private_irqs[VGIC_NR_PRIVATE_IRQS];
 
-	spinlock_t ap_list_lock;	/* Protects the ap_list */
+	raw_spinlock_t ap_list_lock;	/* Protects the ap_list */
 
 	/*
 	 * List of IRQs that this VCPU should consider because they are either
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 330c1ada7326..dfbfcb1fe933 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -206,7 +206,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	vgic_cpu->sgi_iodev.base_addr = VGIC_ADDR_UNDEF;
 
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
-	spin_lock_init(&vgic_cpu->ap_list_lock);
+	raw_spin_lock_init(&vgic_cpu->ap_list_lock);
 
 	/*
 	 * Enable and configure all SGIs to be edge-triggered and
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index ea54a1923c4f..abd9c7352677 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -54,11 +54,11 @@ struct vgic_global kvm_vgic_global_state __ro_after_init = {
  * When taking more than one ap_list_lock at the same time, always take the
  * lowest numbered VCPU's ap_list_lock first, so:
  *   vcpuX->vcpu_id < vcpuY->vcpu_id:
- *     spin_lock(vcpuX->arch.vgic_cpu.ap_list_lock);
- *     spin_lock(vcpuY->arch.vgic_cpu.ap_list_lock);
+ *     raw_spin_lock(vcpuX->arch.vgic_cpu.ap_list_lock);
+ *     raw_spin_lock(vcpuY->arch.vgic_cpu.ap_list_lock);
  *
  * Since the VGIC must support injecting virtual interrupts from ISRs, we have
- * to use the spin_lock_irqsave/spin_unlock_irqrestore versions of outer
+ * to use the raw_spin_lock_irqsave/raw_spin_unlock_irqrestore versions of outer
  * spinlocks for any lock that may be taken while injecting an interrupt.
  */
 
@@ -351,7 +351,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 
 	/* someone can do stuff here, which we re-check below */
 
-	spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 	raw_spin_lock(&irq->irq_lock);
 
 	/*
@@ -368,7 +368,8 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 
 	if (unlikely(irq->vcpu || vcpu != vgic_target_oracle(irq))) {
 		raw_spin_unlock(&irq->irq_lock);
-		spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+		raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock,
+					   flags);
 
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		goto retry;
@@ -383,7 +384,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 	irq->vcpu = vcpu;
 
 	raw_spin_unlock(&irq->irq_lock);
-	spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
+	raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
 
 	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 	kvm_vcpu_kick(vcpu);
@@ -597,7 +598,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
 retry:
-	spin_lock(&vgic_cpu->ap_list_lock);
+	raw_spin_lock(&vgic_cpu->ap_list_lock);
 
 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
@@ -638,7 +639,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		/* This interrupt looks like it has to be migrated. */
 
 		raw_spin_unlock(&irq->irq_lock);
-		spin_unlock(&vgic_cpu->ap_list_lock);
+		raw_spin_unlock(&vgic_cpu->ap_list_lock);
 
 		/*
 		 * Ensure locking order by always locking the smallest
@@ -652,9 +653,9 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 			vcpuB = vcpu;
 		}
 
-		spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
-		spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
-				 SINGLE_DEPTH_NESTING);
+		raw_spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
+		raw_spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
+				      SINGLE_DEPTH_NESTING);
 		raw_spin_lock(&irq->irq_lock);
 
 		/*
@@ -676,8 +677,8 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		}
 
 		raw_spin_unlock(&irq->irq_lock);
-		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
-		spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);
+		raw_spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
+		raw_spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);
 
 		if (target_vcpu_needs_kick) {
 			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
@@ -687,7 +688,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		goto retry;
 	}
 
-	spin_unlock(&vgic_cpu->ap_list_lock);
+	raw_spin_unlock(&vgic_cpu->ap_list_lock);
 }
 
 static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
@@ -872,9 +873,9 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
-	spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
 	vgic_flush_lr_state(vcpu);
-	spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
 
 	if (can_access_vgic_from_kernel())
 		vgic_restore_state(vcpu);
@@ -918,7 +919,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 
 	vgic_get_vmcr(vcpu, &vmcr);
 
-	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		raw_spin_lock(&irq->irq_lock);
@@ -931,7 +932,7 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 			break;
 	}
 
-	spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+	raw_spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
 
 	return pending;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

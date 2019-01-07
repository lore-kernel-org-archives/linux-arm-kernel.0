Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3184C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A3C217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FPkcxPTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A3C217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7CpBkb1G0UDMN9Aju80rpfV1+Pt7UJwg67M7++l2yKI=; b=FPkcxPTWj+zZXsfpmhzFOzhNHy
	ieg+jw++MBPhzTruMQcAqQaL9mPu5lu4iwd2phY+p+RQdjejNOVpQxnXxWOVYG8plPZK6h+nNmT9B
	NCUP+GnQXuWmrTDqbAjFbohpI5503oDguvswANNmmO8EGFp5eDWsrOzOSYkJz2Mc3j8BwFMjuSMVj
	WLOl5nE3gP+V/SzN2HaxNrD5Mdo8y2RyPHoY1uZGXUlxaxDST7a7/ChsPWIbKeeqnuqmv3GPqcX0P
	PdqhCipJ9VV1SVX/phWrwx3NOhklFsTifPXIBSIbRrx489xMdXChlDZ+XFEk4aOEgQ3ffhEN2IxJh
	T1YaZEqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggWUe-0006xx-Ay; Mon, 07 Jan 2019 15:07:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggWU9-0006U2-Be
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 15:06:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 369CF15AD;
 Mon,  7 Jan 2019 07:06:37 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 445543F5B7;
 Mon,  7 Jan 2019 07:06:35 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 2/3] KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a
 raw_spinlock
Date: Mon,  7 Jan 2019 15:06:16 +0000
Message-Id: <1546873577-13895-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
References: <1546873577-13895-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_070637_450853_1882C985 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: linux-rt-users@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 marc.zyngier@arm.com, bigeasy@linutronix.de,
 Christoffer Dall <christoffer.dall@arm.com>, rostedt@goodmis.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

vgic_dist->lpi_list_lock must always be taken with interrupts disabled as
it is used in interrupt context.

For configurations such as PREEMPT_RT_FULL, this means that it should
be a raw_spinlock since RT spinlocks are interruptible.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h        |  2 +-
 virt/kvm/arm/vgic/vgic-init.c |  2 +-
 virt/kvm/arm/vgic/vgic-its.c  |  8 ++++----
 virt/kvm/arm/vgic/vgic.c      | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index b542605..32954e1 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -256,7 +256,7 @@ struct vgic_dist {
 	u64			propbaser;
 
 	/* Protects the lpi_list and the count value below. */
-	spinlock_t		lpi_list_lock;
+	raw_spinlock_t		lpi_list_lock;
 	struct list_head	lpi_list_head;
 	int			lpi_list_count;
 
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 1128e97..330c1ad 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -64,7 +64,7 @@ void kvm_vgic_early_init(struct kvm *kvm)
 	struct vgic_dist *dist = &kvm->arch.vgic;
 
 	INIT_LIST_HEAD(&dist->lpi_list_head);
-	spin_lock_init(&dist->lpi_list_lock);
+	raw_spin_lock_init(&dist->lpi_list_lock);
 }
 
 /* CREATION */
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 911ba61..ab3f477 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -73,7 +73,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	irq->target_vcpu = vcpu;
 	irq->group = 1;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
 	/*
 	 * There could be a race with another vgic_add_lpi(), so we need to
@@ -101,7 +101,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	dist->lpi_list_count++;
 
 out_unlock:
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	/*
 	 * We "cache" the configuration table entries in our struct vgic_irq's.
@@ -332,7 +332,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 	if (!intids)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
 		if (i == irq_count)
 			break;
@@ -341,7 +341,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 			continue;
 		intids[i++] = irq->intid;
 	}
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	*intid_ptr = intids;
 	return i;
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index bc36f2e..ea54a19 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -72,7 +72,7 @@ static struct vgic_irq *vgic_get_lpi(struct kvm *kvm, u32 intid)
 	struct vgic_irq *irq = NULL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
 		if (irq->intid != intid)
@@ -88,7 +88,7 @@ static struct vgic_irq *vgic_get_lpi(struct kvm *kvm, u32 intid)
 	irq = NULL;
 
 out_unlock:
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	return irq;
 }
@@ -138,15 +138,15 @@ void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq)
 	if (irq->intid < VGIC_MIN_LPI)
 		return;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 	if (!kref_put(&irq->refcount, vgic_irq_release)) {
-		spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+		raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 		return;
 	};
 
 	list_del(&irq->lpi_list);
 	dist->lpi_list_count--;
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	kfree(irq);
 }
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

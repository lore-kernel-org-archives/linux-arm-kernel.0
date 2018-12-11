Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D44C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3456820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+yPOmii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3456820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RaAME9A6TPpmelg/zouy8a6YbWCQXcQw9RsRmkdY6NA=; b=H+y
	POmiiM9/gAB8TnA85Jt8WMmAMnhZXyTKg5Im6ZK0DlovKJ+UbPC2fQ2ebP4VdadDiVZA18/+gQKwo
	Fy6de2XLlPWc4xNVpp9CgfaZfhEoPPpUtKfTjUdlkddIrBMA5EPvU6WD7Z0Pblsaf5+CWArjcAW4/
	JNOperuHlq0WQKgmQSK6p560H3hEAhGoRP9JEqupo3mmYVZtITowJafHUXDPPWSzCTlpkwpFP1fk3
	lUKUe6sC7qZXhsc3O/qpO5L2UeZZhgrVd6H1qUg3CZartu+aLrundyYiW5Ax0tnKdNNnEs+H7f1+m
	K9R+RrXQ1cC5kLbomR2yMTe+EY0I3Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWgZO-00044Z-PG; Tue, 11 Dec 2018 11:51:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWgZL-00043g-1j
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:51:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A2BEEBD;
 Tue, 11 Dec 2018 03:51:08 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5463F6A8;
 Tue, 11 Dec 2018 03:51:07 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] KVM: arm/arm64: vgic-v2: Set active_source to 0 when
 restoring state
Date: Tue, 11 Dec 2018 12:51:03 +0100
Message-Id: <20181211115103.12212-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_035119_100608_F7D5CDAF 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Christoffer Dall <christoffer.dall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When restoring the active state from userspace, we don't know which CPU
was the source for the active state, and this is not architecturally
exposed in any of the register state.

Set the active_source to 0 in this case.  In the future, we can expand
on this and exposse the information as additional information to
userspace for GICv2 if anyone cares.

Cc: stable@vger.kernel.org
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index f56ff1cf52ec..2b450d49a046 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -338,11 +338,26 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
 	} else {
 		u32 model = vcpu->kvm->arch.vgic.vgic_model;
+		u8 active_source;
 
 		irq->active = active;
+
+		/*
+		 * The GICv2 architecture indicates that the source CPUID for
+		 * an SGI should be provided during an EOI which implies that
+		 * the active state is stored somewhere, but at the same time
+		 * this state is not architecturally exposed anywhere and we
+		 * have no way of knowing the right source.
+		 *
+		 * This may lead to a VCPU not being able to receive
+		 * additional instances of a particular SGI after migration
+		 * for a GICv2 VM on some GIC implementations.  Oh well.
+		 */
+		active_source = (requester_vcpu) ? requester_vcpu->vcpu_id : 0;
+
 		if (model == KVM_DEV_TYPE_ARM_VGIC_V2 &&
 		    active && vgic_irq_is_sgi(irq->intid))
-			irq->active_source = requester_vcpu->vcpu_id;
+			irq->active_source = active_source;
 	}
 
 	if (irq->active)
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C748BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:30:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9622120700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SLgJ7S2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9622120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L5Wqr9ZcxcJh9u6PCaT9fBBNyoniwpcCn9Rh2di6MAU=; b=SLgJ7S2kT5SPHF
	6Ubzk+nmrFsKyKZboMYwVq2lG7YPiDTcPuJQiQCj3tk4OrmkxCNe/E7ILkr/NuB14MaqnD4JOo5M/
	dTh1aSEmQE/DCak9XliANZ1hJj1rN3T6aqwvpsNOUVBO69xf5m2EDqlnv3QjdfgjNP3hVrqP16YUz
	QjDx6w/e/9UQZNxYCvCpC6U63xuKZj2ZltRyVsIZA9w/w3DFkPvc9J0SkwJ86XqE7yIepK8oNwOyd
	8fY1/KH7RBdsCi7mFEM9zAw0M4Q8dUOBzJOjuDDULmQNPLNOGvJC2zORt/dBVIRLNlXcEe9uim4y2
	j/I7E4qkmQKQGiqazSkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDiT-0003Q1-HC; Fri, 22 Feb 2019 16:30:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDge-0000Gg-4u
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:28:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4F0F1682;
 Fri, 22 Feb 2019 08:28:31 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 A459E3F5C1; Fri, 22 Feb 2019 08:28:27 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 18/27] KVM: arm/arm64: arch_timer: Mark physical interrupt
 active when a virtual interrupt is pending
Date: Fri, 22 Feb 2019 16:25:56 +0000
Message-Id: <20190222162605.5054-19-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082832_341244_B16DD4F4 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When a guest gets scheduled, KVM performs a "load" operation,
which for the timer includes evaluating the virtual "active" state
of the interrupt, and replicating it on the physical side. This
ensures that the deactivation in the guest will also take place
in the physical GIC distributor.

If the interrupt is not yet active, we flag it as inactive on the
physical side.  This means that on restoring the timer registers,
if the timer has expired, we'll immediately take an interrupt.
That's absolutely fine, as the interrupt will then be flagged as
active on the physical side. What this assumes though is that we'll
enter the guest right after having taken the interrupt, and that
the guest will quickly ACK the interrupt, making it active at on
the virtual side.

It turns out that quite often, this assumption doesn't really hold.
The guest may be preempted on the back on this interrupt, either
from kernel space or whilst running at EL1 when a host interrupt
fires. When this happens, we repeat the whole sequence on the
next load (interrupt marked as inactive, timer registers restored,
interrupt fires). And if it takes a really long time for a guest
to activate the interrupt (as it does with nested virt), we end-up
with many such events in quick succession, leading to the guest only
making very slow progress.

This can also be seen with the number of virtual timer interrupt on the
host being far greater than the same number in the guest.

An easy way to fix this is to evaluate the timer state when performing
the "load" operation, just like we do when the interrupt actually fires.
If the timer has a pending virtual interrupt at this stage, then we
can safely flag the physical interrupt as being active, which prevents
spurious exits.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/arch_timer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 17f9de73cc8a..af8f2f1d01cc 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -487,12 +487,21 @@ static inline void set_timer_irq_phys_active(struct arch_timer_context *ctx, boo
 static void kvm_timer_vcpu_load_gic(struct arch_timer_context *ctx)
 {
 	struct kvm_vcpu *vcpu = ctx->vcpu;
-	bool phys_active;
+	bool phys_active = false;
+
+	/*
+	 * Update the timer output so that it is likely to match the
+	 * state we're about to restore. If the timer expires between
+	 * this point and the register restoration, we'll take the
+	 * interrupt anyway.
+	 */
+	kvm_timer_update_irq(ctx->vcpu, kvm_timer_should_fire(ctx), ctx);
 
 	if (irqchip_in_kernel(vcpu->kvm))
 		phys_active = kvm_vgic_map_is_active(vcpu, ctx->irq.irq);
-	else
-		phys_active = ctx->irq.level;
+
+	phys_active |= ctx->irq.level;
+
 	set_timer_irq_phys_active(ctx, phys_active);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

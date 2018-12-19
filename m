Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52EAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A01217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gsevV1pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A01217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GrBRxI2jc3+iTkpg0Dda4AtuO/esPcRmGaP4yQID7mM=; b=gsevV1pIpa8m/5
	L6iKXGanOMFhG8JnlBdrwdLSTj7g1G1FA0byLSgdVc0aJ3i7b55x5zg53f6fV0IxqAwHgDzuRlYbH
	DuADjcEwktxu0406zldsJTPScxh10RwPVnevNy9735l3HJm0NYexappatRyRYgFFiOEM0ZeEVECFS
	GUYvZGbrOApu+nP5JMPvnknuAoAylaKkHxPDgi0pe1APUEfub8XFQc7zbM+mqjboc/xellpzutuP0
	lHYrI4db1/yEBnU7Y2ruk9+qFVWs8H6osrs/Qm0bEmDca5t6UTb1r63WUFINXMixcks0UsdmOEynV
	T8PGdPhSywrLu/VXHBkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgH0-0002nG-5r; Wed, 19 Dec 2018 18:08:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDR-0006Ks-4B
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13BDA165C;
 Wed, 19 Dec 2018 10:05:05 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8884B3F675;
 Wed, 19 Dec 2018 10:05:02 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 20/28] KVM: arm/arm64: Remove arch timer workqueue
Date: Wed, 19 Dec 2018 18:03:41 +0000
Message-Id: <20181219180349.242681-21-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100506_660695_936F8E0A 
X-CRM114-Status: GOOD (  17.15  )
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

From: Christoffer Dall <christoffer.dall@arm.com>

The use of a work queue in the hrtimer expire function for the bg_timer
is a leftover from the time when we would inject interrupts when the
bg_timer expired.

Since we are no longer doing that, we can instead call
kvm_vcpu_wake_up() directly from the hrtimer function and remove all
workqueue functionality from the arch timer code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_arch_timer.h |  4 ----
 virt/kvm/arm/arch_timer.c    | 34 +++++++---------------------------
 2 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 6502feb9524b..33771352dcd6 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -21,7 +21,6 @@
 
 #include <linux/clocksource.h>
 #include <linux/hrtimer.h>
-#include <linux/workqueue.h>
 
 struct arch_timer_context {
 	/* Registers: control register, timer value */
@@ -52,9 +51,6 @@ struct arch_timer_cpu {
 	/* Background timer used when the guest is not running */
 	struct hrtimer			bg_timer;
 
-	/* Work queued with the above timer expires */
-	struct work_struct		expired;
-
 	/* Physical timer emulation */
 	struct hrtimer			phys_timer;
 
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 17cecc96f735..da261f5e2a91 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -70,11 +70,9 @@ static void soft_timer_start(struct hrtimer *hrt, u64 ns)
 		      HRTIMER_MODE_ABS);
 }
 
-static void soft_timer_cancel(struct hrtimer *hrt, struct work_struct *work)
+static void soft_timer_cancel(struct hrtimer *hrt)
 {
 	hrtimer_cancel(hrt);
-	if (work)
-		cancel_work_sync(work);
 }
 
 static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
@@ -102,23 +100,6 @@ static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Work function for handling the backup timer that we schedule when a vcpu is
- * no longer running, but had a timer programmed to fire in the future.
- */
-static void kvm_timer_inject_irq_work(struct work_struct *work)
-{
-	struct kvm_vcpu *vcpu;
-
-	vcpu = container_of(work, struct kvm_vcpu, arch.timer_cpu.expired);
-
-	/*
-	 * If the vcpu is blocked we want to wake it up so that it will see
-	 * the timer has expired when entering the guest.
-	 */
-	kvm_vcpu_wake_up(vcpu);
-}
-
 static u64 kvm_timer_compute_delta(struct arch_timer_context *timer_ctx)
 {
 	u64 cval, now;
@@ -188,7 +169,7 @@ static enum hrtimer_restart kvm_bg_timer_expire(struct hrtimer *hrt)
 		return HRTIMER_RESTART;
 	}
 
-	schedule_work(&timer->expired);
+	kvm_vcpu_wake_up(vcpu);
 	return HRTIMER_NORESTART;
 }
 
@@ -300,7 +281,7 @@ static void phys_timer_emulate(struct kvm_vcpu *vcpu)
 	 * then we also don't need a soft timer.
 	 */
 	if (kvm_timer_should_fire(ptimer) || !kvm_timer_irq_can_fire(ptimer)) {
-		soft_timer_cancel(&timer->phys_timer, NULL);
+		soft_timer_cancel(&timer->phys_timer);
 		return;
 	}
 
@@ -426,7 +407,7 @@ void kvm_timer_unschedule(struct kvm_vcpu *vcpu)
 
 	vtimer_restore_state(vcpu);
 
-	soft_timer_cancel(&timer->bg_timer, &timer->expired);
+	soft_timer_cancel(&timer->bg_timer);
 }
 
 static void set_cntvoff(u64 cntvoff)
@@ -544,7 +525,7 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 	 * In any case, we re-schedule the hrtimer for the physical timer when
 	 * coming back to the VCPU thread in kvm_timer_vcpu_load().
 	 */
-	soft_timer_cancel(&timer->phys_timer, NULL);
+	soft_timer_cancel(&timer->phys_timer);
 
 	/*
 	 * The kernel may decide to run userspace after calling vcpu_put, so
@@ -637,7 +618,6 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
 	vcpu_ptimer(vcpu)->cntvoff = 0;
 
-	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
 	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	timer->bg_timer.function = kvm_bg_timer_expire;
 
@@ -794,8 +774,8 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 
-	soft_timer_cancel(&timer->bg_timer, &timer->expired);
-	soft_timer_cancel(&timer->phys_timer, NULL);
+	soft_timer_cancel(&timer->bg_timer);
+	soft_timer_cancel(&timer->phys_timer);
 	kvm_vgic_unmap_phys_irq(vcpu, vtimer->irq.irq);
 }
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

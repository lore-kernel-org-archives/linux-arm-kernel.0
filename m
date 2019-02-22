Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE07FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E8E2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kF67vjmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E8E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VmdRBPlf21kr6be+vLq813Cx8W5uVql8DppljVz1om0=; b=kF67vjmtxT1UK2
	qJV7GvBn/uJphoi0KGzoLNsDoJ5n940/dEHAMMMTrwQySr+17TQ/Km8jcU9IPRtHAvixiFJ8QM/6J
	kgUizH7IRqB7Vjz1p4NNlTv27HRiesKQIIR2JOtwJf2DnuBNg6dom7CPP17821EyxorGjDL9Wasos
	V5Ocli8uznp4DVJs3iPg0cu38PEYfNuh0jPX+/vzQQwmqOADkaVkouMPbq97WoVhi1MPK5rn0pI1y
	Y5Rup1owmqLhZSdC1QHuaeHbXKs1BdSqhTTV1SmCTWNC8xj4ODi5gL5OrH9bdCFaiHiRZGP6U2tS/
	SB2hoi1oSJcLneggzv0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDh7-0000W1-1b; Fri, 22 Feb 2019 16:29:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDfm-0007eF-RI
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:27:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59E3165C;
 Fri, 22 Feb 2019 08:27:37 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 AA2893F5C1; Fri, 22 Feb 2019 08:27:32 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 08/27] KVM: arm/arm64: Simplify bg_timer programming
Date: Fri, 22 Feb 2019 16:25:46 +0000
Message-Id: <20190222162605.5054-9-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082739_090155_DF20CF81 
X-CRM114-Status: GOOD (  14.26  )
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

From: Christoffer Dall <christoffer.dall@arm.com>

Instead of calling into kvm_timer_[un]schedule from the main kvm
blocking path, test if the VCPU is on the wait queue from the load/put
path and perform the background timer setup/cancel in this path.

This has the distinct advantage that we no longer race between load/put
and schedule/unschedule and programming and canceling of the bg_timer
always happens when the timer state is not loaded.

Note that we must now remove the checks in kvm_timer_blocking that do
not schedule a background timer if one of the timers can fire, because
we no longer have a guarantee that kvm_vcpu_check_block() will be called
before kvm_timer_blocking.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_arch_timer.h |  3 ---
 virt/kvm/arm/arch_timer.c    | 35 ++++++++++++++---------------------
 virt/kvm/arm/arm.c           |  2 --
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 33771352dcd6..d6e6a45d1d24 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -76,9 +76,6 @@ int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 
 bool kvm_timer_is_pending(struct kvm_vcpu *vcpu);
 
-void kvm_timer_schedule(struct kvm_vcpu *vcpu);
-void kvm_timer_unschedule(struct kvm_vcpu *vcpu);
-
 u64 kvm_phys_timer_read(void);
 
 void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index b07ac4614e1c..4986028d9829 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -349,22 +349,12 @@ static void vtimer_save_state(struct kvm_vcpu *vcpu)
  * thread is removed from its waitqueue and made runnable when there's a timer
  * interrupt to handle.
  */
-void kvm_timer_schedule(struct kvm_vcpu *vcpu)
+static void kvm_timer_blocking(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
-	vtimer_save_state(vcpu);
-
-	/*
-	 * No need to schedule a background timer if any guest timer has
-	 * already expired, because kvm_vcpu_block will return before putting
-	 * the thread to sleep.
-	 */
-	if (kvm_timer_should_fire(vtimer) || kvm_timer_should_fire(ptimer))
-		return;
-
 	/*
 	 * If both timers are not capable of raising interrupts (disabled or
 	 * masked), then there's no more work for us to do.
@@ -373,12 +363,19 @@ void kvm_timer_schedule(struct kvm_vcpu *vcpu)
 		return;
 
 	/*
-	 * The guest timers have not yet expired, schedule a background timer.
+	 * At least one guest time will expire. Schedule a background timer.
 	 * Set the earliest expiration time among the guest timers.
 	 */
 	soft_timer_start(&timer->bg_timer, kvm_timer_earliest_exp(vcpu));
 }
 
+static void kvm_timer_unblocking(struct kvm_vcpu *vcpu)
+{
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
+
+	soft_timer_cancel(&timer->bg_timer);
+}
+
 static void vtimer_restore_state(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
@@ -401,15 +398,6 @@ static void vtimer_restore_state(struct kvm_vcpu *vcpu)
 	local_irq_restore(flags);
 }
 
-void kvm_timer_unschedule(struct kvm_vcpu *vcpu)
-{
-	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
-
-	vtimer_restore_state(vcpu);
-
-	soft_timer_cancel(&timer->bg_timer);
-}
-
 static void set_cntvoff(u64 cntvoff)
 {
 	u32 low = lower_32_bits(cntvoff);
@@ -485,6 +473,8 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
 	/* Set the background timer for the physical timer emulation. */
 	phys_timer_emulate(vcpu);
 
+	kvm_timer_unblocking(vcpu);
+
 	/* If the timer fired while we weren't running, inject it now */
 	if (kvm_timer_should_fire(ptimer) != ptimer->irq.level)
 		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
@@ -527,6 +517,9 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 	 */
 	soft_timer_cancel(&timer->phys_timer);
 
+	if (swait_active(kvm_arch_vcpu_wq(vcpu)))
+		kvm_timer_blocking(vcpu);
+
 	/*
 	 * The kernel may decide to run userspace after calling vcpu_put, so
 	 * we reset cntvoff to 0 to ensure a consistent read between user
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index b77db673bb03..9fbdb9e1c51f 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -335,13 +335,11 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	kvm_timer_schedule(vcpu);
 	kvm_vgic_v4_enable_doorbell(vcpu);
 }
 
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
-	kvm_timer_unschedule(vcpu);
 	kvm_vgic_v4_disable_doorbell(vcpu);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

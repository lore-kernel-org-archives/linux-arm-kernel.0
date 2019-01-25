Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D81C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:48:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86F02082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="laItL8T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86F02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rnjvUrSph5ngWcLHKwNlG8EldV2D0tmirM9VMj0hQak=; b=laItL8T2A5maYMeRH1SQo3mphA
	D629Y0Br5/m/hxdTSEfUo0fFS13E6F3516cjqC5muZYwvVJGxhmKNLq7nLJRKyzS7J6vFDoLF4/YU
	PB+3R61agqpMbvcCSl5OWjRjFrkc/NThxAnzUm2hcwSXBolTMK0PbiOEX/HvcYJEVlO9H4hJSgQ2y
	3J3up2e0CB7X9hixeZFZh/XU2fUQ591/d0V7XK1SkaAGKyCNWykG7etpIR/tLoU+5EAkjytwi+fQA
	1ztcDc9xwI7Lp7q/QGCd4F3iEpE5EmN8fCO9D+CZlRmQosweFJLV5OThVCLWTyhoGxHF0eXq2o0Pa
	cS7jPuow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmy5e-0004Bn-E2; Fri, 25 Jan 2019 09:47:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmy4q-0003DD-81
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:47:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA92D1650;
 Fri, 25 Jan 2019 01:47:07 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549933F589;
 Fri, 25 Jan 2019 01:47:07 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] KVM: arm/arm64: Require VCPU threads to turn them self off
Date: Fri, 25 Jan 2019 10:46:54 +0100
Message-Id: <20190125094656.5026-4-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125094656.5026-1-christoffer.dall@arm.com>
References: <20190125094656.5026-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014708_726046_87B89DC4 
X-CRM114-Status: GOOD (  11.20  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To avoid a race between turning VCPUs off and turning them on, make sure
that only the VCPU threat itself turns off the VCPU.  When other threads
want to turn of a VCPU, they now do this via a request.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  2 ++
 arch/arm64/include/asm/kvm_host.h |  2 ++
 virt/kvm/arm/arm.c                |  8 ++++++--
 virt/kvm/arm/psci.c               | 11 ++---------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 50e89869178a..b1cfae222441 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -49,6 +49,8 @@
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
 #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
+#define KVM_REQ_VCPU_OFF \
+	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index da3fc7324d68..d43b13421987 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -49,6 +49,8 @@
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
 #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
+#define KVM_REQ_VCPU_OFF \
+	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 9c486fad3f9f..785076176814 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -404,8 +404,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 static void vcpu_power_off(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.power_off = true;
-	kvm_make_request(KVM_REQ_SLEEP, vcpu);
+	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
 	kvm_vcpu_kick(vcpu);
 }
 
@@ -646,6 +645,11 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
 			vcpu_req_sleep(vcpu);
 
+		if (kvm_check_request(KVM_REQ_VCPU_OFF, vcpu)) {
+			vcpu->arch.power_off = true;
+			vcpu_req_sleep(vcpu);
+		}
+
 		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
 			kvm_reset_vcpu(vcpu);
 
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index b9cff1d4b06d..20255319e193 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -97,9 +97,7 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
 
 static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.power_off = true;
-	kvm_make_request(KVM_REQ_SLEEP, vcpu);
-	kvm_vcpu_kick(vcpu);
+	kvm_make_request(KVM_REQ_VCPU_OFF, vcpu);
 }
 
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
@@ -198,9 +196,6 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 
 static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 {
-	int i;
-	struct kvm_vcpu *tmp;
-
 	/*
 	 * The KVM ABI specifies that a system event exit may call KVM_RUN
 	 * again and may perform shutdown/reboot at a later time that when the
@@ -210,9 +205,7 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 	 * after this call is handled and before the VCPUs have been
 	 * re-initialized.
 	 */
-	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
-		tmp->arch.power_off = true;
-	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
+	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_VCPU_OFF);
 
 	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
 	vcpu->run->system_event.type = type;
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC64C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D462175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vERT9Lb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D462175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrat9lBv0LZhOyLONyXFxmrQpL1YyPOa1alVRFNNbrY=; b=vERT9Lb8TK6uQk
	0lBJVVyKQdBlT5q168fLpaVVBqj+wuw6PiLs0TqitKS0oG0nOzBwsHAOaV0yeesJBnU7/e1qPSm3j
	JZrB0aqXkbJEf6pS7bJmRzBZJ4f/LpC9viibV+K8yTkGyE1QWSczwQVUXxm1yO0l5b7FH9A6sDaO8
	l3ifAOFRe1JQwU4Nal4cRW22Vb/A6i1tJyC5MxFRIVmj7vzUqRJl96b8hRL8yRPW8erXwEMXcWpF0
	kjajTGsh6aymQ/gZTQysAn2VO0yTmLTF4hpwF3L+k6bFpGuGEqYykMldxp6v1czMoJMFbbo0gjDKa
	TY5J9ZFdceYqZz3hD39Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjcn-0005un-VW; Thu, 07 Feb 2019 13:21:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjaI-0002LE-Q1
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:19:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219D3A78;
 Thu,  7 Feb 2019 05:19:18 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDBA3F675;
 Thu,  7 Feb 2019 05:19:15 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 08/11] KVM: arm/arm64: vgic: Always initialize the group of
 private IRQs
Date: Thu,  7 Feb 2019 13:18:40 +0000
Message-Id: <20190207131843.157210-9-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207131843.157210-1-marc.zyngier@arm.com>
References: <20190207131843.157210-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_051919_793239_D5FADBC3 
X-CRM114-Status: GOOD (  16.20  )
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

From: Christoffer Dall <christoffer.dall@arm.com>

We currently initialize the group of private IRQs during
kvm_vgic_vcpu_init, and the value of the group depends on the GIC model
we are emulating.  However, CPUs created before creating (and
initializing) the VGIC might end up with the wrong group if the VGIC
is created as GICv3 later.

Since we have no enforced ordering of creating the VGIC and creating
VCPUs, we can end up with part the VCPUs being properly intialized and
the remaining incorrectly initialized.  That also means that we have no
single place to do the per-cpu data structure initialization which
depends on knowing the emulated GIC model (which is only the group
field).

This patch removes the incorrect comment from kvm_vgic_vcpu_init and
initializes the group of all previously created VCPUs's private
interrupts in vgic_init in addition to the existing initialization in
kvm_vgic_vcpu_init.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-init.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index dfbfcb1fe933..3bdb31eaed64 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -231,13 +231,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 			irq->config = VGIC_CONFIG_LEVEL;
 		}
 
-		/*
-		 * GICv3 can only be created via the KVM_DEVICE_CREATE API and
-		 * so we always know the emulation type at this point as it's
-		 * either explicitly configured as GICv3, or explicitly
-		 * configured as GICv2, or not configured yet which also
-		 * implies GICv2.
-		 */
 		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
 			irq->group = 1;
 		else
@@ -281,7 +274,7 @@ int vgic_init(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
-	int ret = 0, i;
+	int ret = 0, i, idx;
 
 	if (vgic_initialized(kvm))
 		return 0;
@@ -298,6 +291,19 @@ int vgic_init(struct kvm *kvm)
 	if (ret)
 		goto out;
 
+	/* Initialize groups on CPUs created before the VGIC type was known */
+	kvm_for_each_vcpu(idx, vcpu, kvm) {
+		struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+
+		for (i = 0; i < VGIC_NR_PRIVATE_IRQS; i++) {
+			struct vgic_irq *irq = &vgic_cpu->private_irqs[i];
+			if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+				irq->group = 1;
+			else
+				irq->group = 0;
+		}
+	}
+
 	if (vgic_has_its(kvm)) {
 		ret = vgic_v4_init(kvm);
 		if (ret)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

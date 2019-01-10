Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E00C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:34:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24327214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jj/9jsdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24327214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=165v5ZQ0s+wMRlf7osiAsv4esWaXQ6xYcQuY1CRcY4Q=; b=jj/
	9jsdru49+JQAgnu7M6k37wHVo9mg02S3Ycncmx+AoLZBk/KaFrL/vCJcJryiquyT9Swk6nnrUNCx7
	VSTSpWjP0bBmElEA2LOexcNQS0fFBxpafjo4NyRCaGRlOnVxIEGzjPgq0rw+WZoIKBDe9xEl3LTgo
	dAm2Y0VMJi/iDaBOS6u6Gmp7+bI9WNGxAbGwMTFNlPhgx8fHrdSzdTivUnIC8c6kXrlG9lAMBoxd3
	/mK3LCmWrk7AFirTGOh5+gXo2KwUQAencFMUmqCvsma2DY3CoZ4jDn26ofxV9RElokhlyIIx4eNIo
	0mxwj0nSqRRXsF4E46+txH4v3u9vfrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbPG-000205-0U; Thu, 10 Jan 2019 14:34:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbPC-0001zB-GZ
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:34:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C4B1596;
 Thu, 10 Jan 2019 06:33:56 -0800 (PST)
Received: from localhost (chrdal02-desktop.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 CD3E33F5AF; Thu, 10 Jan 2019 06:33:55 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] KVM: arm/arm64: vgic: Always initialize the group of private
 IRQs
Date: Thu, 10 Jan 2019 15:33:52 +0100
Message-Id: <20190110143352.17295-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_063358_563957_D0E2A176 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Julien Thierry <julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

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
---
I tested this by modifying kvmtool to create the vgic in the middle of creating
the VCPUs, and looking in /sys/kernel/debug/kvm/<pid>/vgic-state showed the
first VCPU with private interrupts with group 0 for gicv3 and the secondary
VCPU with group 1 prior to this patch, and both VCPUs with group 1 following
this patch for GICv3 and both with group 0 with GICv2.

diff --git a/arm/kvm.c b/arm/kvm.c
index b824f63..c6c5fbc 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -82,10 +82,6 @@ void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
 
 	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
 		MADV_HUGEPAGE);
-
-	/* Create the virtual GIC. */
-	if (gic__create(kvm, kvm->cfg.arch.irqchip))
-		die("Failed to create virtual GIC");
 }
 
 #define FDT_ALIGN	SZ_2M
diff --git a/kvm-cpu.c b/kvm-cpu.c
index cc8385f..7a2fde0 100644
--- a/kvm-cpu.c
+++ b/kvm-cpu.c
@@ -253,6 +253,7 @@ panic_kvm:
 int kvm_cpu__init(struct kvm *kvm)
 {
 	int max_cpus, recommended_cpus, i;
+	bool gic_created = false;
 
 	max_cpus = kvm__max_cpus(kvm);
 	recommended_cpus = kvm__recommended_cpus(kvm);
@@ -281,6 +282,12 @@ int kvm_cpu__init(struct kvm *kvm)
 	}
 
 	for (i = 0; i < kvm->nrcpus; i++) {
+		if (i == 1) {
+			/* Create the virtual GIC. */
+			if (gic__create(kvm, kvm->cfg.arch.irqchip))
+				die("Failed to create virtual GIC");
+			gic_created = true;
+		}
 		kvm->cpus[i] = kvm_cpu__arch_init(kvm, i);
 		if (!kvm->cpus[i]) {
 			pr_warning("unable to initialize KVM VCPU");
@@ -288,6 +295,10 @@ int kvm_cpu__init(struct kvm *kvm)
 		}
 	}
 
+	/* Create the virtual GIC. */
+	if (!gic_created && gic__create(kvm, kvm->cfg.arch.irqchip))
+		die("Failed to create virtual GIC");
+
 	return 0;
 
 fail_alloc:

 virt/kvm/arm/vgic/vgic-init.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index c0c0b88af1d5..f935adc50626 100644
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
@@ -298,6 +291,19 @@ int vgic_init(struct kvm *kvm)
 	if (ret)
 		goto out;
 
+	/* Initialize groups on CPUs created before the VGIC type was known */
+	kvm_for_each_vcpu(i, vcpu, kvm) {
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
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

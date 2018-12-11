Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D778FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:24:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CD320849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lN3sc2G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CD320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eIoTkvsKOL4MfzQ1A7fPi8sL5DUwQof9EOTJ5PQ3dGM=; b=lN3
	sc2G02MHhRyeOxxQJaTxEDJFlAeu0Dpllc76F3AEpX15omrPu1nHZDbEZJOoXrE7ZzwcmM/bmEU4m
	3FGwd7p+ixbeN8GYnPecwcyrrEAE+xaqyJIOivp67tsR9BV4SnMZxiSMIAF9SuDQJLHgobfrzC+LM
	b81+yBUwa9I5BuDekmW7wC8py6s7tn4yNfY/afV5zGcC4CRONtWzu95tdaG6vYJeeNNczIDJ6uXUx
	zEPNXr+SiodFvuSjVNv60RdVkmkn7FlcV+rlWr03zHWrmLD2rc5ebju0O4y0VEnrVkW+FvcIK6kKj
	w3LglEM/t0nul3fcdJJ2rwpnAp5I5Ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWh5H-00083Y-Pi; Tue, 11 Dec 2018 12:24:19 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWh5D-00082O-JI
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:24:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B9CEBD;
 Tue, 11 Dec 2018 04:24:04 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE0373F6A8;
 Tue, 11 Dec 2018 04:24:03 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less
Date: Tue, 11 Dec 2018 13:23:57 +0100
Message-Id: <20181211122357.15320-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_042415_649681_28ED3C70 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: kvm@vger.kernel.org, julien.thierry@arm.com,
 Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, stable@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We recently addressed a VMID generation race by introducing a read/write
lock around accesses and updates to the vmid generation values.

However, kvm_arch_vcpu_ioctl_run() also calls need_new_vmid_gen() but
does so without taking the read lock.

As far as I can tell, this can lead to the same kind of race:

  VM 0, VCPU 0			VM 0, VCPU 1
  ------------			------------
  update_vttbr (vmid 254)
  				update_vttbr (vmid 1) // roll over
				read_lock(kvm_vmid_lock);
				force_vm_exit()
  local_irq_disable
  need_new_vmid_gen == false //because vmid gen matches

  enter_guest (vmid 254)
  				kvm_arch.vttbr = <PGD>:<VMID 1>
				read_unlock(kvm_vmid_lock);

  				enter_guest (vmid 1)

Which results in running two VCPUs in the same VM with different VMIDs
and (even worse) other VCPUs from other VMs could now allocate clashing
VMID 254 from the new generation as long as VCPU 0 is not exiting.

Attempt to solve this by making sure vttbr is updated before another CPU
can observe the updated VMID generation.

Cc: stable@vger.kernel.org
Fixes: f0cf47d939d0 "KVM: arm/arm64: Close VMID generation race"
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 virt/kvm/arm/arm.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 23774970c9df..abcd29db2d7a 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -66,7 +66,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
 static unsigned int kvm_vmid_bits __read_mostly;
-static DEFINE_RWLOCK(kvm_vmid_lock);
+static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
@@ -484,7 +484,9 @@ void force_vm_exit(const cpumask_t *mask)
  */
 static bool need_new_vmid_gen(struct kvm *kvm)
 {
-	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
+	u64 current_vmid_gen = atomic64_read(&kvm_vmid_gen);
+	smp_rmb(); /* Orders read of kvm_vmid_gen and kvm->arch.vmid */
+	return unlikely(READ_ONCE(kvm->arch.vmid_gen) != current_vmid_gen);
 }
 
 /**
@@ -499,16 +501,11 @@ static void update_vttbr(struct kvm *kvm)
 {
 	phys_addr_t pgd_phys;
 	u64 vmid, cnp = kvm_cpu_has_cnp() ? VTTBR_CNP_BIT : 0;
-	bool new_gen;
 
-	read_lock(&kvm_vmid_lock);
-	new_gen = need_new_vmid_gen(kvm);
-	read_unlock(&kvm_vmid_lock);
-
-	if (!new_gen)
+	if (!need_new_vmid_gen(kvm))
 		return;
 
-	write_lock(&kvm_vmid_lock);
+	spin_lock(&kvm_vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -516,7 +513,7 @@ static void update_vttbr(struct kvm *kvm)
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		write_unlock(&kvm_vmid_lock);
+		spin_unlock(&kvm_vmid_lock);
 		return;
 	}
 
@@ -539,7 +536,6 @@ static void update_vttbr(struct kvm *kvm)
 		kvm_call_hyp(__kvm_flush_vm_context);
 	}
 
-	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
 	kvm->arch.vmid = kvm_next_vmid;
 	kvm_next_vmid++;
 	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
@@ -550,7 +546,10 @@ static void update_vttbr(struct kvm *kvm)
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
 	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid | cnp;
 
-	write_unlock(&kvm_vmid_lock);
+	smp_wmb();
+	WRITE_ONCE(kvm->arch.vmid_gen, atomic64_read(&kvm_vmid_gen));
+
+	spin_unlock(&kvm_vmid_lock);
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

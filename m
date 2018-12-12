Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3701E20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SsAIZc2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3701E20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d3RxlXCg7+up6WYXYOpXTjr2IkIemdXczKNsxEN+aDg=; b=SsAIZc2RQXOjHe
	WXv7M1pYlwunlsvRXpzlZ5a4OFx622k3W8F/ArMrhyYo8Nk9R7brK336pkZGEhoEGaqtMKtQDUmjO
	jSREFEUqv1B7FggTGwhmvnvGaYd8D4OEwIUmK5IiyhGwjlpIFW3uT9GVvyE0nM4fcLAKs47Akjk0s
	mJbgHAx72LiOhzMFUGQSvpkNCXKvXYdHHTm7jC2ebITAgxy/VHeBZT23jAfrfUbAR09s9ZBQjatgK
	dTNGrG358OCIn7Pa+4AY8Cs1cUv5tSTxiPaaAf5mGdsz6xCVbNHZ20gyYbKrsj67FX3bjdPXaXCDX
	7LgqoTE5aI6KZp25JS6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX64E-0008Eu-Ee; Wed, 12 Dec 2018 15:04:54 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62e-0006W0-Fa
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D270015AB;
 Wed, 12 Dec 2018 07:03:14 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5793A3F59C;
 Wed, 12 Dec 2018 07:03:13 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 09/12] KVM: arm64: Provide a PV_TIME device to user
 space
Date: Wed, 12 Dec 2018 15:02:23 +0000
Message-Id: <20181212150226.38051-10-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070317_501813_C33578A6 
X-CRM114-Status: GOOD (  23.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allow user space to inform the KVM host where in the physical memory
map the paravirtualized time structures should be located.

A single device is created which provides two base addresses. One
is the base of the Live Physical Time (LPT) structure shared with
the guest. This must be 64 bytes long.

The other is the base of an array of Stolen Time (ST) structures,
one for each VCPU. There must be (64 * total number of VCPUs) bytes
of memory available at this location.

The addresses are given in terms of the physical address visible to
the guest and must be 64 byte aligned. The memory should be marked as
reserved to the guest to stop it allocating it for other purposes.

A method is also provided to change the paravirtualized clock
frequency seen by a guest. This can only be changed before the guest
has been started, otherwise the guest will become confused.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h  |   2 +
 arch/arm64/include/uapi/asm/kvm.h |   6 +
 arch/arm64/kvm/Makefile           |   1 +
 include/uapi/linux/kvm.h          |   2 +
 virt/kvm/arm/mmu.c                |  44 +++++++
 virt/kvm/arm/pvtime.c             | 189 ++++++++++++++++++++++++++++++
 6 files changed, 244 insertions(+)
 create mode 100644 virt/kvm/arm/pvtime.c

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 658657367f2f..3c266521223a 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -167,6 +167,8 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 			  phys_addr_t pa, unsigned long size, bool writable);
+int kvm_phys_addr_memremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size, bool writable);
 
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 97c3478ee6e7..e1d42ff35430 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -307,6 +307,12 @@ struct kvm_vcpu_events {
 #define KVM_PSCI_RET_INVAL		PSCI_RET_INVALID_PARAMS
 #define KVM_PSCI_RET_DENIED		PSCI_RET_DENIED
 
+/* Device Control API: PV_TIME */
+#define KVM_DEV_ARM_PV_TIME_PADDR	0
+#define  KVM_DEV_ARM_PV_TIME_ST		0
+#define KVM_DEV_ARM_PV_TIME_STATE_SIZE	1
+#define KVM_DEV_ARM_PV_TIME_STATE	2
+
 #endif
 
 #endif /* __ARM_KVM_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 45bb68f6c161..a3f064f0a51d 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -16,6 +16,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/e
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/arm.o $(KVM)/arm/mmu.o $(KVM)/arm/mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/psci.o $(KVM)/arm/perf.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hypercalls.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/pvtime.o
 
 kvm-$(CONFIG_KVM_ARM_HOST) += inject_fault.o regmap.o va_layout.o
 kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652c9fa4..494f7ad7987e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1198,6 +1198,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
 	KVM_DEV_TYPE_ARM_VGIC_ITS,
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
+	KVM_DEV_TYPE_ARM_PV_TIME,
+#define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_MAX,
 };
 
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5eca48bdb1a6..17ec31c40039 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1227,6 +1227,50 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	return ret;
 }
 
+/**
+ * kvm_phys_addr_memremap - map a memory range to guest IPA
+ *
+ * @kvm:	The KVM pointer
+ * @guest_ipa:	The IPA at which to insert the mapping
+ * @pa:		The physical address of the memory
+ * @size:	The size of the mapping
+ */
+int kvm_phys_addr_memremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size, bool writable)
+{
+	phys_addr_t addr, end;
+	int ret = 0;
+	unsigned long pfn;
+	struct kvm_mmu_memory_cache cache = { 0, };
+
+	end = (guest_ipa + size + PAGE_SIZE - 1) & PAGE_MASK;
+	pfn = __phys_to_pfn(pa);
+
+	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
+		pte_t pte = pfn_pte(pfn, PAGE_S2);
+
+		if (writable)
+			pte = kvm_s2pte_mkwrite(pte);
+
+		ret = mmu_topup_memory_cache(&cache,
+					     kvm_mmu_cache_min_pages(kvm),
+					     KVM_NR_MEM_OBJS);
+		if (ret)
+			goto out;
+		spin_lock(&kvm->mmu_lock);
+		ret = stage2_set_pte(kvm, &cache, addr, &pte, 0);
+		spin_unlock(&kvm->mmu_lock);
+		if (ret)
+			goto out;
+
+		pfn++;
+	}
+
+out:
+	mmu_free_memory_cache(&cache);
+	return ret;
+}
+
 static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 {
 	kvm_pfn_t pfn = *pfnp;
diff --git a/virt/kvm/arm/pvtime.c b/virt/kvm/arm/pvtime.c
new file mode 100644
index 000000000000..e033f55e3ee4
--- /dev/null
+++ b/virt/kvm/arm/pvtime.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Arm Ltd.
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_mmu.h>
+
+/* We currently only support PV time on ARM64 */
+#ifdef CONFIG_ARM64
+
+#include <asm/pvclock-abi.h>
+
+static int max_stolen_size(void)
+{
+	int size = KVM_MAX_VCPUS * sizeof(struct pvclock_vcpu_stolen_time_info);
+
+	return ALIGN(size, PAGE_SIZE);
+}
+
+static int kvm_arm_pvtime_create(struct kvm_device *dev, u32 type)
+{
+	struct kvm_arch_pvtime *pvtime = &dev->kvm->arch.pvtime;
+
+	pvtime->st = alloc_pages_exact(max_stolen_size(),
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!pvtime->st)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void kvm_arm_pvtime_destroy(struct kvm_device *dev)
+{
+	struct kvm_arch_pvtime *pvtime = &dev->kvm->arch.pvtime;
+
+	pvtime->st_base = GPA_INVALID;
+	free_pages_exact(pvtime->st, max_stolen_size());
+}
+
+static int pvtime_map_pages(struct kvm *kvm, gpa_t guest_paddr,
+			    void *kaddr, int size)
+{
+	return kvm_phys_addr_memremap(kvm, guest_paddr,
+			virt_to_phys(kaddr),
+			size, false);
+}
+
+static int pvtime_save_state(struct kvm *kvm, u64 type, void __user *user)
+{
+	void *source;
+	size_t size;
+
+	switch (type) {
+	case KVM_DEV_ARM_PV_TIME_ST:
+		source = kvm->arch.pvtime.st;
+		size = sizeof(struct pvclock_vcpu_stolen_time_info) *
+			atomic_read(&kvm->online_vcpus);
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	if (copy_to_user(user, source, size))
+		return -EFAULT;
+	return 0;
+}
+
+static int pvtime_restore_state(struct kvm *kvm, u64 type, void __user *user)
+{
+	void *dest;
+	size_t size;
+
+	switch (type) {
+	case KVM_DEV_ARM_PV_TIME_ST:
+		dest = kvm->arch.pvtime.st;
+		size = sizeof(struct pvclock_vcpu_stolen_time_info) *
+			atomic_read(&kvm->online_vcpus);
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	if (copy_from_user(dest, user, size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_arm_pvtime_set_attr(struct kvm_device *dev,
+				   struct kvm_device_attr *attr)
+{
+	struct kvm_arch_pvtime *pvtime = &dev->kvm->arch.pvtime;
+	u64 __user *user = (u64 __user *)attr->addr;
+	u64 paddr;
+	int ret;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_PV_TIME_PADDR:
+		if (get_user(paddr, user))
+			return -EFAULT;
+		if (paddr & 63)
+			return -EINVAL;
+		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_ST:
+			if (pvtime->st_base != GPA_INVALID)
+				return -EEXIST;
+			ret = pvtime_map_pages(dev->kvm, paddr, pvtime->st,
+					max_stolen_size());
+			if (ret)
+				return ret;
+			pvtime->st_base = paddr;
+			return 0;
+		}
+		break;
+	case KVM_DEV_ARM_PV_TIME_STATE_SIZE:
+		return -EPERM;
+	case KVM_DEV_ARM_PV_TIME_STATE:
+		return pvtime_restore_state(dev->kvm, attr->attr, user);
+	}
+	return -ENXIO;
+}
+
+static int kvm_arm_pvtime_get_attr(struct kvm_device *dev,
+				   struct kvm_device_attr *attr)
+{
+	u64 __user *user = (u64 __user *)attr->addr;
+	u32 size;
+
+	switch (attr->group) {
+	case KVM_DEV_ARM_PV_TIME_PADDR:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_ST:
+			if (put_user(dev->kvm->arch.pvtime.st_base, user))
+				return -EFAULT;
+			return 0;
+		}
+		break;
+	case KVM_DEV_ARM_PV_TIME_STATE_SIZE:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_ST:
+			size = sizeof(struct pvclock_vcpu_stolen_time_info);
+			size *= atomic_read(&dev->kvm->online_vcpus);
+			break;
+		default:
+			return -ENXIO;
+		}
+		if (put_user(size, user))
+			return -EFAULT;
+		return 0;
+	case KVM_DEV_ARM_PV_TIME_STATE:
+		return pvtime_save_state(dev->kvm, attr->attr, user);
+	}
+	return -ENXIO;
+}
+
+static int kvm_arm_pvtime_has_attr(struct kvm_device *dev,
+				   struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_DEV_ARM_PV_TIME_PADDR:
+	case KVM_DEV_ARM_PV_TIME_STATE_SIZE:
+	case KVM_DEV_ARM_PV_TIME_STATE:
+		switch (attr->attr) {
+		case KVM_DEV_ARM_PV_TIME_ST:
+			return 0;
+		}
+		break;
+	}
+	return -ENXIO;
+}
+
+static const struct kvm_device_ops pvtime_ops = {
+	"Arm PV time",
+	.create = kvm_arm_pvtime_create,
+	.destroy = kvm_arm_pvtime_destroy,
+	.set_attr = kvm_arm_pvtime_set_attr,
+	.get_attr = kvm_arm_pvtime_get_attr,
+	.has_attr = kvm_arm_pvtime_has_attr
+};
+
+static int __init kvm_pvtime_init(void)
+{
+	kvm_register_device_ops(&pvtime_ops, KVM_DEV_TYPE_ARM_PV_TIME);
+
+	return 0;
+}
+
+late_initcall(kvm_pvtime_init);
+
+#endif
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

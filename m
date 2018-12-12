Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA6C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:03:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDBE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q8cfJvm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDBE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t58of9AO/acnPn8FwFLtUFA1tFYyztHPdj+wpBDQ/CI=; b=q8cfJvm4jCYvd/
	bxX2D44R5rFbSSHctBdvAgtSpT5w1zvWsjJBpJ7L9xWwP38mAoohWasrehzNAttSNrQiO1lYgwley
	smb86764/1DaO9DAhDqwRnTnTs+zWZJPNcLJTNBSFlsl2EpQf54MDE3ufMD4AExYibiBUcwgJGC3/
	xpw4nRIFgEK0GctDcP3qm4FOF6OjOTpgo7OT6evJdhZYiamd/wzEk/eJVRwhZtJ22aS2VeVYvnwys
	YnKqEDKexfcQuZOSsYaBzfKuhEK5gY5885OZ/OYQYg8qnDiM3TVFZutVIHEwBdKJkV/yjwWsdR+p9
	EarAD/i20GeFnExF3yFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX62s-0006wi-P7; Wed, 12 Dec 2018 15:03:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62U-0006GX-MT
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0C8B1596;
 Wed, 12 Dec 2018 07:03:00 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 262FB3F59C;
 Wed, 12 Dec 2018 07:02:59 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 01/12] KVM: arm64: Document PV-time interface
Date: Wed, 12 Dec 2018 15:02:15 +0000
Message-Id: <20181212150226.38051-2-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070306_761594_E069139A 
X-CRM114-Status: GOOD (  21.36  )
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

We introduce a paravirtualization interface for KVM/arm64 based on the
"Arm Paravirtualized Time for Arm-Base Systems" specification DEN 0057A.

User space can specify a reserved area of memory for the guest and
inform KVM to populate the memory with information on stolen time and
Live Physical Time (LPT) that can be used to derive a stable
counter/timer for a guest subject to migration between hosts with
different counter frequencies.

A hypercall interface is provided for the guest to interrogate the
hypervisor's support for this interface and the location of the shared
memory structures.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 Documentation/virtual/kvm/arm/pvtime.txt | 169 +++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/virtual/kvm/arm/pvtime.txt

diff --git a/Documentation/virtual/kvm/arm/pvtime.txt b/Documentation/virtual/kvm/arm/pvtime.txt
new file mode 100644
index 000000000000..1870b904075b
--- /dev/null
+++ b/Documentation/virtual/kvm/arm/pvtime.txt
@@ -0,0 +1,169 @@
+Paravirtualized time support for arm64
+======================================
+
+Arm specification DEN0057/A defined a standard for paravirtualised time
+support for Aarch64 guests:
+
+https://developer.arm.com/docs/den0057/a
+
+KVM/Arm64 implements this specification by providing some hypervisor service
+calls to support a paravirtualized guest obtaining a view of the amount of
+time stolen from its execution and a concept of Live Physical Time (LPT) which
+represents time during which the guest is running and works across migrations.
+
+Three new SMCCC compatible hypercalls are defined:
+
+PV_FEATURES 0xC5000020
+PV_TIME_LPT 0xC5000021
+PV_TIME_ST  0xC5000022
+
+These are only available in the SMC64/HVC64 calling convention as
+paravirtualized time is not available to 32 bit Arm guests.
+
+PV_FEATURES
+    Function ID:  (uint32)  : 0xC5000020
+    PV_func_id:   (uint32)  : Either PV_TIME_LPT or PV_TIME_ST
+    Return value: (int32)   : NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
+                              PV-time feature is supported by the hypervisor.
+
+PV_TIME_LPT
+    Function ID:  (uint32)  : 0xC5000021
+    Flags:        (uint32)  : Bit[0]: Request migration interrupts
+                                      (not currently supported by KVM)
+    Return value: (int64)   : IPA of the shared live physical time data
+                              structure or negative error code on failure:
+                              NOT_SUPPORTED (-1)
+                              INVALID_PARAMETERS (-2)
+
+PV_TIME_ST
+    Function ID:  (uint32)  : 0xC5000022
+    Return value: (int64)   : IPA of the stolen time data structure for this
+                              (V)CPU. On failure:
+                              NOT_SUPPORTED (-1)
+
+Live Physical Time
+------------------
+
+The structure pointed to by the PV_TIME_LPT hypercall is as follows:
+
+  Field           | Byte Length | Byte Offset | Description
+  --------------- | ----------- | ----------- | -------------------------------
+  Revision        |      4      |      0      | Must be 0 for this revision
+  Attributes      |      4      |      4      | Must be 0
+  sequence_number |      8      |      8      | Bit 0: reserved
+                  |             |             | Bits 1:63 number of migrations
+  scale_mult      |      8      |      16     | Multiplier to scale from native
+                  |             |             | frequency to PV frequency
+  shift           |      4      |      24     | Shift applied before multiplier
+  Reserved        |      4      |      28     | Must be 0
+  Fn              |      8      |      32     | Native frequency
+  Fpv             |      8      |      40     | Paravirtualized frequency seen
+                  |             |             | by guest
+  div_by_fpv_mult |      8      |      48     | Multiplier to implement fast
+                  |             |             | divide by Fpv
+
+Where scale_mult is defined as 2^(64-shift) * Fpv / Fn
+
+The structure will be updated by the hypervisor whenever the guest is migrated
+to a new host. It will be present within a reserved region of the normal
+memory given to the guest. The guest should not attempt to write into this
+memory.
+
+Stolen Time
+-----------
+
+The structure pointed to by the PV_TIME_ST hypercall is as follows:
+
+  Field       | Byte Length | Byte Offset | Description
+  ----------- | ----------- | ----------- | --------------------------
+  Revision    |      4      |      0      | Must be 0 for version 0.1
+  Attributes  |      4      |      4      | Must be 0
+  Stolen time |      8      |      8      | Stolen time in unsigned
+              |             |             | nanoseconds indicating how
+              |             |             | much time this VCPU thread
+              |             |             | was involuntarily not
+              |             |             | running on a physical CPU.
+
+The structure will be updated by the hypervisor periodically as time is stolen
+from the VCPU. It will be present within a reserved region of the normal
+memory given to the guest. The guest should not attempt to write into this
+memory. There is a structure by VCPU of the guest.
+
+User space interface
+====================
+
+User space can request that KVM provide the paravirtualized time interface to
+a guest by creating a KVM_DEV_TYPE_ARM_PV_TIME device, for example:
+
+    struct kvm_create_device pvtime_device = {
+            .type = KVM_DEV_TYPE_ARM_PV_TIME,
+            .attr = 0,
+            .flags = 0,
+    };
+
+    pvtime_fd = ioctl(vm_fd, KVM_CREATE_DEVICE, &pvtime_device);
+
+The guest IPA of the structures must be given to KVM. This is the address of
+the LPT structure and the base address of an array of stolen time structures
+(one for each VCPU). For example:
+
+    struct kvm_device_attr lpt_base = {
+            .group = KVM_DEV_ARM_PV_TIME_PADDR,
+            .attr = KVM_DEV_ARM_PV_TIME_LPT,
+            .addr = (u64)(unsigned long)&lpt_paddr
+    };
+    struct kvm_device_attr st_base = {
+            .group = KVM_DEV_ARM_PV_TIME_PADDR,
+            .attr = KVM_DEV_ARM_PV_TIME_ST,
+            .addr = (u64)(unsigned long)&st_paddr
+    };
+
+    ioctl(pvtime_fd, KVM_SET_DEVICE_ATTR, &lpt_base);
+    ioctl(pvtime_fd, KVM_SET_DEVICE_ATTR, &st_base);
+
+The paravirtualized frequency of the guest can also be set. By default this
+will be the counter frequency of the host. However when migrating a guest from
+another host, this must be manually set to ensure that the guest sees the same
+frequency.
+
+    u32 frequency;
+
+    struct kvm_device_attr lpt_freq = {
+            .group = KVM_DEV_ARM_PV_TIME_FREQUENCY,
+            .attr = KVM_DEV_ARM_PV_TIME_LPT,
+            .addr = (u64)(unsigned long)&frequency
+    };
+
+    ioctl(pvtime_fd, KVM_SET_DEVICE_ATTR, &lpt_freq);
+
+For migration (or save/restore) of a guest it is necessary to save the contents
+of the shared pages and later restore them. KVM_DEV_ARM_PV_TIME_STATE_SIZE
+provides the size of this data and KVM_DEV_ARM_PV_TIME_STATE allows the state
+to be read/written. The state for stolen time and LPT are accessed separately.
+It is also necessary for the physical address and frequency to be set
+identically when restoring. The kernel will update the structure on first run
+of the vCPU(s) to contain the new coefficients.
+
+    void *save_state(int fd, u64 attr, u32 *size) {
+        struct kvm_device_attr get_size = {
+                .group = KVM_DEV_ARM_PV_TIME_STATE_SIZE,
+                .attr = attr,
+                .addr = (u64)(unsigned long)size
+        };
+
+        ioctl(fd, KVM_GET_DEVICE_ATTR, get_size);
+
+        void *buffer = malloc(*size);
+
+        struct kvm_device_attr get_state = {
+                .group = KVM_DEV_ARM_PV_TIME_STATE,
+                .attr = attr,
+                .addr = (u64)(unsigned long)size
+        };
+
+        ioctl(fd, KVM_GET_DEVICE_ATTR, buffer);
+    }
+
+    void *lpt_state = save_state(pvtime_fd, KVM_DEV_ARM_PV_TIME_LPT, &lpt_size);
+    void *st_state = save_state(pvtime_fd, KVM_DEV_ARM_PV_TIME_ST, &st_size);
+
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

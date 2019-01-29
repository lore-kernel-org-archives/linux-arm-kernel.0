Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F3BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3D020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cx0qBRC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3D020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XwgQiEXo46B+Ug759quVsdpmPICS4BWS1Ha/N76NEgo=; b=cx0qBRC39Vl/P/
	gdRGS4wr3sg/hF50tQtznIlESueiIEhp6+//wbZ/A8ftyQXEgx/OqmWHW5T4z3VzKhGrxpYpUUFMd
	GreCIRuHPcSdHdI6mSOugVaPqBIrEqeEc2Gw7gIXPmp4ipHNpAGrkqeGN+7VCZjP/glhOCO8VQW6h
	km+LRvXkpzYWpoYi5uI34vjYOQOqgHqMx0gvqOoXFsBa/pcC4iVxsNQanoSIcIjj+FSkTwHtaPuZa
	mJwDHaoU9IYpstupKypKhftC78F1a8khDfLmrQ3/tzqAqvesz4ZE/AnDNGUfrHsUwsLOcv10MQ3cT
	4plHZsyjkkSbCfkDhcZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYWe-0002L2-GA; Tue, 29 Jan 2019 18:54:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSe-0006VW-TQ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B54EA78;
 Tue, 29 Jan 2019 10:50:16 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE583F557;
 Tue, 29 Jan 2019 10:50:13 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 13/26] KVM: arm/arm64: Add kvm_ras.h to collect kvm
 specific RAS plumbing
Date: Tue, 29 Jan 2019 18:48:49 +0000
Message-Id: <20190129184902.102850-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_105017_570430_59ED7978 
X-CRM114-Status: GOOD (  18.63  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, james.morse@arm.com,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To split up APEIs in_nmi() path, the caller needs to always be
in_nmi(). KVM shouldn't have to know about this, pull the RAS plumbing
out into a header file.

Currently guest synchronous external aborts are claimed as RAS
notifications by handle_guest_sea(), which is hidden in the arch codes
mm/fault.c. 32bit gets a dummy declaration in system_misc.h.

There is going to be more of this in the future if/when the kernel
supports the SError-based firmware-first notification mechanism and/or
kernel-first notifications for both synchronous external abort and
SError. Each of these will come with some Kconfig symbols and a
handful of header files.

Create a header file for all this.

This patch gives handle_guest_sea() a 'kvm_' prefix, and moves the
declarations to kvm_ras.h as preparation for a future patch that moves
the ACPI-specific RAS code out of mm/fault.c.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

---
Changes since v6:
 * Tinkered with the commit message
---
 arch/arm/include/asm/kvm_ras.h       | 14 ++++++++++++++
 arch/arm/include/asm/system_misc.h   |  5 -----
 arch/arm64/include/asm/kvm_ras.h     | 11 +++++++++++
 arch/arm64/include/asm/system_misc.h |  2 --
 arch/arm64/mm/fault.c                |  2 +-
 virt/kvm/arm/mmu.c                   |  4 ++--
 6 files changed, 28 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_ras.h
 create mode 100644 arch/arm64/include/asm/kvm_ras.h

diff --git a/arch/arm/include/asm/kvm_ras.h b/arch/arm/include/asm/kvm_ras.h
new file mode 100644
index 000000000000..e9577292dfe4
--- /dev/null
+++ b/arch/arm/include/asm/kvm_ras.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 - Arm Ltd */
+
+#ifndef __ARM_KVM_RAS_H__
+#define __ARM_KVM_RAS_H__
+
+#include <linux/types.h>
+
+static inline int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr)
+{
+	return -1;
+}
+
+#endif /* __ARM_KVM_RAS_H__ */
diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 8e76db83c498..66f6a3ae68d2 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -38,11 +38,6 @@ static inline void harden_branch_predictor(void)
 
 extern unsigned int user_debug;
 
-static inline int handle_guest_sea(phys_addr_t addr, unsigned int esr)
-{
-	return -1;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_ARM_SYSTEM_MISC_H */
diff --git a/arch/arm64/include/asm/kvm_ras.h b/arch/arm64/include/asm/kvm_ras.h
new file mode 100644
index 000000000000..6096f0251812
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_ras.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 - Arm Ltd */
+
+#ifndef __ARM64_KVM_RAS_H__
+#define __ARM64_KVM_RAS_H__
+
+#include <linux/types.h>
+
+int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr);
+
+#endif /* __ARM64_KVM_RAS_H__ */
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 0e2a0ecaf484..32693f34f431 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -46,8 +46,6 @@ extern void __show_regs(struct pt_regs *);
 
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
-int handle_guest_sea(phys_addr_t addr, unsigned int esr);
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index efb7b2cbead5..c76dc981e3fc 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -733,7 +733,7 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
 };
 
-int handle_guest_sea(phys_addr_t addr, unsigned int esr)
+int kvm_handle_guest_sea(phys_addr_t addr, unsigned int esr)
 {
 	return ghes_notify_sea();
 }
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index fbdf3ac2f001..600e0cc74ea4 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -27,10 +27,10 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_mmio.h>
+#include <asm/kvm_ras.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/virt.h>
-#include <asm/system_misc.h>
 
 #include "trace.h"
 
@@ -1903,7 +1903,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * For RAS the host kernel may handle this abort.
 		 * There is no need to pass the error into the guest.
 		 */
-		if (!handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
+		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
 			return 1;
 
 		if (unlikely(!is_iabt)) {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

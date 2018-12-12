Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F2320849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t162WNjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L7/xspgfakw7s/dMvN/n5pudWGSE8737AdiZA/vG5XY=; b=t162WNjHOn+SPS
	e4QnbyPrreRipmDgT0aJnxIsvkJRfPHR/ffzkA8QYitJGfHqq60gv1qwxjszXUnVvXOTUXzk2xw9X
	iqldYcQvOw19M0c/869IFsEaXMMAdrXf80kT2PtO+tudaaAOWcXD1zN1OS1J0VB918V2D8tr5Y906
	ethHDkquWnKB30sMiVEi+z9n1EkqJTmh9pcifSXP0Lsq1d2+n1ivDSMOEU7EpMVQ6zDg4vPE1FAUU
	vsb41tdEdR+RO8t8jBifV6VnFNQG1dd8v4bnZHHjQ7N/DxO5RrVECpK0AKht8xN6eY9G5p6MyiPaC
	q5velGPmBqgzQboIYjww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX655-0001vL-Iq; Wed, 12 Dec 2018 15:05:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62e-0006OL-FU
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:03:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1C61688;
 Wed, 12 Dec 2018 07:03:07 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EF23F59C;
 Wed, 12 Dec 2018 07:03:06 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 05/12] KVM: arm64: Implement PV_FEATURES call
Date: Wed, 12 Dec 2018 15:02:19 +0000
Message-Id: <20181212150226.38051-6-steven.price@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212150226.38051-1-steven.price@arm.com>
References: <20181212150226.38051-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070317_813454_7CCE1F1F 
X-CRM114-Status: GOOD (  15.75  )
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

This provides a mechanism for querying which paravirtualized features
are available in this hypervisor.

Also add the header file which defines the ABI for the paravirtualized
clock features we're about to add.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/pvclock-abi.h | 32 ++++++++++++++++++++++++++++
 include/linux/arm-smccc.h            | 20 +++++++++++++++++
 virt/kvm/arm/hypercalls.c            |  9 ++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 arch/arm64/include/asm/pvclock-abi.h

diff --git a/arch/arm64/include/asm/pvclock-abi.h b/arch/arm64/include/asm/pvclock-abi.h
new file mode 100644
index 000000000000..4f710dec6592
--- /dev/null
+++ b/arch/arm64/include/asm/pvclock-abi.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Arm Ltd. */
+
+#ifndef __ASM_PVCLOCK_ABI_H
+#define __ASM_PVCLOCK_ABI_H
+
+/* The below structures and constants are defined in ARM DEN0057A */
+
+struct pvclock_vm_time_info {
+	__le32 revision;
+	__le32 attributes;
+	__le64 sequence_number;
+	__le64 scale_mult;
+	__le32 shift;
+	__le32 reserved;
+	__le64 native_freq;
+	__le64 pv_freq;
+	__le64 div_by_pv_freq_mult;
+} __packed;
+
+struct pvclock_vcpu_stolen_time_info {
+	__le32 revision;
+	__le32 attributes;
+	__le64 stolen_time;
+	/* Structure must be 64 byte aligned, pad to that size */
+	u8 padding[48];
+} __packed;
+
+#define PV_VM_TIME_NOT_SUPPORTED	-1
+#define PV_VM_TIME_INVALID_PARAMETERS	-2
+
+#endif
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 4d5ec5f10a51..12e88e1ba222 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -54,6 +54,7 @@
 #define ARM_SMCCC_OWNER_SIP		2
 #define ARM_SMCCC_OWNER_OEM		3
 #define ARM_SMCCC_OWNER_STANDARD	4
+#define ARM_SMCCC_OWNER_STANDARD_HYP	5
 #define ARM_SMCCC_OWNER_TRUSTED_APP	48
 #define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
@@ -355,5 +356,24 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 		method;							\
 	})
 
+/* Paravirtualised time calls (defined by ARM DEN0057A) */
+#define ARM_SMCCC_HV_PV_FEATURES				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x20)
+
+#define ARM_SMCCC_HV_PV_TIME_LPT				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x21)
+
+#define ARM_SMCCC_HV_PV_TIME_ST					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x22)
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
index 153aa7642100..ba13b798f0f8 100644
--- a/virt/kvm/arm/hypercalls.c
+++ b/virt/kvm/arm/hypercalls.c
@@ -5,6 +5,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
+#include <asm/pvclock-abi.h>
 
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
@@ -40,6 +41,14 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 				break;
 			}
 			break;
+		case ARM_SMCCC_HV_PV_FEATURES:
+			val = SMCCC_RET_SUCCESS;
+			break;
+		}
+		break;
+	case ARM_SMCCC_HV_PV_FEATURES:
+		feature = smccc_get_arg1(vcpu);
+		switch (feature) {
 		}
 		break;
 	default:
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

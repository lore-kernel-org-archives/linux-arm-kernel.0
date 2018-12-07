Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:43:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14D52082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U44Ee2Xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14D52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HCIHNDnvUrZhfGCrMpiJyFM5fzXUyYXzgY+gkY1voaI=; b=U44Ee2Xp91kcw7kY97BiR/+S1t
	YgsJloTffzNHeBIiLiQodCvu3K+FObofdcmM7nDwP26Azl0lU3+sXSkSdOn3QMTwkJPABPNLaP0Vv
	OmhLAdHMvHeaEfYQi5Oo3mKECkgJBN+PsKapID0xwwdHtxuzKbFl4B4LOWFsMI/d2Tka//FvnOh3M
	M/4f7ZhASg84ud1LRt5HR9VlfiihaO9ajHGMOvJaxGKO08yUguUosSnTnuGHccAF5S/Tu5iW9snWZ
	ufW0IztHnjoTc3crLFk4BCVFtrJRKpH60xFUjBF1K+oM7UV07gnxGk1eFP5aWAkVcnEyhVPM6Z+Eh
	Ea6hYKxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL62-00082V-Qr; Fri, 07 Dec 2018 18:43:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL3S-00059N-H0
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:41:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1610715AD;
 Fri,  7 Dec 2018 10:40:40 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1CF53F5AF;
 Fri,  7 Dec 2018 10:40:36 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 10/13] arm64: add prctl control for resetting ptrauth keys
Date: Fri,  7 Dec 2018 18:39:28 +0000
Message-Id: <20181207183931.4285-11-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104050_732370_D4461336 
X-CRM114-Status: GOOD (  19.66  )
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
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an arm64-specific prctl to allow a thread to reinitialize its
pointer authentication keys to random values. This can be useful when
exec() is not used for starting new processes, to ensure that different
processes still have different keys.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h |  3 +++
 arch/arm64/include/asm/processor.h    |  4 +++
 arch/arm64/kernel/Makefile            |  1 +
 arch/arm64/kernel/pointer_auth.c      | 47 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h            |  8 ++++++
 kernel/sys.c                          |  8 ++++++
 6 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/kernel/pointer_auth.c

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 89190d93c850..7797bc346c6b 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -59,6 +59,8 @@ static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
 		__ptrauth_key_install(APGA, keys->apga);
 }
 
+extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
+
 /*
  * The EL0 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0 being enabled, or bits 63:56 would also apply.
@@ -82,6 +84,7 @@ do {									\
 	ptrauth_keys_switch(&(tsk)->thread_info.keys_user)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
+#define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_thread_init_user(tsk)
 #define ptrauth_thread_switch(tsk)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6b0d4dff5012..40ccfb7605b6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -46,6 +46,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
 #include <asm/pgtable-hwdef.h>
+#include <asm/pointer_auth.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
@@ -270,6 +271,9 @@ extern void __init minsigstksz_setup(void);
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
 #define SVE_GET_VL()	sve_get_current_vl()
 
+/* PR_PAC_RESET_KEYS prctl */
+#define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
+
 /*
  * For CONFIG_GCC_PLUGIN_STACKLEAK
  *
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4c8b13bede80..096740ab81d2 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -57,6 +57,7 @@ arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 arm64-obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
 arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
+arm64-obj-$(CONFIG_ARM64_PTR_AUTH)	+= pointer_auth.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
new file mode 100644
index 000000000000..b9f6f5f3409a
--- /dev/null
+++ b/arch/arm64/kernel/pointer_auth.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/errno.h>
+#include <linux/prctl.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <asm/cpufeature.h>
+#include <asm/pointer_auth.h>
+
+int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
+{
+	struct ptrauth_keys *keys = &tsk->thread_info.keys_user;
+	unsigned long addr_key_mask = PR_PAC_APIAKEY | PR_PAC_APIBKEY |
+				      PR_PAC_APDAKEY | PR_PAC_APDBKEY;
+	unsigned long key_mask = addr_key_mask | PR_PAC_APGAKEY;
+
+	if (!system_supports_address_auth() && !system_supports_generic_auth())
+		return -EINVAL;
+
+	if (!arg) {
+		ptrauth_keys_init(keys);
+		ptrauth_keys_switch(keys);
+		return 0;
+	}
+
+	if (arg & ~key_mask)
+		return -EINVAL;
+
+	if (((arg & addr_key_mask) && !system_supports_address_auth()) ||
+	    ((arg & PR_PAC_APGAKEY) && !system_supports_generic_auth()))
+		return -EINVAL;
+
+	if (arg & PR_PAC_APIAKEY)
+		get_random_bytes(&keys->apia, sizeof(keys->apia));
+	if (arg & PR_PAC_APIBKEY)
+		get_random_bytes(&keys->apib, sizeof(keys->apib));
+	if (arg & PR_PAC_APDAKEY)
+		get_random_bytes(&keys->apda, sizeof(keys->apda));
+	if (arg & PR_PAC_APDBKEY)
+		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
+	if (arg & PR_PAC_APGAKEY)
+		get_random_bytes(&keys->apga, sizeof(keys->apga));
+
+	ptrauth_keys_switch(keys);
+
+	return 0;
+}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b17201edfa09..b4875a93363a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -220,4 +220,12 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
+/* Reset arm64 pointer authentication keys */
+#define PR_PAC_RESET_KEYS		54
+# define PR_PAC_APIAKEY			(1UL << 0)
+# define PR_PAC_APIBKEY			(1UL << 1)
+# define PR_PAC_APDAKEY			(1UL << 2)
+# define PR_PAC_APDBKEY			(1UL << 3)
+# define PR_PAC_APGAKEY			(1UL << 4)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 123bd73046ec..64b5a230f38d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -121,6 +121,9 @@
 #ifndef SVE_GET_VL
 # define SVE_GET_VL()		(-EINVAL)
 #endif
+#ifndef PAC_RESET_KEYS
+# define PAC_RESET_KEYS(a, b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2476,6 +2479,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
 		break;
+	case PR_PAC_RESET_KEYS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = PAC_RESET_KEYS(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

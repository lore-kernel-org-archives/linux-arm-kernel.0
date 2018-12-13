Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A5C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5AB2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PQMAC4VG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5AB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8o94IQqz8iRKt3cU9JwxUZmsHi/XC2OMF0JRl/bTquE=; b=PQMAC4VGLbGvel
	mGkTOkfdDy28ihFLOgbiy+7oI8xcSOIwkbIUSmAU7B9r4KmQ/ZZDuunLJZE5E5BrFGqHqmIhOw2uu
	hsJ9CUaVV7vzareJ+8tQdoxu5Tx2X0U4qJ23RpLsdSBeqKaZRjadjxavwjmzJ7f7Ceg41yw2Q8IqC
	LL3c4Kkp0/dTnnycL/47bbIVeKaNewdmivcdCMV+Mo5ujam5VxJsD5h+35+fIc1JpgCSJtaIVR0E4
	39RJmQdPIYOfprB2my6W19NFIXPU1Ev8IjaUjx8oS8hT3ugD4DFetTDY7kb4xvsi+iEwKBrafqmBy
	uC+GVFFPaN5dP/tJN/Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUM8-0002EK-EV; Thu, 13 Dec 2018 17:01:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUKR-0007Uo-Hu
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:59:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F11EBD;
 Thu, 13 Dec 2018 08:59:07 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EE293F614;
 Thu, 13 Dec 2018 08:59:04 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 06/24] arm64: compat: Split kuser32
Date: Thu, 13 Dec 2018 16:57:28 +0000
Message-Id: <20181213165746.56930-7-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_085916_264408_3FD9B73A 
X-CRM114-Status: GOOD (  18.04  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To make it possible to disable kuser helpers in aarch32 we need to
divide the kuser and the sigreturn functionalities.

This patch splits the current version of kuser32 in kuser32 (for kuser
helpers) and sigreturn32 (for sigreturn helpers).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/Makefile      |  2 +-
 arch/arm64/kernel/kuser32.S     | 58 ++-------------------------------
 arch/arm64/kernel/sigreturn32.S | 46 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4c8b13bede80..6bd4f619732a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o
+					   sigreturn32.o sys_compat.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 997e6b27ff6a..f19e2b015097 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -1,24 +1,9 @@
 /*
- * Low-level user helpers placed in the vectors page for AArch32.
+ * AArch32 user helpers.
  * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
  *
  * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- *
- * AArch32 user helpers.
+ * Copyright (C) 2012-2018 ARM Ltd.
  *
  * Each segment is 32-byte aligned and will be moved to the top of the high
  * vector page.  New segments (if ever needed) must be added in front of
@@ -77,42 +62,3 @@ __kuser_helper_version:			// 0xffff0ffc
 	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
 	.globl	__kuser_helper_end
 __kuser_helper_end:
-
-/*
- * AArch32 sigreturn code
- *
- * For ARM syscalls, the syscall number has to be loaded into r7.
- * We do not support an OABI userspace.
- *
- * For Thumb syscalls, we also pass the syscall number via r7. We therefore
- * need two 16-bit instructions.
- */
-	.globl __aarch32_sigret_code_start
-__aarch32_sigret_code_start:
-
-	/*
-	 * ARM Code
-	 */
-	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
-
-	/*
-	 * ARM code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
-
-        .globl __aarch32_sigret_code_end
-__aarch32_sigret_code_end:
diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
new file mode 100644
index 000000000000..475d30d471ac
--- /dev/null
+++ b/arch/arm64/kernel/sigreturn32.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AArch32 sigreturn code.
+ * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
+ *
+ * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
+ * Copyright (C) 2012-2018 ARM Ltd.
+ *
+ * For ARM syscalls, the syscall number has to be loaded into r7.
+ * We do not support an OABI userspace.
+ *
+ * For Thumb syscalls, we also pass the syscall number via r7. We therefore
+ * need two 16-bit instructions.
+ */
+
+#include <asm/unistd.h>
+
+	.globl __aarch32_sigret_code_start
+__aarch32_sigret_code_start:
+
+	/*
+	 * ARM Code
+	 */
+	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3		// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef		// svc	#__NR_compat_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
+
+	/*
+	 * ARM code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
+
+        .globl __aarch32_sigret_code_end
+__aarch32_sigret_code_end:
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

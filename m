Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6934C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:30:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EC52075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEYCrSHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EC52075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=12Q0WX8HoNuKDOX0/3xf2Kbxv/Qn40fIVR5DX46EWuM=; b=pEYCrSHND1Bmh5
	AicN+gUPiSe+DQh6PH0LqUwvm9Oaa022/YkuM8P5UUhzn5yrI+YTkFGztEcf0Tp8vBUu4D+fdGJ4D
	H1wFJtQdHYvLmXzMSA0q7QJbgHmWM0a3VbbW3mfBs66zhdVMKjMHURk5A0m6Zm3tyjj4OnvgECIa1
	oB9g/zMolYn/xVqgh4Jj9wuqir37IVRvUblOIw3VhRLhUpMA5XrenbsuLef3yCAcN/twTtrYjB37h
	edd+LMuSWwOxNvUhPMtkUYvfTBEBIQ37bRHi+e87DkeqV8Axjx5oaURGawkOymgYiOzzz2apMsa0w
	APibYTM6dQeMV4WSvHWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9yA-0005nb-LO; Fri, 22 Feb 2019 12:30:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9uO-0000X7-Nf
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F58616A3;
 Fri, 22 Feb 2019 04:26:28 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00EFD3F690;
 Fri, 22 Feb 2019 04:26:25 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 18/23] arm64: Add vDSO compat support
Date: Fri, 22 Feb 2019 12:24:25 +0000
Message-Id: <20190222122430.21180-19-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042629_637699_8818EC94 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vDSO compat support to the arm64 building system.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig         |  1 +
 arch/arm64/Makefile        | 23 +++++++++++++++++++++--
 arch/arm64/kernel/Makefile |  6 +++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ed3290494f1c..67bf39985d8c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -101,6 +101,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_COMPAT_VDSO
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b025304bde46..111cb0f7b73b 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -49,9 +49,25 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
+  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
+
+  ifeq ($(CONFIG_CC_IS_CLANG), y)
+    $(warning CROSS_COMPILE_ARM32 is clang, the compat vDSO will not be built)
+  else ifeq ($(CROSS_COMPILE_ARM32),)
+    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
+    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
+  else
+    export CROSS_COMPILE_ARM32
+    export CONFIG_COMPAT_VDSO := y
+    compat_vdso := -DCONFIG_COMPAT_VDSO=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -163,6 +179,9 @@ ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
+		$(build)=arch/arm64/kernel/vdso32  \
+		include/generated/vdso32-offsets.h)
 endif
 
 define archhelp
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index c7bd0794855a..78a55fc8e0c7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,10 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
-					   sigreturn32.o sys_compat.o
+					   sys_compat.o
+ifneq ($(CONFIG_COMPAT_VDSO), y)
+obj-$(CONFIG_COMPAT)			+= sigreturn32.o
+endif
 obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
@@ -62,6 +65,7 @@ obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 
 obj-y					+= vdso/ probes/
+obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

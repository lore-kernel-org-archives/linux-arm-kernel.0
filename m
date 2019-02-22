Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:27:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63EB2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QtRxqGYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63EB2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F9kztGXwfw2b15cwPAHaFCouM1sUYiPfDcP19dYPEec=; b=QtRxqGYzyAumjg
	eHCWGtc36x6jGw0kYM3puET9e/ruXfKFYzEvcUUTLAzipMwXZMoJFInfqLHzdTVGBeAENLLYeyqbk
	7q1T0K4KWZMy+kyhH3rfjGC0Q2uwBRxkVuT2JhmPNmud98svc0ay8C/utj/d7LraMn+QCW6nH2YZ5
	YQwZqVyu5Y24b8iGruA8mHAIF/k13P+/XWSS9bargS8vbUaQKigejhSbdpInsY+W7gedNYF50wRrR
	Rvepc3TpxXFLABX8jGP5QChd/MOKlwBy9jw+dFuNzEARoAwgvrmi+4mr3Q8yFaqWxLIKbMtUt/AjE
	m5/mJXPhKRb5BIHvFVKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9vg-0002DC-9E; Fri, 22 Feb 2019 12:27:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9tw-00006c-VI
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B429F16A3;
 Fri, 22 Feb 2019 04:26:00 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B953F690;
 Fri, 22 Feb 2019 04:25:58 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
Date: Fri, 22 Feb 2019 12:24:15 +0000
Message-Id: <20190222122430.21180-9-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042601_561204_98BEBAC1 
X-CRM114-Status: GOOD (  22.96  )
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

When kuser helpers are enabled the kernel maps the relative code at
a fixed address (0xffff0000). Making configurable the option to disable
them means that the kernel can remove this mapping and any access to
this memory area results in a sigfault.

Add a KUSER_HELPERS config option that can be used to disable the
mapping when it is turned off.

This option can be turned off if and only if the applications are
designed specifically for the platform and they do not make use of the
kuser helpers code.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig          | 21 +++++++++++++++++++++
 arch/arm64/kernel/Makefile  |  3 ++-
 arch/arm64/kernel/kuser32.S |  7 +++----
 arch/arm64/kernel/vdso.c    | 15 +++++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d898da2e20f5..ed3290494f1c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1465,6 +1465,27 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable kuser helpers page for compatibility with 32 bit applications."
+	depends on COMPAT
+	default y
+	help
+	  Enables kuser helpers to be mapped in a special purpose page at a fixed
+	  address to maintain independence from the type of CPU present in the SoC.
+	  This feature is provided for compatibility reasons in fact allows 32 bit
+	  applications compliant with ARMv4 up to ARMv8 to run without any
+	  modification.
+
+	  Warning: Being always mapped at a fixed address makes it easier to create
+	  exploits based on ROP type of attacks.
+
+	  As a consequence of this, this feature is made configurable but be aware that
+	  it can be turned off if and only if the binaries and the libraries running on
+	  a specific platform are designed to do not make use of these helpers, otherwise
+	  should be left on.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 50f76b88a967..c7bd0794855a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,8 +27,9 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-obj-$(CONFIG_COMPAT)			+= sys32.o kuser32.o signal32.o 	\
+obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sigreturn32.o sys_compat.o
+obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index f19e2b015097..7d38633bf33f 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -5,10 +5,9 @@
  * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
  * Copyright (C) 2012-2018 ARM Ltd.
  *
- * Each segment is 32-byte aligned and will be moved to the top of the high
- * vector page.  New segments (if ever needed) must be added in front of
- * existing ones.  This mechanism should be used only for things that are
- * really small and justified, and not be abused freely.
+ * The kuser helpers below are mapped at a fixed address by
+ * aarch32_setup_additional_pages() ad are provided for compatibility
+ * reasons with 32 bit (aarch32) applications that need them.
  *
  * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
  */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 4c9476516e2f..523e56658b84 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -75,6 +75,7 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
 	},
 };
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
@@ -96,6 +97,12 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	return 0;
 }
+#else
+static int aarch32_alloc_kuser_vdso_page(void)
+{
+	return 0;
+}
+#endif /* CONFIG_KUSER_HELPER */
 
 static int aarch32_alloc_sigreturn_vdso_page(void)
 {
@@ -127,6 +134,7 @@ static int __init aarch32_alloc_vdso_pages(void)
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
@@ -139,6 +147,13 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#else
+static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
+{
+	/* kuser helpers not enabled */
+	return 0;
+}
+#endif /* CONFIG_KUSER_HELPERS */
 
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

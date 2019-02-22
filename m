Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:29:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F332075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwveHOgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F332075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CxsPxS3IlCJn1olZIhYcCmel+nd0yMt5o3y8yOl3O8w=; b=lwveHOgWGZKlfy
	fDv54QLp3uW9/5xsAvqPVhlUFLi1Sqi1X4hZQd8XqvgtVBW+nWPwz+sRixoJW7cqSxkydJXVwVBLN
	AblQq0bujorX7TSWgn0lWWmJO/nQrqgH00+Qe7yZkUVJNrw6omk7ZpCFTm+MptHhoEdTPrGls0gxS
	v9k2fqDq/qJk6dIRaXyvactGjVtesj2v+iPsGY+f1CUHpYKZsOw8BuDHBRBd10wfb2oOkMGReSUyV
	LrwWWQkkZIv+Bf0iuyxSsdyMUPNvkffZorAJ0svUIFAMK8b20cMNUxOkvvczWWXPAYRU+Hhut8eXV
	HIusXvt3pb9f02+Ix3XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9xQ-0003ei-0d; Fri, 22 Feb 2019 12:29:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9uG-0000FH-Bb
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6271688;
 Fri, 22 Feb 2019 04:26:20 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A41513F690;
 Fri, 22 Feb 2019 04:26:17 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 15/23] arm64: compat: vDSO setup for compat layer
Date: Fri, 22 Feb 2019 12:24:22 +0000
Message-Id: <20190222122430.21180-16-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042620_677831_061D3382 
X-CRM114-Status: GOOD (  15.58  )
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

If CONFIG_GENERIC_COMPAT_VDSO is enabled, compat vDSO are installed in a
compat (32 bit) process instead of sigpage.

Add the necessary code to setup the vDSO required pages.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 60 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index c217245768ea..55343f8f3593 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -41,10 +41,16 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
+#ifdef CONFIG_COMPAT_VDSO
+extern char vdso32_start[], vdso32_end[];
+#endif /* CONFIG_COMPAT_VDSO */
 
 /* vdso_lookup arch_index */
 enum arch_vdso_type {
 	ARM64_VDSO = 0,
+#ifdef CONFIG_COMPAT_VDSO
+	ARM64_VDSO32 = 1,
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 struct __vdso_lookup_t {
@@ -64,6 +70,13 @@ static struct __vdso_lookup_t vdso_lookup[2] __ro_after_init = {
 		.vdso_code_start = vdso_start,
 		.vdso_code_end = vdso_end,
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "vdso32",
+		.vdso_code_start = vdso32_start,
+		.vdso_code_end = vdso32_end,
+	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 /*
@@ -179,23 +192,45 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	return __vdso_remap(ARM64_VDSO32, sm, new_vma);
+}
+#endif /* CONFIG_COMPAT_VDSO */
+
 /*
  * aarch32_vdso_pages:
  * 0 - kuser helpers
  * 1 - sigreturn code
+ * or (CONFIG_COMPAT_VDSO):
+ * 0 - kuser helpers
+ * 1 - vdso data
+ * 2 - vdso code
  */
 static struct page *aarch32_vdso_pages[2] __ro_after_init;
-static struct vm_special_mapping aarch32_vdso_spec[2] __ro_after_init = {
+static struct vm_special_mapping aarch32_vdso_spec[3] __ro_after_init = {
 	{
 		/* Must be named [vectors] for compatibility with arm. */
 		.name	= "[vectors]",
 		.pages	= &aarch32_vdso_pages[0],
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "[vvar]",
+	},
+	{
+		.name = "[vdso]",
+		.mremap = aarch32_vdso_mremap,
+	},
+#else
 	{
 		/* Must be named [sigpage] for compatibility with arm. */
 		.name	= "[sigpage]",
 		.pages	= &aarch32_vdso_pages[1],
 	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 #ifdef CONFIG_KUSER_HELPERS
@@ -227,6 +262,15 @@ static int aarch32_alloc_kuser_vdso_page(void)
 }
 #endif /* CONFIG_KUSER_HELPER */
 
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_init(void)
+{
+	vdso_lookup[ARM64_VDSO32].dm = &aarch32_vdso_spec[1];
+	vdso_lookup[ARM64_VDSO32].cm = &aarch32_vdso_spec[2];
+
+	return __vdso_init(ARM64_VDSO32);
+}
+#else
 static int aarch32_alloc_sigreturn_vdso_page(void)
 {
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
@@ -249,11 +293,16 @@ static int aarch32_alloc_sigreturn_vdso_page(void)
 	return 0;
 
 }
+#endif /* CONFIG_COMPAT_VDSO */
 
 static int __init aarch32_alloc_vdso_pages(void)
 {
 	return aarch32_alloc_kuser_vdso_page() &
+#ifdef CONFIG_COMPAT_VDSO
+	       aarch32_vdso_init();
+#else
 	       aarch32_alloc_sigreturn_vdso_page();
+#endif /* CONFIG_COMPAT_VDSO */
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
@@ -278,6 +327,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 }
 #endif /* CONFIG_KUSER_HELPERS */
 
+#ifndef CONFIG_COMPAT_VDSO
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -301,6 +351,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_COMPAT_VDSO */
 
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
@@ -314,7 +365,14 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_COMPAT_VDSO
+	ret = __setup_additional_pages(ARM64_VDSO32,
+				       mm,
+				       bprm,
+				       uses_interp);
+#else
 	ret = aarch32_sigreturn_setup(mm);
+#endif /* CONFIG_COMPAT_VDSO */
 
 out:
 	up_write(&mm->mmap_sem);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

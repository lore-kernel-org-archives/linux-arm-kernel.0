Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:45:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2BE2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bWyiVKXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2BE2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WqL4WES3owRFDixPCpCPdB70NXq0msnF9O+1TCjJXdY=; b=bWyiVKXosGIha2
	zFiO816m+WsRhNSybJ6DENMWseS309HV3ElNyulAQjBI8TuBse3etGD0F7MG7RGlBaQ+CxRZJdtct
	lw07EyrH0XBvwEiH9O2LbEm6n8NRmKdUBAp07GN2pnIGLo1U3iT484XU6UGz62ah7ItnXoNxADi+R
	jdKzZvBuB3NPbvznv7IE8Z1aWBpVMMMlCSQtA1t03W5v5Oaz4gJShR7iNXrzQZOg4mYv5Ah9thtQJ
	9p5lh6Ru+BWPHyf5yzBY0AatdfzKdAQ54/gocPmMg5hfkaW/dX344+PJQiRpujobojVEoQhAwmnEt
	qCwHOYIZtsL2ZgNFmi0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxACL-0002en-Ft; Fri, 22 Feb 2019 12:45:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9uD-0000EQ-I7
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F58A78;
 Fri, 22 Feb 2019 04:26:17 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0A43F690;
 Fri, 22 Feb 2019 04:26:14 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 14/23] arm64: Refactor vDSO code
Date: Fri, 22 Feb 2019 12:24:21 +0000
Message-Id: <20190222122430.21180-15-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042618_018478_4DD5B872 
X-CRM114-Status: GOOD (  20.82  )
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

Most of the code for initializing the vDSOs in arm64 and compat will
be in common, hence a refactor of the current code is required to avoid
duplication and simplify maintainability.

Refactor vdso.c to simplify the implementation of arm64 vDSO compat
(which will be pushed with a future patch).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 208 +++++++++++++++++++++++++--------------
 1 file changed, 135 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 523e56658b84..c217245768ea 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -41,7 +41,30 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
+
+/* vdso_lookup arch_index */
+enum arch_vdso_type {
+	ARM64_VDSO = 0,
+};
+
+struct __vdso_lookup_t {
+	const char *name;
+	const char *vdso_code_start;
+	const char *vdso_code_end;
+	unsigned long vdso_pages;
+	/* Data Mapping */
+	struct vm_special_mapping *dm;
+	/* Code Mapping */
+	struct vm_special_mapping *cm;
+};
+
+static struct __vdso_lookup_t vdso_lookup[2] __ro_after_init = {
+	{
+		.name = "vdso",
+		.vdso_code_start = vdso_start,
+		.vdso_code_end = vdso_end,
+	},
+};
 
 /*
  * The vDSO data page.
@@ -52,6 +75,106 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
+static int __vdso_remap(enum arch_vdso_type arch_index,
+			const struct vm_special_mapping *sm,
+			struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	unsigned long vdso_size = vdso_lookup[arch_index].vdso_code_end -
+				  vdso_lookup[arch_index].vdso_code_start;
+
+	if (vdso_size != new_size)
+		return -EINVAL;
+
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
+static int __vdso_init(enum arch_vdso_type arch_index)
+{
+	int i;
+	struct page **vdso_pagelist;
+	unsigned long pfn;
+
+	if (memcmp(vdso_lookup[arch_index].vdso_code_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -EINVAL;
+	}
+
+	vdso_lookup[arch_index].vdso_pages = (
+			vdso_lookup[arch_index].vdso_code_end -
+			vdso_lookup[arch_index].vdso_code_start) >>
+			PAGE_SHIFT;
+	pr_info("%s: %ld pages (%ld code @ %p, %ld data @ %p)\n",
+		vdso_lookup[arch_index].name,
+		vdso_lookup[arch_index].vdso_pages + 1,
+		vdso_lookup[arch_index].vdso_pages,
+		vdso_lookup[arch_index].vdso_code_start, 1L, vdso_data);
+
+	/* Allocate the vDSO pagelist, plus a page for the data. */
+	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages + 1,
+				sizeof(struct page *),
+				GFP_KERNEL);
+	if (vdso_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page. */
+	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
+
+
+	/* Grab the vDSO code pages. */
+	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
+
+	for (i = 0; i < vdso_lookup[arch_index].vdso_pages; i++)
+		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+
+	vdso_lookup[arch_index].dm->pages = &vdso_pagelist[0];
+	vdso_lookup[arch_index].cm->pages = &vdso_pagelist[1];
+
+	return 0;
+}
+
+static int __setup_additional_pages(enum arch_vdso_type arch_index,
+				    struct mm_struct *mm,
+				    struct linux_binprm *bprm,
+				    int uses_interp)
+{
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	void *ret;
+
+	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
+	/* Be sure to map the data page */
+	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = ERR_PTR(vdso_base);
+		goto up_fail;
+	}
+
+	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+				       VM_READ|VM_MAYREAD,
+				       vdso_lookup[arch_index].dm);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	vdso_base += PAGE_SIZE;
+	mm->context.vdso = (void *)vdso_base;
+	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vdso_lookup[arch_index].cm);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	return 0;
+
+up_fail:
+	mm->context.vdso = NULL;
+	return PTR_ERR(ret);
+}
+
 #ifdef CONFIG_COMPAT
 /*
  * Create and map the vectors page for AArch32 tasks.
@@ -62,7 +185,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
  * 1 - sigreturn code
  */
 static struct page *aarch32_vdso_pages[2] __ro_after_init;
-static const struct vm_special_mapping aarch32_vdso_spec[2] = {
+static struct vm_special_mapping aarch32_vdso_spec[2] __ro_after_init = {
 	{
 		/* Must be named [vectors] for compatibility with arm. */
 		.name	= "[vectors]",
@@ -202,15 +325,7 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-	unsigned long vdso_size = vdso_end - vdso_start;
-
-	if (vdso_size != new_size)
-		return -EINVAL;
-
-	current->mm->context.vdso = (void *)new_vma->vm_start;
-
-	return 0;
+	return __vdso_remap(ARM64_VDSO, sm, new_vma);
 }
 
 static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
@@ -225,39 +340,10 @@ static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
 
 static int __init vdso_init(void)
 {
-	int i;
-	struct page **vdso_pagelist;
-	unsigned long pfn;
+	vdso_lookup[ARM64_VDSO].dm = &vdso_spec[0];
+	vdso_lookup[ARM64_VDSO].cm = &vdso_spec[1];
 
-	if (memcmp(vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
-		return -EINVAL;
-	}
-
-	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
-
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-				GFP_KERNEL);
-	if (vdso_pagelist == NULL)
-		return -ENOMEM;
-
-	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
-
-
-	/* Grab the vDSO code pages. */
-	pfn = sym_to_pfn(vdso_start);
-
-	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
-
-	vdso_spec[0].pages = &vdso_pagelist[0];
-	vdso_spec[1].pages = &vdso_pagelist[1];
-
-	return 0;
+	return __vdso_init(ARM64_VDSO);
 }
 arch_initcall(vdso_init);
 
@@ -265,43 +351,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
-	void *ret;
-
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	int ret;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
-	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
-				       &vdso_spec[0]);
-	if (IS_ERR(ret))
-		goto up_fail;
-
-	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
-	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(ret))
-		goto up_fail;
 
+	ret = __setup_additional_pages(ARM64_VDSO,
+				       mm,
+				       bprm,
+				       uses_interp);
 
 	up_write(&mm->mmap_sem);
-	return 0;
 
-up_fail:
-	mm->context.vdso = NULL;
-	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
+	return ret;
 }
 
 #define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D17C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:27:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5A02075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lDpH5mts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5A02075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yTUe/KvECVNoDwiHmf3I33rHISorbiz6PhELF2NpjHk=; b=lDpH5mtsU/DgLO
	mAZcJZ5ef/LQ9FzKKtxC751lXmmZvtb3eV/UFmwqQ6MBTjWoM9TFdcrxK6sXGXQdUybyeNcZfXjns
	0jOVOER9AdU7vCKGN3zeVXlOAqRoUJvMZk9XMkmJEI3qGSKZKt3dTa2hgd8LWxVGvDDhu8lrvxNIL
	76WM/cI0Gsu3eZgmR4PgE5c/dnPd5UaO4jGm4dMlO3Ckr58OyeKYP1nNxzkBbtYFuUvIoUAh3wXKw
	zRhD0Eg63wW2K2GUPGey3SiCkAUue/7oQl++3YyK5ZYwNB0dF/RnOi175xiuov/zePEDwMx7M6dJq
	y141O7IuItP5YiE7cORw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9vK-0001kn-DL; Fri, 22 Feb 2019 12:27:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9tu-0008U9-5S
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:26:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9C21682;
 Fri, 22 Feb 2019 04:25:57 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4203F690;
 Fri, 22 Feb 2019 04:25:55 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 07/23] arm64: compat: Refactor aarch32_alloc_vdso_pages()
Date: Fri, 22 Feb 2019 12:24:14 +0000
Message-Id: <20190222122430.21180-8-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042558_965160_B8E6BD60 
X-CRM114-Status: GOOD (  15.22  )
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

aarch32_alloc_vdso_pages() needs to the refactored to make it
easier to disable kuser helpers.

Divide the function in aarch32_alloc_kuser_vdso_page() and
aarch32_alloc_sigreturn_vdso_page().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 49 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 41161d5f99f7..4c9476516e2f 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -75,40 +75,55 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
 	},
 };
 
-static int __init aarch32_alloc_vdso_pages(void)
+static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
-	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
-
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
-	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
-	unsigned long vdso_pages[2];
-
-	vdso_pages[0] = get_zeroed_page(GFP_ATOMIC);
-	if (!vdso_pages[0])
-		return -ENOMEM;
+	unsigned long vdso_page;
 
-	vdso_pages[1] = get_zeroed_page(GFP_ATOMIC);
-	if (!vdso_pages[1])
+	vdso_page = get_zeroed_page(GFP_ATOMIC);
+	if (!vdso_page)
 		return -ENOMEM;
 
 	/* kuser helpers */
-	memcpy((void *)(vdso_pages[0] + 0x1000 - kuser_sz),
+	memcpy((void *)(vdso_page + 0x1000 - kuser_sz),
 	       __kuser_helper_start,
 	       kuser_sz);
 
+	flush_icache_range(vdso_page, vdso_page + PAGE_SIZE);
+
+	aarch32_vdso_pages[0] = virt_to_page(vdso_page);
+
+	return 0;
+}
+
+static int aarch32_alloc_sigreturn_vdso_page(void)
+{
+	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
+	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
+	unsigned long vdso_page;
+
+	vdso_page = get_zeroed_page(GFP_ATOMIC);
+	if (!vdso_page)
+		return -ENOMEM;
+
 	/* sigreturn code */
-	memcpy((void *)vdso_pages[1],
+	memcpy((void *)vdso_page,
 	       __aarch32_sigret_code_start,
 	       sigret_sz);
 
-	flush_icache_range(vdso_pages[0], vdso_pages[0] + PAGE_SIZE);
-	flush_icache_range(vdso_pages[1], vdso_pages[1] + PAGE_SIZE);
+	flush_icache_range(vdso_page, vdso_page + PAGE_SIZE);
 
-	aarch32_vdso_pages[0] = virt_to_page(vdso_pages[0]);
-	aarch32_vdso_pages[1] = virt_to_page(vdso_pages[1]);
+	aarch32_vdso_pages[1] = virt_to_page(vdso_page);
 
 	return 0;
+
+}
+
+static int __init aarch32_alloc_vdso_pages(void)
+{
+	return aarch32_alloc_kuser_vdso_page() &
+	       aarch32_alloc_sigreturn_vdso_page();
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75355C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E952086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l5x1i19v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E952086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ywCmZxPNxNrb4l9QUVS3OdJmDw7rT6Ee4lmxOP31qvM=; b=l5x1i19vVoKEhw
	5UBjeoUUkyTKfb/zTc7SYrNd8YPXlTZizJoXWX0NEV1okn83i9aFpelqlVDbq3E0z0QZJ+b+OelbH
	MzIc7lxXMoRleBNQLTLoyjnRoVf3feWcPQXJmRQoEBZx0F0P5T8tPg+GUQPpaS1HgQ7gNsrF9OJXj
	zIYiA8qEygDPzPhc/XOLEf8Q0JwnNsBnlL/Al24zaBxa3TCZK9d/3zZCiLK0L6Y0Fp/WPeR1jnpwK
	aZSWaWjErHtkslYU6fPX2O7TuUf+qi2bzl+V9TPNmNexRVUiU5lHrbukbeeqs107o8xK2tU2K9yF1
	P0lq/hWKAgU2lvn4kasQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtydL-0008DQ-AG; Wed, 13 Feb 2019 17:47:43 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtycG-0006nL-7m; Wed, 13 Feb 2019 17:46:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/8] initramfs: move the legacy keepinitrd parameter to core
 code
Date: Wed, 13 Feb 2019 18:46:19 +0100
Message-Id: <20190213174621.29297-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

No need to handle the freeing disable in arch code when we already
have a core hook (and a different name for the option) for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig             |  7 +++++++
 arch/arm/Kconfig         |  1 +
 arch/arm/mm/init.c       | 25 ++++++-------------------
 arch/arm64/Kconfig       |  1 +
 arch/arm64/mm/init.c     | 17 ++---------------
 arch/unicore32/Kconfig   |  1 +
 arch/unicore32/mm/init.c | 14 +-------------
 init/initramfs.c         |  9 +++++++++
 8 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..d2bf5db0805f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -245,6 +245,13 @@ config ARCH_HAS_FORTIFY_SOURCE
 	  An architecture should select this when it can successfully
 	  build and run with CONFIG_FORTIFY_SOURCE.
 
+#
+# Select if the arch provides a historic keepinit alias for the retain_initrd
+# command line option
+#
+config ARCH_HAS_KEEPINITRD
+	bool
+
 # Select if arch has all set_memory_ro/rw/x/nx() functions in asm/cacheflush.h
 config ARCH_HAS_SET_MEMORY
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..4c99a29a8ec7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -8,6 +8,7 @@ config ARM
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
+	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b7db87..d0ccbfab94db 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -752,27 +752,14 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-static int keep_initrd;
-
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd) {
-		if (start == initrd_start)
-			start = round_down(start, PAGE_SIZE);
-		if (end == initrd_end)
-			end = round_up(end, PAGE_SIZE);
+	if (start == initrd_start)
+		start = round_down(start, PAGE_SIZE);
+	if (end == initrd_end)
+		end = round_up(end, PAGE_SIZE);
 
-		poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
-		free_reserved_area((void *)start, (void *)end, -1, "initrd");
-	}
+	poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
-
-static int __init keepinitrd_setup(char *__unused)
-{
-	keep_initrd = 1;
-	return 1;
-}
-
-__setup("keepinitrd", keepinitrd_setup);
 #endif
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..74c89b628afd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..019c790d8d56 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -622,24 +622,11 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-static int keep_initrd __initdata;
-
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd) {
-		free_reserved_area((void *)start, (void *)end, 0, "initrd");
-		memblock_free(__virt_to_phys(start), end - start);
-	}
-}
-
-static int __init keepinitrd_setup(char *__unused)
-{
-	keep_initrd = 1;
-	return 1;
+	free_reserved_area((void *)start, (void *)end, 0, "initrd");
+	memblock_free(__virt_to_phys(start), end - start);
 }
-
-__setup("keepinitrd", keepinitrd_setup);
 #endif
 
 /*
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c3a41bfe161b..b924c11e3ff9 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -2,6 +2,7 @@
 config UNICORE32
 	def_bool y
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_KEEPINITRD
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_GENERIC_DMA_COHERENT
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 85ef2c624090..e3f4f791e10a 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -318,20 +318,8 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-static int keep_initrd;
-
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd)
-		free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-
-static int __init keepinitrd_setup(char *__unused)
-{
-	keep_initrd = 1;
-	return 1;
+	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
-
-__setup("keepinitrd", keepinitrd_setup);
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index c55e08f72fad..cf8bf014873f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -513,6 +513,15 @@ static int __init retain_initrd_param(char *str)
 }
 __setup("retain_initrd", retain_initrd_param);
 
+#ifdef CONFIG_ARCH_HAS_KEEPINITRD
+static int __init keepinitrd_setup(char *__unused)
+{
+	do_retain_initrd = 1;
+	return 1;
+}
+__setup("keepinitrd", keepinitrd_setup);
+#endif
+
 extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

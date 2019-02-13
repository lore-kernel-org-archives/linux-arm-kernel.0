Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1521C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DE32190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uxuoYyPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DE32190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTFLGjF3074XrNJLBvo7Wm4OUzCsm0kVO4NFM1CYqBQ=; b=uxuoYyPFw56xx5
	FdDfXaqgH4hkelNbN4WxyIgOFxeI3SzxLX9antGWs6/Jxy45/EtFh2VYtr7YaNUB/9ahunE6/2k/9
	01WVWvSrPoudHXf/JxFmPawLjRscX2hLmaj5bVVU3taXE2abyTb141fJU9ZamNBSs+kl+5EEY3oJe
	p0NklLmRRLlerW0KxgrwXAlyu3IYp1V/NzvZ3y4Klrja+batezPT9trgocyGRHKSaEwn5nO8bPN6P
	3PrTuKvoZuN2HKBDhk1BsFR6O6kiIyBrIOtcNhRmL1uz2tVb0hy5pxPJ9v7M06S1apDOVYZ1Kkk+i
	dfQknF671ioJqtUtYHpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtydB-0007xg-4B; Wed, 13 Feb 2019 17:47:33 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtycL-0006ux-DF; Wed, 13 Feb 2019 17:46:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 8/8] initramfs: poison freed initrd memory
Date: Wed, 13 Feb 2019 18:46:21 +0100
Message-Id: <20190213174621.29297-9-hch@lst.de>
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

Various architectures including x86 poison the freed initrd memory.
Do the same in the generic free_initrd_mem implementation and switch
a few more architectures that are identical to the generic code over
to it now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/init.c     | 8 --------
 arch/s390/mm/init.c     | 8 --------
 arch/sparc/mm/init_32.c | 8 --------
 arch/sparc/mm/init_64.c | 8 --------
 init/initramfs.c        | 3 ++-
 5 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index b521d8e2d359..a9a977d75838 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -492,14 +492,6 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 void (*free_init_pages_eva)(void *begin, void *end) = NULL;
 
 void __ref free_initmem(void)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3e82f66d5c61..25e3113091ea 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -154,14 +154,6 @@ void free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 unsigned long memory_block_size_bytes(void)
 {
 	/*
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d900952bfc5f..f0dbc0bde70f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -299,14 +299,6 @@ void free_initmem (void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index b4221d3727d0..4179f0e11fd5 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2602,14 +2602,6 @@ void free_initmem(void)
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
-			   "initrd");
-}
-#endif
-
 pgprot_t PAGE_KERNEL __read_mostly;
 EXPORT_SYMBOL(PAGE_KERNEL);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index f3aaa58ac63d..4a42ff3a2bd1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -529,7 +529,8 @@ extern unsigned long __initramfs_size;
 
 void __weak free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
+	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
+			"initrd");
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

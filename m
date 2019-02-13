Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF6C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FA3222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PJ5ZP3c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FA3222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gWTqduNDPVF/gszy38y4bx9jdmplgPRrcutZC8hXTls=; b=PJ5ZP3c57RAST3
	p7AlURsyv4IsOhcG4bjcDVnurUDv4I/rXxyMtZddaO6GgQdSdQbInpqwkQeeslfpcSe3KGRNTdU2F
	37vAMUVSDsCCIjxmWfKiSAy/0oQkjHhHgZlqtMw3bpgJJE+n+/s5/Qs8cVDRzzyClVWrCterJk88+
	VtjBETA/ghu4+pjLp5LYNgB7Ye+cBHM8ZJnD4quoBsVSIY50U7sjO+E/kx9ALOaBNXgoB/++B526y
	8MxyAAxyk0HTzRsqWeO5tHMKB+vLczUOIRB2qDcQzyZAcPXEIhRclBQCqT0f/DoTX5dx3vzAgLiSW
	mcDS+8enhqmIPgMmbaPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyhh-0003aq-LE; Wed, 13 Feb 2019 17:52:13 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtycB-0006gW-B2; Wed, 13 Feb 2019 17:46:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/8] initramfs: factor out a helper to populate the initrd
 image
Date: Wed, 13 Feb 2019 18:46:17 +0100
Message-Id: <20190213174621.29297-5-hch@lst.de>
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

This will allow for cleaner code sharing in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6c2ed1d7276e..c2e9a8845e98 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -595,6 +595,28 @@ static void __init clean_rootfs(void)
 	kfree(buf);
 }
 
+#ifdef CONFIG_BLK_DEV_RAM
+static void populate_initrd_image(char *err)
+{
+	ssize_t written;
+	int fd;
+
+	unpack_to_rootfs(__initramfs_start, __initramfs_size);
+
+	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
+			err);
+	fd = ksys_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	if (fd < 0)
+		return;
+
+	written = xwrite(fd, (char *)initrd_start, initrd_end - initrd_start);
+	if (written != initrd_end - initrd_start)
+		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
+		       written, initrd_end - initrd_start);
+	ksys_close(fd);
+}
+#endif /* CONFIG_BLK_DEV_RAM */
+
 static int __init populate_rootfs(void)
 {
 	/* Load the built in initramfs */
@@ -604,7 +626,6 @@ static int __init populate_rootfs(void)
 	/* If available load the bootloader supplied initrd */
 	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
 #ifdef CONFIG_BLK_DEV_RAM
-		int fd;
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
@@ -612,22 +633,7 @@ static int __init populate_rootfs(void)
 			goto done;
 
 		clean_rootfs();
-		unpack_to_rootfs(__initramfs_start, __initramfs_size);
-
-		printk(KERN_INFO "rootfs image is not initramfs (%s)"
-				"; looks like an initrd\n", err);
-		fd = ksys_open("/initrd.image",
-			      O_WRONLY|O_CREAT, 0700);
-		if (fd >= 0) {
-			ssize_t written = xwrite(fd, (char *)initrd_start,
-						initrd_end - initrd_start);
-
-			if (written != initrd_end - initrd_start)
-				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-				       written, initrd_end - initrd_start);
-
-			ksys_close(fd);
-		}
+		populate_initrd_image(err);
 	done:
 		/* empty statement */;
 #else
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

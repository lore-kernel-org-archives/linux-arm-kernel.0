Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C868FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9848A2190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFO1lC8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9848A2190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iN3VywjxvSkFdiAhaiTuvaOLar4LrGC/k2W8kojYTI=; b=bFO1lC8imHUKMc
	dlDaxj9z5C3UThPrWltv2/F/vnBNDtzOne7VsVfWakByvMdUslkgFl0rrNIMJ6tLzdzTlmZmSxtu/
	ziuX4Y87MPVNjGZJ/dMGMy4/vW+IF+hNIbvIx0mRGiQBOC0t+WzISmHmNLiM7qAhiUI2v1JMcGdg5
	W1LjT/v5hdt4dq+8pMniVzYFBT9aSA/g2i38U0FtQd0Ag8cU5dLMWhIDWw0iXh7cR2zVPRRHHJDbU
	NVNzAa8itRuQ0M2CTYjQmlOHueBqLEnPwgc0X19rSyc/ihz90WtEPyuZolpJk6IaOaJUMX/MtO47O
	mxXonhiK9b+QtCfDhyeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtycz-0007kv-VS; Wed, 13 Feb 2019 17:47:21 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtycD-0006kA-Ph; Wed, 13 Feb 2019 17:46:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/8] initramfs: cleanup populate_rootfs
Date: Wed, 13 Feb 2019 18:46:18 +0100
Message-Id: <20190213174621.29297-6-hch@lst.de>
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

The code for kernels that support ramdisks or not is mostly the
same.  Unify it by using an IS_ENABLED for the info message, and
moving the error message into a stub for populate_initrd_image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c2e9a8845e98..c55e08f72fad 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -615,6 +615,11 @@ static void populate_initrd_image(char *err)
 		       written, initrd_end - initrd_start);
 	ksys_close(fd);
 }
+#else
+static void populate_initrd_image(char *err)
+{
+	printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+}
 #endif /* CONFIG_BLK_DEV_RAM */
 
 static int __init populate_rootfs(void)
@@ -623,30 +628,22 @@ static int __init populate_rootfs(void)
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
 		panic("%s", err); /* Failed to decompress INTERNAL initramfs */
-	/* If available load the bootloader supplied initrd */
-	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
-#ifdef CONFIG_BLK_DEV_RAM
+
+	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
+		goto done;
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (!err)
-			goto done;
+	else
+		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
+	if (err) {
 		clean_rootfs();
 		populate_initrd_image(err);
-	done:
-		/* empty statement */;
-#else
-		printk(KERN_INFO "Unpacking initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (err) {
-			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-			clean_rootfs();
-		}
-#endif
 	}
 
+done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

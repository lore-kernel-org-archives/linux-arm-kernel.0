Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4409C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08752190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tlFQHJrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08752190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xPaBsiPE1XYTdOjMFdAZ30O8Vn2CltdLengPAPaTkOM=; b=tlFQHJrpyFbwCE
	ZJlHWTf/oJ2ObWMyMoCElm4sqONB7Vgt4mHAB0kVIYTmnro4v4S4H3FM0K0yqh3MEmkaAljFaXz7o
	2kNmJEHE5SG47rQc3SWdQJwN50PSIH90W88awXJ2cGo0HKQvCULTnLpY8pqc+6J+b48uGyCusprD6
	my0+jOyD+/NWo/GjXi0MCbvBXPyPBwuymrWye3z5u76hPv+tputiUO+0jHq2Qsi23HjEkNU7WHUqu
	lQdWrytZgXUu5O+DhAfjfCMpSwO6PVzfko1EGPtg3RhqWDCEnJesnM2yqPguKdXq1P0HBBDBujmXu
	Z8fhkx8lCs6vtDWgtSAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtycc-0007Lw-Bx; Wed, 13 Feb 2019 17:46:58 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyc8-0006cs-PL; Wed, 13 Feb 2019 17:46:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/8] initramfs: cleanup initrd freeing
Date: Wed, 13 Feb 2019 18:46:16 +0100
Message-Id: <20190213174621.29297-4-hch@lst.de>
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

Factor the kexec logic into a separate helper, and then inline the
rest of free_initrd into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 53 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 1cba6bbeeb75..6c2ed1d7276e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -518,37 +518,35 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
-static void __init free_initrd(void)
-{
 #ifdef CONFIG_KEXEC_CORE
+static bool kexec_free_initrd(void)
+{
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
-#endif
-	if (do_retain_initrd)
-		goto skip;
 
-#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (initrd_start < crashk_end && initrd_end > crashk_start) {
-		/*
-		 * Initialize initrd memory region since the kexec boot does
-		 * not do.
-		 */
-		memset((void *)initrd_start, 0, initrd_end - initrd_start);
-		if (initrd_start < crashk_start)
-			free_initrd_mem(initrd_start, crashk_start);
-		if (initrd_end > crashk_end)
-			free_initrd_mem(crashk_end, initrd_end);
-	} else
-#endif
-		free_initrd_mem(initrd_start, initrd_end);
-skip:
-	initrd_start = 0;
-	initrd_end = 0;
+	if (initrd_start >= crashk_end || initrd_end <= crashk_start)
+		return false;
+
+	/*
+	 * Initialize initrd memory region since the kexec boot does not do.
+	 */
+	memset((void *)initrd_start, 0, initrd_end - initrd_start);
+	if (initrd_start < crashk_start)
+		free_initrd_mem(initrd_start, crashk_start);
+	if (initrd_end > crashk_end)
+		free_initrd_mem(crashk_end, initrd_end);
+	return true;
 }
+#else
+static inline bool kexec_free_initrd(void)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_CORE */
 
 #define BUF_SIZE 1024
 static void __init clean_rootfs(void)
@@ -642,7 +640,16 @@ static int __init populate_rootfs(void)
 		}
 #endif
 	}
-	free_initrd();
+
+	/*
+	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * free only memory that is not part of crashkernel region.
+	 */
+	if (!do_retain_initrd && !kexec_free_initrd())
+		free_initrd_mem(initrd_start, initrd_end);
+	initrd_start = 0;
+	initrd_end = 0;
+
 	flush_delayed_fput();
 	return 0;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

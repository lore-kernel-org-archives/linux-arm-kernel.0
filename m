Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2592A20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uHKcQ8Nw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjA1JZCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2592A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2jg0qoyswGDk10vbbLJuKgA6HSrTXL8POTVwRJIcJoc=; b=uHKcQ8NwK+XEHD
	rGedwY5VYo6Qi2OmPsXZliGRcrP4SjuRCV7tolGpZ472cBgIKyKde1wbGD32+AVk7EPrEu/MF21f+
	9Flp/zWpYA7MCOhWd688QZvw6TTF7O1gKg+PNvjYzQmB7oLXDhrcXBh9Ae1l1FWjsN/Ye5P0O4yml
	SIyszHJIykPAwZd0pGZ5ao/Wf1U7ermMkbnyJa7tzJYAYu4/0pc5v2U5j8j7wTvEgq/5dkPfPajCc
	OK1+SwRIGxv9SjzrWwnVrDTYhFGnOo7aNyNmdVLJ24h7d77eYvpqIismQ9YIBgt6f4VkjgSDNC1S9
	CLrdJsS74vw0ekBbUSvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxFR-0006q4-Tn; Tue, 22 Jan 2019 14:41:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxF4-0006UV-SF
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:41:35 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1438621721;
 Tue, 22 Jan 2019 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548168090;
 bh=8BjUBVZCmrAANyhj3BZe6P8VfjTGGURJDzipiOghw9Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jjA1JZCXKIIzmIlK9iATEw2pkvtdWfFyrg8yAp+kgKzJvqrN7hM3ca6BwXzTDXHKI
 a3Mn3P2wv99+NRlMTtvqPpUL45tDwysnbj/6W/WW7PHhqKbycILLDk4f22Fs+sLtSc
 bDw4HkWPE4/qKXQrwfeckH4qUKmF68NxAmPC6zbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/4] arm: dump: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 15:41:12 +0100
Message-Id: <20190122144114.9816-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_064131_654849_461909FF 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Jinbum Park <jinb.park7@gmail.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jinbum Park <jinb.park7@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/ptdump.h | 9 +++------
 arch/arm/mm/dump.c            | 4 ++--
 arch/arm/mm/ptdump_debugfs.c  | 8 ++------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
index 3ebf9718288d..0c2d3d0d4cc6 100644
--- a/arch/arm/include/asm/ptdump.h
+++ b/arch/arm/include/asm/ptdump.h
@@ -21,13 +21,10 @@ struct ptdump_info {
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
-static inline int ptdump_debugfs_register(struct ptdump_info *info,
-					const char *name)
-{
-	return 0;
-}
+static inline void ptdump_debugfs_register(struct ptdump_info *info,
+					   const char *name) { }
 #endif /* CONFIG_ARM_PTDUMP_DEBUGFS */
 
 void ptdump_check_wx(void);
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 084779c5c893..eb385a500ed0 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -450,7 +450,7 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	ptdump_initialize();
-	return ptdump_debugfs_register(&kernel_ptdump_info,
-					"kernel_page_tables");
+	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	return 0;
 }
 __initcall(ptdump_init);
diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index be8d87be4b93..598b636615a2 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -24,11 +24,7 @@ static const struct file_operations ptdump_fops = {
 	.release	= single_release,
 };
 
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-	struct dentry *pe;
-
-	pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
-	return pe ? 0 : -ENOMEM;
-
+	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

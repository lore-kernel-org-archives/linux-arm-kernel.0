Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09581C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EF520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="spzunC4n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRhhNgsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EF520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=358CS94MrfwK8xOAgwcP4qHx0r6UrZNrmWxyffNuwQU=; b=spzunC4nouszCp
	c2cuTCq3M4xtIwS/daNmQOwG0fhQVtQyaW/oTjG01rglpG27Q+SNeeFW86G3N7q6OJMvzr+ost6hD
	fBPVKRv40HTPoVTLTf0CPRpxos2uYBKPbogp/7BZBO5uGM4v3RZMvT7o/4a8NDFF2cqTN0NpL5nns
	Px5TCUR0wHa6mMDG99uyBuYeQK+5Q+KweKYTL+G2SeQLug2DFVGvh0yvr9D2QNuDoTOxGME94UgRW
	ddID3/KVdnANnJQeV0dnrZ0S0gymOW/2U9KYEo0Z/RDjmeCMUG17FzPuJ3xiJB7MGlfjQGaLjj6tu
	jczQXYvTyuQ48E54JS3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxFD-0006bv-2g; Tue, 22 Jan 2019 14:41:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxF2-0006RA-Aq
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:41:33 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 799EB20855;
 Tue, 22 Jan 2019 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548168088;
 bh=+rMan51RaYrsGd1clsL6raIWizTKaNVX/cWyBz3I4IQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bRhhNgsRJ4bBuopJ2XMvhNcv1Yv8fMrIb2/iM+yLQE76etYZrzqQj1/2dO0lNYcQd
 Z0fXSeWxf2dPklZ7x3HJPAqDBiG4mNLWzFDFLdt1u1jenTxzrlQxfPIXqHBafwNOOW
 ZENY9Q1Z6bAuUYFN6UVkb0/HGcG+F6GkD2vU2iRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/4] arm64: dump: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 15:41:11 +0100
Message-Id: <20190122144114.9816-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_064128_952307_8EC09A75 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Peng Donglin <dolinux.peng@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peng Donglin <dolinux.peng@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/ptdump.h | 9 +++------
 arch/arm64/mm/dump.c            | 4 ++--
 arch/arm64/mm/ptdump_debugfs.c  | 7 ++-----
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 6afd8476c60c..9e948a93d26c 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -34,13 +34,10 @@ struct ptdump_info {
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
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
 #endif
 void ptdump_check_wx(void);
 #endif /* CONFIG_ARM64_PTDUMP_CORE */
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index fcb1f2a6d7c6..08c250350b8a 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -407,7 +407,7 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	ptdump_initialize();
-	return ptdump_debugfs_register(&kernel_ptdump_info,
-					"kernel_page_tables");
+	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 24d786fc3a4c..064163f25592 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -12,10 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
 
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-	struct dentry *pe;
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

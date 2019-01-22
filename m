Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CFDC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:42:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872A121019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ruiUjhdo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc9LH+bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872A121019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QD7nFcrqxZxWc3TJC87eK+h1lEZ1rD129EgSt/Jd20E=; b=ruiUjhdoZfc/KC
	PQL5hW0j7dGwbjtt31lBkWrwJglpMmcj1RjNryi547fuuUZcQ7iOY61lQo+vM5J24mcEoz6IB3Ob2
	dT1EzN+Tva7SPdg9Ux1ENiik2Q+/zo7G2cGybRYUZiajyN1kJVYof9d+wmBXL67TUAjFaq4AstAVO
	fw0Ahcs55ZBiGZ4nMlpca2M8OnHhnQBG6a8DZFmNZnnuyPtRR71AXhhxXuI4x64FM77lJQpeiOXyO
	yJPotpDKsTW03TzK+Tt1XHABqPRZyUUcPe8DEqq1zn/I6HdAHc+xnUTat2BR6zE0chHCUMu9sBcHp
	oCQBokKVao4gWg9Y7NAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxG4-0007UY-UZ; Tue, 22 Jan 2019 14:42:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxFA-0006a7-2G
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:41:41 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45B4F217D6;
 Tue, 22 Jan 2019 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548168095;
 bh=JBjLL9TSk/DcRzx3WlQjotQ/M37jVyqq/YrBoWKS0Hw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Oc9LH+bwETYqPMMPYduzLxssl/TIEgtp1+BPNOdaigJ/2Qk+2eUcIg8Im/wWtq0e2
 r3xFsDBRre/lXreJUM/3KLk9Za1Xd03RyhtglET+bVURiYw668ijKBA3s+WofCQwRg
 qLnFk7n22/489T8Tw4C6D0bz0arDhf5qdO9eJAkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4/4] arm: omap2: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 15:41:14 +0100
Message-Id: <20190122144114.9816-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_064136_137187_5E3825C0 
X-CRM114-Status: GOOD (  12.28  )
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
Cc: Tony Lindgren <tony@atomide.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/pm-debug.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5a8839203958..1f9334a3d611 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -193,9 +193,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 		return 0;
 
 	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
-	if (d)
-		(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
-			(void *)pwrdm, &pwrdm_suspend_fops);
+	debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d, pwrdm,
+			    &pwrdm_suspend_fops);
 
 	return 0;
 }
@@ -233,16 +232,14 @@ static int __init pm_dbg_init(void)
 		return 0;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (!d)
-		return -EINVAL;
 
-	(void) debugfs_create_file("count", 0444, d, NULL, &pm_dbg_counters_fops);
-	(void) debugfs_create_file("time", 0444, d, NULL, &pm_dbg_timers_fops);
+	debugfs_create_file("count", 0444, d, NULL, &pm_dbg_counters_fops);
+	debugfs_create_file("time", 0444, d, NULL, &pm_dbg_timers_fops);
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
-				   &enable_off_mode, &pm_dbg_option_fops);
+	debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
+			    &enable_off_mode, &pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

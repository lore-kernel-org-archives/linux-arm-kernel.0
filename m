Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF0721019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eTmdxD74";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y4R6ZdqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0oYKbaTCSU28XBOPFZ6MhQrjlM5eziUSaCrJicc2Wtw=; b=eTmdxD74Y77Tvr
	ZTg2sPhHcpOSJE/uBcjFxFkkJKQVl7BL4c/GE1OGSbIM/skvNh4ngV2w+8ewyPGK0yFR3h+jSJ8Qg
	aJ+BjfHiNbKK6kAjlnKZhjCNh7tVmQlQa4foX9SNpll5otm2fMZzz1RB44PjQSEOCLQiCZPM5oRa9
	FCjzkfswi6Qw80i/oaOYYi+gMw0RzJ97ZapBczO0+d9Ga/ek/v0+igofXz+Dg8JFObOPKlDLI5Bi3
	nGpu3Tvmy3Qn6f4B/PwfDRf20dY6gYp7wFnyZrgl4hiWeHrB0r0/KVKDVJkjufnL4Rt42MVOi9WKx
	2y8Eoo068ZckT8OUMDlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxFh-00074F-FA; Tue, 22 Jan 2019 14:42:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxF7-0006Xo-CU
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:41:36 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8706721726;
 Tue, 22 Jan 2019 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548168093;
 bh=2rmGDbNBH5/CgNPKDpWNXtKTH4HHX/G4IW9TDzzgGyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=y4R6ZdqH4OIMvuO7z1or3zb3XXTVumm17TBMgneiIksWziTj8hEe7lOFOjwoCTc3E
 xgUf9h5mZU5N8XBSmEaBkYni3VOwpyr1Y0sX0TgUZc8PgjrRznLHn+aOIoNH1MQQJ3
 RnxL5OXNXPDTpUhG1x/iu/n5Up5DzqPerX52Kszg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/4] arm: omap1: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 15:41:13 +0100
Message-Id: <20190122144114.9816-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_064133_782981_D69C803C 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Tony Lindgren <tony@atomide.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap1/clock.c | 63 +++++++------------------------------
 arch/arm/mach-omap1/pm.c    |  7 ++---
 2 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index c8c6fe88b2d6..3d7ab2bcf46c 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -990,84 +990,45 @@ static int debug_clock_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(debug_clock);
 
-static int clk_debugfs_register_one(struct clk *c)
+static void clk_debugfs_register_one(struct clk *c)
 {
-	int err;
 	struct dentry *d;
 	struct clk *pa = c->parent;
 
 	d = debugfs_create_dir(c->name, pa ? pa->dent : clk_debugfs_root);
-	if (!d)
-		return -ENOMEM;
 	c->dent = d;
 
-	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	d = debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	d = debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-	return 0;
-
-err_out:
-	debugfs_remove_recursive(c->dent);
-	return err;
+	debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
+	debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
+	debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
 }
 
-static int clk_debugfs_register(struct clk *c)
+static void clk_debugfs_register(struct clk *c)
 {
 	int err;
 	struct clk *pa = c->parent;
 
-	if (pa && !pa->dent) {
-		err = clk_debugfs_register(pa);
-		if (err)
-			return err;
-	}
+	if (pa && !pa->dent)
+		clk_debugfs_register(pa);
 
-	if (!c->dent) {
-		err = clk_debugfs_register_one(c);
-		if (err)
-			return err;
-	}
-	return 0;
+	if (!c->dent)
+		clk_debugfs_register_one(c);
 }
 
 static int __init clk_debugfs_init(void)
 {
 	struct clk *c;
 	struct dentry *d;
-	int err;
 
 	d = debugfs_create_dir("clock", NULL);
-	if (!d)
-		return -ENOMEM;
 	clk_debugfs_root = d;
 
-	list_for_each_entry(c, &clocks, node) {
-		err = clk_debugfs_register(c);
-		if (err)
-			goto err_out;
-	}
+	list_for_each_entry(c, &clocks, node)
+		clk_debugfs_register(c);
 
-	d = debugfs_create_file("summary", S_IRUGO,
-		d, NULL, &debug_clock_fops);
-	if (!d)
-		return -ENOMEM;
+	debugfs_create_file("summary", S_IRUGO, d, NULL, &debug_clock_fops);
 
 	return 0;
-err_out:
-	debugfs_remove_recursive(clk_debugfs_root);
-	return err;
 }
 late_initcall(clk_debugfs_init);
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 998075d3ef86..d068958d6f8a 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -539,11 +539,8 @@ static void omap_pm_init_debugfs(void)
 	struct dentry *d;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (!d)
-		return;
-
-	(void) debugfs_create_file("omap_pm", S_IWUSR | S_IRUGO,
-					d, NULL, &omap_pm_debug_fops);
+	debugfs_create_file("omap_pm", S_IWUSR | S_IRUGO, d, NULL,
+			    &omap_pm_debug_fops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

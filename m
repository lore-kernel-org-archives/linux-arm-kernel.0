Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F64C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:40:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B917320881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cz/CjvLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B917320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Niu30Pb2Wgd/kNYwzJX2P/1iKt38Bzi8AMV8VnAH0lA=; b=cz/CjvLdMn7vsk
	Jpt7Qp7L07ZsrQoe8deg95H5+wzXty4CpcLnvWyLqMjj/L6FR0qCFYlTqFhZ4dLiN85xwpUws1vh4
	rKAlC3rT5b3gMBRKPV4X+/ea6n92UUrfm3ou8epVEbgNOeCdSpxntSS00w6Bju/0dR3h0MNMhFZb+
	D3ehwLp2GSsJPfn9DS1vNhBfs2GjhheLL2QfSx9xru0MjXL8bxtGdKQig8p6mLKTk3Y7dbzhxIttC
	Y95rpJO/aeWx0nfovbyoxFb669Lnwp/JVi0+tB0ChT5wdxS2xqW+ibmjmRkSMr+szb314M6p3KtW7
	wHAeU7ODFH2pQ9WYXosw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxap-0006uj-It; Wed, 30 Jan 2019 21:40:23 +0000
Received: from eddie.linux-mips.org ([148.251.95.138] helo=cvs.linux-mips.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxam-0006uL-HH
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:40:22 +0000
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992792AbfA3VkSjTYCh (ORCPT
 <rfc822;linux-arm-kernel@lists.infradead.org>);
 Wed, 30 Jan 2019 22:40:18 +0100
Date: Wed, 30 Jan 2019 22:40:17 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] PM/runtime: Optimize pm_runtime_autosuspend_expiration()
Message-ID: <20190130214017.GA5038@lenoch>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_134021_334091_31CFEF55 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

pm_runtime_autosuspend_expiration calls ktime_get_mono_fast_ns
even when its returned value may be unused. Therefore get
current time later and remove gotos while there.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 This patch is based on top of bleeding-edge branch, where
 "[PATCH v2 ] PM-runtime: fix deadlock with ktime" is sitting.
 I expect v3 of that patch, which should not harm this one.
 It is meant to replace "PM/runtime: Do not needlessly call ktime_get"
 sent earlier.

 drivers/base/power/runtime.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 65e2b5f48e0c..7bbe28faca8d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -145,24 +145,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
 u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
-	u64 last_busy, expires = 0;
-	u64 now = ktime_get_mono_fast_ns();
+	u64 expires;
 
 	if (!dev->power.use_autosuspend)
-		goto out;
+		return 0;
 
 	autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
 	if (autosuspend_delay < 0)
-		goto out;
-
-	last_busy = READ_ONCE(dev->power.last_busy);
+		return 0;
 
-	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
-	if (expires <= now)
-		expires = 0;	/* Already expired. */
+	expires  = READ_ONCE(dev->power.last_busy);
+	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
+	if (expires > ktime_get_mono_fast_ns())
+		return expires;	/* Expires in the future */
 
- out:
-	return expires;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

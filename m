Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CA021871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RMXElVkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CA021871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o2Lv2D47xGKucQGIiZVQDLO2cCyHWljOnI06NwyqolM=; b=RMXElVkHDdcPjR
	Wwt3dmLAUfzu/tLCgsUZqfS0sth36RJtRDpjE8MfNLrqucZjvtXQQnTNeVydiitVnZeKXzkvrwYKu
	Qgin1xDkC3KLyPGT5AvpUphaPosp8j+zIDwT1jtV7c5TPEYY3EsuMFgvVblI6v1f98Oyq2BFImyeB
	QXdG7rDZ9XdSb3wKA+A2F9/aiBE3dftjRoWaocI6WQaz93cfEhFd5EF3SKtWEf82tmdpBnxxTJIHN
	XSC2ra0j8fnlTMit0yy2doUozzl+k9nBJPM3VDDjS3ZgHCqCiipCyK6fCqXQWGLhwtO0iIdVFEg2o
	aeWLLq8Rtf9lO8bSb8sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfeuj-000823-Tq; Sat, 05 Jan 2019 05:54:29 +0000
Received: from gateway30.websitewelcome.com ([192.185.152.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfeuh-00081J-DO
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 05:54:28 +0000
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 2FA906DD6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  4 Jan 2019 23:54:24 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id feuegcKe42qH7feuegHwbm; Fri, 04 Jan 2019 23:54:24 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46922 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gfeud-004N6I-8m; Fri, 04 Jan 2019 23:54:23 -0600
Date: Fri, 4 Jan 2019 23:54:21 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Russell King <linux@armlinux.org.uk>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] ARM: integrator: impd1: fix NULL pointer dereference
Message-ID: <418252fcd77472413ce15ac3df167e448a4defe9.1546667177.git.gustavo@embeddedor.com>
References: <cover.1546667177.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1546667177.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfeud-004N6I-8m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46922
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_215427_490692_C55C2E27 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on lookup.

This issue was detected with the help of Coccinelle.

Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - None.

 arch/arm/mach-integrator/impd1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index a109f6482413..eb0149561be2 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -392,6 +392,9 @@ static int __ref impd1_probe(struct lm_device *dev)
 			lookup = devm_kzalloc(&dev->dev,
 					      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 					      GFP_KERNEL);
+			if (!lookup)
+				return -ENOMEM;
+
 			chipname = devm_kstrdup(&dev->dev, devname, GFP_KERNEL);
 			mmciname = kasprintf(GFP_KERNEL, "lm%x:00700", dev->id);
 			lookup->dev_id = mmciname;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

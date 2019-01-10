Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79008C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBFE208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QlCYHZFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBFE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cZUUavW6gjX/XNSaM3+g2kq8737LGAynpinZwgc5Bgw=; b=QlCYHZFO9NbSFB
	/XoQDjv+iuE3+s4wmj351+3k0Qyma5Gm9NxboxtyYdKRh3ahaUsr9IulybOw5QmWfDbkTb/reqKKH
	17IJAEGBN33DLPd8EfMoyyeTGSP/2Qvu3BhG+UUUKQuIBokaCuC8oXk3mI+HNW2hUWj5EqwOK9DTs
	4LwnVrBfryhEsPWLnbQ3RJ9IjR3dpZhDgkwAwhwJsnz1B+pNS6+zTJpcJGIAqnPnf0SWHt4kMXo/s
	ycFY2cjnegM556ZfRay02j7gvFnzTz6Bn0z1I1n4AeF3N0HTPgtKqFViisJ77sEqvCLjS22NdEcgm
	JsujUjpoe7jBYoe3X3nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghedc-00040U-5n; Thu, 10 Jan 2019 18:01:04 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghebu-0000yZ-OJ
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:59:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 497091002F5;
 Thu, 10 Jan 2019 18:59:17 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wtSn1BSFsvzF; Thu, 10 Jan 2019 18:59:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id EF22D100306;
 Thu, 10 Jan 2019 18:59:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yq6oPVIWhROU; Thu, 10 Jan 2019 18:58:56 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 621BE1002FD;
 Thu, 10 Jan 2019 18:58:55 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>
Subject: [PATCH v5 08/10] power: supply: olpc_battery: Allow building the
 driver on non-x86
Date: Thu, 10 Jan 2019 18:58:43 +0100
Message-Id: <20190110175845.1203986-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_095919_173394_7A9F7E4C 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With the recent changes to the driver and addition of OLPC XO-1.75 EC
driver it is possible to use this driver on ARM-based XO laptops as
well.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/power/supply/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..66e4d1958de3 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -151,7 +151,7 @@ config BATTERY_PMU
 
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
-	depends on X86_32 && OLPC
+	depends on OLPC_EC
 	help
 	  Say Y to enable support for the battery on the OLPC laptop.
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

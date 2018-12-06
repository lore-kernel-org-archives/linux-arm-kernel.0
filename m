Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E96C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210C42082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eqAkPpCe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WyQG6iMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210C42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JiHBKbKH3FMqTQ15XW6oH30Ezx0cWU4BhPESPONtmdk=; b=eqAkPpCesdFgxOcPgI7A5+IMQP
	VTgH1QTy1KNLMYMnzyaiGoLfNq9zKhuJM8i23K9ejJ60MzmJonsoV8JrPx64DGEk2h0VXQj6u4X/L
	liQTJcweb4WgY1dHQlwLs1munqL+dxorls+48FpuiX37ApgaIh33ELfvmLLZTFiFnBWlUMQKftqYW
	neV1uvadV9b6ANqJU7UO0cyZrsB5hiZBG1O0wiFkGAwwvz01F7hH9ZPdUESzczHIy5OYFiYjIZT1f
	vy86Mj0y5/ivzeJYsOhWOuwjWtik0ZlorMwYqB/i0CGPnKNtLZY9N8tnnF/FW8lFvndY+4DeknuB/
	+r7YlBBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1y4-0005lo-R8; Thu, 06 Dec 2018 22:18:00 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1wx-00085t-8i
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:16:58 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id CFAEC25BF81;
 Fri,  7 Dec 2018 08:59:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133578; bh=U7grjBLbWCNK4XiFoCXxQoXgJFp1XiHIgghx55CM66g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WyQG6iMADQIM9V0I5yy0VD0x7Mn3mF0KOCzv8kcuBy9aaZwOlOJoyhY5Vc2Z1oxvU
 iVPaY5vhfekETCy9VkgvbbNbOrEZ/wWBuFnzssK6sbPNo4Pbw899blIIG658GBivIH
 eM4l3UzyY0s+Mow8DPkVwUvZ8rrzlCwv/qMwSxqo=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 1F118E23292; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 8/9] ARM: shmobile: R-Mobile: Clean up struct rmobile_pm_domain
Date: Thu,  6 Dec 2018 13:59:33 -0800
Message-Id: <445aeb081bc7131c0dcb0818f0326a8dd5a14a14.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141651_788235_E7DCC16C 
X-CRM114-Status: GOOD (  15.67  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 59b89af1d5551c12 ("ARM: shmobile: sh7372: Remove Legacy C
SoC code") removed the last user of the rmobile_pm_domain.resume()
callback.

Commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
for R-Mobile A1") removed the last user of the rmobile_pm_domain.no_debug
flag and of the "pm-rmobile.h" header file (outside the actual driver).

Hence remove no longer used rmobile_pm_domain members, and absorb the
header file into the driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 37 ++++++++++++++++++-------------------
 arch/arm/mach-shmobile/pm-rmobile.h | 22 ----------------------
 2 files changed, 18 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rmobile.h

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index c6a11b5ec6db..421ae1c887d8 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -18,12 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 
 #include <asm/io.h>
 
-#include "pm-rmobile.h"
-
 /* SYSC */
 #define SPDCR		0x08	/* SYS Power Down Control Register */
 #define SWUCR		0x14	/* SYS Wakeup Control Register */
@@ -32,6 +31,14 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
+struct rmobile_pm_domain {
+	struct generic_pm_domain genpd;
+	struct dev_power_governor *gov;
+	int (*suspend)(void);
+	void __iomem *base;
+	unsigned int bit_shift;
+};
+
 static inline
 struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
 {
@@ -65,16 +72,13 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
-	if (!rmobile_pd->no_debug)
-		pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n",
-			 genpd->name, mask,
-			 __raw_readl(rmobile_pd->base + PSTR));
+	pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n", genpd->name, mask,
+		 __raw_readl(rmobile_pd->base + PSTR));
 
 	return 0;
 }
 
-static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
-				 bool do_resume)
+static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
 {
 	unsigned int mask;
 	unsigned int retry_count;
@@ -85,7 +89,7 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 
 	mask = BIT(rmobile_pd->bit_shift);
 	if (__raw_readl(rmobile_pd->base + PSTR) & mask)
-		goto out;
+		return ret;
 
 	__raw_writel(mask, rmobile_pd->base + SWUCR);
 
@@ -100,21 +104,16 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 	if (!retry_count)
 		ret = -EIO;
 
-	if (!rmobile_pd->no_debug)
-		pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
-			 rmobile_pd->genpd.name, mask,
-			 __raw_readl(rmobile_pd->base + PSTR));
-
-out:
-	if (ret == 0 && rmobile_pd->resume && do_resume)
-		rmobile_pd->resume();
+	pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
+		 rmobile_pd->genpd.name, mask,
+		 __raw_readl(rmobile_pd->base + PSTR));
 
 	return ret;
 }
 
 static int rmobile_pd_power_up(struct generic_pm_domain *genpd)
 {
-	return __rmobile_pd_power_up(to_rmobile_pd(genpd), true);
+	return __rmobile_pd_power_up(to_rmobile_pd(genpd));
 }
 
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
@@ -127,7 +126,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->power_on			= rmobile_pd_power_up;
 	genpd->attach_dev		= cpg_mstp_attach_dev;
 	genpd->detach_dev		= cpg_mstp_detach_dev;
-	__rmobile_pd_power_up(rmobile_pd, false);
+	__rmobile_pd_power_up(rmobile_pd);
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
 }
 
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
deleted file mode 100644
index 69f839259b09..000000000000
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- */
-#ifndef PM_RMOBILE_H
-#define PM_RMOBILE_H
-
-#include <linux/pm_domain.h>
-
-struct rmobile_pm_domain {
-	struct generic_pm_domain genpd;
-	struct dev_power_governor *gov;
-	int (*suspend)(void);
-	void (*resume)(void);
-	void __iomem *base;
-	unsigned int bit_shift;
-	bool no_debug;
-};
-
-#endif /* PM_RMOBILE_H */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

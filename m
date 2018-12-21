Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412EA21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a1zAnEnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412EA21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bJ3zPrtMiGBdzkODj0/4huEpKaEPLUpAl8Rgp6VmlPg=; b=a1zAnEntyPDMRO
	zKnvDUJDuQBr8ZbU26qDXRiOFkPINi8n2C3MpygHLZej0vJzOTiNi0V2w4nZOZPY8G5oSenem3X7b
	Zl7rFV2nwgk6X40hKsouUnQyS/tgaOqBqovf9Ojo5OGBjP8Cbm7A0Y0RdrAj8CJijhzKrZsN9RnZq
	Wp4C4B4NlIlgZghLQNGRHUhC5FUXxB93WJM7/ZqSYUMA1DFEOyPhMg7cMqDyaNOtbDG70HrBQTkHU
	Wj+z3puDzWiE8f7M5VWs5MTfqQDdkgZpPBJwPEglMbPegcV+G3UatJyG6F85iQnS8PftzArhNa4GK
	9NP3zs7bJTZ7Pa7EF/8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQR8-0003tp-Fe; Fri, 21 Dec 2018 19:26:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQQW-0003OZ-6O
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:25:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B702615AD;
 Fri, 21 Dec 2018 11:25:36 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A539D3F575;
 Fri, 21 Dec 2018 11:25:35 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] firmware: arm_sdei: Fix DT platform device creation
Date: Fri, 21 Dec 2018 19:25:19 +0000
Message-Id: <20181221192519.94915-3-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221192519.94915-1-james.morse@arm.com>
References: <20181221192519.94915-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_112540_262839_B862928F 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out the dt-probing part of this wasn't tested properly after it
was merged. commit 3aa0582fdb82 ("of: platform: populate /firmware/ node
from of_platform_default_populate_init()") changed the core-code to
generate the platform devices, meaning the driver's attempt fails, and it
bails out.

Fix this by removing the manual platform-device creation for DT systems,
core code has always done this for us.

CC: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>

---
Why is this useful on DT systems? The spec has parts to bind interrupts
as NMI, and signal CPUs with a well known event number. As probing has
evidently never worked with DT I don't think it needs a fix/stable tag.
---
 drivers/firmware/arm_sdei.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index dffb47c6b480..c64c7da73829 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1009,7 +1009,6 @@ static struct platform_driver sdei_driver = {
 
 static bool __init sdei_present_dt(void)
 {
-	struct platform_device *pdev;
 	struct device_node *np, *fw_np;
 
 	fw_np = of_find_node_by_name(NULL, "firmware");
@@ -1019,11 +1018,7 @@ static bool __init sdei_present_dt(void)
 	np = of_find_matching_node(fw_np, sdei_of_match);
 	if (!np)
 		return false;
-
-	pdev = of_platform_device_create(np, sdei_driver.driver.name, NULL);
 	of_node_put(np);
-	if (!pdev)
-		return false;
 
 	return true;
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

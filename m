Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66081C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBD821928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BVTNwY7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBD821928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bmFhAUaV6PbvkF43DCLmwEq6FXzvW4ntcAVexQebNBM=; b=BVTNwY7W+Ia2gn
	5ApXAx7JgaeaZOOxbZpw/upfzDOO0wVc/AlJrPOIE2OF1CkcMUgMROgwgdqEB6TJdndkZAkRQEB9h
	nFDKX1P/A0VVoYLy2pJt2Y21Y6VavrmzsMWUBLe3ZkFVIvXFrxbGM+pCJr0CiXUprWZW+tMTaUL3x
	OOm85I4tW3p6i9QkbnluAQXFGtfIZvLqbiQW/68dpFO500OYYNSr6MMeDqSrtiq61QvGV9lZGeXMP
	SaI7aJOn7nh6ANPDjlGrQyhpMDK/dX+r2VPTN79ktdvOYni5UuNSPwWTs6QNSyeOc7o27HMR7EXbA
	1UWd8K/L4L09SCe2YVpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQQh-0003YH-Qf; Fri, 21 Dec 2018 19:25:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQQW-0003OX-6L
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:25:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F2BB1596;
 Fri, 21 Dec 2018 11:25:34 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F157B3F575;
 Fri, 21 Dec 2018 11:25:32 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] firmware: arm_sdei: fix wrong of_node_put() in init
 function
Date: Fri, 21 Dec 2018 19:25:18 +0000
Message-Id: <20181221192519.94915-2-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221192519.94915-1-james.morse@arm.com>
References: <20181221192519.94915-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_112540_262752_29364E93 
X-CRM114-Status: GOOD (  12.62  )
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

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

After finding a "firmware" dt node arm_sdei tries to match it's
compatible string with it. To do so it's calling of_find_matching_node()
which already takes care of decreasing the refcount on the "firmware"
node. We are then incorrectly decreasing the refcount on that node
again.

This patch removes the unwarranted call to of_node_put().

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1ea71640fdc2..dffb47c6b480 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1017,7 +1017,6 @@ static bool __init sdei_present_dt(void)
 		return false;
 
 	np = of_find_matching_node(fw_np, sdei_of_match);
-	of_node_put(fw_np);
 	if (!np)
 		return false;
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

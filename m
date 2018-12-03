Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DF3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:07:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00B720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lZauBChd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00B720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9hs3DSZj5KF+Yuob98hNoO2LkH3z2mOZX+pazxsFgM=; b=lZauBChdNsygrm
	DDNxaB5RDvUgkpS06b9MEDBNJZF1LjtEWIv7I4vINF20RHxGWarM7cOWucyG581djf1xoq6CVicyU
	Ldln94RqbSj9brY185NWy5TdeQ5UGgYOma/Pn6HJpOE+NXs5up0GBCXGOsMeutv1dEXUcuJuoDP6k
	6CP7eFg5kkdGajVk/ClwGdeXJ6SX4aswuUw2cMP9N+2kAiUXfXj7uIZzocx64h1VyuoDUD1hvcJz3
	N6QmafpO92GGrVKDYiUJl8rjcMtzuloyWCQTD0WKNd1yRGxxPjQP/iiycXqXs8aX8qeMhx+DFXNLm
	I505shBymcqK3LtqgC6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTscs-0005Qn-9t; Mon, 03 Dec 2018 18:07:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTscM-0004uH-DK
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:06:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 108D11713;
 Mon,  3 Dec 2018 10:06:50 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404C33F59C;
 Mon,  3 Dec 2018 10:06:47 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 04/25] ACPI / APEI: Make hest.c manage the estatus memory
 pool
Date: Mon,  3 Dec 2018 18:05:52 +0000
Message-Id: <20181203180613.228133-5-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100650_717348_3F489A85 
X-CRM114-Status: GOOD (  18.40  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ghes.c has a memory pool it uses for the estatus cache and the estatus
queue. The cache is initialised when registering the platform driver.
For the queue, an NMI-like notification has to grow/shrink the pool
as it is registered and unregistered.

This is all pretty noisy when adding new NMI-like notifications, it
would be better to replace this with a static pool size based on the
number of users.

As a precursor, move the call that creates the pool from ghes_init(),
into hest.c. Later this will take the number of ghes entries and
consolidate the queue allocations.
Remove ghes_estatus_pool_exit() as hest.c doesn't have anywhere to put
this.

The pool is now initialised as part of ACPI's subsys_initcall():
(acpi_init(), acpi_scan_init(), acpi_pci_root_init(), acpi_hest_init())
Before this patch it happened later as a GHES specific device_initcall().

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 33 ++++++---------------------------
 drivers/acpi/apei/hest.c |  5 +++++
 include/acpi/ghes.h      |  2 ++
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index c15264f2dc4b..78058adb2574 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -162,26 +162,16 @@ static void ghes_iounmap_irq(void)
 	clear_fixmap(FIX_APEI_GHES_IRQ);
 }
 
-static int ghes_estatus_pool_init(void)
+static int ghes_estatus_pool_expand(unsigned long len); //temporary
+
+int ghes_estatus_pool_init(void)
 {
 	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
 	if (!ghes_estatus_pool)
 		return -ENOMEM;
-	return 0;
-}
 
-static void ghes_estatus_pool_free_chunk(struct gen_pool *pool,
-					      struct gen_pool_chunk *chunk,
-					      void *data)
-{
-	vfree((void *)chunk->start_addr);
-}
-
-static void ghes_estatus_pool_exit(void)
-{
-	gen_pool_for_each_chunk(ghes_estatus_pool,
-				ghes_estatus_pool_free_chunk, NULL);
-	gen_pool_destroy(ghes_estatus_pool);
+	return ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
+					GHES_ESTATUS_CACHE_ALLOCED_MAX);
 }
 
 static int ghes_estatus_pool_expand(unsigned long len)
@@ -1225,18 +1215,9 @@ static int __init ghes_init(void)
 
 	ghes_nmi_init_cxt();
 
-	rc = ghes_estatus_pool_init();
-	if (rc)
-		goto err;
-
-	rc = ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
-				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
-	if (rc)
-		goto err_pool_exit;
-
 	rc = platform_driver_register(&ghes_platform_driver);
 	if (rc)
-		goto err_pool_exit;
+		goto err;
 
 	rc = apei_osc_setup();
 	if (rc == 0 && osc_sb_apei_support_acked)
@@ -1249,8 +1230,6 @@ static int __init ghes_init(void)
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
 
 	return 0;
-err_pool_exit:
-	ghes_estatus_pool_exit();
 err:
 	return rc;
 }
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index b1e9f81ebeea..da5fabaeb48f 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 
 #include "apei-internal.h"
 
@@ -200,6 +201,10 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
 	if (!ghes_arr.ghes_devs)
 		return -ENOMEM;
 
+	rc = ghes_estatus_pool_init();
+	if (rc)
+		goto out;
+
 	rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
 	if (rc)
 		goto err;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 82cb4eb225a4..46ef5566e052 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -52,6 +52,8 @@ enum {
 	GHES_SEV_PANIC = 0x3,
 };
 
+int ghes_estatus_pool_init(void);
+
 /* From drivers/edac/ghes_edac.c */
 
 #ifdef CONFIG_EDAC_GHES
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

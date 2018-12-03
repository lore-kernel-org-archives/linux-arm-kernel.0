Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3ECC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BA2208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hd+cFFEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BA2208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KX2Abx7Zq0QAPD/UIRmDuknI1XgjjfH63Ty6RzSiwFc=; b=hd+cFFEgvf0Lwq
	gp0Xi2KjIUxqDpwD2fJPVZahyW6COcp9TwktUoCN1c/PpCubI762tgTy5yi5eTFV6EK5R/MBpBaqd
	XiA4yjHYRT/zaGNPayhwLj+d1qv0Lwna9f4907s1kkBZxvZ27SViJ4iTZo6PqRtfrEcJVQb37Zqg+
	wi81+BGTSFdA/UzuzLDobSKNC00Vw94ttdbnnlbrqCA+V2JhGURzdosQHSUhM60G7jEY+t+9Yhd09
	wAAa8Im/X4v0/wsjX5niMqqaLlAQWw3anMqjb5ymfvwrJH6+UvWOMZL1RUMXMJtrnKCQtwJon7k1H
	1XZlt1+0oAjfGgDOiHiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTscQ-0004xD-27; Mon, 03 Dec 2018 18:06:54 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTscL-0004lT-N1
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:06:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6CA7168F;
 Mon,  3 Dec 2018 10:06:42 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BD73F59C;
 Mon,  3 Dec 2018 10:06:39 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 02/25] ACPI / APEI: Remove silent flag from
 ghes_read_estatus()
Date: Mon,  3 Dec 2018 18:05:50 +0000
Message-Id: <20181203180613.228133-3-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100649_870803_0BF2D670 
X-CRM114-Status: GOOD (  14.29  )
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

Subsequent patches will split up ghes_read_estatus(), at which
point passing around the 'silent' flag gets annoying. This is to
suppress prink() messages, which prior to commit 42a0bb3f7138
("printk/nmi: generic solution for safe printk in NMI"), were
unsafe in NMI context.

This is no longer necessary, remove the flag. printk() messages
are batched in a per-cpu buffer and printed via irq-work, or a call
back from panic().

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * Moved earlier in the series,
 * Tinkered with the commit message.
 * switched to pr_warn_ratelimited() to shut checkpatch up

shutup checkpatch
---
 drivers/acpi/apei/ghes.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ab2dae6fc7e4..e8503c7d721f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -324,7 +324,7 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	}
 }
 
-static int ghes_read_estatus(struct ghes *ghes, int silent)
+static int ghes_read_estatus(struct ghes *ghes)
 {
 	struct acpi_hest_generic *g = ghes->generic;
 	u64 buf_paddr;
@@ -333,8 +333,7 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 
 	rc = apei_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
-		if (!silent && printk_ratelimit())
-			pr_warning(FW_WARN GHES_PFX
+		pr_warn_ratelimited(FW_WARN GHES_PFX
 "Failed to read error status block address for hardware error source: %d.\n",
 				   g->header.source_id);
 		return -EIO;
@@ -366,9 +365,9 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 	rc = 0;
 
 err_read_block:
-	if (rc && !silent && printk_ratelimit())
-		pr_warning(FW_WARN GHES_PFX
-			   "Failed to read error status block!\n");
+	if (rc)
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Failed to read error status block!\n");
 	return rc;
 }
 
@@ -700,7 +699,7 @@ static int ghes_proc(struct ghes *ghes)
 {
 	int rc;
 
-	rc = ghes_read_estatus(ghes, 0);
+	rc = ghes_read_estatus(ghes);
 	if (rc)
 		goto out;
 
@@ -937,7 +936,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		return ret;
 
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-		if (ghes_read_estatus(ghes, 1)) {
+		if (ghes_read_estatus(ghes)) {
 			ghes_clear_estatus(ghes);
 			continue;
 		} else {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

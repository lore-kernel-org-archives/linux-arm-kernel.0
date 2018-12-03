Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53635C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:08:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5E220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IMrFgGKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5E220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dIqJvb69PPxO+W4ImZ15qlNikv6eGnX6xCaooo7bwIs=; b=IMrFgGKpmjGNg/
	524c4KTRAm8dRdElRRnkb0j1vfd8bGeEARSEmg8f5D5Q+xquWpv6Dr3Dfh+H+10G7Vbavd6nNVyJp
	l4pTrZ/a1fcSybkiea2jDnvQNhuAVhzgNwR/QSYLIbFSeHILrmRIkdI3i1A5WHdeRtDK7K8jbsvsX
	O5ym4c1upBA7sbJiz5v84pJDuQpS2GqTslTwhpQtPmgaf9sUT4LP613Us/LAcvt7dFbz0YwJ9wnes
	CNmdgkjMeAX/7BcE7BiXgj3R9DJYhpOENm1YzddvG6Nl4b857nyZZGrJ+E1kluiXiIrbyaJU9qKWA
	mDLCH+COkpe/V0wWqfpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsdw-0006ZV-Ph; Mon, 03 Dec 2018 18:08:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsca-00051b-2h
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EACD169E;
 Mon,  3 Dec 2018 10:06:57 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E39C3F59C;
 Mon,  3 Dec 2018 10:06:54 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 06/25] ACPI / APEI: Don't store CPER records physical
 address in struct ghes
Date: Mon,  3 Dec 2018 18:05:54 +0000
Message-Id: <20181203180613.228133-7-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100705_791935_68720A13 
X-CRM114-Status: GOOD (  17.92  )
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

When CPER records are found the address of the records is stashed
in the struct ghes. Once the records have been processed, this
address is overwritten with zero so that it won't be processed
again without being re-populated by firmware.

This goes wrong if a struct ghes can be processed concurrently,
as can happen at probe time when an NMI occurs. If the NMI arrives
on another CPU, the probing CPU may call ghes_clear_estatus() on the
records before the handler had finished with them.
Even on the same CPU, once the interrupted handler is resumed, it
will call ghes_clear_estatus() on the NMIs records, this memory may
have already been re-used by firmware.

Avoid this stashing by letting the caller hold the address. A
later patch will do away with the use of ghes->flags in the
read/clear code too.

Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v6:
 * Moved earlier in the series
 * Added buf_adder = 0 on all the error paths, and test for it in
   ghes_estatus_clear() for extra sanity.
---
 drivers/acpi/apei/ghes.c | 40 +++++++++++++++++++++++-----------------
 include/acpi/ghes.h      |  1 -
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7c2e9ac140d4..acf0c37e9af9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -305,29 +305,30 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	}
 }
 
-static int ghes_read_estatus(struct ghes *ghes)
+static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
 {
 	struct acpi_hest_generic *g = ghes->generic;
-	u64 buf_paddr;
 	u32 len;
 	int rc;
 
-	rc = apei_read(&buf_paddr, &g->error_status_address);
+	rc = apei_read(buf_paddr, &g->error_status_address);
 	if (rc) {
+		*buf_paddr = 0;
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 "Failed to read error status block address for hardware error source: %d.\n",
 				   g->header.source_id);
 		return -EIO;
 	}
-	if (!buf_paddr)
+	if (!*buf_paddr)
 		return -ENOENT;
 
-	ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
+	ghes_copy_tofrom_phys(ghes->estatus, *buf_paddr,
 			      sizeof(*ghes->estatus), 1);
-	if (!ghes->estatus->block_status)
+	if (!ghes->estatus->block_status) {
+		*buf_paddr = 0;
 		return -ENOENT;
+	}
 
-	ghes->buffer_paddr = buf_paddr;
 	ghes->flags |= GHES_TO_CLEAR;
 
 	rc = -EIO;
@@ -339,7 +340,7 @@ static int ghes_read_estatus(struct ghes *ghes)
 	if (cper_estatus_check_header(ghes->estatus))
 		goto err_read_block;
 	ghes_copy_tofrom_phys(ghes->estatus + 1,
-			      buf_paddr + sizeof(*ghes->estatus),
+			      *buf_paddr + sizeof(*ghes->estatus),
 			      len - sizeof(*ghes->estatus), 1);
 	if (cper_estatus_check(ghes->estatus))
 		goto err_read_block;
@@ -349,17 +350,20 @@ static int ghes_read_estatus(struct ghes *ghes)
 	if (rc)
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 				    "Failed to read error status block!\n");
+
 	return rc;
 }
 
-static void ghes_clear_estatus(struct ghes *ghes)
+static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr)
 {
 	ghes->estatus->block_status = 0;
 	if (!(ghes->flags & GHES_TO_CLEAR))
 		return;
-	ghes_copy_tofrom_phys(ghes->estatus, ghes->buffer_paddr,
-			      sizeof(ghes->estatus->block_status), 0);
-	ghes->flags &= ~GHES_TO_CLEAR;
+	if (buf_paddr) {
+		ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
+				      sizeof(ghes->estatus->block_status), 0);
+		ghes->flags &= ~GHES_TO_CLEAR;
+	}
 }
 
 static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
@@ -678,9 +682,10 @@ static void __ghes_panic(struct ghes *ghes)
 
 static int ghes_proc(struct ghes *ghes)
 {
+	u64 buf_paddr;
 	int rc;
 
-	rc = ghes_read_estatus(ghes);
+	rc = ghes_read_estatus(ghes, &buf_paddr);
 	if (rc)
 		goto out;
 
@@ -695,7 +700,7 @@ static int ghes_proc(struct ghes *ghes)
 	ghes_do_proc(ghes, ghes->estatus);
 
 out:
-	ghes_clear_estatus(ghes);
+	ghes_clear_estatus(ghes, buf_paddr);
 
 	if (rc == -ENOENT)
 		return rc;
@@ -910,6 +915,7 @@ static void __process_error(struct ghes *ghes)
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
+	u64 buf_paddr;
 	struct ghes *ghes;
 	int sev, ret = NMI_DONE;
 
@@ -917,8 +923,8 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		return ret;
 
 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {
-		if (ghes_read_estatus(ghes)) {
-			ghes_clear_estatus(ghes);
+		if (ghes_read_estatus(ghes, &buf_paddr)) {
+			ghes_clear_estatus(ghes, buf_paddr);
 			continue;
 		} else {
 			ret = NMI_HANDLED;
@@ -934,7 +940,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			continue;
 
 		__process_error(ghes);
-		ghes_clear_estatus(ghes);
+		ghes_clear_estatus(ghes, buf_paddr);
 	}
 
 #ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index cd9ee507d860..f82f4a7ddd90 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -22,7 +22,6 @@ struct ghes {
 		struct acpi_hest_generic_v2 *generic_v2;
 	};
 	struct acpi_hest_generic_status *estatus;
-	u64 buffer_paddr;
 	unsigned long flags;
 	union {
 		struct list_head list;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

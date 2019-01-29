Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C45C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9725F20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WwQ5g6lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+IGJvDDFK/56WeUXeUVJn5nV24nXWvLj2Slkx1/xSU=; b=WwQ5g6lzDGfsgH
	I6XoOo3X64e/u6ucdQu75Agwi8X6MiHdzcSU74y9gYp0DBsjApSKkNx7U/PrV98zv06ZgFF0mnTkt
	l6oAPrIZv1Zc8PxsOJ0bLNPV/XVGYfFWwMAVWEc7Y12t44ClsglPOspCKGehTtd0LMAdA6VG8P+CP
	NPRiv2GBzTVEUFkVfycAHmLsozH6EtvNRFX+sRVWdbUo5+jrEQmeKsDng8sTPOc1bvNC7e4HNI7yJ
	yt5Ihb5iAix1PexwF9mkSBmznJ62dljYRn/0FFCQuJIt5ewKMORUMA9yB1PDgbtB05cjsNEfD1zOL
	qIchr8vziQpUYX0sL7uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYVe-0001PJ-Md; Tue, 29 Jan 2019 18:53:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSW-0005yI-7u
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6620A78;
 Tue, 29 Jan 2019 10:50:07 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3533B3F557;
 Tue, 29 Jan 2019 10:50:05 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 10/26] ACPI / APEI: Don't allow ghes_ack_error() to mask
 earlier errors
Date: Tue, 29 Jan 2019 18:48:46 +0000
Message-Id: <20190129184902.102850-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_105008_782218_250AE780 
X-CRM114-Status: GOOD (  16.46  )
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
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, james.morse@arm.com,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

During ghes_proc() we use ghes_ack_error() to tell an external agent
we are done with these records and it can re-use the memory.

rc may hold an error returned by ghes_read_estatus(), ENOENT causes
us to skip ghes_ack_error() (as there is nothing to ack), but rc may
also by EIO, which gets supressed.

ghes_clear_estatus() is where we mark the records as processed for
non GHESv2 error sources, and already spots the ENOENT case as
buf_paddr is set to 0 by ghes_read_estatus().

Move the ghes_ack_error() call in here to avoid extra logic with
the return code in ghes_proc().

This enables GHESv2 acking for NMI-like error sources. This is safe
as the buffer is pre-mapped by map_gen_v2() before the GHES is added
to any NMI handler lists.

This same pre-mapping step means we can't receive an error from
apei_read()/write() here as apei_check_gar() succeeded when it
was mapped, and the mapping was cached, so the address can't be
rejected at runtime. Remove the error-returns as this is now
called from a function with no return.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 47 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cb3d88de711f..bd58749d31bb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -197,6 +197,21 @@ static void unmap_gen_v2(struct ghes *ghes)
 	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
 }
 
+static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
+{
+	int rc;
+	u64 val = 0;
+
+	rc = apei_read(&val, &gv2->read_ack_register);
+	if (rc)
+		return;
+
+	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
+	val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
+
+	apei_write(val, &gv2->read_ack_register);
+}
+
 static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 {
 	struct ghes *ghes;
@@ -361,6 +376,13 @@ static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr)
 
 	ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
 			      sizeof(ghes->estatus->block_status), 0);
+
+	/*
+	 * GHESv2 type HEST entries introduce support for error acknowledgment,
+	 * so only acknowledge the error if this support is present.
+	 */
+	if (is_hest_type_generic_v2(ghes))
+		ghes_ack_error(ghes->generic_v2);
 }
 
 static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
@@ -652,21 +674,6 @@ static void ghes_estatus_cache_add(
 	rcu_read_unlock();
 }
 
-static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
-{
-	int rc;
-	u64 val = 0;
-
-	rc = apei_read(&val, &gv2->read_ack_register);
-	if (rc)
-		return rc;
-
-	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
-	val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
-
-	return apei_write(val, &gv2->read_ack_register);
-}
-
 static void __ghes_panic(struct ghes *ghes, u64 buf_paddr)
 {
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
@@ -701,16 +708,6 @@ static int ghes_proc(struct ghes *ghes)
 out:
 	ghes_clear_estatus(ghes, buf_paddr);
 
-	if (rc == -ENOENT)
-		return rc;
-
-	/*
-	 * GHESv2 type HEST entries introduce support for error acknowledgment,
-	 * so only acknowledge the error if this support is present.
-	 */
-	if (is_hest_type_generic_v2(ghes))
-		return ghes_ack_error(ghes->generic_v2);
-
 	return rc;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

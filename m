Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A78C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6AC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qa9KP3DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6AC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3okNjNOeIZFcZEgmpi2l4uBXqNpCwnGAKfR6SvLMG4Q=; b=Qa9KP3DHGf7Cev
	3ZM2dQMV4smO5YtMQMY7dxRvGQ8RTKOkptpsFFIfzZx3b/ZG6rq3e0r/0LBsMMcrfb0XZJ0m0dftC
	+fHCBpSYP9Shy4W5bUFD2Q+ak+2TpDgnzXyl/d964RzhqafIXiOE6lAWcY5NeevI61kkdSnP9eubv
	a/fxWGscMWIIubgEDBxuKnUprlb7OCkIlEKuUkCgPm6L0dcCJEb9hg4rKHM0Odf2D+clJ/v4ulYwn
	W06dFYDkOmmE+/UkQuMQ0MxeYxXNACTzUNQw4MD0VAg6c9xeb5RRffDsTAGN6CyvcsWMRSq0eHFxN
	SEdrb+9Tz8i6r0xGO4xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsdg-0006Iu-CM; Mon, 03 Dec 2018 18:08:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsca-0005AL-QZ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E741713;
 Mon,  3 Dec 2018 10:07:04 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BA93F719;
 Mon,  3 Dec 2018 10:07:01 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 08/25] ACPI / APEI: Don't update struct ghes' flags in
 read/clear estatus
Date: Mon,  3 Dec 2018 18:05:56 +0000
Message-Id: <20181203180613.228133-9-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100705_757261_7C8B15DB 
X-CRM114-Status: GOOD (  14.48  )
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

ghes_read_estatus() sets a flag in struct ghes if the buffer of
CPER records needs to be cleared once the records have been
processed. This flag value is a problem if a struct ghes can be
processed concurrently, as happens at probe time if an NMI arrives
for the same error source. The NMI clears the flag, meaning the
interrupted handler may never do the ghes_estatus_clear() work.

The GHES_TO_CLEAR flags is only set at the same time as
buffer_paddr, which is now owned by the caller and passed to
ghes_clear_estatus(). Use this value as the flag.

A non-zero buf_paddr returned by ghes_read_estatus() means
ghes_clear_estatus() should clear this address. ghes_read_estatus()
already checks for a read of error_status_address being zero,
so CPER records cannot be written here.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>

--
Changes since v6:
 * Added Boris' RB, then:
 * Moved earlier in the series,
 * Tinkered with the commit message,
 * Always cleared buf_paddr on errors in the previous patch, which was
   previously in here.
---
 drivers/acpi/apei/ghes.c | 8 +-------
 include/acpi/ghes.h      | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f7a0ff1c785a..d06456e60318 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -329,8 +329,6 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
 		return -ENOENT;
 	}
 
-	ghes->flags |= GHES_TO_CLEAR;
-
 	rc = -EIO;
 	len = cper_estatus_len(ghes->estatus);
 	if (len < sizeof(*ghes->estatus))
@@ -357,13 +355,9 @@ static int ghes_read_estatus(struct ghes *ghes, u64 *buf_paddr)
 static void ghes_clear_estatus(struct ghes *ghes, u64 buf_paddr)
 {
 	ghes->estatus->block_status = 0;
-	if (!(ghes->flags & GHES_TO_CLEAR))
-		return;
-	if (buf_paddr) {
+	if (buf_paddr)
 		ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
 				      sizeof(ghes->estatus->block_status), 0);
-		ghes->flags &= ~GHES_TO_CLEAR;
-	}
 }
 
 static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index f82f4a7ddd90..e3f1cddb4ac8 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -13,7 +13,6 @@
  * estatus: memory buffer for error status block, allocated during
  * HEST parsing.
  */
-#define GHES_TO_CLEAR		0x0001
 #define GHES_EXITING		0x0002
 
 struct ghes {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

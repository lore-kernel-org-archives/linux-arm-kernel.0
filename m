Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A5C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DBA20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n9XzatLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DBA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=grekcOhKiHQez3f43qgXxQkv/dNRsH3QCtKIu5x4WBA=; b=n9XzatLHjKr6fB9ybS1TD9kabr
	Jn5Nt5itPoJUlxVj22T5/gEWcgBY9TeNL7NneJBBQHiXBmcrGzLMdrGFmsxjBwZytta1Eza1Kaj0w
	Dyw4DdUn6lgixF+hgSjtIXMC3qBz4COmna7/6UR5IaZsOPZapj6u1CVGfOuI3+GSKwQTq2ErJ8Q6f
	o1q6Je+4HZkvdSgKZRUSySCDcZ837KYif5FLp+bAvm+uONZ33EobKR66cTWmaqoFTD/PghjzTpPQf
	iIqrkOBMpV08QfGGwvzHeVCGEvaNaEChpBy0fbVwuSn6DUkfgLELDAQZQZMzmfsurfhs0DLFpTxpB
	kP+VjeLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGnv-0005dq-HW; Sat, 09 Feb 2019 00:47:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGns-0005cy-0g
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 00:47:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594EF1596;
 Fri,  8 Feb 2019 16:47:30 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB2543F719;
 Fri,  8 Feb 2019 16:47:29 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Date: Fri,  8 Feb 2019 18:47:16 -0600
Message-Id: <20190209004718.3292087-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_164732_069317_D89A7324 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, rafael.j.wysocki@intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, robert.moore@intel.com,
 linux-acpi@vger.kernel.org, lenb@kernel.org, erik.schmauss@intel.com,
 devel@acpica.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[Placeholder patch for upstream ACPICA commit]

Add just ACPI 6.3 changes associated with the arm64 SPE.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/acpi/actbl2.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c50ef7e6b942..4b58eb6cf64e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
+/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
 	u64 gicr_base_address;
 	u64 arm_mpidr;
 	u8 efficiency_class;
-	u8 reserved2[3];
+	u8 reserved2;
+	u16 spe_overflow_interrupt;
 };
 
 /* Masks for Flags field above */
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

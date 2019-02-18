Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F09C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:04:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8324520C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zxe84ozc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8324520C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPOps1AHHP0sKRRqDKy6DbsRGis9FlJwU1DjJQdgf2Y=; b=Zxe84ozcAB3SQz
	EO1SgxPgUJOPvPHBb9KH2+kuMWRA8i+ePKEST/+PRwOJ74jm8zKUJ3lunrxe0VHSQB1wkVOzgVwwU
	l+NfXO8QwdZTMHFxPe3weV2v5r5gKiHn6mH3NeN95dTngWV13cAgPIHU0P04MCW/mg+PFPP1t0D5o
	qcUsKtcieNIgShfWSHbfwt5jGb0F/cjOJAT7TJ10aAr7Y0L6xM3BlQPxbPshn2ecFKQySMw3wuyj0
	pOmBNdlAHegNL74Y3fcfKp6ZHET9J+5GOf6Hv6iEOZmu1zivohhPNyrm7yI3NrftHLrQ4cfmQH1Ho
	AVQsfvHfWUQEz5vQh5pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmLP-0004iZ-5E; Mon, 18 Feb 2019 17:04:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLC-0004VU-2K
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C9516A3;
 Mon, 18 Feb 2019 09:04:15 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22E333FB75;
 Mon, 18 Feb 2019 09:04:13 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] arm64: dump: Make kernel page table dumper dynamic again
Date: Mon, 18 Feb 2019 17:02:41 +0000
Message-Id: <20190218170245.14915-6-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090426_157242_D66BC68C 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: crecklin@redhat.com, Steve Capper <steve.capper@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The kernel page table dumper assumes that the placement of VA regions is
constant and determined at compile time. As we are about to introduce
variable VA logic, we need to be able to determine certain regions at
boot time.

This patch adds logic to the kernel page table dumper s.t. these regions
can be computed at boot time.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/mm/dump.c | 58 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 3dd9b884bd39..2196131b8e4f 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -29,23 +29,45 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
 
-static const struct addr_marker address_markers[] = {
-	{ PAGE_OFFSET,			"Linear Mapping start" },
-	{ VA_START,			"Linear Mapping end" },
+
+enum address_markers_idx {
+	PAGE_OFFSET_NR = 0,
+	VA_START_NR,
+#ifdef CONFIG_KASAN
+	KASAN_START_NR,
+	KASAN_END_NR,
+#endif
+	MODULES_START_NR,
+	MODULES_END_NR,
+	VMALLOC_START_NR,
+	VMALLOC_END_NR,
+	FIXADDR_START_NR,
+	FIXADDR_END_NR,
+	PCI_START_NR,
+	PCI_END_NR,
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	VMEMMAP_START_NR,
+#endif
+	END_NR
+};
+
+static struct addr_marker address_markers[] = {
+	{ 0 /* PAGE_OFFSET */,		"Linear Mapping start" },
+	{ 0 /* VA_START */,		"Linear Mapping end" },
 #ifdef CONFIG_KASAN
-	{ KASAN_SHADOW_START,		"Kasan shadow start" },
+	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
 #endif
 	{ MODULES_VADDR,		"Modules start" },
 	{ MODULES_END,			"Modules end" },
 	{ VMALLOC_START,		"vmalloc() area" },
-	{ VMALLOC_END,			"vmalloc() end" },
-	{ FIXADDR_START,		"Fixmap start" },
-	{ FIXADDR_TOP,			"Fixmap end" },
-	{ PCI_IO_START,			"PCI I/O start" },
-	{ PCI_IO_END,			"PCI I/O end" },
+	{ 0 /* VMALLOC_END */,		"vmalloc() end" },
+	{ 0 /* FIXADDR_START */,	"Fixmap start" },
+	{ 0 /* FIXADDR_TOP */,		"Fixmap end" },
+	{ 0 /* PCI_IO_START */,		"PCI I/O start" },
+	{ 0 /* PCI_IO_END */,		"PCI I/O end" },
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	{ VMEMMAP_START,		"vmemmap" },
+	{ 0 /* VMEMMAP_START */,	"vmemmap" },
 #endif
 	{ -1,				NULL },
 };
@@ -380,7 +402,6 @@ static void ptdump_initialize(void)
 static struct ptdump_info kernel_ptdump_info = {
 	.mm		= &init_mm,
 	.markers	= address_markers,
-	.base_addr	= PAGE_OFFSET,
 };
 
 void ptdump_check_wx(void)
@@ -406,6 +427,21 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	ptdump_initialize();
+	kernel_ptdump_info.base_addr = PAGE_OFFSET;
+	address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
+	address_markers[VA_START_NR].start_address = VA_START;
+#ifdef CONFIG_KASAN
+	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
+#endif
+	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
+	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
+	address_markers[FIXADDR_END_NR].start_address = FIXADDR_TOP;
+	address_markers[PCI_START_NR].start_address = PCI_IO_START;
+	address_markers[PCI_END_NR].start_address = PCI_IO_END;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	address_markers[VMEMMAP_START_NR].start_address = VMEMMAP_START;
+#endif
+
 	return ptdump_debugfs_register(&kernel_ptdump_info,
 					"kernel_page_tables");
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

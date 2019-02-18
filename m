Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24121C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:04:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B4920C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D33gZFdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B4920C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=04TKSjJnI7uVZS6K/1Lbuy5IgtxHTVqTOKIT9KhWbZg=; b=D33gZFdcemRxIA
	5uEiV+kqyYISi2Gd9+xnMZY7Zdb9xbgVy4bGZGvbOXtA4TlnKExfvjCPeE7mDLhbk7YI8UTkrPCa6
	4awrI3hmmGLUIO7U+84TPbYIgUghnHTgni8otVnjnhq5jRExbcpo/kHbX8xP9+M1z+00xYxC18Gxg
	lTkFg231N6d96zL2PFD/4sQqXuLYK0z9XrVLY1RPE/Q7gUCz1tvqRDNWvuWfFfsTzOWXZfankzbah
	caPj92ybxVRqidJtfQCSJdOo2fcAJSgBAYkG/ORrTqH746ROBypSeRUWmfUyxs/DaAbgn0FxKsG94
	twokmtrV+pPaZxpzbD6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmLE-0004WD-Pn; Mon, 18 Feb 2019 17:04:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLA-0004VL-8k
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0743615AB;
 Mon, 18 Feb 2019 09:04:14 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90C6E3FB75;
 Mon, 18 Feb 2019 09:04:12 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/9] arm64: mm: Replace fixed map BUILD_BUG_ON's with BUG_ON's
Date: Mon, 18 Feb 2019 17:02:40 +0000
Message-Id: <20190218170245.14915-5-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090424_321418_28DD29DA 
X-CRM114-Status: GOOD (  12.56  )
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

In order to prepare for a variable VA_BITS we need to account for a
variable size VMEMMAP which in turn means the position of the fixed map
is variable at compile time.

Thus, we need to replace the BUILD_BUG_ON's that check the fixed map
position with BUG_ON's.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7401a8481f78..c24bc447ed9c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -830,7 +830,7 @@ void __init early_fixmap_init(void)
 	 * The boot-ioremap range spans multiple pmds, for which
 	 * we are not prepared:
 	 */
-	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+	BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
 
 	if ((pmdp != fixmap_pmd(fix_to_virt(FIX_BTMAP_BEGIN)))
@@ -898,9 +898,9 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	 * On 4k pages, we'll use section mappings for the FDT so we only
 	 * have to be in the same PUD.
 	 */
-	BUILD_BUG_ON(dt_virt_base % SZ_2M);
+	BUG_ON(dt_virt_base % SZ_2M);
 
-	BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> SWAPPER_TABLE_SHIFT !=
+	BUG_ON(__fix_to_virt(FIX_FDT_END) >> SWAPPER_TABLE_SHIFT !=
 		     __fix_to_virt(FIX_BTMAP_BEGIN) >> SWAPPER_TABLE_SHIFT);
 
 	offset = dt_phys % SWAPPER_BLOCK_SIZE;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

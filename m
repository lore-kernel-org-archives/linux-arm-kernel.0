Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB320C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:34:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B605222C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmTjnFL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B605222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZDMWMNcIM5AvBawUR4vONGmZm2oCG16Mc+nJ2CKcn1A=; b=rmTjnFL6PSJ2he
	PkbSThIBDINruUmJVWCmuvKfxNkj0PawAFlQo6bCwclcv4mPxXhcWincz3qGXYY81e2TKxaPQoXyX
	i2y6d4Fp88Rfz7yJejv41UJUy8JGi06UwEIMfaL6NbF6ID0QISR/lwcvz8ZmCdfsd530zNEX7zEKN
	oDs+XCePg62ze+zJbz9UgDaX0/4jOBdXLJE1VHGe5S4Sjhf8Vh/4RR7JF1NeEk2/7x4OvXkMA/Ng6
	jeTtqyYJzZic+Mpze7xSsjM9TWjEjD/M33eVM1KNg8+p2w4z7hXSXZu4g1gdThTmOtQWc44BibqL/
	ifefvdBdJ0YhATZY+UIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtmFb-00018S-Td; Wed, 13 Feb 2019 04:34:23 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtmFY-00017s-H9
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 04:34:22 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5880A2E10681E6751E86;
 Wed, 13 Feb 2019 12:34:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 12:34:02 +0800
From: Chen Zhou <chenzhou10@huawei.com>
To: <horms@verge.net.au>, <will.deacon@arm.com>
Subject: [PATCH] ARM: kdump: 2nd kernel should use strict pfn_valid in
 SPARSEMEM platform
Date: Wed, 13 Feb 2019 12:47:57 +0800
Message-ID: <20190213044757.62597-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_203420_742687_6EB0304C 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: wangnan0@huawei.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch removes an irrational limitation for crash dump kernel on ARM
platform when SPARSEMEM enabled.

Without this patch, crash reservation area for a crash dump kernel with
SPARSEMEM selected must occupy a full section plus 1MiB. If not,
elfcorehdr and some memory space used by the first kernel will unable to
get accessed. This is caused by pfn_valid: fast pfn_valid ragards any
pfn in a valid section as valid and prevents it to be ioremapped.

This limitation wastes memory, because sections are always large and
crash dump kernel should be as small as possible.

This patch selects HAVE_ARCH_PFN_VALID for CRASH_DUMP, makes crash dump
kernel to use strict version of pfn_valid().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 813d042..84b2ae7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1589,7 +1589,7 @@ config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
 config HAVE_ARCH_PFN_VALID
-	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM || CRASH_DUMP
 
 config HAVE_GENERIC_GUP
 	def_bool y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

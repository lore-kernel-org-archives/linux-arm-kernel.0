Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:21:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B403220859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="noR+UD+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B403220859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aksyZ/AZUuwMtCkOkdKKZ0wT2ih0ApaBkJnAba5+7o4=; b=noR+UD+yeZy35l
	uFbywe9lImnWrAkGwRT720+50HzyO3WcjfNFf1gNb2db53SuVL5yL4VK1LXvUW4Rd7pphQnnMAMJn
	QAEWfDMMffcwL+/AeuIufAE+4RrZ0HW1Wubol8k1kYjkRg8F94RXEdjoE4kho8FY+voF/bYMHNCBn
	bGUqHBxcycCe7uNZuOUt3oCT1aYPc04PWBSqkEEFWdnO292i1kGKwOKcGVy757lKL4Z27gD4CzU63
	LWClhdUhtnRY7tInoZALVIVabTsrlVTF9XXvjSJj31uh8oBlsiwhroe8xYbgVgi7ODWziwjHBKv8d
	zs0zElNsMdbH3SOKzy5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghKME-0003Pn-44; Wed, 09 Jan 2019 20:21:46 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghKLj-0002qM-WB
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 20:21:19 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1ghKLg-0005pG-2E; Wed, 09 Jan 2019 13:21:14 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ghKLW-0001pA-NZ; Wed, 09 Jan 2019 13:21:02 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Wed,  9 Jan 2019 13:20:59 -0700
Message-Id: <20190109202100.6968-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190109202100.6968-1-logang@deltatee.com>
References: <20190109202100.6968-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
 catalin.marinas@arm.com, linux@armlinux.org.uk, sbates@raithlin.com,
 logang@deltatee.com, keescook@chromium.org, philip@cog.systems,
 rostedt@goodmis.org, nicolas.pitre@linaro.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/2] ARM: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_122116_068684_822ACD93 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 Stephen Bates <sbates@raithlin.com>, Philip Derrin <philip@cog.systems>,
 Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cleanup the arm_memory_present() function seeing it's very
similar to other arches.

The new memblocks_present() helper checks for node ids which the
arm version did not. However, this is equivalent seeing
HAVE_MEMBLOCK_NODE_MAP should be false in this arch and therefore
memblock_get_region_node() should return 0.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Philip Derrin <philip@cog.systems>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/init.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b7db87..6c50dd407ba8 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
 EXPORT_SYMBOL(pfn_valid);
 #endif
 
-#ifndef CONFIG_SPARSEMEM
-static void __init arm_memory_present(void)
-{
-}
-#else
-static void __init arm_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg)
-		memory_present(0, memblock_region_memory_base_pfn(reg),
-			       memblock_region_memory_end_pfn(reg));
-}
-#endif
-
 static bool arm_memblock_steal_permitted = true;
 
 phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
@@ -292,7 +277,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
 	 */
-	arm_memory_present();
+	memblocks_present();
 
 	/*
 	 * sparse_init() needs the bootmem allocator up and running.
-- 
2.19.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

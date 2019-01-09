Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:21:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8744214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tUWVWywz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8744214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F1ZmLPSG3GQhXqJk+Ma+4tuPzPaMMPjZgYaNTPnewyA=; b=tUWVWywzfTVkqX
	UnGk+nLSNej6kDxn+faHRM03DV6GTws8O+tMGG2unejs7JRVBr6q/P/aGYlWKGAETYw6CPkTtxMJF
	+sS3PUfW+mzPe0lP+EIC/lKnWZoYZZVjlMi6Lw+pcS8e9o2mqokzbzzKz17OdpqdeecNrO6OtermY
	IFPV8SwzJJWEOY7FFfli9P9Sf9k3k9mrK10UAh/Mk7QI4VgkKEBc4ZzdmMq+8nq0CRIq0fB8mp0IE
	869L2qoKJvH7UHVREf2kQNmCwkjOTGnjcLxPhJ1BWpkpbkv9aAqt2oXOVrshAxm2XaBVPNdBjXGSy
	iYCE+z8UsjpPWQpnFm/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghKLn-0002rJ-6t; Wed, 09 Jan 2019 20:21:19 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghKLj-0002pW-Hx
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 20:21:18 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1ghKLa-0005pH-Ei; Wed, 09 Jan 2019 13:21:08 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ghKLW-0001pD-QC; Wed, 09 Jan 2019 13:21:02 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Wed,  9 Jan 2019 13:21:00 -0700
Message-Id: <20190109202100.6968-3-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190109202100.6968-1-logang@deltatee.com>
References: <20190109202100.6968-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
 catalin.marinas@arm.com, linux@armlinux.org.uk, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_122115_639062_70C23C17 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Logan Gunthorpe <logang@deltatee.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cleanup the arm64_memory_present() function seeing it's very
similar to other arches.

memblocks_present() is a direct replacement of arm64_memory_present()

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/init.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..2302b4093a63 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -285,24 +285,6 @@ int pfn_valid(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_valid);
 
-#ifndef CONFIG_SPARSEMEM
-static void __init arm64_memory_present(void)
-{
-}
-#else
-static void __init arm64_memory_present(void)
-{
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg) {
-		int nid = memblock_get_region_node(reg);
-
-		memory_present(nid, memblock_region_memory_base_pfn(reg),
-				memblock_region_memory_end_pfn(reg));
-	}
-}
-#endif
-
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
 /*
@@ -489,7 +471,7 @@ void __init bootmem_init(void)
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
 	 */
-	arm64_memory_present();
+	memblocks_present();
 
 	sparse_init();
 	zone_sizes_init(min, max);
-- 
2.19.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

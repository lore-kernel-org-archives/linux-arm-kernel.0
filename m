Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:59:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3024A20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tjg3sHtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3024A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=c7dgFmpfXhiT50AERpjTzqmDeYAvrVzmI/AIRKTsMjM=; b=tjg3sHtFOIcjJ5CGeR/uNo1GjL
	HZV6ZURxoljfVn0j1H3XN5e+phmgoAEU29UAWd+niX/QPO7W/Sg1J56m+rr2L80cI6g3XVnH/5dZR
	NAIjiB7Vk5BQGQLkDRMpRamKrHwrEhJr2IN9r8kSwCDu+O0nSB4fZ3xTjUxDsvXgfadtR9h7IYmCe
	BpXN4eGHgeIBBmVJohoEC9gkGOgiOlcoahnwD1YOGl/jxutWAR/jb7E/mY592Hf0DAV4xA7nZwwOp
	l/WDg6UhxPurlFy3BbqW3tf/Wpw2+Z7+o9J2ebr5UZQBsGdJuMdVriJ79yWF/Ag+RDGyYT3txok6m
	sGFsQmEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1q4-0005th-6l; Mon, 14 Jan 2019 12:59:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1py-0005qa-O3; Mon, 14 Jan 2019 12:59:32 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49D2289AC1;
 Mon, 14 Jan 2019 12:59:30 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D587E5D76A;
 Mon, 14 Jan 2019 12:59:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 1/9] agp: efficeon: no need to set PG_reserved on GATT
 tables
Date: Mon, 14 Jan 2019 13:58:55 +0100
Message-Id: <20190114125903.24845-2-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 14 Jan 2019 12:59:30 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_045930_807698_77986FC9 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@redhat.com>, David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The l1 GATT page table is kept in a special on-chip page with 64 entries.
We allocate the l2 page table pages via get_zeroed_page() and enter them
into the table. These l2 pages are modified accordingly when
inserting/removing memory via efficeon_insert_memory and
efficeon_remove_memory.

Apart from that, these pages are not exposed or ioremap'ed. We can stop
setting them reserved (propably copied from generic code).

Cc: David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/char/agp/efficeon-agp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index 7f88490b5479..c53f0f9ef5b0 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -163,7 +163,6 @@ static int efficeon_free_gatt_table(struct agp_bridge_data *bridge)
 		unsigned long page = efficeon_private.l1_table[index];
 		if (page) {
 			efficeon_private.l1_table[index] = 0;
-			ClearPageReserved(virt_to_page((char *)page));
 			free_page(page);
 			freed++;
 		}
@@ -219,7 +218,6 @@ static int efficeon_create_gatt_table(struct agp_bridge_data *bridge)
 			efficeon_free_gatt_table(agp_bridge);
 			return -ENOMEM;
 		}
-		SetPageReserved(virt_to_page((char *)page));
 
 		for (offset = 0; offset < PAGE_SIZE; offset += clflush_chunk)
 			clflush((char *)page+offset);
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

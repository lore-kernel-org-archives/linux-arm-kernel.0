Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728F9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C61A2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZufpleBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C61A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AS27PTm3UpEnxoDJPXXY1ZZjra75RsKolVUmT6e8MBg=; b=ZufpleBEW1WHsskIwl8H3PjMRj
	boFqXrg13VkZ/nltEU/rXXhfD7gLVRhxTJrg8ndYrWNIHCRW/rSdRswBL50T0bpZEGjxvjBDc0HwE
	MkxyNjBclOY0FVQni0O2r/nqmEQ/0uaB1i+P4vK1uCadlI5SLNXHq8Mer2CYX32qTvh/WTC/nKaOE
	4riijtLYzubIpuWPHaZPcBjLbFOh/tj1qfj7hH9WioaL1zFKmn+PlHnJA5hxXBk9vIriw6MLO0c8/
	QPML/bg6jL2kwFjKNzAAzv6xpTwqbAQQGhcjUg8llvGDrYgDLnG0IDN3nIrN7YPE1eb8Kx+ZIsG6I
	B7jxKynA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWLd-0004TG-Dc; Wed, 05 Dec 2018 12:32:13 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWJo-0002JH-I2; Wed, 05 Dec 2018 12:30:39 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B69453078A25;
 Wed,  5 Dec 2018 12:30:19 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C16E183D2;
 Wed,  5 Dec 2018 12:30:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 7/7] mm: better document PG_reserved
Date: Wed,  5 Dec 2018 13:28:51 +0100
Message-Id: <20181205122851.5891-8-david@redhat.com>
In-Reply-To: <20181205122851.5891-1-david@redhat.com>
References: <20181205122851.5891-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 05 Dec 2018 12:30:20 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_043021_379489_A2FF4589 
X-CRM114-Status: GOOD (  15.81  )
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
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Miles Chen <miles.chen@mediatek.com>, David Hildenbrand <david@redhat.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, yi.z.zhang@linux.intel.com,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Anthony Yznaga <anthony.yznaga@oracle.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The usage of PG_reserved and how PG_reserved pages are to be treated is
burried deep down in different parts of the kernel. Let's shine some light
onto these details by documenting (most?) current users and expected
behavior.

I don't see a reason why we have to document "Some of them might not even
exist". If there is a user, we should document it. E.g. for balloon
drivers we now use PG_offline to indicate that a page might currently
not be backed by memory in the hypervisor. And that is independent from
PG_reserved.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: yi.z.zhang@linux.intel.com
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 68b8495e2fbc..112526f5ba61 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,8 +17,22 @@
 /*
  * Various page->flags bits:
  *
- * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist...
+ * PG_reserved is set for special pages. The "struct page" of such a page
+ * should in general not be touched (e.g. set dirty) except by their owner.
+ * Pages marked as PG_reserved include:
+ * - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
+ * - Pages allocated early during boot (bootmem, memblock)
+ * - Zero pages
+ * - Pages that have been associated with a zone but are not available for
+ *   the page allocator (e.g. excluded via online_page_callback())
+ * - Pages to exclude from the hibernation image (e.g. loaded kexec images)
+ * - MMIO pages (communicate with a device, special caching strategy needed)
+ * - MCA pages on ia64 (pages with memory errors)
+ * - Device memory (e.g. PMEM, DAX, HMM)
+ * Some architectures don't allow to ioremap pages that are not marked
+ * PG_reserved (as they might be in use by somebody else who does not respect
+ * the caching strategy). Consequently, PG_reserved for a page mapped into
+ * user space can indicate the zero page, the vDSO, MMIO pages or device memory.
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

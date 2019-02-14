Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F684C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FD3222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GyuUi6Ku";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o4Pyezdi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWgMzsoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FD3222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yq4uMMZYfdn8rubHAj4XWG6T4GB4PQbC+jJkxn3vTrE=; b=GyuUi6KuCLHDeSRmaGV97Ydndb
	NNS7MPdFYSSCXENG4SH4d6JrejQnPRVPXlPiIdKXlysxI1+cOSZVuxzYx3M+CznIyIP/hKGyBPOVW
	cyVfPshlUHsQLI/jkJa4gOduPB+4SVmJxJkOdKzfLWLP3asjpAqsqETfeDzp6aRNtC3UxMhnpepRA
	TNskF0Ck5SgNs3pXIR5COzyEFrwm5dkkMxsHmIqFnvJsEwtZOp4JxgoWOQfLHtywXgWCYONke7B/v
	NQN3vIY85bYgIXuDB2wnZNE5KRXpVWISm2g5ca4vS5OQ1Wf2w+cGHUmpt+oHeqCIs+A1VZMxgNaQN
	Fakgr2aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4n8-0000jW-MV; Thu, 14 Feb 2019 00:22:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4mw-0008SM-94
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 00:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ov6dF12doUxji6ePINUtaYIJxqhm2/VTB1zpiOjT1tA=; b=o4Pyezdi5DGkNeOZJ7+ieqka0
 Tt8HyqdHqzqH9zRLbMrCJ01CNv2/rOX0rNaq5Q72YR2bdDanxwNohSg5oYm+AWCDXrb8uiBPnwaZg
 9KLPPyaHGxB84SjaGV5DfGs5JgqtbkixEdqFOlot0nGD7cRaf8L6t24Fw0vXkZAoBkckMmnGBzPpD
 BmAV7QQo9zAKDtZVUIyZnDF+YRb0uG058Qx4kbdOgvqJcLrWzoLIW+QDGtqL6HDSpoiTDc6NlOHnd
 354hrR6PVFQl8WavzX+groe//aNyk5cVAqJA4dLaBvOUhQPv3oHexhznlOhtYIh8fau6lBWEC3acD
 HrqHWc9cA==;
Received: from userp2120.oracle.com ([156.151.31.85])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4VE-00052c-VZ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:03:56 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwk6t099402;
 Thu, 14 Feb 2019 00:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=Ov6dF12doUxji6ePINUtaYIJxqhm2/VTB1zpiOjT1tA=;
 b=HWgMzsoVLWuxYs5bJDKNiffhWGRMwUJsNHgz0cMMCPscT4fdXMdRnfNdp9sKENEJvwft
 TXF3uWQrqHXeKNtriV1PxiSLggLWtrKHDZbqDPKfC2vSDmyGgCvykt4L33owldrq6md1
 TQQBpA6dSqxhEIVIk5w1iCvxCAnQfbKcOuFvv8SErUpmXO8Gu4GIlFIIKLHDLf3O5o4+
 ufPr2YjYEzK5U4hHeZSfwBGrufuBkFk0aiuvWEs187yLF1EZ2nbUxudhQYjrx/FwpdC3
 jHTyqjS/1miNz9E4XceIQ4rlIkCOYGq8Vpq/8qTkxjsEyQH8SgC1/wxD+ys2W18dm4Sm 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2120.oracle.com with ESMTP id 2qhree55nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02TBh001559
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:30 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E02TYJ018941;
 Thu, 14 Feb 2019 00:02:29 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Feb 2019 16:02:29 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
 catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
 konrad.wilk@oracle.com
Subject: [RFC PATCH v8 14/14] xpfo,
 mm: Optimize XPFO TLB flushes by batching them together
Date: Wed, 13 Feb 2019 17:01:37 -0700
Message-Id: <6a92971cd9b360ec1b0ae75887f33f67774d681a.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_000354_593035_B484AED1 
X-CRM114-Status: GOOD (  33.88  )
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
Cc: kernel-hardening@lists.openwall.com, peterz@infradead.org,
 dave.hansen@intel.com, Khalid Aziz <khalid.aziz@oracle.com>,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com, hch@lst.de,
 x86@kernel.org, kanth.ghatraju@oracle.com, labbott@redhat.com,
 pradeep.vincent@oracle.com, jcm@redhat.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, linux-mm@kvack.org,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, tglx@linutronix.de, oao.m.martins@oracle.com,
 dwmw@amazon.co.uk, kirill.shutemov@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When XPFO forces a TLB flush on all cores, the performance impact is
very significant. Batching as many of these TLB updates as
possible can help lower this impact. When a userspace allocates a
page, kernel tries to get that page from the per-cpu free list.
This free list is replenished in bulk when it runs low. Free
list is being replenished for future allocation to userspace is a
good opportunity to update TLB entries in batch and reduce the
impact of multiple TLB flushes later. This patch adds new tags for
the page so a page can be marked as available for userspace
allocation and unmapped from kernel address space. All such pages
are removed from kernel address space in bulk at the time they are
added to per-cpu free list. This patch when combined with deferred
TLB flushes improves performance further. Using the same benchmark
as before of building kernel in parallel, here are the system
times on two differently sized systems:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

4.20					950.966s
4.20+XPFO				25073.169s	26.366x
4.20+XPFO+Deferred flush		1372.874s	1.44x
4.20+XPFO+Deferred flush+Batch update	1255.021s	1.32x

Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

4.20					607.671s
4.20+XPFO				1588.646s	2.614x
4.20+XPFO+Deferred flush		803.989s	1.32x
4.20+XPFO+Deferred flush+Batch update	795.728s	1.31x

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 arch/x86/mm/xpfo.c         |  5 +++++
 include/linux/page-flags.h |  5 ++++-
 include/linux/xpfo.h       |  8 ++++++++
 mm/page_alloc.c            |  4 ++++
 mm/xpfo.c                  | 35 +++++++++++++++++++++++++++++++++--
 5 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
index d3833532bfdc..fb06bb3cb718 100644
--- a/arch/x86/mm/xpfo.c
+++ b/arch/x86/mm/xpfo.c
@@ -87,6 +87,11 @@ inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
 
 }
 
+void xpfo_flush_tlb_all(void)
+{
+	xpfo_flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
+}
+
 inline void xpfo_flush_kernel_tlb(struct page *page, int order)
 {
 	int level;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a532063f27b5..fdf7e14cbc96 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -406,9 +406,11 @@ PAGEFLAG(Idle, idle, PF_ANY)
 PAGEFLAG(XpfoUser, xpfo_user, PF_ANY)
 TESTCLEARFLAG(XpfoUser, xpfo_user, PF_ANY)
 TESTSETFLAG(XpfoUser, xpfo_user, PF_ANY)
+#define __PG_XPFO_USER	(1UL << PG_xpfo_user)
 PAGEFLAG(XpfoUnmapped, xpfo_unmapped, PF_ANY)
 TESTCLEARFLAG(XpfoUnmapped, xpfo_unmapped, PF_ANY)
 TESTSETFLAG(XpfoUnmapped, xpfo_unmapped, PF_ANY)
+#define __PG_XPFO_UNMAPPED	(1UL << PG_xpfo_unmapped)
 #endif
 
 /*
@@ -787,7 +789,8 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON)
+	(((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON & ~__PG_XPFO_USER & \
+					~__PG_XPFO_UNMAPPED)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 1dd590ff1a1f..c4f6c99e7380 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -34,6 +34,7 @@ void set_kpte(void *kaddr, struct page *page, pgprot_t prot);
 void xpfo_dma_map_unmap_area(bool map, const void *addr, size_t size,
 				    enum dma_data_direction dir);
 void xpfo_flush_kernel_tlb(struct page *page, int order);
+void xpfo_flush_tlb_all(void);
 
 void xpfo_kmap(void *kaddr, struct page *page);
 void xpfo_kunmap(void *kaddr, struct page *page);
@@ -55,6 +56,8 @@ bool xpfo_enabled(void);
 
 phys_addr_t user_virt_to_phys(unsigned long addr);
 
+bool xpfo_pcp_refill(struct page *page, enum migratetype migratetype,
+		     int order);
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_init_single_page(struct page *page) { }
@@ -82,6 +85,11 @@ static inline bool xpfo_enabled(void) { return false; }
 
 static inline phys_addr_t user_virt_to_phys(unsigned long addr) { return 0; }
 
+static inline bool xpfo_pcp_refill(struct page *page,
+				   enum migratetype migratetype, int order)
+{
+}
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d00382b20001..5702b6fa435c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2478,6 +2478,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			int migratetype)
 {
 	int i, alloced = 0;
+	bool flush_tlb = false;
 
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
@@ -2503,6 +2504,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
+		flush_tlb |= xpfo_pcp_refill(page, migratetype, order);
 	}
 
 	/*
@@ -2513,6 +2515,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock(&zone->lock);
+	if (flush_tlb)
+		xpfo_flush_tlb_all();
 	return alloced;
 }
 
diff --git a/mm/xpfo.c b/mm/xpfo.c
index 5157cbebce4b..7f78d00df002 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -47,7 +47,8 @@ void __meminit xpfo_init_single_page(struct page *page)
 
 void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 {
-	int i, flush_tlb = 0;
+	int i;
+	bool flush_tlb = false;
 
 	if (!static_branch_unlikely(&xpfo_inited))
 		return;
@@ -65,7 +66,7 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 			 * was previously allocated to the kernel.
 			 */
 			if (!TestSetPageXpfoUser(page + i))
-				flush_tlb = 1;
+				flush_tlb = true;
 		} else {
 			/* Tag the page as a non-user (kernel) page */
 			ClearPageXpfoUser(page + i);
@@ -74,6 +75,8 @@ void xpfo_alloc_pages(struct page *page, int order, gfp_t gfp)
 
 	if (flush_tlb)
 		xpfo_flush_kernel_tlb(page, order);
+
+	return;
 }
 
 void xpfo_free_pages(struct page *page, int order)
@@ -190,3 +193,31 @@ void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 			kunmap_atomic(mapping[i]);
 }
 EXPORT_SYMBOL(xpfo_temp_unmap);
+
+bool xpfo_pcp_refill(struct page *page, enum migratetype migratetype,
+		     int order)
+{
+	int i;
+	bool flush_tlb = false;
+
+	if (!static_branch_unlikely(&xpfo_inited))
+		return false;
+
+	for (i = 0; i < 1 << order; i++) {
+		if (migratetype == MIGRATE_MOVABLE) {
+			/* GPF_HIGHUSER **
+			 * Tag the page as a user page, mark it as unmapped
+			 * in kernel space and flush the TLB if it was
+			 * previously allocated to the kernel.
+			 */
+			if (!TestSetPageXpfoUnmapped(page + i))
+				flush_tlb = true;
+			SetPageXpfoUser(page + i);
+		} else {
+			/* Tag the page as a non-user (kernel) page */
+			ClearPageXpfoUser(page + i);
+		}
+	}
+
+	return(flush_tlb);
+}
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

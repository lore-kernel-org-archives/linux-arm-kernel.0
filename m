Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C7C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:02:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A852086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpI7HyoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A852086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=k+Q+IwV3mmsF/+eSQgFKDgGy1M6QGBR1zECcNhvMYWw=; b=MpI7HyoY8aQemL+vGH3qjk2Kf6
	AEAcpAYJseL7/3NM7dboZEnc9zAyZMtGSOw1u+vk8LJr4jRy3+KXbiuzcG/2x0cd2Rugy24HmIqEY
	Hyu8dxQpmg8rwsYOiQjTkamOhEBdfT5XriFBFtbyRz9L6fdEry3Jm9R6dnOLvxDuCnPgaYc9fG9OE
	9EZNGMLSMqSgg5D1hkKflcmZvl1+Wa/uj4IPbzsJWYcK26yNAaMdF0ZAq0B3w6mZEtszffTOSVMOt
	y393AHpwXtpagC2e+FhUdlQUa4+LUP7rRObM+yFj70m0UhyEit5rFzs8qAAQdpO5zbIycsIEgTrXT
	G/nxcjeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1sN-00012S-JQ; Mon, 14 Jan 2019 13:01:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1rC-0008Lg-L4; Mon, 14 Jan 2019 13:01:26 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1E207FD56;
 Mon, 14 Jan 2019 13:00:44 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41B9E5D76A;
 Mon, 14 Jan 2019 13:00:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 8/9] ia64: perfmon: Don't mark buffer pages as PG_reserved
Date: Mon, 14 Jan 2019 13:59:02 +0100
Message-Id: <20190114125903.24845-9-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 14 Jan 2019 13:00:46 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_050047_209497_8F1A5B14 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: linux-s390@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
 linux-m68k@lists.linux-m68k.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the old days, remap_pfn_range() required pages to be marked as
PG_reserved, so they would e.g. never get swapped out. This was required
for special mappings. Nowadays, this is fully handled via the VMA
(VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP inside remap_pfn_range()
to be precise). PG_reserved is no longer required but only a relict from
the past.

So only architecture specific MM handling might require it (e.g. to
detect them as MMIO pages). As there are no architecture specific checks
for PageReserved() apart from MCA handling in ia64code, this can go. Use
simple vzalloc()/vfree() instead.

Note that before calling vzalloc(), size has already been aligned to
PAGE_SIZE, no need to align again.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/ia64/kernel/perfmon.c | 59 +++-----------------------------------
 1 file changed, 4 insertions(+), 55 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 46bff1661836..7a969f4c3534 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -583,17 +583,6 @@ pfm_put_task(struct task_struct *task)
 	if (task != current) put_task_struct(task);
 }
 
-static inline void
-pfm_reserve_page(unsigned long a)
-{
-	SetPageReserved(vmalloc_to_page((void *)a));
-}
-static inline void
-pfm_unreserve_page(unsigned long a)
-{
-	ClearPageReserved(vmalloc_to_page((void*)a));
-}
-
 static inline unsigned long
 pfm_protect_ctx_ctxsw(pfm_context_t *x)
 {
@@ -816,44 +805,6 @@ pfm_reset_msgq(pfm_context_t *ctx)
 	DPRINT(("ctx=%p msgq reset\n", ctx));
 }
 
-static void *
-pfm_rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long addr;
-
-	size = PAGE_ALIGN(size);
-	mem  = vzalloc(size);
-	if (mem) {
-		//printk("perfmon: CPU%d pfm_rvmalloc(%ld)=%p\n", smp_processor_id(), size, mem);
-		addr = (unsigned long)mem;
-		while (size > 0) {
-			pfm_reserve_page(addr);
-			addr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-	}
-	return mem;
-}
-
-static void
-pfm_rvfree(void *mem, unsigned long size)
-{
-	unsigned long addr;
-
-	if (mem) {
-		DPRINT(("freeing physical buffer @%p size=%lu\n", mem, size));
-		addr = (unsigned long) mem;
-		while ((long) size > 0) {
-			pfm_unreserve_page(addr);
-			addr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-		vfree(mem);
-	}
-	return;
-}
-
 static pfm_context_t *
 pfm_context_alloc(int ctx_flags)
 {
@@ -1498,7 +1449,7 @@ pfm_free_smpl_buffer(pfm_context_t *ctx)
 	/*
 	 * free the buffer
 	 */
-	pfm_rvfree(ctx->ctx_smpl_hdr, ctx->ctx_smpl_size);
+	vfree(ctx->ctx_smpl_hdr);
 
 	ctx->ctx_smpl_hdr  = NULL;
 	ctx->ctx_smpl_size = 0UL;
@@ -2137,7 +2088,7 @@ pfm_close(struct inode *inode, struct file *filp)
 	 * All memory free operations (especially for vmalloc'ed memory)
 	 * MUST be done with interrupts ENABLED.
 	 */
-	if (smpl_buf_addr)  pfm_rvfree(smpl_buf_addr, smpl_buf_size);
+	vfree(smpl_buf_addr);
 
 	/*
 	 * return the memory used by the context
@@ -2266,10 +2217,8 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 
 	/*
 	 * We do the easy to undo allocations first.
- 	 *
-	 * pfm_rvmalloc(), clears the buffer, so there is no leak
 	 */
-	smpl_buf = pfm_rvmalloc(size);
+	smpl_buf = vzalloc(size);
 	if (smpl_buf == NULL) {
 		DPRINT(("Can't allocate sampling buffer\n"));
 		return -ENOMEM;
@@ -2346,7 +2295,7 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 error:
 	vm_area_free(vma);
 error_kmem:
-	pfm_rvfree(smpl_buf, size);
+	vfree(smpl_buf);
 
 	return -ENOMEM;
 }
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

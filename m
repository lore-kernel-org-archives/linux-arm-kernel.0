Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:13:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C0A2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kG6QnhRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C0A2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3VKsxyH4FJQD/0G/rpT1vV+mVqNtKcNr7qFZaL0CWts=; b=kG6QnhRnCFNNx1AWxnRotYdn+N
	HI6Y5ddGEh9ez47fD6ZdNj8Gu0YsXRkvn4vMoO2kBwJehqaHRaJ6JYu+im9iOy8+XfigFl5rtcYog
	RUfcmusLsECZ8qK5/v0wUQTrXhIy1GagmW1aVJgMWwVwIQON64RmcrrzoPc/g7yd9MunDiOa1bObE
	tns2W+/603UipVLFXFhGUsHtKR3DuiJLIw7BMEcFoFfh3+5bTApxirrXCVVf0tNP+3gntJnVbAYc0
	Ixz6XzygjEC7uFDVK3FYHXu+Mqzz3OkCevMDB7d0rbq7hqr3OOCDAx2ESQ2Xdf4Mge7qpR6RKhkRQ
	NO1a6XrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXlPU-0001mF-SW; Fri, 14 Dec 2018 11:13:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXlNL-0007zE-Mi; Fri, 14 Dec 2018 11:11:35 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03073307CDFE;
 Fri, 14 Dec 2018 11:11:21 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-139.ams2.redhat.com [10.36.117.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F18FD61295;
 Fri, 14 Dec 2018 11:11:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 8/9] ia64: perfmon: Don't mark buffer pages as PG_reserved
Date: Fri, 14 Dec 2018 12:10:13 +0100
Message-Id: <20181214111014.15672-9-david@redhat.com>
In-Reply-To: <20181214111014.15672-1-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 14 Dec 2018 11:11:21 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_031124_255844_E9393D98 
X-CRM114-Status: GOOD (  15.07  )
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
index a9d4dc6c0427..e1b9287dc455 100644
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
@@ -817,44 +806,6 @@ pfm_reset_msgq(pfm_context_t *ctx)
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
@@ -1499,7 +1450,7 @@ pfm_free_smpl_buffer(pfm_context_t *ctx)
 	/*
 	 * free the buffer
 	 */
-	pfm_rvfree(ctx->ctx_smpl_hdr, ctx->ctx_smpl_size);
+	vfree(ctx->ctx_smpl_hdr);
 
 	ctx->ctx_smpl_hdr  = NULL;
 	ctx->ctx_smpl_size = 0UL;
@@ -2138,7 +2089,7 @@ pfm_close(struct inode *inode, struct file *filp)
 	 * All memory free operations (especially for vmalloc'ed memory)
 	 * MUST be done with interrupts ENABLED.
 	 */
-	if (smpl_buf_addr)  pfm_rvfree(smpl_buf_addr, smpl_buf_size);
+	vfree(smpl_buf_addr);
 
 	/*
 	 * return the memory used by the context
@@ -2267,10 +2218,8 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
 
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
@@ -2347,7 +2296,7 @@ pfm_smpl_buffer_alloc(struct task_struct *task, struct file *filp, pfm_context_t
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

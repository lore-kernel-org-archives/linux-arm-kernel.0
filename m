Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9023BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:51:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C8A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WwBEVAkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vKryr8D1u4tBORk82NfwB6l3ZTT0UuhIwwct71iNI4Q=; b=WwBEVAkj2ip7CW
	gDQdNcjJQMtAPH3XPUfYhfQcQJSgjDuH6p+7YU0gaBRl85yYKMo7DYxoXAAaFRZTeNJjFTrBHatX8
	zJIpzi8rx4z+CTkyZUp3qGKTr+RY8NnU57XXr/QPPj/oGRyabEpEV6shkL3UuhDkriRzJ5mWtyb2J
	42oiR12TMOgmH0EYjatu/3nZHXA5ZWAZCG+AD0ALkda5wDfN90kqANA2n5rizUZzPTE9mdRHH4Xws
	8mpwT5uKx27SlctkZk7V2wNzPg165rEFdHrtHwrqANQCn0Tlx3V3NzIRwmT8DX4KZbPJlY9QAtMlt
	z4DPZ8KLJzqQB3Emgi7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2UJ-0001qd-I9; Thu, 06 Dec 2018 22:51:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2U6-0001gd-TC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:51:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBB3015AB;
 Thu,  6 Dec 2018 14:50:57 -0800 (PST)
Received: from capper-debian.arm.com (unknown [10.37.12.92])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B5193F5AF;
 Thu,  6 Dec 2018 14:50:56 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 1/7] mm: mmap: Allow for "high" userspace addresses
Date: Thu,  6 Dec 2018 22:50:36 +0000
Message-Id: <20181206225042.11548-2-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206225042.11548-1-steve.capper@arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_145106_949674_6208B043 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: ard.biesheuvel@linaro.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 Steve Capper <steve.capper@arm.com>, will.deacon@arm.com, jcm@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for "high" userspace addresses that are
optionally supported on the system and have to be requested via a hint
mechanism ("high" addr parameter to mmap).

Architectures such as powerpc and x86 achieve this by making changes to
their architectural versions of arch_get_unmapped_* functions. However,
on arm64 we use the generic versions of these functions.

Rather than duplicate the generic arch_get_unmapped_* implementations
for arm64, this patch instead introduces two architectural helper macros
and applies them to arch_get_unmapped_*:
 arch_get_mmap_end(addr) - get mmap upper limit depending on addr hint
 arch_get_mmap_base(addr, base) - get mmap_base depending on addr hint

If these macros are not defined in architectural code then they default
to (TASK_SIZE) and (base) so should not introduce any behavioural
changes to architectures that do not define them.

Signed-off-by: Steve Capper <steve.capper@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

---

Changed in V4, added Catalin's reviewed by

Changed in V3, commit log cleared up, explanation given for why core
code change over just architectural change
---
 mm/mmap.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6c04292e16a7..7bb64381e77c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2066,6 +2066,15 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	return gap_end;
 }
 
+
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr, base) (base)
+#endif
+
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
@@ -2085,8 +2094,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
 	struct vm_unmapped_area_info info;
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
 
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -2095,7 +2105,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma_prev(mm, addr, &prev);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)) &&
 		    (!prev || addr >= vm_end_gap(prev)))
 			return addr;
@@ -2104,7 +2114,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
+	info.high_limit = mmap_end;
 	info.align_mask = 0;
 	return vm_unmapped_area(&info);
 }
@@ -2124,9 +2134,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE - mmap_min_addr)
+	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED)
@@ -2136,7 +2147,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma_prev(mm, addr, &prev);
-		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
 				(!vma || addr + len <= vm_start_gap(vma)) &&
 				(!prev || addr >= vm_end_gap(prev)))
 			return addr;
@@ -2145,7 +2156,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = mm->mmap_base;
+	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.align_mask = 0;
 	addr = vm_unmapped_area(&info);
 
@@ -2159,7 +2170,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
-		info.high_limit = TASK_SIZE;
+		info.high_limit = mmap_end;
 		addr = vm_unmapped_area(&info);
 	}
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A45C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:04:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C8E2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="guvwnYGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C8E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XfY7mkEcmQ5j+fH2tstsblb+XPrg6ff11jOtONYkjE0=; b=guv
	wnYGU3wiZam2K1jis4aJZTN15DAeTSqi5knQ7PcgJGaQfW50HkdvGyjmxINfMg/A9JReC8EhI/iL3
	NZAUNPcbWZu8jp4rGWqoHw9xyoagPfNbmm93vC1n7W1Yc9X+J3q+sULgfpkmlWfIa8p1heYm2PQwl
	8CS3jrN1gJxv1zf9mkNwClSufSnH8kOY9YAfrSgCLKhyzmUKem1mZjDil1Hk1lx+JonAv+/J2FVIL
	AfRe143hK/Bh6B8NfpKhSBYZXF9Yjgj8AsqJeJFSsj7qVP7iHMC/lKsZmY+HfG7Xjpu3aMWhabnPZ
	6PfVoIgK+q1b4AjkFw3AFDfkRPaiqNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy8RA-0006I7-LQ; Mon, 25 Feb 2019 05:04:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy8R0-000692-3w
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 05:04:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B016F80D;
 Sun, 24 Feb 2019 21:04:02 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.42.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0B9A3F5C1;
 Sun, 24 Feb 2019 21:03:59 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 0/6] arm64/mm: Enable accounting for page table pages
Date: Mon, 25 Feb 2019 10:33:53 +0530
Message-Id: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_210410_166781_B58F63A4 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, yuzhao@google.com, Steve.Capper@arm.com,
 marc.zyngier@arm.com, Catalin.Marinas@arm.com, suzuki.poulose@arm.com,
 will.deacon@arm.com, james.morse@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently page table page allocation and release has multiple combinations
for user space and kernel mapping page tables. Not only this is vulnerable
for bad page state errors it also prevents accurate accounting for those
pages through NR_PAGETABLE. This patch series attempts to standardize all
(except PGD slab cache 'pdg_cache') page table page allocation and release
through pte_alloc_one()/pte_free() which in turn guarantees that all these
pages will go trough pgtable_page_[ctor|dtor] constructs. It also takes
care of some of the pages who might have been allocated early via memblock.

This enables memcg based accounting for user process page table pages via
__GFP_ACCOUNT. For now this also removes standard ptable page allocators
usage from KVM stage-2 as some of them use multi order allocation which is
not supported in a generic way.

While here, enable ARCH_ENABLE_SPLIT_PMD_PTLOCK which can improve memory
scalability on larger systems. This enablement was first proposed [1] by
Yu Zhao using generic pgtable_pmd_page_ctor() which does not take zone stat
and page state into account. Hence the current proposal tries to merge both
through an arm64 specific helper pgtable_pmd_page_ctor_workaround() which
should eventually be dropped once we fix generic functions.

[1] https://patchwork.kernel.org/patch/10813793/

Changes in V2:

- Created temporary page structures in __[pmd|pud]_free_tlb per Will
- Incorporated efi_mm while determining pgtable allocation flag per Will
- Dropped parts of commit message from patch 'arm64/mm: Make all page table pages'
- Dropped patch 'arm64/mm: Ensure PGD kmem cache object is actually allocated'
- Added new patch 'arm64/mm: Enable ARCH_ENABLE_SPLIT_PMD_PTLOCK'

V1: https://www.spinics.net/lists/arm-kernel/msg701954.html

Anshuman Khandual (6):
  KVM: ARM: Remove pgtable standard functions from stage-2 page tables
  arm64/mm: Make pgd_pgtable_alloc() call pte_alloc_one() always
  arm64/mm: Make all page table pages cycles through standard constructs
  arm64/mm: Call pgtable_page_dtor() for both PMD and PUD page table pages
  arm64/mm: Enable page table page accounting for user space
  arm64/mm: Enable ARCH_ENABLE_SPLIT_PMD_PTLOCK

 arch/arm/include/asm/stage2_pgtable.h   |  4 +-
 arch/arm64/Kconfig                      |  4 ++
 arch/arm64/include/asm/pgalloc.h        | 95 ++++++++++++++++++++++---
 arch/arm64/include/asm/stage2_pgtable.h |  4 +-
 arch/arm64/include/asm/tlb.h            |  6 ++
 arch/arm64/mm/mmu.c                     | 17 +++--
 arch/arm64/mm/pgd.c                     |  4 +-
 7 files changed, 115 insertions(+), 19 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

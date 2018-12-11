Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E9EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D832081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jWz7GwQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D832081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=f44Hl/wtfAmbdCDkeT0FfrmnZSrWX5A1sRzqjVwKdMc=; b=jWz
	7GwQFcD0QJan3+DBnP5nbjGiejdDcdxPMrPXdzndjGSxtzQlFSp6vcr6CcuBm/fipdN2sZz26r/YE
	po6fizSjmPOitJb7n4bcR38A8YYImprcX8LRlwkSZW6sMwOZBfPsErGfeYCqeXLt1NS7pGm5trpCU
	dPj8P3DCiccu0yFwAcwVqTOrovIGweuExRhXoxe/Ocym3UGCbLliETjBZxrFtZgJxuUzXyy9uuZzJ
	MBBpEAjrXeYCPP73MHmtvUyaq/JBj1/tA+uPPY4BKTjCNd7bcn8pAV9n2m7uKej6s+2728B98DFsQ
	0r368emc5rk1eU3ZaL8JUfbZkWeOtZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlaJ-0003OT-OS; Tue, 11 Dec 2018 17:12:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlZw-00032u-Nx
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:12:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C65D1596;
 Tue, 11 Dec 2018 09:12:06 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4E9E23F6A8; Tue, 11 Dec 2018 09:12:04 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 0/8] kvm: arm64: Support PUD hugepage at stage 2
Date: Tue, 11 Dec 2018 17:10:33 +0000
Message-Id: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091216_848483_BE50FF9D 
X-CRM114-Status: GOOD (  16.83  )
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
Cc: kvm@vger.kernel.org, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, will.deacon@arm.com,
 christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series is an update to the PUD hugepage support previously posted
at [0]. This patchset adds support for PUD hugepages at stage 2 a
feature that is useful on cores that have support for large sized TLB
mappings (e.g., 1GB for 4K granule).

The patches are based on v4.20-rc4

The patches have been tested on AMD Seattle system with the following
hugepage sizes - 2M and 1G.

Right now the PUD hugepage for stage2 is only supported if the stage2
has 4 levels. i.e, with an IPA size of minimum 44bits with 4K pages.
This could be relaxed to stage2 with 3 levels, with the stage1 PUD huge
page mapped in the entry level of the stage2 (i.e, pgd). I have not
added the change here to keep this version stable w.r.t the previous
version. I could post a patch later after further discussions in the
list.


[0] https://patchwork.kernel.org/cover/10622379/

v9 -> v10
* Address comments on v9. Mainly converting BUG() => WARN_ON(1)
  in arm32 for PUD helpers.
* Dropped Suzuki's "Review" tags from the patches which were modified.

v8 -> v9

* Dropped bugfix patch 1 which has been merged

v7 -> v8

* Add kvm_stage2_has_pud() helper on arm32
* Rebased to v6 of 52bit dynamic IPA support

v6 -> v7

* Restrict thp check to exclude hugetlbfs pages - Patch 1
* Don't update PUD entry if there's no change - Patch 9
* Add check for PUD level in stage 2 - Patch 9

v5 -> v6

* Split Patch 1 to move out the refactoring of exec permissions on
  page table entries.
* Patch 4 - Initialise p*dpp pointers in stage2_get_leaf_entry()
* Patch 5 - Trigger a BUG() in kvm_pud_pfn() on arm

v4 -> v5:
* Patch 1 - Drop helper stage2_should_exec() and refactor the
  condition to decide if a page table entry should be marked
  executable
* Patch 4-6 - Introduce stage2_get_leaf_entry() and use it in this and
  latter patches
* Patch 7 - Use stage 2 accessors instead of using the page table
  helpers directly
* Patch 7 - Add a note to update the PUD hugepage support when number
  of levels of stage 2 tables differs from stage 1

v3 -> v4:
* Patch 1 and 7 - Don't put down hugepages pte if logging is enabled
* Patch 4-5 - Add PUD hugepage support for exec and access faults
* Patch 6 - PUD hugepage support for aging page table entries

v2 -> v3:
* Update vma_pagesize directly if THP [1/4]. Previsouly this was done
  indirectly via hugetlb
* Added review tag [4/4]

v1 -> v2:
* Create helper to check if the page should have exec permission [1/4]
* Fix broken condition to detect THP hugepage [1/4]
* Fix in-correct hunk resulting from a rebase [4/4]

Punit Agrawal (8):
  KVM: arm/arm64: Share common code in user_mem_abort()
  KVM: arm/arm64: Re-factor setting the Stage 2 entry to exec on fault
  KVM: arm/arm64: Introduce helpers to manipulate page table entries
  KVM: arm64: Support dirty page tracking for PUD hugepages
  KVM: arm64: Support PUD hugepage in stage2_is_exec()
  KVM: arm64: Support handling access faults for PUD hugepages
  KVM: arm64: Update age handlers to support PUD hugepages
  KVM: arm64: Add support for creating PUD hugepages at stage 2

 arch/arm/include/asm/kvm_mmu.h         |  61 +++++++
 arch/arm/include/asm/stage2_pgtable.h  |   5 +
 arch/arm64/include/asm/kvm_mmu.h       |  48 +++++
 arch/arm64/include/asm/pgtable-hwdef.h |   4 +
 arch/arm64/include/asm/pgtable.h       |   9 +
 virt/kvm/arm/mmu.c                     | 312 ++++++++++++++++++++++++---------
 6 files changed, 360 insertions(+), 79 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

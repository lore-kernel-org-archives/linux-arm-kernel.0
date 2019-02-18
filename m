Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D56C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A9C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/lEpmUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A9C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pqKd9g6JIdQnEwSia6i4ck3ufS6rxI0OhY8x8y20F9c=; b=d/lEpmUyAbGhga
	6vnoLxxFsKu/Y2lm/++ui0F9asLIAX7HIiZJPvC6xh3XVaZo+terh0wZJfSYx0ZivKCsYPcgod6yv
	UXGaAFne3vtMYncFkXq3ma/dQ+INjvFo7zixt7wFWmccXqUkxumqnL24KYtYHguMgxs9L8bPulQXu
	sV9tR/r1QR3NbnIRKutzwiupa1e7w02MSPqGN4bbNSofdVI2u7Y7/h3CavETLzaF7xu5hhifb3pFs
	CbSOvvbQYJVczhHaw52SsSuh1jLA2K7eJiadOt5zic4azSW9HFuL3mo5zDguP6rzz8EdHTLQqNtYk
	jw+fXwHG7XUqcLR06qKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmLY-0004vM-LJ; Mon, 18 Feb 2019 17:04:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmL9-0004VK-Ua
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 373D41684;
 Mon, 18 Feb 2019 09:04:14 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E44FC3F740;
 Mon, 18 Feb 2019 09:04:07 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] arm/arm64: KVM: Formalise end of direct linear map
Date: Mon, 18 Feb 2019 17:02:37 +0000
Message-Id: <20190218170245.14915-2-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090429_686428_CB1F3E08 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: crecklin@redhat.com, Steve Capper <steve.capper@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We assume that the direct linear map ends at ~0 in the KVM HYP map
intersection checking code. This assumption will become invalid later on
for arm64 when the address space of the kernel is re-arranged.

This patch introduces a new constant PAGE_OFFSET_END for both arm and
arm64 and defines it to be ~0UL

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/include/asm/memory.h   | 1 +
 arch/arm64/include/asm/memory.h | 1 +
 virt/kvm/arm/mmu.c              | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ed8fd0d19a3e..45c211fd50da 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -24,6 +24,7 @@
 
 /* PAGE_OFFSET - the virtual address of the start of the kernel image */
 #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
+#define PAGE_OFFSET_END		(~0UL)
 
 #ifdef CONFIG_MMU
 
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0c656850eeea..617071dbad06 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -52,6 +52,7 @@
 	(UL(1) << VA_BITS) + 1)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
 	(UL(1) << (VA_BITS - 1)) + 1)
+#define PAGE_OFFSET_END		(~0UL)
 #define KIMAGE_VADDR		(MODULES_END)
 #define BPF_JIT_REGION_START	(VA_START + KASAN_SHADOW_SIZE)
 #define BPF_JIT_REGION_SIZE	(SZ_128M)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 30251e288629..94496bdffb49 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2179,10 +2179,10 @@ int kvm_mmu_init(void)
 	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
 	kvm_debug("HYP VA range: %lx:%lx\n",
 		  kern_hyp_va(PAGE_OFFSET),
-		  kern_hyp_va((unsigned long)high_memory - 1));
+		  kern_hyp_va(PAGE_OFFSET_END));
 
 	if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
-	    hyp_idmap_start <  kern_hyp_va((unsigned long)high_memory - 1) &&
+	    hyp_idmap_start <  kern_hyp_va(PAGE_OFFSET_END) &&
 	    hyp_idmap_start != (unsigned long)__hyp_idmap_text_start) {
 		/*
 		 * The idmap page is intersecting with the VA space,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

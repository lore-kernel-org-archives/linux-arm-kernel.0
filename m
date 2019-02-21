Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1249DC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:35:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D894721848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxUBQ6MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D894721848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BSGJfWkxISE9F8OFLrQNaSLxBQ1sgAnQWgHuy4OeK1A=; b=qxUBQ6MZe0AqBO
	WX/CAruwtXYGyEvG4D9qk/1jTr+/UuTrTlp42VfH5YyRbQbfoKjZUZ6ixHTGlR115757zABfMauwg
	R6DIqcsUwMnUWB7sqxXCDfBhPQqzLUP1Pko+tUobMVt8NuFQAejO8dP/XmXzBV0sPkX/GR92ITFAl
	MW1F0ZHIXOuugcpYQG3eGMy/5X3oD/yC1LfdKCLASGyyoGNUeevclFcz5fYz2KE1pGFJrKehoaAcx
	/0n4998ZxK4VFiRGm/YzyZ2qNQTJ1Qyi5bwatbVleNsXVd45lL3JpNvRyaLMeIm+Q0kNuq/I2QMRP
	CHihGq+aHRX5aSs5GNYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmdh-0004YD-Bz; Thu, 21 Feb 2019 11:35:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmdP-00045i-H9
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:35:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33748165C;
 Thu, 21 Feb 2019 03:35:23 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A693F3F5C1;
 Thu, 21 Feb 2019 03:35:19 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 02/13] x86/mm: Add p?d_large() definitions
Date: Thu, 21 Feb 2019 11:34:51 +0000
Message-Id: <20190221113502.54153-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221113502.54153-1-steven.price@arm.com>
References: <20190221113502.54153-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_033523_924910_C7E0DCC1 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Exposing the pud/pgd levels of the page tables to walk_page_range() means
we may come across the exotic large mappings that come with large areas
of contiguous memory (such as the kernel's linear map).

Expose p?d_large() from each architecture to detect these large mappings.

x86 already has these defined as inline functions, add a macro of the
same name so we don't end up with the generic version too.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/include/asm/pgtable.h | 3 +++
 arch/x86/mm/dump_pagetables.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..3695f6acb6af 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -234,6 +234,7 @@ static inline int pmd_large(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
 }
+#define pmd_large(x)	pmd_large(x)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
@@ -873,6 +874,7 @@ static inline int pud_large(pud_t pud)
 	return 0;
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
+#define pud_large(x)	pud_large(x)
 
 static inline unsigned long pud_index(unsigned long address)
 {
@@ -1214,6 +1216,7 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 }
 
 static inline int pgd_large(pgd_t pgd) { return 0; }
+#define pgd_large(x)	pgd_large(x)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e3cdc85ce5b6..cf37abc0f58a 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -432,6 +432,7 @@ static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
 
 #else
 #define walk_pmd_level(m,s,a,e,p) walk_pte_level(m,s,__pmd(pud_val(a)),e,p)
+#undef pud_large
 #define pud_large(a) pmd_large(__pmd(pud_val(a)))
 #define pud_none(a)  pmd_none(__pmd(pud_val(a)))
 #endif
@@ -469,6 +470,7 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 
 #else
 #define walk_pud_level(m,s,a,e,p) walk_pmd_level(m,s,__pud(p4d_val(a)),e,p)
+#undef p4d_large
 #define p4d_large(a) pud_large(__pud(p4d_val(a)))
 #define p4d_none(a)  pud_none(__pud(p4d_val(a)))
 #endif
@@ -503,6 +505,7 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
 	}
 }
 
+#undef pgd_large
 #define pgd_large(a) (pgtable_l5_enabled() ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
 #define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AABC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:08:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D9020842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F3AcZbBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D9020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ncOkv7wXRnH0tpOoo4mmgohnWtm1HMPhrEO6cxIZj8I=; b=F3AcZbBMXkjgwL
	n/MBOi9p3Qp/yq9rKNBRu0FhsocLXjFk35EVuSDfWnFd8qfMgDEgZKufonD7sHYadfleMi6rCAQDM
	vlrFKrxLgE82G7s1ERToRrCYLRnuCP22/M4QfayamR/mVIspumq9m3vQcraEGbqzegRIVqC2x7X3v
	kqRTmMB1QE4MZifGDNNA2glnXFo3kdzzw1mGx/X7AJG9Z+l7fWunaumAL7QpVoIdcpCnNIcOVspQX
	LhCJ5bJfNcmSG9w5LREyINX3QfDcS0vYIoi+qdc2/CQ3zo4eqODoA1h/HNQuL/Vu0rWXu6lGloQ+A
	oWVG1i45iRkrehK85Obw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2hL-0001aI-6A; Wed, 27 Feb 2019 17:08:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2fe-000889-LX
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:07:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D221684;
 Wed, 27 Feb 2019 09:07:02 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABECA3F738;
 Wed, 27 Feb 2019 09:06:58 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 09/34] m68k: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:43 +0000
Message-Id: <20190227170608.27963-10-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_090703_196617_698E3F2F 
X-CRM114-Status: GOOD (  13.46  )
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
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-m68k@lists.linux-m68k.org, linux-arm-kernel@lists.infradead.org, "Liang,
 Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For m68k, we don't support large pages, so add stubs returning 0

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linux-m68k@lists.linux-m68k.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
 arch/m68k/include/asm/motorola_pgtable.h | 2 ++
 arch/m68k/include/asm/pgtable_no.h       | 1 +
 arch/m68k/include/asm/sun3_pgtable.h     | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 5d5502cb2b2d..63827d28a017 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -196,11 +196,13 @@ static inline int pmd_none2(pmd_t *pmd) { return !pmd_val(*pmd); }
 static inline int pmd_bad2(pmd_t *pmd) { return 0; }
 #define pmd_bad(pmd) pmd_bad2(&(pmd))
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
+#define pmd_large(pmd) (0)
 static inline void pmd_clear(pmd_t *pmdp) { pmd_val(*pmdp) = 0; }
 
 static inline int pgd_none(pgd_t pgd) { return 0; }
 static inline int pgd_bad(pgd_t pgd) { return 0; }
 static inline int pgd_present(pgd_t pgd) { return 1; }
+static inline int pgd_large(pgd_t pgd) { return 0; }
 static inline void pgd_clear(pgd_t *pgdp) {}
 
 #define pte_ERROR(e) \
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 7f66a7bad7a5..a649eb8a91de 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -138,6 +138,7 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_bad(pmd)		((pmd_val(pmd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pmd_present(pmd)	(pmd_val(pmd) & _PAGE_TABLE)
+#define pmd_large(pmd)		(0)
 #define pmd_clear(pmdp) ({			\
 	unsigned long *__ptr = pmdp->pmd;	\
 	short __i = 16;				\
@@ -150,6 +151,7 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		((pgd_val(pgd) & _DESCTYPE_MASK) != _PAGE_TABLE)
 #define pgd_present(pgd)	(pgd_val(pgd) & _PAGE_TABLE)
+#define pgd_large(pgd)		(0)
 #define pgd_clear(pgdp)		({ pgd_val(*pgdp) = 0; })
 #define pgd_page(pgd)		(mem_map + ((unsigned long)(__va(pgd_val(pgd)) - PAGE_OFFSET) >> PAGE_SHIFT))
 
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc3a96c77bd8..eeef17b2eae8 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -17,6 +17,7 @@
  * Trivial page table functions.
  */
 #define pgd_present(pgd)	(1)
+#define pgd_large(pgd)		(0)
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
 #define pgd_clear(pgdp)
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index c987d50866b4..eea72e3515db 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -143,6 +143,7 @@ static inline int pmd_bad2 (pmd_t *pmd) { return 0; }
 static inline int pmd_present2 (pmd_t *pmd) { return pmd_val (*pmd) & SUN3_PMD_VALID; }
 /* #define pmd_present(pmd) pmd_present2(&(pmd)) */
 #define pmd_present(pmd) (!pmd_none2(&(pmd)))
+#define pmd_large(pmd) (0)
 static inline void pmd_clear (pmd_t *pmdp) { pmd_val (*pmdp) = 0; }
 
 static inline int pgd_none (pgd_t pgd) { return 0; }
@@ -150,6 +151,7 @@ static inline int pgd_bad (pgd_t pgd) { return 0; }
 static inline int pgd_present (pgd_t pgd) { return 1; }
 static inline void pgd_clear (pgd_t *pgdp) {}
 
+static inline int pgd_large(pgd_t pgd) { return 0; }
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

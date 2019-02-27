Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A55C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E936D20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X986gP4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E936D20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/tZMPLJVjHEp2hjvhPcD95CcV0iAZ2EQFel5OOOnW4E=; b=X986gP4zoYzhwe
	z0WH6j/2KYdpEebro29/sTb/LloiBsKkH+P/S/omrSBVy+62Ooc4M8DNad8MNjfEKhZUrGQ2pScLR
	QpHMD4XJufQOasEdwy3s2Gl2Bp9W7TuHa1DACtdU1ifWzwBLeYCUbxXWy8/+Cu26IkyywJzhgilZ9
	lbkDlXq+1zN1FbYRwMUUihjDmwNdiBx7GpDxR5/OicsgIhb9xpj8wIVtQTPnp0uL6Pd4kiiUlv/8e
	IHlwZrerMqAnRXFdYJ0c29NKGc+WOqcnaSMyYIMTQ1seG4upW8WtZt2WL53TzdyJ7UrhvDbPplkrl
	pb0Qo/g6ZT4+R3WRPiIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2hh-00023b-43; Wed, 27 Feb 2019 17:09:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2fm-0008K6-43
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:07:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC55B16A3;
 Wed, 27 Feb 2019 09:07:09 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240003F738;
 Wed, 27 Feb 2019 09:07:06 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 11/34] mips: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:45 +0000
Message-Id: <20190227170608.27963-12-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_090710_545574_5D2770D2 
X-CRM114-Status: GOOD (  13.72  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
 Steven Price <steven.price@arm.com>, Ingo Molnar <mingo@redhat.com>,
 James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For mips, we don't support large pages on 32 bit so add stubs returning 0.
For 64 bit look for _PAGE_HUGE flag being set. This means exposing the
flag when !CONFIG_MIPS_HUGE_TLB_SUPPORT.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: Paul Burton <paul.burton@mips.com>
CC: James Hogan <jhogan@kernel.org>
CC: linux-mips@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/mips/include/asm/pgtable-32.h   |  5 +++++
 arch/mips/include/asm/pgtable-64.h   | 15 +++++++++++++++
 arch/mips/include/asm/pgtable-bits.h |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 74afe8c76bdd..58cab62d768b 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -104,6 +104,11 @@ static inline int pmd_present(pmd_t pmd)
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
 }
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return 0;
+}
+
 static inline void pmd_clear(pmd_t *pmdp)
 {
 	pmd_val(*pmdp) = ((unsigned long) invalid_pte_table);
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 93a9dce31f25..981930e1f843 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -204,6 +204,11 @@ static inline int pgd_present(pgd_t pgd)
 	return pgd_val(pgd) != (unsigned long)invalid_pud_table;
 }
 
+static inline int pgd_large(pgd_t pgd)
+{
+	return 0;
+}
+
 static inline void pgd_clear(pgd_t *pgdp)
 {
 	pgd_val(*pgdp) = (unsigned long)invalid_pud_table;
@@ -273,6 +278,11 @@ static inline int pmd_present(pmd_t pmd)
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
 }
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return (pmd_val(pmd) & _PAGE_HUGE) != 0;
+}
+
 static inline void pmd_clear(pmd_t *pmdp)
 {
 	pmd_val(*pmdp) = ((unsigned long) invalid_pte_table);
@@ -297,6 +307,11 @@ static inline int pud_present(pud_t pud)
 	return pud_val(pud) != (unsigned long) invalid_pmd_table;
 }
 
+static inline int pud_large(pud_t pud)
+{
+	return (pud_val(pud) & _PAGE_HUGE) != 0;
+}
+
 static inline void pud_clear(pud_t *pudp)
 {
 	pud_val(*pudp) = ((unsigned long) invalid_pmd_table);
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index f88a48cd68b2..5ab296dee8fa 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -132,7 +132,7 @@ enum pgtable_bits {
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
-#if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
+#if defined(CONFIG_64BIT)
 # define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
 #endif
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

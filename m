Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF63C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BEB20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBUAmLL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BEB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gMsadY99r7bn1YCDE89QjgYeBl8rTIagxn9kVZ0ykyk=; b=GBUAmLL4CdgTZk
	aHlX+4P/2sBmEARuaTGsSM6g1f2SbKJ91CZqhtWHKl6k6UQX2Fdpw8yUY5aZwz2kIWswlz36laZ+8
	fd2XEeX9QJlcgyckyQZpjOGU2aktPknXJdFYEc6cQKlBffhP6UK4HjwssMWgWUnVaLn4aBz4n8omt
	iDIqThVIt0aZHyyekKnQ76hwO2W/ZTtReTatYOSh3nKdPGl02YiLWT0I40a8ev0SH77p3Vwag+4Ka
	WPgrJruyjEtD545B0tvZWKKLcQX+fu5Tb5gC2mbly5QXam7GNF2GHhAIFTjh+tDlbfV3AZRE/WbON
	e+27SZIBTYxPNu/63TiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2ig-0003qF-3o; Wed, 27 Feb 2019 17:10:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2gP-0008V8-Ii; Wed, 27 Feb 2019 17:07:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810B91684;
 Wed, 27 Feb 2019 09:07:49 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB0C3F738;
 Wed, 27 Feb 2019 09:07:45 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 21/34] um: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:55 +0000
Message-Id: <20190227170608.27963-22-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_090749_850965_5455D429 
X-CRM114-Status: GOOD (  11.53  )
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
 "H. Peter Anvin" <hpa@zytor.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Steven Price <steven.price@arm.com>, Ingo Molnar <mingo@redhat.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For um, we don't support large pages, so add stubs returning 0.

CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: linux-um@lists.infradead.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/um/include/asm/pgtable-3level.h | 1 +
 arch/um/include/asm/pgtable.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index c4d876dfb9ac..2abf9aa5808e 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -57,6 +57,7 @@
 #define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEWPAGE))
 #define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
+#define pud_large(x)	(0)
 #define pud_populate(mm, pud, pmd) \
 	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
 
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 9c04562310b3..d5fa4e118dcc 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -100,6 +100,7 @@ extern unsigned long end_iomem;
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define pmd_large(x)	(0)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
 
 #define pmd_newpage(x)  (pmd_val(x) & _PAGE_NEWPAGE)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B452EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819F42084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhdlR61B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819F42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uM5iYteQ48KklVtxqs5SlAqWCg94cEyexJhg/b7cEbU=; b=UhdlR61Bp2HKFPRS6eA6dchV7h
	a2ukoj/RtQBoLG3FZLqYKR2q6b9qVjH2OzRPPkuwBiBxMTd+9rFkaDdR+EiQWmppVVkA4zZzsUAc1
	aQaIGRNJy3CegTzmQ+Bpwa690LG6sspY09wfzbaJ6dlMMyrzvjStmzA2VhBFz3x+dLtleeAcosi0n
	4P0Hi9EApJLMLVNcDhQup50Gp9W5Y2xGBvM52Cmyssv1UFTGIysvA3H6wpZ9LTUNtB2wD+6gnx+8M
	9h7vw5iAB2LtWpdD5hWFb2CbIa718ZiE4jGot0jxYRS7+NDxR2/4ds5xq7qqxRBwZh4mcFn7WBOfk
	dkqkUcTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnM2-0004RX-2z; Thu, 21 Feb 2019 12:21:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnLh-0003yF-5q
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:21:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D286E15AB;
 Thu, 21 Feb 2019 04:21:08 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9875B3F575;
 Thu, 21 Feb 2019 04:21:07 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/6] arm64: HWCAP: encapsulate elf_hwcap
Date: Thu, 21 Feb 2019 12:20:54 +0000
Message-Id: <1550751657-30252-4-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_042109_478199_B1F26DDD 
X-CRM114-Status: GOOD (  12.00  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The introduction of AT_HWCAP2 introduced accessors which ensure that
hwcap features are set and tested appropriately.

Let's now mandate access to elf_hwcap via these accessors by making
elf_hwcap static within cpufeature.c.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 15 ++++-----------
 arch/arm64/include/asm/hwcap.h      |  6 +++---
 arch/arm64/kernel/cpufeature.c      | 27 +++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index dd21a32..a5acce4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -395,19 +395,12 @@ extern struct static_key_false arm64_const_caps_ready;
 	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
 
 bool this_cpu_has_cap(unsigned int cap);
+void cpu_set_feature(unsigned int num);
+bool cpu_have_feature(unsigned int num);
+unsigned long cpu_get_elf_hwcap(void);
+unsigned long cpu_get_elf_hwcap2(void);
 
-static inline void cpu_set_feature(unsigned int num)
-{
-	WARN_ON(num >= MAX_CPU_FEATURES);
-	elf_hwcap |= BIT(num);
-}
 #define cpu_set_feature_name(name) cpu_set_feature(cpu_feature(name))
-
-static inline bool cpu_have_feature(unsigned int num)
-{
-	WARN_ON(num >= MAX_CPU_FEATURES);
-	return elf_hwcap & BIT(num);
-}
 #define cpu_have_feature_name(name) cpu_have_feature(cpu_feature(name))
 
 /* System capability check for constant caps */
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 7549c72..170fb94 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -17,6 +17,7 @@
 #define __ASM_HWCAP_H
 
 #include <uapi/asm/hwcap.h>
+#include <asm/cpufeature.h>
 
 #define COMPAT_HWCAP_HALF	(1 << 1)
 #define COMPAT_HWCAP_THUMB	(1 << 2)
@@ -81,8 +82,8 @@
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
-#define ELF_HWCAP		lower_32_bits(elf_hwcap)
-#define ELF_HWCAP2		upper_32_bits(elf_hwcap)
+#define ELF_HWCAP		cpu_get_elf_hwcap()
+#define ELF_HWCAP2		cpu_get_elf_hwcap2()
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
@@ -98,6 +99,5 @@ enum {
 #endif
 };
 
-extern unsigned long elf_hwcap;
 #endif
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6a477a3..d57a179 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -35,8 +35,7 @@
 #include <asm/traps.h>
 #include <asm/virt.h>
 
-unsigned long elf_hwcap __read_mostly;
-EXPORT_SYMBOL_GPL(elf_hwcap);
+static unsigned long elf_hwcap __read_mostly;
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_ELF_HWCAP_DEFAULT	\
@@ -1909,6 +1908,30 @@ bool this_cpu_has_cap(unsigned int n)
 	return false;
 }
 
+void cpu_set_feature(unsigned int num)
+{
+	WARN_ON(num >= MAX_CPU_FEATURES);
+	elf_hwcap |= BIT(num);
+}
+EXPORT_SYMBOL_GPL(cpu_set_feature);
+
+bool cpu_have_feature(unsigned int num)
+{
+	WARN_ON(num >= MAX_CPU_FEATURES);
+	return elf_hwcap & BIT(num);
+}
+EXPORT_SYMBOL_GPL(cpu_have_feature);
+
+unsigned long cpu_get_elf_hwcap(void)
+{
+	return lower_32_bits(elf_hwcap);
+}
+
+unsigned long cpu_get_elf_hwcap2(void)
+{
+	return upper_32_bits(elf_hwcap);
+}
+
 static void __init setup_system_capabilities(void)
 {
 	/*
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

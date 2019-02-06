Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A486C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3895F20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MhzW5E6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3895F20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DX0SF27jr+lRUKHDmbnOxvnL2lIrZ67KYe/FVKrGqJI=; b=MhzW5E6OwXiKCqUvj1VG5Fy4Hp
	l9qYIXUSHLaUT3oYTD4sjKmpyCmPDLwnRSL9MeRo3t107fQQ9n53nz4nKtrF9Q8HpRG+ZxLXhADhS
	FTCdmV+ktXtw1MrBIstgq0f5tNpEwZa14U0XBM3bK0YMWgHkJBssrrRCa+An8xWJ64mJO1hwRvKLw
	g3PUhhmT75Ef958gRxx6ciGA6zNNnQYGFuikOLLgvpYpTmb8hBV4o+Cri4QrjwiHRFNf7RyrrexBN
	lVONfViy3pCSGHmY+BQhQdYqu+K2bXSjAXaM7lnm4J8NW87eI2oNdHobD/iS5J3wS11LTY45Owj+x
	Ohwmy4rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNJJ-0003bx-2k; Wed, 06 Feb 2019 13:32:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNIm-00034t-5s
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 13:31:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 907441650;
 Wed,  6 Feb 2019 05:31:43 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554433F557;
 Wed,  6 Feb 2019 05:31:42 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/6] arm64: HWCAP: encapsulate elf_hwcap
Date: Wed,  6 Feb 2019 13:31:05 +0000
Message-Id: <1549459868-45992-4-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
References: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_053144_266479_CF6E9C33 
X-CRM114-Status: GOOD (  13.21  )
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

The introduction of elf_hwcap2 introduced accessors which ensure that
features are set/tested in the appropriate elf_hwcapX variable.

Let's now mandate access to elf_hwcapX via these accessors by making
elf_hwcapX static within cpufeature.c.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 19 ++++---------------
 arch/arm64/include/asm/hwcap.h      |  6 +++---
 arch/arm64/kernel/cpufeature.c      | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 15d939e..0e6132f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -395,21 +395,10 @@ extern struct static_key_false arm64_const_caps_ready;
 
 bool this_cpu_has_cap(unsigned int cap);
 
-static inline void cpu_set_feature(unsigned int num)
-{
-	if (num < 32)
-		elf_hwcap |= BIT(num);
-	else
-		elf_hwcap2 |= BIT(num - 32);
-}
-
-static inline bool cpu_have_feature(unsigned int num)
-{
-	if (num < 32)
-		return elf_hwcap & BIT(num);
-	else
-		return elf_hwcap2 & BIT(num - 32);
-}
+void cpu_set_feature(unsigned int num);
+bool cpu_have_feature(unsigned int num);
+unsigned long cpu_get_elf_hwcap(void);
+unsigned long cpu_get_elf_hwcap2(void);
 
 /* System capability check for constant caps */
 static inline bool __cpus_have_const_cap(int num)
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 05ee9b9..ced87ad 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -17,6 +17,7 @@
 #define __ASM_HWCAP_H
 
 #include <uapi/asm/hwcap.h>
+#include <asm/cpufeature.h>
 
 #define COMPAT_HWCAP_HALF	(1 << 1)
 #define COMPAT_HWCAP_THUMB	(1 << 2)
@@ -80,8 +81,8 @@
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
-#define ELF_HWCAP		elf_hwcap
-#define ELF_HWCAP2		elf_hwcap2
+#define ELF_HWCAP		cpu_get_elf_hwcap()
+#define ELF_HWCAP2		cpu_get_elf_hwcap2()
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
@@ -97,6 +98,5 @@ enum {
 #endif
 };
 
-extern unsigned long elf_hwcap, elf_hwcap2;
 #endif
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d10a455..5b9620d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -35,11 +35,8 @@
 #include <asm/traps.h>
 #include <asm/virt.h>
 
-unsigned long elf_hwcap __read_mostly;
-EXPORT_SYMBOL_GPL(elf_hwcap);
-
-unsigned long elf_hwcap2 __read_mostly;
-EXPORT_SYMBOL_GPL(elf_hwcap2);
+static unsigned long elf_hwcap __read_mostly;
+static unsigned long elf_hwcap2 __read_mostly;
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_ELF_HWCAP_DEFAULT	\
@@ -1912,6 +1909,32 @@ bool this_cpu_has_cap(unsigned int n)
 	return false;
 }
 
+void cpu_set_feature(unsigned int num)
+{
+	if (num < 32)
+		elf_hwcap |= BIT(num);
+	else
+		elf_hwcap2 |= BIT(num - 32);
+}
+
+bool cpu_have_feature(unsigned int num)
+{
+	if (num < 32)
+		return elf_hwcap & BIT(num);
+	else
+		return elf_hwcap2 & BIT(num - 32);
+}
+
+unsigned long cpu_get_elf_hwcap(void)
+{
+	return elf_hwcap;
+}
+
+unsigned long cpu_get_elf_hwcap2(void)
+{
+	return elf_hwcap2;
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

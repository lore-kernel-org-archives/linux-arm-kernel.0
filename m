Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:22:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140402084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cjEleYz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140402084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vE0bw4rUwTCf8amgstMaftwbWgfsrvXBZP3Zw2onkFk=; b=cjEleYz0g7UXD7jBGzWDftt8cm
	d1fr3V2s3/zsbcFgNa+r+GMbykb454CEbTMGNisKk1YImkg9qrKfSglemvbkOMc6Akzqe76Va2hjt
	MXGdruGvpzRmX0lBG+ZhH8SaS8KSftsVLxwPPiJrhO7A6OdkMwpN9xbMpG4dh4uUAEMjeueJx9x/C
	DGg2/UkFDbfWJzymhc8VLWBcV7TsT02Lx6ObNgKnqoHtgW2Jo1lzIzamDZ2HM8/jAui3tnVY1X6H+
	2VUwTSHsA+s3MQ0IbPr6fJPfZmuQLB2A8jWtF9r0PjmQ3DCkTsJhsI3kQSrgZYIOpHMw7wfmzN6jI
	rJ6r8PiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnMY-0005AI-AY; Thu, 21 Feb 2019 12:22:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnLi-0003zq-FK
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:21:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D83A165C;
 Thu, 21 Feb 2019 04:21:10 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23BE13F575;
 Thu, 21 Feb 2019 04:21:08 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 4/6] arm64: Expose DC CVADP to userspace
Date: Thu, 21 Feb 2019 12:20:55 +0000
Message-Id: <1550751657-30252-5-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_042110_769892_4D4854D7 
X-CRM114-Status: GOOD (  12.15  )
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

ARMv8.5 builds upon the ARMv8.2 DC CVAP instruction by introducing a DC
CVADP instruction which cleans the data cache to the point of deep
persistence. Let's expose this support via the arm64 ELF hwcaps.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 Documentation/arm64/elf_hwcaps.txt  | 4 ++++
 arch/arm64/include/uapi/asm/hwcap.h | 5 +++++
 arch/arm64/kernel/cpufeature.c      | 1 +
 arch/arm64/kernel/cpuinfo.c         | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index 13d6691..7db6e13 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -135,6 +135,10 @@ HWCAP_DCPOP
 
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0001.
 
+HWCAP_DCPODP
+
+    Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
+
 HWCAP_SHA3
 
     Functionality implied by ID_AA64ISAR0_EL1.SHA3 == 0b0001.
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 453b45a..d64af39 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -53,4 +53,9 @@
 #define HWCAP_PACA		(1 << 30)
 #define HWCAP_PACG		(1UL << 31)
 
+/*
+ * HWCAP2 flags - for AT_HWCAP2
+ */
+#define HWCAP2_DCPODP		(1 << 0)
+
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d57a179..7e76c92 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1555,6 +1555,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_DIT_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DIT),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DCPOP),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_DCPODP),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_JSCVT),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FCMA),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_LRCPC),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 810db95..093ca53 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -85,6 +85,7 @@ static const char *const hwcap_str[] = {
 	"sb",
 	"paca",
 	"pacg",
+	"dcpodp",
 	NULL
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

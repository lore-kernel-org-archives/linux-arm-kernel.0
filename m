Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F75CC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:49:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4CD2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dw0zoqyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4CD2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2kK7indbTjuZaDfAUOrErN41jPedXoj+8ncd8/liPQM=; b=Dw0zoqyfltd2L5q8vJA2215IXl
	RWLXrPA38ykEIMYlnapj3HtmwFV6I41XKjhNqdZaUGZ5kQEBfBST/QlN6lqbyaH5lMAfZ91lamlF4
	eT4QnqHHh6IEGsRaJiY3Rz4jbtogHxpSUqcMwSVSuDwgxwVm5JbOkbssukQPRKTI3+igBJ2plAp2o
	fmnnWzNG/+ZUmucAosRVN22wblsD+J+OZVJikIXdoYsgVvuXkGdO7OryvGSA9l1j07QC8AAQ6MkpB
	Rv4nv5y/USZ7APoQM7EC2v5TUtNRrbnjmAdvW2OUxCmQoCJ3Av6O3/6ZLxAaqKPSR6QLST1uk2U7X
	yZRHByVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7h7-0003cs-Fa; Wed, 12 Dec 2018 16:49:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7fz-0002GQ-8W
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 16:48:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E151684;
 Wed, 12 Dec 2018 08:47:57 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 291B93F575;
 Wed, 12 Dec 2018 08:47:55 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 04/25] arm64: cpufeature: Add cpufeature for IRQ priority
 masking
Date: Wed, 12 Dec 2018 16:47:04 +0000
Message-Id: <1544633245-6036-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_084759_405021_B84E7E95 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a cpufeature indicating whether a cpu supports masking interrupts
by priority.

The feature will be properly enabled in a later patch.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 6e2d254..f367e5c 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -54,7 +54,8 @@
 #define ARM64_HAS_CRC32				33
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1188873		35
+#define ARM64_HAS_IRQ_PRIO_MASKING		36
 
-#define ARM64_NCAPS				36
+#define ARM64_NCAPS				37
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64..149bf1e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -514,6 +514,12 @@ static inline bool system_supports_cnp(void)
 		cpus_have_const_cap(ARM64_HAS_CNP);
 }
 
+static inline bool system_uses_irq_prio_masking(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
+	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
+}
+
 #define ARM64_SSBD_UNKNOWN		-1
 #define ARM64_SSBD_FORCE_DISABLE	0
 #define ARM64_SSBD_KERNEL		1
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 865bb55..4426b5b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1145,6 +1145,14 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 }
 #endif /* CONFIG_ARM64_RAS_EXTN */
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
+				   int scope)
+{
+	return false;
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1368,6 +1376,21 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 		.cpu_enable = cpu_enable_cnp,
 	},
 #endif
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	{
+		/*
+		 * Depends on having GICv3
+		 */
+		.desc = "IRQ priority masking",
+		.capability = ARM64_HAS_IRQ_PRIO_MASKING,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.matches = can_use_gic_priorities,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
+#endif
 	{},
 };
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

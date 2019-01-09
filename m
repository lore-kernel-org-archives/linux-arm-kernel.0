Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579C8206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BgeHReWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579C8206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iADGnPVC7wvEAgHGSuaCTc7b7GE9YNDrm08X0gWuzJ8=; b=BgeHReWD1/WyWjdJ55abYHoI5G
	FWmMHaaebik4/mWcHeIU8N+CMT9T5F1sRVq7jpq1ip5ktMJ10D9RowtmFR4OYMx262uTaeqeoO1Jl
	w2Qb9F5fQ0rCY9qEGvFhOEU6HwXhFn/G9H0N9u6zdgn0J5uwQNpCHwGAp1ElhICgF/TYcYe91ugY0
	ThDq7OJJ7RJ1p8rgIB1oysB6e+C9O9PzKCIPFv8Qy94vVpaqVo557U8/8E/lCiu+WRf1OXKqYLIMd
	NRIJtX6zHFNvT/D9rR2yYTohovUP4Na4VIwJzHQfkMDvzBoNZxa/trIHZwPK+DtAzSULVyrJNxX8H
	Zo6JN9WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghNiI-0006mz-5M; Wed, 09 Jan 2019 23:56:46 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghNhT-0005xZ-F8
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 23:55:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E675315BF;
 Wed,  9 Jan 2019 15:55:54 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AD533F5AF;
 Wed,  9 Jan 2019 15:55:54 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/7] arm64: add sysfs vulnerability show for meltdown
Date: Wed,  9 Jan 2019 17:55:41 -0600
Message-Id: <20190109235544.2992426-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_155555_846483_ADC937D4 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Display the mitigation status if active, otherwise
assume the cpu is safe unless it doesn't have CSV3
and isn't in our whitelist.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ab784d7a0083..ef7bbc49ef78 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -944,8 +944,12 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	return has_cpuid_feature(entry, scope);
 }
 
+/* default value is invalid until unmap_kernel_at_el0() runs */
+static bool __meltdown_safe = true;
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
+extern uint arm64_requested_vuln_attrs;
 
 static bool is_cpu_meltdown_safe(void)
 {
@@ -972,6 +976,14 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 {
 	char const *str = "command line option";
 
+	bool meltdown_safe = is_cpu_meltdown_safe() ||
+		has_cpuid_feature(entry, scope);
+
+	if (!meltdown_safe)
+		__meltdown_safe = false;
+
+	arm64_requested_vuln_attrs |= VULN_MELTDOWN;
+
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
 	 * ThunderX leads to apparent I-cache corruption of kernel text, which
@@ -993,11 +1005,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	if (is_cpu_meltdown_safe())
-		return false;
-
-	/* Defer to CPU feature registers */
-	return !has_cpuid_feature(entry, scope);
+	return !meltdown_safe;
 }
 
 static void
@@ -2065,3 +2073,17 @@ static int __init enable_mrs_emulation(void)
 }
 
 core_initcall(enable_mrs_emulation);
+
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	if (arm64_kernel_unmapped_at_el0())
+		return sprintf(buf, "Mitigation: KPTI\n");
+
+	if (__meltdown_safe)
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

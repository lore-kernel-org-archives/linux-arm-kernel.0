Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A679C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:25:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDFC2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8q2R8mQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDFC2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tQkMcD/Xctzq7JZxJDHvUgUR1XkUIcwlD7RQpduZx4M=; b=G8q2R8mQrHG0XWn9ZT0p/adZdx
	Qoc3NNUz4AX0gRUzY6s9EpedxkLjOKCzIle4YiDNL7l6lyqJf1xOu1GiOxHT/UhzPVn30HvtWYlf+
	wL8sg+g/UNqWsOD6Q1PbNjW28TjFqzEOdhlYTuf9Av/K1/qiSs/8CJ0Hm7bTxvq+IJSA/v505y7+w
	6Ea6sDjRHjAmvHvKqKhEVubBq1V9x/IrfAzgbML7dgvz3r00UzI3ZzHsTSK+x33oEwvjJYFLBYDBL
	oHEtsgioeU5/ACtDTRLD1yVOL0byaGpBm9nNb/bVAmbKQPC9/LYidtch3rlwjcaMC03Wjk/ymsPDz
	znpg272A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmXS-0005qX-KN; Fri, 30 Nov 2018 17:25:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmRF-0008Ah-AE
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:18:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E161684;
 Fri, 30 Nov 2018 09:18:36 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 83F213F5A0; Fri, 30 Nov 2018 09:18:34 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/7] arm64: capabilities: Optimize this_cpu_has_cap
Date: Fri, 30 Nov 2018 17:18:04 +0000
Message-Id: <1543598286-2663-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091850_302845_27FD2BEF 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: mark.rutland@arm.com, vladimir.murzin@arm.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, dave.martin@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make use of the sorted capability list to access the capability
entry in this_cpu_has_cap() to avoid iterating over the two
tables.

Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6a2563b..618857f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1512,25 +1512,6 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-/*
- * Check if the current CPU has a given feature capability.
- * Should be called from non-preemptible context.
- */
-static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
-			       unsigned int cap)
-{
-	const struct arm64_cpu_capabilities *caps;
-
-	if (WARN_ON(preemptible()))
-		return false;
-
-	for (caps = cap_array; caps->matches; caps++)
-		if (caps->capability == cap)
-			return caps->matches(caps, SCOPE_LOCAL_CPU);
-
-	return false;
-}
-
 static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 				      u16 scope_mask, const char *info)
 {
@@ -1780,10 +1761,16 @@ static void __init mark_const_caps_ready(void)
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-bool this_cpu_has_cap(unsigned int cap)
+bool this_cpu_has_cap(unsigned int n)
 {
-	return (__this_cpu_has_cap(arm64_features, cap) ||
-		__this_cpu_has_cap(arm64_errata, cap));
+	if (!WARN_ON(preemptible()) && n < ARM64_NCAPS) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
+
+		if (cap)
+			return cap->matches(cap, SCOPE_LOCAL_CPU);
+	}
+
+	return false;
 }
 
 static void __init setup_system_capabilities(void)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

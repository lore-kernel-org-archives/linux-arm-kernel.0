Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249DFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E893820868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShCTZCYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E893820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fmxNypWMyN5WHUoe+Qxm7oe9u9MfoBuFTH95c7o+lVQ=; b=ShCTZCYO89TuHrzwPvdksigqcA
	1o3RNTa/HsbvfWYPgCMxsAW+kS4g5auTohJsipvYjik0CdXtrQK1gLCX+0WBM8hMxOrkbsCgQdIOa
	3lYN7mEzpt5wQkjGe78knqO8+AoaHgJwa2Zd3bDtO0h1rH3xKkkkDYtrtHr7nrgy2GdKys4fmhIJ8
	nr0t7DLn6bpOo8SJ1PG54pvQ/uG/4wxr2s2xuW+DdidDLZN+raYcjxbmSD3R0XGWg+QkAhtL6Cd7Z
	cWOUB0/kKyI8sCiFJwxv3jCge5sIb40vGe1aTMtepFkKMmhYzb69arXRRwbemPG77tmElA2lttPYB
	PFoWB5qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV3Kc-0003cQ-Rt; Thu, 06 Dec 2018 23:45:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3Jq-0001pR-9c
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:44:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5B8615AB;
 Thu,  6 Dec 2018 15:44:29 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34B3B3F5AF;
 Thu,  6 Dec 2018 15:44:29 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] arm64: kpti: move check for non-vulnerable CPUs to a
 function
Date: Thu,  6 Dec 2018 17:44:03 -0600
Message-Id: <20181206234408.1287689-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206234408.1287689-1-jeremy.linton@arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_154434_492467_12F83008 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, ykaukab@suse.de, dave.martin@arm.com,
 shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Add is_meltdown_safe() which is a whitelist of known safe cores.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
[Moved location of function]
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index aec5ecb85737..242898395f68 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -908,8 +908,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
-static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
-				int scope)
+static bool is_cpu_meltdown_safe(void)
 {
 	/* List of CPUs that are not vulnerable and don't need KPTI */
 	static const struct midr_range kpti_safe_list[] = {
@@ -917,6 +916,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
 		{ /* sentinel */ }
 	};
+	/* Don't force KPTI for CPUs that are not vulnerable */
+	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+		return true;
+
+	return false;
+}
+
+static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
+				int scope)
+{
 	char const *str = "command line option";
 
 	/*
@@ -940,8 +949,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	/* Don't force KPTI for CPUs that are not vulnerable */
-	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+	if (is_cpu_meltdown_safe())
 		return false;
 
 	/* Defer to CPU feature registers */
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

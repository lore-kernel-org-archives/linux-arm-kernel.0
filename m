Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F29C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:25:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6A42146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRddwhmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6A42146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=07AzlPeyYamoaWj7vBsU6ytUBlfGvgUr/Ssy1ivll0U=; b=RRddwhmnyGZorwUW8VtHudHIbp
	KBEdhn9NMBst2pVV543yX5usgHeSnNXf9VC8Nu3kI8xio+VvZk51X19Sqfs/xPo3n/5rdetn0ZBBM
	C/wJtTzKgASo030IJ2P8dUnJZ6aTf4Chui3irB52TdgxyZksF02DIJi7q/QF8HUc6dbq1LAdyNkJe
	GAX6E5NuMkiYX94bYV/2Z0o+1UKgUnU+/5e3UljfvlqPtcCrBWOGotM9e566I3fsMO28iBNVcDNiK
	QShh3tdbTRidpcFRq0ImdO3bvRsqVoN3EsXMbF9eqjfEMZxaT2lus3QYfPRTta+SZa/Z9zcFCmg7o
	TkKbKSvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmXT-0005rf-VK; Fri, 30 Nov 2018 17:25:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmRF-0008Ai-BX
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:18:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C066A168F;
 Fri, 30 Nov 2018 09:18:37 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4666C3F5A0; Fri, 30 Nov 2018 09:18:36 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] arm64: capabilities: Use linear array for detection
 and verification
Date: Fri, 30 Nov 2018 17:18:05 +0000
Message-Id: <1543598286-2663-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091850_140078_B65D2E9C 
X-CRM114-Status: GOOD (  14.60  )
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

Use the sorted list of capability entries for the detection and
verification.

Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 618857f..13d729c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1512,28 +1512,25 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				      u16 scope_mask, const char *info)
+static void update_cpu_capabilities(u16 scope_mask)
 {
+	int i;
+	const struct arm64_cpu_capabilities *caps;
+
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
-	for (; caps->matches; caps++) {
-		if (!(caps->type & scope_mask) ||
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask) ||
+		    cpus_have_cap(caps->capability) ||
 		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
-		if (!cpus_have_cap(caps->capability) && caps->desc)
-			pr_info("%s %s\n", info, caps->desc);
+		if (caps->desc)
+			pr_info("detected: %s\n", caps->desc);
 		cpus_set_cap(caps->capability);
 	}
 }
 
-static void update_cpu_capabilities(u16 scope_mask)
-{
-	__update_cpu_capabilities(arm64_errata, scope_mask,
-				  "enabling workaround for");
-	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
-}
-
 static int __enable_cpu_capability(void *arg)
 {
 	const struct arm64_cpu_capabilities *cap = arg;
@@ -1597,16 +1594,17 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
  *
  * Returns "false" on conflicts.
  */
-static bool
-__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
-			u16 scope_mask)
+static bool verify_local_cpu_caps(u16 scope_mask)
 {
+	int i;
 	bool cpu_has_cap, system_has_cap;
+	const struct arm64_cpu_capabilities *caps;
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 
-	for (; caps->matches; caps++) {
-		if (!(caps->type & scope_mask))
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask))
 			continue;
 
 		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);
@@ -1637,7 +1635,7 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 		}
 	}
 
-	if (caps->matches) {
+	if (i < ARM64_NCAPS) {
 		pr_crit("CPU%d: Detected conflict for capability %d (%s), System: %d, CPU: %d\n",
 			smp_processor_id(), caps->capability,
 			caps->desc, system_has_cap, cpu_has_cap);
@@ -1647,12 +1645,6 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 	return true;
 }
 
-static bool verify_local_cpu_caps(u16 scope_mask)
-{
-	return __verify_local_cpu_caps(arm64_errata, scope_mask) &&
-	       __verify_local_cpu_caps(arm64_features, scope_mask);
-}
-
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AADC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A00E2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rvrgCTbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A00E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NUSaagahMyqKa3ww7DVfiTRWl2iACPWOGgpOIbtah7E=; b=rvrgCTbtC3Tj/OwDZyQoMPq950
	cEy8CIl+cKYMonC99mZ8RC1P3abI+cLZEop8yKjmSvcwXccrmwFPnazWY/SAvdaiE9sE6hT7is41v
	a+Rq8TZ+R/aG9jF7yhMu+B01tM1WwoLMgcB0gcklFAmCc6qOZV42FHQV8KOG7cU6sIcZM89PE1/So
	lMWTtqXT+hTXaWOqHh72f1L+pufOvC2nEkKLO26rjXOzPVkSocxoViVRSod/sW0RUvN3Qgot1q1vU
	S+31pIdKXmSHATCbdHfr0+9dfoVYdD4+zKEUuKJtLIHhCyF0KGHuBHYrY3yRo5uiNG5uGl+ftd5fd
	tezcdG8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmT7-0002xw-85; Fri, 30 Nov 2018 17:20:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmRF-0008Ap-AF
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:19:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82AB0EBD;
 Fri, 30 Nov 2018 09:18:39 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 08D4F3F5A0; Fri, 30 Nov 2018 09:18:37 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/7] arm64: capabilities: Batch cpu_enable callbacks
Date: Fri, 30 Nov 2018 17:18:06 +0000
Message-Id: <1543598286-2663-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091850_327898_DF58F6DB 
X-CRM114-Status: GOOD (  16.29  )
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

We use a stop_machine call for each available capability to
enable it on all the CPUs available at boot time. Instead
we could batch the cpu_enable callbacks to a single stop_machine()
call to save us some time.

Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++
 arch/arm64/kernel/cpufeature.c      | 70 +++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64..0a15e2c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -357,6 +357,9 @@ extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+#define for_each_available_cap(cap)		\
+	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
+
 bool this_cpu_has_cap(unsigned int cap);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 13d729c..b12b9933 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1531,11 +1531,27 @@ static void update_cpu_capabilities(u16 scope_mask)
 	}
 }
 
-static int __enable_cpu_capability(void *arg)
+/*
+ * Enable all the available capabilities on this CPU. The capabilities
+ * with BOOT_CPU scope are handled separately and hence skipped here.
+ */
+static int cpu_enable_non_boot_scope_capabilities(void *__unused)
 {
-	const struct arm64_cpu_capabilities *cap = arg;
+	int i;
+	u16 non_boot_scope = SCOPE_ALL & ~SCOPE_BOOT_CPU;
 
-	cap->cpu_enable(cap);
+	for_each_available_cap(i) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[i];
+
+		if (WARN_ON(!cap))
+			continue;
+
+		if (!(cap->type & non_boot_scope))
+			continue;
+
+		if (cap->cpu_enable)
+			cap->cpu_enable(cap);
+	}
 	return 0;
 }
 
@@ -1543,21 +1559,29 @@ static int __enable_cpu_capability(void *arg)
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init
-__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			  u16 scope_mask)
+static void __init enable_cpu_capabilities(u16 scope_mask)
 {
+	int i;
+	const struct arm64_cpu_capabilities *caps;
+	bool boot_scope;
+
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
-	for (; caps->matches; caps++) {
-		unsigned int num = caps->capability;
+	boot_scope = !!(scope_mask & SCOPE_BOOT_CPU);
 
-		if (!(caps->type & scope_mask) || !cpus_have_cap(num))
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		unsigned int num;
+
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask))
+			continue;
+		num = caps->capability;
+		if (!cpus_have_cap(num))
 			continue;
 
 		/* Ensure cpus_have_const_cap(num) works */
 		static_branch_enable(&cpu_hwcap_keys[num]);
 
-		if (caps->cpu_enable) {
+		if (boot_scope && caps->cpu_enable)
 			/*
 			 * Capabilities with SCOPE_BOOT_CPU scope are finalised
 			 * before any secondary CPU boots. Thus, each secondary
@@ -1566,25 +1590,19 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			 * the boot CPU, for which the capability must be
 			 * enabled here. This approach avoids costly
 			 * stop_machine() calls for this case.
-			 *
-			 * Otherwise, use stop_machine() as it schedules the
-			 * work allowing us to modify PSTATE, instead of
-			 * on_each_cpu() which uses an IPI, giving us a PSTATE
-			 * that disappears when we return.
 			 */
-			if (scope_mask & SCOPE_BOOT_CPU)
-				caps->cpu_enable(caps);
-			else
-				stop_machine(__enable_cpu_capability,
-					     (void *)caps, cpu_online_mask);
-		}
+			caps->cpu_enable(caps);
 	}
-}
 
-static void __init enable_cpu_capabilities(u16 scope_mask)
-{
-	__enable_cpu_capabilities(arm64_errata, scope_mask);
-	__enable_cpu_capabilities(arm64_features, scope_mask);
+	/*
+	 * For all non-boot scope capabilities, use stop_machine()
+	 * as it schedules the work allowing us to modify PSTATE,
+	 * instead of on_each_cpu() which uses an IPI, giving us a
+	 * PSTATE that disappears when we return.
+	 */
+	if (!boot_scope)
+		stop_machine(cpu_enable_non_boot_scope_capabilities,
+			     NULL, cpu_online_mask);
 }
 
 /*
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

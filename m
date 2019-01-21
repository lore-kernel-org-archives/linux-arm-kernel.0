Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB9C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:38:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825A220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ItkRZVNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825A220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aVD2zI0sJFHB5prybQyeKqRpWDdlsT++Q+FvLOzIsMY=; b=ItkRZVNgeAa6wxicsT+syEN3CF
	UXYeS/NaFzGthL2Hw5dGfCKb92yoWx9flQQ/2SRkSy3ljbUfvvxaWoICit7dlCMOd+jw1Ykpgygso
	1WSJoBodb/3pvt3QI1htmyrIq/o3BDa8c70wt5JJjZ029HARVrjMb5z9LbfXzmTynApfkqvdsh+po
	gBUXhThzJ/DoUCf0tA/JCTFV7WPj9sgWJeM8QYMyO2wxHlckOit6BqZ2JJImcs423fufl3tUnlKiy
	i2M2A/v6nSajOmbnynBFp5P2kSHMm6O0TIDNH+HFBMmy+YDy4zgKWXSfbH2r0lprXzLDfVcg/cSwZ
	vEIBgw3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbel-000206-8O; Mon, 21 Jan 2019 15:38:35 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbas-0005WG-KP
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:34:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10738EBD;
 Mon, 21 Jan 2019 07:34:34 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7CBC3F5C1;
 Mon, 21 Jan 2019 07:34:31 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 14/26] arm64: alternative: Allow alternative status
 checking per cpufeature
Date: Mon, 21 Jan 2019 15:33:33 +0000
Message-Id: <1548084825-8803-15-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073435_025088_F4F0F572 
X-CRM114-Status: GOOD (  16.57  )
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
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>,
 catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Christoffer Dall <Christoffer.Dall@arm.com>, james.morse@arm.com,
 joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In preparation for the application of alternatives at different points
during the boot process, provide the possibility to check whether
alternatives for a feature of interest was already applied instead of
having a global boolean for all alternatives.

Make VHE enablement code check for the VHE feature instead of considering
all alternatives.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Christoffer Dall <Christoffer.Dall@arm.com>
---
 arch/arm64/include/asm/alternative.h |  3 +--
 arch/arm64/kernel/alternative.c      | 21 +++++++++++++++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 4b650ec..9806a23 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -14,8 +14,6 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 
-extern int alternatives_applied;
-
 struct alt_instr {
 	s32 orig_offset;	/* offset to original instruction */
 	s32 alt_offset;		/* offset to replacement instruction */
@@ -28,6 +26,7 @@ typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
 void __init apply_alternatives_all(void);
+bool alternative_is_applied(u16 cpufeature);
 
 #ifdef CONFIG_MODULES
 void apply_alternatives_module(void *start, size_t length);
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index b5d6039..c947d22 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -32,13 +32,23 @@
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-int alternatives_applied;
+static int all_alternatives_applied;
+
+static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
 
 struct alt_region {
 	struct alt_instr *begin;
 	struct alt_instr *end;
 };
 
+bool alternative_is_applied(u16 cpufeature)
+{
+	if (WARN_ON(cpufeature >= ARM64_NCAPS))
+		return false;
+
+	return test_bit(cpufeature, applied_alternatives);
+}
+
 /*
  * Check if the target PC is within an alternative block.
  */
@@ -192,6 +202,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 		dsb(ish);
 		__flush_icache_all();
 		isb();
+
+		/* We applied all that was available */
+		bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
 	}
 }
 
@@ -208,14 +221,14 @@ static int __apply_alternatives_multi_stop(void *unused)
 
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-		while (!READ_ONCE(alternatives_applied))
+		while (!READ_ONCE(all_alternatives_applied))
 			cpu_relax();
 		isb();
 	} else {
-		BUG_ON(alternatives_applied);
+		BUG_ON(all_alternatives_applied);
 		__apply_alternatives(&region, false);
 		/* Barriers provided by the cache flushing */
-		WRITE_ONCE(alternatives_applied, 1);
+		WRITE_ONCE(all_alternatives_applied, 1);
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f56e0a..d607ea3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1118,7 +1118,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
 	 * do anything here.
 	 */
-	if (!alternatives_applied)
+	if (!alternative_is_applied(ARM64_HAS_VIRT_HOST_EXTN))
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
 }
 #endif
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

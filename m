Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A96C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:39:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DEF20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmdJan9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DEF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9MLNCvytiW+JF41zHe0FPrqf9KZJ2Ah2ZnFJ4154s+Q=; b=jmdJan9oT0i3yQKGVlQpR9vMp1
	DjEu8MBSvV06uQzeyeqtsEY/jDgzaK/GLzhPSr445hv4XAqVL0u7HUgv3Rm6Zob+R2S4Zgc8ouo6O
	Mcn+HxxNaKh72oxAaxL9PtqnecAHBrglr/psVct49w+Z4wt0bFcc87tN9BiVbmkv67a2oa6kQn5rl
	r6JAzAdgK6L7j+3DjaA4cz/yG4Z/lNx+w3wZElFluKbmzCMKyLll6bjk0T8aAUaZrd5Ec6OMzZDr4
	pRgAOSuttbQsci/XAWtutyKTai/YpVKtHP0BNnYWgGwSP0nBJYZpk6g3kZBuD0cb0nK/RKMgUsBJc
	3ZNHveNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbfF-0002Sd-5A; Mon, 21 Jan 2019 15:39:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbau-0005jI-Gl
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:35:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ECD41650;
 Mon, 21 Jan 2019 07:34:36 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E9943F5C1;
 Mon, 21 Jan 2019 07:34:34 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 15/26] arm64: alternative: Apply alternatives early in boot
 process
Date: Mon, 21 Jan 2019 15:33:34 +0000
Message-Id: <1548084825-8803-16-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073437_119118_E97E67F6 
X-CRM114-Status: GOOD (  20.08  )
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

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently alternatives are applied very late in the boot process (and
a long time after we enable scheduling). Some alternative sequences,
such as those that alter the way CPU context is stored, must be applied
much earlier in the boot sequence.

Introduce apply_boot_alternatives() to allow some alternatives to be
applied immediately after we detect the CPU features of the boot CPU.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[julien.thierry@arm.com: rename to fit new cpufeature framework better,
			 apply BOOT_SCOPE feature early in boot]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/alternative.h |  1 +
 arch/arm64/include/asm/cpufeature.h  |  4 ++++
 arch/arm64/kernel/alternative.c      | 43 +++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c       |  6 +++++
 arch/arm64/kernel/smp.c              |  7 ++++++
 5 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 9806a23..b9f8d78 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -25,6 +25,7 @@ struct alt_instr {
 typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
+void __init apply_boot_alternatives(void);
 void __init apply_alternatives_all(void);
 bool alternative_is_applied(u16 cpufeature);
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 89c3f31..e505e1f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -391,6 +391,10 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+/* ARM64 CAPS + alternative_cb */
+#define ARM64_NPATCHABLE (ARM64_NCAPS + 1)
+extern DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
+
 #define for_each_available_cap(cap)		\
 	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
 
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index c947d22..a9b4677 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -155,7 +155,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region, bool is_module)
+static void __apply_alternatives(void *alt_region,  bool is_module,
+				 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -165,6 +166,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 	for (alt = region->begin; alt < region->end; alt++) {
 		int nr_inst;
 
+		if (!test_bit(alt->cpufeature, feature_mask))
+			continue;
+
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
 		    !cpus_have_cap(alt->cpufeature))
@@ -203,8 +207,11 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 		__flush_icache_all();
 		isb();
 
-		/* We applied all that was available */
-		bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
+		/* Ignore ARM64_CB bit from feature mask */
+		bitmap_or(applied_alternatives, applied_alternatives,
+			  feature_mask, ARM64_NCAPS);
+		bitmap_and(applied_alternatives, applied_alternatives,
+			   cpu_hwcaps, ARM64_NCAPS);
 	}
 }
 
@@ -225,8 +232,13 @@ static int __apply_alternatives_multi_stop(void *unused)
 			cpu_relax();
 		isb();
 	} else {
+		DECLARE_BITMAP(remaining_capabilities, ARM64_NPATCHABLE);
+
+		bitmap_complement(remaining_capabilities, boot_capabilities,
+				  ARM64_NPATCHABLE);
+
 		BUG_ON(all_alternatives_applied);
-		__apply_alternatives(&region, false);
+		__apply_alternatives(&region, false, remaining_capabilities);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(all_alternatives_applied, 1);
 	}
@@ -240,6 +252,24 @@ void __init apply_alternatives_all(void)
 	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
 }
 
+/*
+ * This is called very early in the boot process (directly after we run
+ * a feature detect on the boot CPU). No need to worry about other CPUs
+ * here.
+ */
+void __init apply_boot_alternatives(void)
+{
+	struct alt_region region = {
+		.begin	= (struct alt_instr *)__alt_instructions,
+		.end	= (struct alt_instr *)__alt_instructions_end,
+	};
+
+	/* If called on non-boot cpu things could go wrong */
+	WARN_ON(smp_processor_id() != 0);
+
+	__apply_alternatives(&region, false, &boot_capabilities[0]);
+}
+
 #ifdef CONFIG_MODULES
 void apply_alternatives_module(void *start, size_t length)
 {
@@ -247,7 +277,10 @@ void apply_alternatives_module(void *start, size_t length)
 		.begin	= start,
 		.end	= start + length,
 	};
+	DECLARE_BITMAP(all_capabilities, ARM64_NPATCHABLE);
+
+	bitmap_fill(all_capabilities, ARM64_NPATCHABLE);
 
-	__apply_alternatives(&region, true);
+	__apply_alternatives(&region, true, &all_capabilities[0]);
 }
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d607ea3..b530fb24 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -54,6 +54,9 @@
 EXPORT_SYMBOL(cpu_hwcaps);
 static struct arm64_cpu_capabilities const __ro_after_init *cpu_hwcaps_ptrs[ARM64_NCAPS];
 
+/* Need also bit for ARM64_CB_PATCH */
+DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -1677,6 +1680,9 @@ static void update_cpu_capabilities(u16 scope_mask)
 		if (caps->desc)
 			pr_info("detected: %s\n", caps->desc);
 		cpus_set_cap(caps->capability);
+
+		if ((scope_mask & SCOPE_BOOT_CPU) && (caps->type & SCOPE_BOOT_CPU))
+			set_bit(caps->capability, boot_capabilities);
 	}
 }
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f..a944edd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -419,6 +419,13 @@ void __init smp_prepare_boot_cpu(void)
 	 */
 	jump_label_init();
 	cpuinfo_store_boot_cpu();
+
+	/*
+	 * We now know enough about the boot CPU to apply the
+	 * alternatives that cannot wait until interrupt handling
+	 * and/or scheduling is enabled.
+	 */
+	apply_boot_alternatives();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

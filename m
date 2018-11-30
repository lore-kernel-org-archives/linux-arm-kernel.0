Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AE9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860552146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QwSldELq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860552146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6+l3cycxNihfvt2DbQr2OT8DBiWzr+Ixm/FPirRCZyA=; b=QwSldELq0IlSgmJB4AxpIGmbIo
	J/H6zIrI4hoVyimCGZQ1TKy45uhGiwthkLJtd9BJCRgnYrmLVaLDfw1Aq7m7AzOr329hpAyUl2fCc
	HmE+SDdm/snDVYpgC3rgpoddpGo6yPgfYiYGtWuQv1vNHwIWIenG3RQGqT2O/kEy2xQ3hsfOHoibh
	S5NG5KoT4SBow+4n9PU2UAY5rsyDb6C4q7OixVDscVHUZiQU9lG63Esuh8qW6cVuQUn9puEF3yG5g
	Fgq7U8feAGUXKC7cigOXSys399Sj6JzkWmu5skR+9vQlJ9rHehDvIG8+m+0U5LXncmqCNwYfw/3Za
	faomq61Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmXR-0005q6-LQ; Fri, 30 Nov 2018 17:25:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmR3-00088v-Hw
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:18:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E5BB15AB;
 Fri, 30 Nov 2018 09:18:30 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D1DEB3F5A0; Fri, 30 Nov 2018 09:18:28 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/7] arm64: capabilities: Merge duplicate Cavium erratum
 entries
Date: Fri, 30 Nov 2018 17:18:01 +0000
Message-Id: <1543598286-2663-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091837_775005_84B4F82E 
X-CRM114-Status: GOOD (  12.37  )
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
 David Daney <david.daney@cavium.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>,
 dave.martin@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Merge duplicate entries for a single capability using the midr
range list for Cavium errata 30115 and 27456.

Cc: Andrew Pinski <apinski@cavium.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimiri Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cputype.h |  1 +
 arch/arm64/kernel/cpu_errata.c   | 50 +++++++++++++++++++---------------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 2e26375..951ed1a 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -152,6 +152,7 @@ struct midr_range {
 	}
 
 #define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
+#define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
 #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
 
 static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index be1a8bc..bff8fa8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -570,6 +570,28 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 
 #endif
 
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+static const struct midr_range cavium_erratum_27456_cpus[] = {
+	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
+	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
+	/* Cavium ThunderX, T81 pass 1.0 */
+	MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+	{},
+};
+#endif
+
+#ifdef CONFIG_CAVIUM_ERRATUM_30115
+static const struct midr_range cavium_erratum_30115_cpus[] = {
+	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
+	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 2),
+	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
+	MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
+	/* Cavium ThunderX, T83 pass 1.0 */
+	MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+	{},
+};
+#endif
+
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 static const struct midr_range workaround_clean_cache[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
@@ -642,40 +664,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 	{
-	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
-				  0, 0,
-				  1, 1),
-	},
-	{
-	/* Cavium ThunderX, T81 pass 1.0 */
-		.desc = "Cavium erratum 27456",
-		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		ERRATA_MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_27456_cpus),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_30115
 	{
-	/* Cavium ThunderX, T88 pass 1.x - 2.2 */
 		.desc = "Cavium erratum 30115",
 		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
-				      0, 0,
-				      1, 2),
-	},
-	{
-	/* Cavium ThunderX, T81 pass 1.0 - 1.2 */
-		.desc = "Cavium erratum 30115",
-		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX_81XX, 0, 0, 2),
-	},
-	{
-	/* Cavium ThunderX, T83 pass 1.0 */
-		.desc = "Cavium erratum 30115",
-		.capability = ARM64_WORKAROUND_CAVIUM_30115,
-		ERRATA_MIDR_REV(MIDR_THUNDERX_83XX, 0, 0),
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_30115_cpus),
 	},
 #endif
 	{
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

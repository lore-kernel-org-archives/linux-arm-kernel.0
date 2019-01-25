Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C806C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C154218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b/suKxby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C154218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ujUFwHm9rOKOr+Oi2i0TT+kCkQcuz1APde+e2S5Sg/s=; b=b/suKxbyb0sRj+1d/zZs0vB5bL
	+lN0OtlsgrZIsz82gSgAB033Ip2RQGUyTPiae17IAwQGxhrZZzNkbTa8sVKlqDmUPxuO3F4ai3Bwc
	aIbSUkzd6X68NPEqvcdPCBzSP2Ol4Iltmesl0fiJrJeCIxFT0VJyPa2/18kDhe0EPxsovYQAW8GvY
	kS+1Po13ha/pvF8lrhetaCH8k9ZdMDsR2s1ByxAXxvvKbCF1+zj/XFw/TF/iWh6eJNepjLFrifnNm
	h1TpJF4zPQKLEjqWGuTvfetI9LxqF7k/oWoMIaE/4z/vVFeUpzt7S4kRdP2c/U/DtIsuATO719h9j
	dGFFW6aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5ul-00074Q-5K; Fri, 25 Jan 2019 18:09:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5t3-0005P6-NO
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:07:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00DFB1682;
 Fri, 25 Jan 2019 10:07:29 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 595C13F5AF;
 Fri, 25 Jan 2019 10:07:28 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 07/12] arm64: add sysfs vulnerability show for meltdown
Date: Fri, 25 Jan 2019 12:07:06 -0600
Message-Id: <20190125180711.1970973-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125180711.1970973-1-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_100730_538420_9A8E59FF 
X-CRM114-Status: GOOD (  12.16  )
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
 arch/arm64/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a9e18b9cdc1e..624dfe0b5cdd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -944,6 +944,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	return has_cpuid_feature(entry, scope);
 }
 
+/* default value is invalid until unmap_kernel_at_el0() runs */
+static bool __meltdown_safe = true;
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
@@ -962,6 +964,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		{ /* sentinel */ }
 	};
 	char const *str = "command line option";
+	bool meltdown_safe;
+
+	meltdown_safe = is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);
+
+	/* Defer to CPU feature registers */
+	if (has_cpuid_feature(entry, scope))
+		meltdown_safe = true;
+
+	if (!meltdown_safe)
+		__meltdown_safe = false;
 
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
@@ -984,12 +996,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return kaslr_offset() > 0;
 
-	/* Don't force KPTI for CPUs that are not vulnerable */
-	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
-		return false;
-
-	/* Defer to CPU feature registers */
-	return !has_cpuid_feature(entry, scope);
+	return !meltdown_safe;
 }
 
 static void
@@ -2055,3 +2062,17 @@ static int __init enable_mrs_emulation(void)
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

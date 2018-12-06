Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB944C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F92F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mnjClsbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1TNyR0JWEyM6ZK7pM3v4DeaiVeffZrpIaTUbjmnaglw=; b=mnjClsbgBeni8f
	uhrOsoQdXsyA3k50aQbmbHmCV137li8IINVZXLbSQ68uVDMzi4ON3HGg/+nFOWs1B0MM/obNm5LCW
	CKwg7ve9JZoqTOGX8ZY+J7pqX3TIlIs50XQUKctiRwy4aBVdoOwRaKkxkdxFreXqF35+OPri6ImmH
	uw7DDGIQmjPOZHFE6DgKrK20nUHpZiEN65K6GRLdv1PNAXFChcHtU503e4g+B/LaXQoYCT73Mieuw
	rSpFJKx+1n/vPB1pv74QIDWKYP+YI1xwp57Ax/WBCkxatpysWgBXB6+yPF7BNS7P9+Dh9fbxz22Ix
	JiQglwhmCFYMby+7iK2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxWB-0001Iq-SY; Thu, 06 Dec 2018 17:32:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxVF-0000AO-MB
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:32:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52891650;
 Thu,  6 Dec 2018 09:31:44 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 486D43F5AF;
 Thu,  6 Dec 2018 09:31:43 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 5/8] arm64: KVM: Force VHE for systems affected by erratum
 1165522
Date: Thu,  6 Dec 2018 17:31:23 +0000
Message-Id: <20181206173126.139877-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093158_436293_A212C315 
X-CRM114-Status: GOOD (  15.72  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to easily mitigate ARM erratum 1165522, we need to force
affected CPUs to run in VHE mode if using KVM.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpucaps.h  | 3 ++-
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 arch/arm64/kernel/cpu_errata.c    | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 6e2d254c09eb..62d8cd15fdf2 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -54,7 +54,8 @@
 #define ARM64_HAS_CRC32				33
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1188873		35
+#define ARM64_WORKAROUND_1165522		36
 
-#define ARM64_NCAPS				36
+#define ARM64_NCAPS				37
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d6d9aa76a943..9217759afa6b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -432,6 +432,10 @@ static inline bool kvm_arch_requires_vhe(void)
 	if (system_supports_sve())
 		return true;
 
+	/* Some implementations have defects that confine them to VHE */
+	if (cpus_have_cap(ARM64_WORKAROUND_1165522))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e35132d2..476e738e6c46 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -739,6 +739,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_1188873,
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
 	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_1165522
+	{
+		/* Cortex-A76 r0p0 to r2p0 */
+		.desc = "ARM erratum 1165522",
+		.capability = ARM64_WORKAROUND_1165522,
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+	},
 #endif
 	{
 	}
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

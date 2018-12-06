Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B470C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A8520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uIbtMPAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A8520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OQwCV3SmzRDpy49mrJpi8ZQEj04Jm2T3Frh2EjBnXb8=; b=uIbtMPAWSx6mF8
	w/tFHXG6dhJpR7VUG8Fpope30UvfVMm0OqgntbtAKTx7xG5VfeqpPFhUFWOnO4jlkd93kuvXDi+Ad
	QI9QExLauBHiB/DHGCei7nEkTpCWQQbvdZrcw+pMMs1m8ifIVHFtNBHpDMH7SrToYGKlLfkRCUswo
	+YPNWuOKaYy4pEHaHq9av+RGLF7Z3oeNmWAetaGGOdxtuCRAsgnYncPLaWFq//LGJgZv0oA+373Nb
	DIVBpe/8TM1fRAuzogPRaTsF6AGJQhh++WgdRSYXJuWCMkBbcEW90J179KQBUwpeQ+KliBDpWcbtJ
	HFK+WcH6RId6Lb3ZbpZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxWP-0001VQ-3T; Thu, 06 Dec 2018 17:33:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxVF-0000CU-MC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:32:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2E180D;
 Thu,  6 Dec 2018 09:31:50 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16613F5AF;
 Thu,  6 Dec 2018 09:31:48 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 8/8] arm64: Add configuration/documentation for Cortex-A76
 erratum 1165522
Date: Thu,  6 Dec 2018 17:31:26 +0000
Message-Id: <20181206173126.139877-9-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093158_420514_4796AC2D 
X-CRM114-Status: GOOD (  11.67  )
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

Now that the infrastructure to handle erratum 1165522 is in place,
let's make it a selectable option and add the required documentation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 76ccded8b74c..04f0bc4690c6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -57,6 +57,7 @@ stable kernels.
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188873       |
+| ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..a68bc6cc2167 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -497,6 +497,18 @@ config ARM64_ERRATUM_1188873
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1165522
+	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
+	default y
+	help
+	  This option adds work arounds for ARM Cortex-A76 erratum 1165522
+
+	  Affected Cortex-A76 cores (r0p0, r1p0, r2p0) could end-up with
+	  corrupted TLBs by speculating an AT instruction during a guest
+	  context switch.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

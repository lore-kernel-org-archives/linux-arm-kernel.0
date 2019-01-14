Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40095C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:36:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED2C20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2+05N5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED2C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/T1wyXo3znahc0sQktEn4Q7lbPu1niSeBQaDTVcWIEw=; b=A2+05N5FfM0oQm
	uGF3zo9uKfKLczKiW+YVeC2lUD/nrB+U0t0jXqfMtzHqWFwgWTgrMLs/NTV/X/twrwBXVpsD2BCUM
	0IPj4Q9PmVaGn/EFl5uKPG4zDgZ6HXt6QPi4hEcH/kZCl1gxq03ABI/6vyI9fNcl5Hzk+BYMa/ypd
	Hi8BXPzrN2HrofwWZ9lphck+NbDic25ha4/SGP+19R3U6PnHzvLrGzya8HG3UyQ8e9H4f9bexBdD7
	db0bFH8tKXbu0p2V0NLHjH5qcxOhFPxwfyWE+xVJxNQ9zDB/zpy5vPqsczAFy/nQ7vujdgCN+JuVz
	lTO2yctmn5wzlNWhceBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizbN-0001Wp-IU; Mon, 14 Jan 2019 10:36:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizan-00011k-I8
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:35:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F9C1596;
 Mon, 14 Jan 2019 02:35:41 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398603F5BD;
 Mon, 14 Jan 2019 02:35:40 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: Use firmware to detect CPUs that are not
 affected by Spectre-v2
Date: Mon, 14 Jan 2019 10:35:28 +0000
Message-Id: <20190114103528.52931-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114103528.52931-1-marc.zyngier@arm.com>
References: <20190114103528.52931-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_023541_717064_FD66B511 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SMCCC ARCH_WORKAROUND_1 service can indicate that although the
firmware knows about the Spectre-v2 mitigation, this particular
CPU is not vulnerable, and it is thus not necessary to call
the firmware on this CPU.

Let's use this information to our benefit.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 145f8b5d093d..b44f87e7360d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -231,26 +231,38 @@ static int detect_harden_bp_fw(void)
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0) {
+		switch ((int)res.a0) {
+		case 1:
+			/* Firmware says we're just fine */
+			return 0;
+		case 0:
+			cb = call_hvc_arch_workaround_1;
+			/* This is a guest, no need to patch KVM vectors */
+			smccc_start = NULL;
+			smccc_end = NULL;
+			break;
+		default:
 			__hardenbp_enab = false;
 			return -1;
 		}
-		cb = call_hvc_arch_workaround_1;
-		/* This is a guest, no need to patch KVM vectors */
-		smccc_start = NULL;
-		smccc_end = NULL;
 		break;
 
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0) {
+		switch ((int)res.a0) {
+		case 1:
+			/* Firmware says we're just fine */
+			return 0;
+		case 0:
+			cb = call_smc_arch_workaround_1;
+			smccc_start = __smccc_workaround_1_smc_start;
+			smccc_end = __smccc_workaround_1_smc_end;
+			break;
+		default:
 			__hardenbp_enab = false;
 			return -1;
 		}
-		cb = call_smc_arch_workaround_1;
-		smccc_start = __smccc_workaround_1_smc_start;
-		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

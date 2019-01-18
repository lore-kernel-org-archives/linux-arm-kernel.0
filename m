Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD2FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D18720883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gamVBPK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D18720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Cf8+SeBWlglkJcDdeP0iNG+qlGRyG3lBMDEJAQmgspU=; b=gamVBPK6912mB4CzXpv90sPyw/
	RJ4ep3BCsNSKqDUxq9iNPvVqhYUpjBuMLO7eEw41j1wNTVpyTOv3bWmk7gyfd6b4HLuZdXpN6yQAP
	D9Fw5H5ZvhlhBEpC/KehvTlaI/k1vgoVwb47eMVEeg32Jvoxvtd5PlqZrl1HjEvNZuwGxuaklPGnC
	4ES7yUuYGJP7vcqsE8+m6ciGPUNewChma6OXLtwcEA3UjsBqwrdzNyBpT2rAnk6THM063BtP4Hjjp
	S0khOsR6w41KtWCpR5Hlv9VQHjtJC3+ZbhsfY32273G3x++JOwSMfXWaaofJ3HVU4ZzxGA8qSgG1q
	ZZ0dBC6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXJf-00017P-MX; Fri, 18 Jan 2019 16:48:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXI9-00087l-CU
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:47:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D33801596;
 Fri, 18 Jan 2019 08:46:48 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12F2B3F7BE;
 Fri, 18 Jan 2019 08:46:46 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 6/8] arm64/sve: Implement helper to load SVE registers
 from FPSIMD state
Date: Fri, 18 Jan 2019 16:46:08 +0000
Message-Id: <20190118164610.8123-7-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190118164610.8123-1-julien.grall@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084649_922624_D7C0ACA1 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, Julien Grall <julien.grall@arm.com>,
 alex.bennee@linaro.org, Dave.Martin@arm.com, Daniel.Kiss@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In a follow-up patch, we may save the FPSIMD rather than the full SVE
state when the state has to be zeroed on return to userspace (e.g during a
syscall).

Introduce an helper to load SVE vectors from FPSIMD state and zero the rest
of SVE registers.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/include/asm/fpsimd.h  |  3 +++
 arch/arm64/kernel/entry-fpsimd.S | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index fa2439205c35..859c2c108f92 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -82,6 +82,9 @@ extern void sve_load_state(void const *state, u32 const *pfpsr,
 
 extern void sve_flush_live(void);
 
+extern void sve_load_from_fpsimd_state(struct user_fpsimd_state const *state,
+				       unsigned long vq_minus_1);
+
 extern unsigned int sve_get_vl(void);
 
 struct arm64_cpu_capabilities;
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 17121a51c41f..35c21a707730 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -58,6 +58,23 @@ ENTRY(sve_get_vl)
 	ret
 ENDPROC(sve_get_vl)
 
+/*
+ * Load SVE state from FPSIMD state.
+ *
+ * x0 = pointer to struct fpsimd_state
+ * x1 = VQ - 1
+ *
+ * Each SVE vector will be loaded with the first 128-bits taken from FPSIMD
+ * and the rest zeroed. All the other SVE registers will be zeroed.
+ */
+ENTRY(sve_load_from_fpsimd_state)
+		sve_load_vq	x1, x2, x3
+		fpsimd_restore	x0, 8
+ _for n, 0, 15, _sve_pfalse	\n
+		_sve_wrffr 0
+		ret
+ENDPROC(sve_load_from_fpsimd_state)
+
 /* Zero all SVE registers but the first 128-bits of each vector */
 ENTRY(sve_flush_live)
 	sve_flush
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

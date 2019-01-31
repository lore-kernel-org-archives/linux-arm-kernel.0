Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1BCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707CF218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vva3utbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707CF218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LRXY5skHwpKjES38/J4wuDwv7DvA7kbAh14hyjvzUhE=; b=Vva3utbHbe0ZqDieOAx7ESKQSY
	kmESA+xxnw1fi9OTSh2m6cChCW5mGbelcj51qAb2rqvOn4S68TTV+tsKmcRA5MJQsmzcubeCyzY4H
	NhrCGmcfvgn34C0im7e/wFkHhzoi5yxakgfHnQN6LseDQokoCOLXilaO7tWVBXTpsreRFozjn2dj0
	DAhD58NX8lgMPiGaVKfJIXD2YGbxT3MClljZghHC9HNNKqkHhIt+5BigS+Pgo7gOW8KuxifaAJB21
	W7r1o/WY8xg/BHxkqnZJUM+Pv/2XoI5cNkUBXecQGD7cVfJocE4BwuKoCpCTYIxCmPBoTz53o78Is
	Wd3SdadQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpDpd-0000I7-3M; Thu, 31 Jan 2019 15:00:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDoO-0006Ck-8b
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 14:59:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED0BEBD;
 Thu, 31 Jan 2019 06:59:28 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5F0D3F59C;
 Thu, 31 Jan 2019 06:59:25 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 05/25] arm/arm64: gic-v3: Add PMR and RPR accessors
Date: Thu, 31 Jan 2019 14:58:43 +0000
Message-Id: <1548946743-38979-6-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_065928_931072_7958C35A 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org,
 Russell King <linux@armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add helper functions to access system registers related to interrupt
priorities: PMR and RPR.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 16 ++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 0bd5307..bef0b5d 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -34,6 +34,7 @@
 #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
 #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
+#define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)
 
 #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
 #define ICC_AP0R0			__ICC_AP0Rx(0)
@@ -245,6 +246,21 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg(val, ICC_BPR1);
 }
 
+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg(ICC_PMR);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg(val, ICC_PMR);
+}
+
+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg(ICC_RPR);
+}
+
 /*
  * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
  * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index e278f94..37193e2 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -114,6 +114,21 @@ static inline void gic_write_bpr1(u32 val)
 	write_sysreg_s(val, SYS_ICC_BPR1_EL1);
 }
 
+static inline u32 gic_read_pmr(void)
+{
+	return read_sysreg_s(SYS_ICC_PMR_EL1);
+}
+
+static inline void gic_write_pmr(u32 val)
+{
+	write_sysreg_s(val, SYS_ICC_PMR_EL1);
+}
+
+static inline u32 gic_read_rpr(void)
+{
+	return read_sysreg_s(SYS_ICC_RPR_EL1);
+}
+
 #define gic_read_typer(c)		readq_relaxed(c)
 #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
 #define gic_read_lpir(c)		readq_relaxed(c)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

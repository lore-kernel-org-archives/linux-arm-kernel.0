Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95EC2F42E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9D120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oOW0BtXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9D120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZTbBhKYhxZswRaVrH1abBTAHxqqVCUYEp3lOKN941nk=; b=oOW0BtXyCGi+4ZO3sBA1Bv12Rx
	86i2qMt+9CJ3rAOSUJ2quRZIy3l/jP1HvI9v/mrSR+9K/Vsniwt/q07h3zOJR9xIJ46s6nbjBpO8B
	qOhB+h0CoJz0CnKospE6yRdEw1pBgObC/OZ53IxibkXIRgIJqUaQnO/o/Qs+n1J2RdR0UjpfkAA3m
	T4q9sl5q2UczuXAkKlQj9/dQY04VhFIMJlXfeN7/+mQ+Zv9DrNNf4Qdx7S3SNIZWNU6fNl++mxDGA
	G8IpMD1IpEUIRdN2QJT6FzyLsXbr1+KU06erig5IznoYNN+6a4Plo8sqr6WsmEXFBAp4MRlOHAKJ8
	rbwEpPmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbfi-000326-4S; Mon, 21 Jan 2019 15:39:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbb1-0005pC-Le
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:35:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391911993;
 Mon, 21 Jan 2019 07:34:43 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 402AA3F5C1;
 Mon, 21 Jan 2019 07:34:41 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 18/26] arm64: gic-v3: Implement arch support for priority
 masking
Date: Mon, 21 Jan 2019 15:33:37 +0000
Message-Id: <1548084825-8803-19-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073444_323348_57350DE3 
X-CRM114-Status: GOOD (  12.56  )
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
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Implement architecture specific primitive allowing the GICv3 driver to
use priorities to mask interrupts.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index b5f8142..14b41dd 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -22,6 +22,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/irqchip/arm-gic-common.h>
 #include <linux/stringify.h>
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
@@ -162,14 +163,13 @@ static inline bool gic_prio_masking_enabled(void)
 
 static inline void gic_pmr_mask_irqs(void)
 {
-	/* Should not get called yet. */
-	WARN_ON_ONCE(true);
+	BUILD_BUG_ON(GICD_INT_DEF_PRI <= GIC_PRIO_IRQOFF);
+	gic_write_pmr(GIC_PRIO_IRQOFF);
 }
 
 static inline void gic_arch_enable_irqs(void)
 {
-	/* Should not get called yet. */
-	WARN_ON_ONCE(true);
+	asm volatile ("msr daifclr, #2" : : : "memory");
 }
 
 #endif /* __ASSEMBLY__ */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

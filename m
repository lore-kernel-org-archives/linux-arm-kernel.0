Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A2C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671BC217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ju2wGuAh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK1HvAy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671BC217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NEUcHVJNwVcK1MtsWkmhYoOx7/CzX9L5HkTf3vphAeM=; b=Ju2wGuAhRxTRv5
	7i9biTauim+yZl6SANyoNnYnPnNcrLtCOfh5lyIFRENnVY6Vm8ZY+T1jFoVAI7p+Wn3wiqJaSrkcV
	0bbJrXkFJo9CUKukY1neIWMZsUzLQOieod8h2ptADZbFDbRURKi3OdCAZerS448bEjNWhs7LdeiqX
	CDvAuWd4TTBzOfEqjI5FtLf5oWZmrYpt1RdAA4ntXoMDoOdst6h0DB4jyqu8x6qUAd1qoj1nZeAck
	hYTEgeKuN4xsOJa0pX2mvyLz54Kvt6JEDsXQ9Tg2QMrUY/gBPLFib9n8FAEYT3jvuJlZRIwpKSJIq
	IgR/JlKeWcq0B1xIaztA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ5Yj-0000Zb-Jm; Tue, 18 Dec 2018 02:56:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ5Yc-0000JM-1v
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 02:56:32 +0000
Received: from
 sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown
 [40.76.210.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 931222184A;
 Tue, 18 Dec 2018 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545101779;
 bh=MLMGWi5cjWSTIwETIFeyETUoUs3RMVxywCoyrYA70gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qK1HvAy6lYWQuugsWGNmcRU7ONoXIPdyAKGZfERIg0r5J4m/qIKLuKkddhhnFerAJ
 KHQi/C7913n681TKMF1LcR4yY6v6Y3d6jSScvtP0/w9os4ipYMQfmGfwtHPE7W7b6W
 ZHPxVxgIcB/ujuVdZq+5jGUjyBopnqiuCwrbPtCA=
From: Sinan Kaya <okaya@kernel.org>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v11 5/7] arm64: select ACPI PCI code only both features are
 enabled
Date: Tue, 18 Dec 2018 02:56:04 +0000
Message-Id: <20181218025606.32668-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181218025606.32668-1-okaya@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_185630_501767_C7BF4390 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@kernel.org>,
 "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ACPI and PCI are no longer coupled to each other. Specify requirements
for both when pulling in code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..bcb6262044d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config ARM64
 	select ACPI_GTDT if ACPI
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-	select ACPI_MCFG if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
@@ -163,7 +163,7 @@ config ARM64
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
-	select PCI_ECAM if ACPI
+	select PCI_ECAM if (ACPI && PCI)
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
-- 
2.19.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

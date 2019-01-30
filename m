Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FCC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E493820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tedoUIQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E493820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=iBt4qYivhRJ+FQB3hs0t8zc0udpb9UC6aOUr8gV+vE0=; b=ted
	oUIQrRHLWvC2vz4LsRYjgyrUw+j5Hw2omdZbnmPu7+F5quGnRuYM5LqvVEdubtduJqtGkELdEMXF4
	PAnrbfcnF/hXPMTI/epNhQ2lepniyx+D2QBwwdC6TxY2GORX5PwSExQMvN2aBOmEwSUlLzZpAeYDj
	a288gyYTBXunYKWJZL/PeLeSSKVx5OPHXXCiXHudYXaW35jAgyYKFhKqD3WTtxP4IWUVgtJ591mqn
	MHvxaFD+flFE5r7DT5W46mIXUfcB35KuFhuSwGMau3AqoaXCsB9KproNjfLsCEsj3setdhyv0gsH3
	OKTySft7eh4C8XZSo7/ux4HYy55OksQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomwC-0000od-6u; Wed, 30 Jan 2019 10:17:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomvs-0000Ye-BO
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:17:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7835A78;
 Wed, 30 Jan 2019 02:17:23 -0800 (PST)
Received: from bc-d3-1-12.euhpc.arm.com. (bc-d3-1-12.euhpc.arm.com
 [10.6.16.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2142A3F71E;
 Wed, 30 Jan 2019 02:17:22 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: NOMMU: Limit visibility for CONFIG_FLASH_{MEM_BASE, SIZE}
Date: Wed, 30 Jan 2019 10:17:11 +0000
Message-Id: <1548843431-8162-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021724_746493_94F3285D 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: linux@armlinux.org.uk, arnd@arndb.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It looks like usage of CONFIG_FLASH_{MEM_BASE,SIZE} is limited with:

arch/arm/mm/proc-arm740.S
arch/arm/mm/proc-arm940.S
arch/arm/mm/proc-arm946.S

So it might look confusing to see the option for anything except these.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig-nommu | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 1168a03..36c80d3 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -20,10 +20,12 @@ config DRAM_SIZE
 
 config FLASH_MEM_BASE
 	hex 'FLASH Base Address' if SET_MEM_PARAM
+	depends on CPU_ARM740T || CPU_ARM946E || CPU_ARM940T
 	default 0x00400000
 
 config FLASH_SIZE
 	hex 'FLASH Size' if SET_MEM_PARAM
+	depends on CPU_ARM740T || CPU_ARM946E || CPU_ARM940T
 	default 0x00400000
 
 config PROCESSOR_ID
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

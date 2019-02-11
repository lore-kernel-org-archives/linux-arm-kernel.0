Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946EFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6195F218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="khGryIR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6195F218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7i5l/aGYsXKjb0efyiQPhpXBIvXKU3gd3sREwHnD1AU=; b=khGryIR1fo7N2b
	X4RvBZX7yZRXAeCDn/VCsix2azYMGVSu5SDrUmDdIsBhS64dEoX+9RJuUwHtCwp8D/Jzkt9PN2Fs+
	Jmf4IQ/1/sCNpBeyoETXT7nYG2DhyFZ6UjufCPmr8izP4uUOxOk+Otslwifa8N6DvGxCnDlqjBbZs
	o5Ozw210ftSjxcCZgN5KswlwDD8G3b1TtUhYm3sUx/EkkaJ+LC3oGLVBRGfgb8HM/WC9MJwQoAvKL
	V9P+rqhnJFFSBTATahm9U2/mbnuQ1B7e7qgyYb4tLIQ4cijKNqoDZ5taNCIqT5SZ5mJ7sT6Vk8RyR
	dMBRfIxzB5kZ+0404b/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBld-0000y5-AZ; Mon, 11 Feb 2019 13:37:01 +0000
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBko-0008UY-6H; Mon, 11 Feb 2019 13:36:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
Date: Mon, 11 Feb 2019 14:35:46 +0100
Message-Id: <20190211133554.30055-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The OF_RESERVED_MEM can be used if we have either CMA or the generic
declare coherent code built and we support the early flattened DT.

So don't bother making it a user visible options that is selected
by most configs that fit the above category, but just select it when
the requirements are met.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig     | 1 -
 arch/arm/Kconfig     | 1 -
 arch/arm64/Kconfig   | 1 -
 arch/csky/Kconfig    | 1 -
 arch/powerpc/Kconfig | 1 -
 arch/xtensa/Kconfig  | 1 -
 drivers/of/Kconfig   | 5 ++---
 7 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..4103f23b6cea 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -44,7 +44,6 @@ config ARC
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..9395f138301a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -101,7 +101,6 @@ config ARM
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
 	select OF_EARLY_FLATTREE if OF
-	select OF_RESERVED_MEM if OF
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PCI_SYSCALL if PCI
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..1d22e969bdcb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -163,7 +163,6 @@ config ARM64
 	select NEED_SG_DMA_LENGTH
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_SYSCALL if PCI
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c845f5..0a9595afe9be 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -42,7 +42,6 @@ config CSKY
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PERF_USE_VMALLOC if CPU_CK610
 	select RTC_LIB
 	select TIMER_OF
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..5cc4eea362c6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -233,7 +233,6 @@ config PPC
 	select NEED_SG_DMA_LENGTH
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 20a0756f27ef..e242a405151e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -447,7 +447,6 @@ config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	help
 	  Include support for flattened device tree machine descriptions.
 
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index ad3fcad4d75b..3607fd2810e4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -81,10 +81,9 @@ config OF_MDIO
 	  OpenFirmware MDIO bus (Ethernet PHY) accessors
 
 config OF_RESERVED_MEM
-	depends on OF_EARLY_FLATTREE
 	bool
-	help
-	  Helpers to allow for reservation of memory regions
+	depends on OF_EARLY_FLATTREE
+	default y if HAVE_GENERIC_DMA_COHERENT || DMA_CMA
 
 config OF_RESOLVE
 	bool
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

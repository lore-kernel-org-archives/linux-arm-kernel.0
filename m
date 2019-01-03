Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:18:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9FC2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ewL6ibDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9FC2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=X1yZ+ShnQGNwU2e7ecU0l2k74Dhym238wS6MzIRPTDU=; b=ewL6ibDzgnWjoo00dAQK9pdMbG
	FFqqtu7Ea6aI0k38F36kxFo33LTzFYC9PXHKSbJVEjgYMblOomRPTxk5cVWlCkSizksDXlEqBc6aT
	VbfPb2K8/GDZrj5vtJ7AM6FZKxjc8cefZpY1QWg9z/WXKprLQJ5oZcdN3B5VBCmSZqM/cdwQcexJv
	hdDr7LGswk0v0J7EkOM5KQajTu/EUkEWoTqJlaaQ8W3bQjTFBFtbQRgdmNTZQYrtvi9PFEyMi6KIZ
	Yn0p24w0ZQ9LaZRPmGCgm9JDaFo2NxqAJDE6EdS0z/lo7UMD6hAgSYJMr1g7Tyqj8Gwq4bry0MUAy
	sVtCEzOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8VD-0001tH-60; Thu, 03 Jan 2019 19:17:59 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8V8-0001s7-AK
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:17:56 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 lsun@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 3 Jan 2019 21:17:48 +0200
Received: from bu-lab53.mtbu.labs.mlnx (bu-lab53.mtbu.labs.mlnx [10.15.8.107])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x03JHlNG027028;
 Thu, 3 Jan 2019 21:17:48 +0200
Received: from bu-lab53.mtbu.labs.mlnx (localhost [127.0.0.1])
 by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7) with ESMTP id x03JHlA4156094;
 Thu, 3 Jan 2019 14:17:47 -0500
Received: (from lsun@localhost)
 by bu-lab53.mtbu.labs.mlnx (8.14.7/8.14.7/Submit) id x03JHlgO156093;
 Thu, 3 Jan 2019 14:17:47 -0500
From: Liming Sun <lsun@mellanox.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 David Woods <dwoods@mellanox.com>, Robin Murphy <robin.murphy@arm.com>,
 arm-soc <arm@kernel.org>
Subject: [PATCH v7 2/9] arm64: Add Mellanox BlueField SoC config option
Date: Thu,  3 Jan 2019 14:17:15 -0500
Message-Id: <1546543042-156044-2-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546543042-156044-1-git-send-email-lsun@mellanox.com>
References: <1546543042-156044-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_111754_751344_74945EBB 
X-CRM114-Status: UNSURE (   7.84  )
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
Cc: devicetree@vger.kernel.org, Liming Sun <lsun@mellanox.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This commit introduces config option for Mellanox BlueField SoC,
which can be used to build the SoC specific drivers, and enables
it by default in configs/defconfig.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479..a9b10a0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -119,6 +119,12 @@ config ARCH_MESON
 	help
 	  This enables support for the Amlogic S905 SoCs.
 
+config ARCH_MLNX_BLUEFIELD
+	bool "Mellanox BlueField SoC Family"
+	select SOC_MLNX
+	help
+	  This enables support for the Mellanox BlueField SoC.
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d1..85dbef0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -44,6 +44,7 @@ CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
+CONFIG_ARCH_MLNX_BLUEFIELD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:18:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB512173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbihCs4r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WjrE9feW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB512173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=o1Cu4KUYRED22fKaQKZykTUOq0o38sMZ1j3cPfPj69Q=; b=fbihCs4rIyji3JnsW4EQ/4GFg8
	jOPUPf+P5wnCk0c+xOu7JS0uDoJE1/gbdvyy3O7rwCtPCt82YgPurgHxugldBtidOlkqqmlL/83JN
	ftH+5VGijrBaQxO7NbchLKP1pl50cNd+UIEOflLAVHHSEgMd3PLbYcVeYbcl28c4ie0weED5vy+gZ
	khy7cDlltFjrlXDAqD0vOF6A9W9wATf3SLry7jplBgTogk5MTBSv+X3xtG7g3Iu3ywKyGmBEdYEKK
	14yfrMjfv6CgMju+w6CS6wTYqlzrfX6TJidC+BA53Kb0eLoL4UO4Pr1dJaVQAJOEN0Kww03UvEPPH
	K8itZDIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXQN-0000ND-MG; Thu, 10 Jan 2019 10:18:55 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXQD-0000Eh-Pu
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:18:47 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id F24D825B7DA;
 Thu, 10 Jan 2019 21:18:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547115521; bh=+fN9b9sqVrBqQvyfTybKbT1mL8VNSDITqltDqe1gias=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WjrE9feWHhr0HwapvQmLqdinKOw8OECUVZzEwnOjhcFSQ5d9ZsYYxv4l/2gXLpl7K
 QDwiag/F88fua73dm0LSe5nPNBXsbfeiRupIdOhnvLNt+Pc9W84EGc3iabEaP2b6/4
 FulthDx/MbsAspREqeSKI1btqGYIpt1KAHl21+TM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 383A79404A5; Thu, 10 Jan 2019 11:18:39 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] ARM: shmobile: fix build regressions
Date: Thu, 10 Jan 2019 11:18:37 +0100
Message-Id: <8070ba6348608aa1da15eb83dbaa9ece596aaa67.1547115367.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1547115367.git.horms+renesas@verge.net.au>
References: <cover.1547115367.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_021845_981591_A87858D6 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

A number of Kconfig options have become available now to random ARM
platforms outside of ARCH_MULTIPLATFORM, which now causes Kconfig
warnings, and other build errors when those select options that
lack additional dependencies, e.g.:

WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
  Depends on [n]: CPU_V7 [=n]
  Selected by [y]:
  - ARCH_RCAR_GEN2 [=y] && SOC_RENESAS [=y]
  - ARCH_R8A73A4 [=y] && SOC_RENESAS [=y] && ARM [=y]

WARNING: unmet direct dependencies detected for SYS_SUPPORTS_EM_STI
  Depends on [n]: GENERIC_CLOCKEVENTS [=n]
  Selected by [y]:
  - ARCH_EMEV2 [=y] && SOC_RENESAS [=y] && ARM [=y]

Put the old dependency on ARCH_RENESAS back for the moment to restore
the previous behavior.

Fixes: 062887bf5ef7 ("ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 4d8012e1205c..68bfca6f20dd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -44,7 +44,7 @@ config ARCH_RZN1
 	bool
 	select ARM_AMBA
 
-if ARM
+if ARM && ARCH_RENESAS
 
 #comment "Renesas ARM SoCs System Type"
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

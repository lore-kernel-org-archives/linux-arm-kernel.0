Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7115C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:14:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A287B217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PtiKb7i5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UzcQcwND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A287B217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PXGmYx7JoHhYPKuxfat+m2pZ4D76icusrmDJRYW8+VI=; b=PtiKb7i58Knc0G
	3Sfc3PzrI/bhEsmSdFbhsx55XPw/CL1V2KcHqkY68rCX/fxFUv38e5KDV7D5jTqo8e33zMgn9s6yB
	k3Mc0MdYgVdB5pPOrwAlQYJifD705IpsB2p/XOrivYe9VkEoPHjxogoNfePLrrhOJguaBfHQozAkt
	Bm/xLfyXI+J3n+jHTX322eB4mYQ78Jq5kUmZnGJ70iKtPFI1r1/74XiCRhiMT3yekQruvJwcH8KWM
	iDGrwC2UVKhx6XmY/XjPxv5FmWWr8Yos+qEO3pHtOD1PAf23cYlNsqDjbJT6pO4EzWII6V8oLG/vZ
	gmZUF6G96hsg4tEcu0tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBRu-0005P1-38; Tue, 18 Dec 2018 09:13:58 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBR8-0004jL-GG
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:13:14 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18ba1c0000>; Tue, 18 Dec 2018 01:13:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 01:13:08 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 01:13:08 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:13:08 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 18 Dec 2018 09:13:08 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c18ba230000>; Tue, 18 Dec 2018 01:13:08 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 10/20] clk: tegra: dfll: build clk-dfll.c for Tegra124 and
 Tegra210
Date: Tue, 18 Dec 2018 17:12:22 +0800
Message-ID: <20181218091232.23532-11-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218091232.23532-1-josephl@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545124380; bh=FYsaGqMrJl9+Re/gqB0hySfjQBnOmGeLJ/FU3mi4/YU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=UzcQcwNDvwMzcsBLUC+qEX9SLEqFDjstEAH5CO8cKlP9sN6RpepjEapPuW9ovx1sb
 fv/5x8YcLgR/Dowp9Vk3isLODsqO896WsI5/9YL4LOyi0a/UypWQ/W6Z1yefOHPR05
 GH0bKz4JnBZIIZxtBHGv3wKx780nAyTUY56vZEs+fPxN87FuXwRjCgl6JXP0fzZHZF
 yfcKR0O4LdeF4VCNGG74yQ6ID1tYLKhrDeaU1bHk5xPaFZnZTAWiYy+taDouwD8b3i
 Wg3iUfIDjaCrTCqBcvrB8lrpB/zso4bRVMTQr3ZrZtAKTFLBmgpMDRvb1IjCxlwVZk
 tQIxgexYsKCaA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_011311_226487_945CDD13 
X-CRM114-Status: UNSURE (   9.15  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

Tegra210 has a DFLL as well and can share the majority of the code with
the Tegra124 implementation. So build the same code for both platforms.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
*V3:
 - no change
*V2:
 - add ack tag
---
 drivers/clk/tegra/Kconfig  | 5 +++++
 drivers/clk/tegra/Makefile | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
index 7ddacae5d0b1..57902ab43f4a 100644
--- a/drivers/clk/tegra/Kconfig
+++ b/drivers/clk/tegra/Kconfig
@@ -5,3 +5,8 @@ config TEGRA_CLK_EMC
 config CLK_TEGRA_BPMP
 	def_bool y
 	depends on TEGRA_BPMP
+
+config TEGRA_CLK_DFLL
+	depends on (ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC)
+	select PM_OPP
+	def_bool y
diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 6507acc843c7..4812e45c2214 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-dfll-fcpu.o
+obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
 obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
 obj-y					+= cvb.o
 obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B25206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="alNkj+oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B25206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rxFoEmoiP/2bnzIRPdN6xYi9m10wigkfzhJ3Bl5GCeM=; b=alNkj+oGycLI8m
	kSeFHAHZpS4hJ1OwtLvG64oexGSsaPH1S55zskGEVb9idUt9tGbOBTJpMnYr4mc/3lY7pce/W32v4
	4yS2wiL7zzLcEWISXQxJhK8E7IeDKeSyJwEKab5XPLe0mFoN1aGMMl3RrWmcKYyXTrk1Ihj3COqbH
	mLZdbVrP33156mONmzc4uUYT0735u8+tqy/cwIDnKyhOQBmdDgtZdq3o03jF3+TF10lNwEbvxJiPf
	ww9dvCWjnirZLH9g+QkdRnzg2TKslJdGZQYhyM+tFSIh2YFGPPbjwbkOOnI6klXJs3j/W3GD8DRQJ
	dMulu6zpZzgm3wHflQiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYusb-0004Df-Us; Mon, 17 Dec 2018 15:32:25 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYusK-0003wU-1T
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:32:10 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7]
 helo=dude.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gYus4-0006Kg-L4; Mon, 17 Dec 2018 16:31:52 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] soc: imx: gpcv2: handle additional power-down bits in
 handshake register
Date: Mon, 17 Dec 2018 16:31:51 +0100
Message-Id: <20181217153152.21135-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_073208_246567_98A500EC 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some of the i.MX8MQ domains have an additional control bit in the PU
handshake (HSK) register. Documentation about this bit is a bit sparse
at the moment, but it seems that it controls a power-down request to
the AMBA domain bridge (ADB-400) attached to those domains.

As the documentation doesn't desribe the usage of this bit yet, handle
it in the same way as done in the ATF implementation.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
https://source.codeaurora.org/external/imx/imx-atf/tree/plat/freescale/imx8mq/gpc.c?h=imx_4.9.51_imx8m_ga
---
 drivers/soc/imx/gpcv2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 8b4f48a2ca57..a8dd0cddb3d2 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -65,6 +65,12 @@
 
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
+#define GPC_PU_PWRHSK			0x1fc
+
+#define IMX8M_GPU_HSK_PWRDNREQN			BIT(6)
+#define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
+#define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -102,6 +108,7 @@ struct imx_pgc_domain {
 	const struct {
 		u32 pxx;
 		u32 map;
+		u32 hsk;
 	} bits;
 
 	const int voltage;
@@ -142,6 +149,10 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
 				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
 
+	if (domain->bits.hsk)
+		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+				   domain->bits.hsk, on ? domain->bits.hsk : 0);
+
 	regmap_update_bits(domain->regmap, offset,
 			   domain->bits.pxx, domain->bits.pxx);
 
@@ -328,6 +339,7 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_GPU_SW_Pxx_REQ,
 			.map = IMX8M_GPU_A53_DOMAIN,
+			.hsk = IMX8M_GPU_HSK_PWRDNREQN,
 		},
 		.pgc   = IMX8M_PGC_GPU,
 	},
@@ -339,6 +351,7 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_VPU_SW_Pxx_REQ,
 			.map = IMX8M_VPU_A53_DOMAIN,
+			.hsk = IMX8M_VPU_HSK_PWRDNREQN,
 		},
 		.pgc   = IMX8M_PGC_VPU,
 	},
@@ -350,6 +363,7 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_DISP_SW_Pxx_REQ,
 			.map = IMX8M_DISP_A53_DOMAIN,
+			.hsk = IMX8M_DISP_HSK_PWRDNREQN,
 		},
 		.pgc   = IMX8M_PGC_DISP,
 	},
@@ -390,7 +404,7 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 
 static const struct regmap_range imx8m_yes_ranges[] = {
 		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
-				 GPC_M4_PU_PDN_FLG),
+				 GPC_PU_PWRHSK),
 		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_MIPI),
 				 GPC_PGC_SR(IMX8M_PGC_MIPI)),
 		regmap_reg_range(GPC_PGC_CTRL(IMX8M_PGC_PCIE1),
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

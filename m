Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D759CC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BC82082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jcpRc+Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BC82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3Ou6immpyd5stEK0/eQpo0BiOOvumeGHxq5c02ssH/w=; b=jcpRc+Gf3pFIHRiKdF8yXcAxpv
	FZviXKrhp6hdIgVfuzhafMGNDxQOqq8MxDDCfx4vSwhyBt1hp+IONH8qppWqDv3UI1ORyL9ZPb8aH
	cHhIOSF9ttouSxpWAvJ9gXQws3svtTbGpwbqQOyobr0vl/XXM00XE0a2n8+7v3eUfiSbfxeFnS6gE
	yY/pcppqAZ3MukiFUsW3BM9L4+vDFb/MtkLZmMCTyjzhNIL6UDAFAN93CHWe9i579ho0t3xaQ7jjV
	FBltMoMzBE9fsqH+NRUwPVw1nfhakWkuiuAw34KsobsT6PFd8YYipqZi/VHgMPMl5JEvSoul3aokn
	2+bVgskA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiSV-0004C5-0f; Tue, 11 Dec 2018 13:52:23 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiSC-0003ui-VD
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:52:08 +0000
Received: from stefan-Vostro-260.fritz.box ([109.104.44.229]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MowOm-1hFBvu1oGU-00qQhE; Tue, 11 Dec 2018 14:51:48 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/3] nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
Date: Tue, 11 Dec 2018 14:51:12 +0100
Message-Id: <1544536273-17909-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:NCcWYFjC6x0ensAgiEiuINZrqcFL6obCe1vEJR7lkUQCNlUY9Lc
 XZ31IvLSrYrXqt43X9UC7vbqIgNndB21Tpoijpc3EzzO50he8R/gk8SZEHhG25OvKPak/PD
 xhnLj50ssZ0yMI3MpHdpFOL8MDZVLFeAeQRhm7+AgABxNwcSPmI8L+hvO2/y48fYKt8qLRM
 yNq9Rclbz2OgEFTzcOskQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+NqVLwEPgNk=:hwSvcCGjLrnDE4IVg+dmZF
 HA/mOxs0/nzRZXATmyTFRo3ebNP5J8sYD/tnB8uvpqm2twFXpWTkQJF1z8cTWPNZxDCOex7uM
 o7A2gvXCXKNEGQMmJbdmStUU62eVV+yLG8H3vFOsDfE03wjsowDQbemXAYQ7QMaJ+IbsBteEK
 dDB8qlqkoMxzu9Ym8N3GzwM38jg5qlIQolrrzhWFHyHehxinBW4RDSIE9GLP/LrFOykZUmJp9
 /uS6DuJ9H1Uq5oi1lsfkNZ7TIA6LZPeAt2naRtwHBJNDWWZCfbziepZpm3CWkNTidJV1sOMJr
 LLBbxrBEdU3jk+IMi/2gyKaWMoTGmDz7jnZTcegaHxtg6C193/YtzmUQ1lFoMIzraqSAarztX
 xI+MsPJvt8LTZkIvV2sfZpKisBooaaV0rCmd0A9eyezE4oXfPf30H9tLBMoBPD4kwlPcAkygO
 XYKFBKgtKTei+hgXWh+j1YAVp1eT8M42TnDolMNWQatDZq+bC9IvO9sG6VGrQtkeRFfi/cah4
 wOYR4F7wEUCrTAx12tTKLIKDtz/xHHJ4AnkvuxFp3QaI8dCBvwlxEUtHIcBoPZLB0JKhHfgzl
 YQjkDRlHAp+LKlvci6zs0ESiZngwEu/rm9WM+bcvWLNcUVM4J8/yytPa5vdNxY6y2cyGEXR3I
 raJDyhDd5C9YqNGV1NMr+Qt9kAEjF6C84YclD1kn4V9fdgLH/UzRYdw0Vd8LX5SlCA/6Q4qaD
 +yghBHmCLt8GRF7vRMUZG99lk+bfsbj+R/B2eXkBUwphZEQd/MKV+jeTumo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055205_306211_69407267 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In comparision to the i.MX6UL the lower cost variants i.MX6ULL/ULZ only
supports 8 OTP banks a 8 words.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index afb429a..a433a41 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -427,6 +427,12 @@ static const struct ocotp_params imx6ul_params = {
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
+static const struct ocotp_params imx6ull_params = {
+	.nregs = 64,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+};
+
 static const struct ocotp_params imx7d_params = {
 	.nregs = 64,
 	.bank_address_words = 4,
@@ -438,6 +444,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
 	{ .compatible = "fsl,imx6sx-ocotp", .data = &imx6sx_params },
 	{ .compatible = "fsl,imx6ul-ocotp", .data = &imx6ul_params },
+	{ .compatible = "fsl,imx6ull-ocotp", .data = &imx6ull_params },
 	{ .compatible = "fsl,imx7d-ocotp",  .data = &imx7d_params },
 	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
 	{ },
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

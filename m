Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:37:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649ED20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbUvoMZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649ED20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scratchpost.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CfVNDfqaM0eIiH2t+MV5tnsoODt3dAfXNuAGs6qU4FM=; b=ZbUvoMZ+rX/3sI
	VA4DVzrFwSkkSMYMg8CcfkNfRHm+horayyT+OAwaNonhyyXbHbjmYGbqIc9101YgDo9qXQD9QuC7H
	eLrFwXr4UGAa7RW155ZjQrUbaOLETRg8DdWBQmQK8S8rUnvl14RvydXow+8cNgPLCgM1ApQHBBiMi
	AH2n7bpPlwM2pIWVl8LR9OGwUrHEWQf6zzKQwC2xs9KWJjTd+JeNQd93K8QytGrAsbvmjqwYhkklE
	n0IjJtYLWJxeht0oReOkW4wxeVBjzUQ60ni82rnYngebkg/QTBoyOeyFszJCtQfuJqW75PmqtXtCo
	VuF/Bq0oRAR2qrlsZaZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqzi-0002e7-Ok; Wed, 30 Jan 2019 14:37:38 +0000
Received: from dd26836.kasserver.com ([85.13.145.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqy7-00019T-LE
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 14:36:03 +0000
Received: from dayas.3.home (77.116.173.211.wireless.dyn.drei.com
 [77.116.173.211])
 by dd26836.kasserver.com (Postfix) with ESMTPSA id AFE393362C1F;
 Wed, 30 Jan 2019 15:26:03 +0100 (CET)
From: Danny Milosavljevic <dannym@scratchpost.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Danny Milosavljevic <dannym@scratchpost.org>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v15 2/8] ASoC: sun4i-codec: Add Mic Playback Volume
Date: Wed, 30 Jan 2019 11:39:38 +0100
Message-Id: <20190130103945.26692-3-dannym@scratchpost.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130103945.26692-1-dannym@scratchpost.org>
References: <20190130103945.26692-1-dannym@scratchpost.org>
MIME-Version: 1.0
Tags: patch
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_063600_175250_7FF67A01 
X-CRM114-Status: UNSURE (   8.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a control "Mic Playback Volume" that allows the user to control the
MIC gain stage (common for Mic1 and Mic2) leading to the output mixer.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7b965bc50..060a40b45 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -681,6 +681,9 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
+		       sun4i_codec_micin_loopback_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

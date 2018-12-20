Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC1C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942DE218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DKLiMHQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942DE218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bXRe/ZnWpKhS9mid7tWgDeXZexgYpMPBCL4Wka54ZPE=; b=DKLiMHQXSf90gl
	sO/lGg+OrAB51OmxdwUDJt3xlxMtO3+43oRMlbAaLZsNhprOQlC3xFoSOUrMJzVTVudeLyw2mV5jS
	C6BW5Yzq5KbD6gBnoza7UQhGureWZoeq65j3oFBjhBGXfRMsWDTyZo1VeSQdb5Z/1purT5nt5ZQyW
	1Ri1LqR5saZV1ppHEr4aBm3bszJrka7LzCZyiOvLc/mbecFTRcas0xc/3k0HnRbfS6LYChKbC/IU4
	aT0jLlAhQrWDwSkdqi/PT5pSooQASnsfy2UQWrUlEOllh+1bUELtMN9GN8r27/lEmx7/s4TonBSMm
	LC/H7cWkHNSQ77U/WSpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0Nm-0008Dr-PH; Thu, 20 Dec 2018 15:37:06 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0Nj-0008Cq-QR
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:37:05 +0000
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBKFafjM040744;
 Fri, 21 Dec 2018 00:36:41 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 21 Dec 2018 00:36:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from localhost.localdomain (183.38.232.153.ap.dti.ne.jp
 [153.232.38.183]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBKFabSF040730
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Fri, 21 Dec 2018 00:36:41 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: rockchip: add workaround for silence of rk3288
 ACODEC
Date: Fri, 21 Dec 2018 00:36:36 +0900
Message-Id: <20181220153636.5213-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181220153636.5213-1-katsuhiro@katsuster.net>
References: <20181220153636.5213-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_073704_073072_81647DE9 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds reset and precharge in shutdown of PCM device.

ACODEC goes to silence if we change Fs to 44.1kHz from 48kHz. This
workaround seems to work but I don't know this workaround is correct
sequence or not for ACODEC.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/codecs/rk3328_codec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 71f3fc2d970c..f3442a2283ea 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -261,9 +261,12 @@ static int rk3328_codec_close_playback(struct rk3328_codec_priv *rk3328)
 		mdelay(1);
 	}
 
+	/* Workaround for silence when changed Fs 48 -> 44.1kHz */
+	rk3328_codec_reset(rk3328);
+
 	regmap_update_bits(rk3328->regmap, DAC_PRECHARGE_CTRL,
 			   DAC_CHARGE_CURRENT_ALL_MASK,
-			   DAC_CHARGE_CURRENT_I);
+			   DAC_CHARGE_CURRENT_ALL_ON);
 
 	return 0;
 }
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

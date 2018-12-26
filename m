Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9DF218A5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHyoi9rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9DF218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VtrZpiohbM8WSyaRalh7TPY3q43PAneITw+boyeRONU=; b=EHyoi9rtfr6MFC
	avSTqUWCpTj1TjpNAAqovwyi4mgJLPd9rnnn2zP9BSSC4cGX5zZJPyS61zr5ZZ6kMc1Wk/QNVXd74
	kyfxNpjC2+l9l8tAIWbPXJ/lDvIzzLnqrNUOQXy3qw+2WJ7keEcwoxHMwS57/GiCLFL7UCMJdXvjs
	fJ9xrUgjtp2w7nFuMv7NEtANXxBy3wWWmSoNChPGaFXC+0hRDD3hyQ98zSDYQRsUnb68oh8n16QTY
	FfOQVR7OLcpyAoMO45vI7YhPpISl8zC10aANIJNyE5Re7Haph6lIbtPddJJW2ZoOUsLFU6yi7kmKC
	CpXZSAVk8MvQCNVXeL4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcGSz-0004m9-O5; Wed, 26 Dec 2018 21:11:49 +0000
Received: from gateway21.websitewelcome.com ([192.185.45.147])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcGSk-0004kg-KP
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 21:11:36 +0000
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway21.websitewelcome.com (Postfix) with ESMTP id 916C6400CBF90
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 15:11:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id cGSKgpg5HdnCecGSKgyBV3; Wed, 26 Dec 2018 15:11:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=54028 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gcGSJ-003Bzu-I8; Wed, 26 Dec 2018 15:11:07 -0600
Date: Wed, 26 Dec 2018 15:11:06 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe
Message-ID: <20181226211106.GA16692@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gcGSJ-003Bzu-I8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.104]:54028
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_131134_719337_DC6948A0 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, if platform_get_irq_byname() fails, the returned error
turns into a huge value, once it is being store into a variable
of type unsigned int, hence never actually reporting any error
and causing unexpected behavior when using the values stored
in aud_drv_data->s2mm_irq and aud_drv_data->mm2s_irq.

Fix this by changing the type of variables s2mm_irq and mm2s_irq in
structure xlnx_pcm_drv_data from unsigned int to int.

Addresses-Coverity-ID: 1476096 ("Unsigned compared against 0")
Fixes: 796175a94a7f ("ASoC: xlnx: add pcm formatter platform driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index f7235f7664d7..d2194da928e7 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -76,8 +76,8 @@ struct xlnx_pcm_drv_data {
 	void __iomem *mmio;
 	bool s2mm_presence;
 	bool mm2s_presence;
-	unsigned int s2mm_irq;
-	unsigned int mm2s_irq;
+	int s2mm_irq;
+	int mm2s_irq;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
 	struct clk *axi_clk;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

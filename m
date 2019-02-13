Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D217C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:21:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21554222CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ulmoUbBr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="B43ZzV6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21554222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tRU2xbxQAxqmhxhGGBk/ejTnrtzziTMlXAxW2A6GQgA=; b=ulm
	oUbBrbrA66quVk9FMc0+p5cqmGrjTBW7JUy24tXuiFPuDJqMyAq+Rqf6eHsAk2kVJw+LnOCprSt+a
	A6w6XasUrlU3U8rityZVAT2Q+ZNs4qvK7AOFiQQp71eAPMC+RdqKERtIrWEuUFDqgQ2MkA0J6zPcm
	CGmhpcA4/Of1dXwJiHv6zbl6KpFm/iIMQ1GtT1fJn8LZVjiucu5zzXCo+snApU+RMcuB48feDzAkI
	FT1b+jH160h6ubPmf45x7hUNRMUDXW8lBGPLCv6+4df1+m+kuRSOLXlkpsY8X26IDf/49d/CryWO1
	H8kEwtrZGyyyrROrzP+MJaVKzYDFZGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwLf-00055B-9U; Wed, 13 Feb 2019 15:21:19 +0000
Received: from m12-17.163.com ([220.181.12.17])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwLc-00053v-20
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:21:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=JS4RGYTdm5rUrpgn+q
 ISygEYopSRQ9C2C1Tg46GD540=; b=B43ZzV6yG0HaXsekE/AKGHMve3JkWKdlJU
 z1fkehq+55oXmEuIn/V7D43GRmM42WNHVkjcm+w4gIeHKf/QyfUu+KJlPSX/lXo8
 yYU0ByvBYfys3zW/9/K3YbYVPiZdIiYZlScMk4jpkcVuzc8zY781pLhHb+gQudnG
 P6cwDd7mE=
Received: from yangwei-T440.lan (unknown [125.69.43.124])
 by smtp13 (Coremail) with SMTP id EcCowAAHMb_fNWRceZBkFg--.32302S3;
 Wed, 13 Feb 2019 23:21:04 +0800 (CST)
From: Yang Wei <albin_yang@163.com>
To: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net] net: nuvoton: w90p910_ether: replace dev_kfree_skb_irq by
 dev_consume_skb_irq for drop profiles
Date: Wed, 13 Feb 2019 23:21:02 +0800
Message-Id: <1550071262-4889-1-git-send-email-albin_yang@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowAAHMb_fNWRceZBkFg--.32302S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWDKF17tFWxtw4rXrWUJwb_yoWfCFb_C3
 4UXrWxA398Jrn8trW0gw4F9r9Y9wn8ZrW8CF4Iq3y3X3yUK3s5CF1kurnxGrnxWa18XF17
 GrW2qFZxA342qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjRwZ3UUUUU==
X-Originating-IP: [125.69.43.124]
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/1tbiEQBaolWBkKV6fQAAsP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_072116_535632_A4E1103F 
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
Cc: yang.wei9@zte.com.cn, davem@davemloft.net, mcuos.com@gmail.com,
 albin_yang@163.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yang Wei <yang.wei9@zte.com.cn>

dev_consume_skb_irq() should be called in w90p910_ether_start_xmit()
when skb xmit done. It makes drop profiles(dropwatch, perf) more
friendly.

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 drivers/net/ethernet/nuvoton/w90p910_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index c662c6f..67bf02b 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -630,7 +630,7 @@ static int w90p910_ether_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (!(w90p910_send_frame(dev, skb->data, skb->len))) {
 		ether->skb = skb;
-		dev_kfree_skb_irq(skb);
+		dev_consume_skb_irq(skb);
 		return 0;
 	}
 	return -EAGAIN;
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

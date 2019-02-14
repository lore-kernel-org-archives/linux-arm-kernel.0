Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF307C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:57:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D66E222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pme0GsY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D66E222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QFtCDvvxGUpi0c7h7+29u1tFuepRy/gIerP5Ci359k4=; b=Pme0GsY4XnFFdM
	5M4mmG8Ox1Oxpwd1yGZVoOQrKNrx5qVC2CH25VF0vfh/0aAzV5sPaHprs51kh7yoB4PLMPMAiCG+a
	C9vDV26KGCGIULzpwpPO63F6UReSoG2TfYHbjHKkK0pvg/Drpl802MbHMQF5OCazbs2/z8ZXmJYzf
	32wCmuMFAb7fTk0/r3hdex/0jRD48YUm1787zCUnOZN//id/sbhrEgejnwSIWWm0TD/xLxW3dQTrm
	8oVFEZCaOJw3NeSIBhYfEDyXv9ZU/CCWvEzoGU8GpWxn34jtSSI1eOSbktFAnmQYQ0MSTNKw5SuoN
	Rec9yIzPCD70FsUvIBMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKKQ-0006Rq-Tr; Thu, 14 Feb 2019 16:57:38 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKKO-0006Pq-1u
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:57:37 +0000
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net
 [96.89.128.221]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id A20B414D5DF1C;
 Thu, 14 Feb 2019 08:57:31 -0800 (PST)
Date: Thu, 14 Feb 2019 08:57:31 -0800 (PST)
Message-Id: <20190214.085731.1881035353506058355.davem@davemloft.net>
To: albin_yang@163.com
Subject: Re: [PATCH net] net: nuvoton: w90p910_ether: replace
 dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
From: David Miller <davem@davemloft.net>
In-Reply-To: <1550071262-4889-1-git-send-email-albin_yang@163.com>
References: <1550071262-4889-1-git-send-email-albin_yang@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 14 Feb 2019 08:57:31 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_085736_090668_A66274BE 
X-CRM114-Status: UNSURE (   5.94  )
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
Cc: yang.wei9@zte.com.cn, netdev@vger.kernel.org, mcuos.com@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yang Wei <albin_yang@163.com>
Date: Wed, 13 Feb 2019 23:21:02 +0800

> From: Yang Wei <yang.wei9@zte.com.cn>
> 
> dev_consume_skb_irq() should be called in w90p910_ether_start_xmit()
> when skb xmit done. It makes drop profiles(dropwatch, perf) more
> friendly.
> 
> Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>

Applied.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

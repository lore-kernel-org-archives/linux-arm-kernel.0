Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7290C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:32:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77AE20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jUsVe1FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77AE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zNyDl/iITTktuQuhy8Psee4zBCj4QHBIcn6BSueGlno=; b=jUsVe1FBQ2j7jN
	g3amlxM7NcNkspifnceKjvp8zkkYsEzptHMQDgb230psqzx2y8YZ4NF4QmrYa0McsRGIZHJtuGSHb
	UDNnVzAVY9MYu/mMu81VlsJyZxTFdDsTPRvyrore8iQjFVyRPA1eIxLVE3H8KGnuI4AyL1u8iDlww
	wIOsNnrGGpT+MdsdVzU0CefBW6cYAY39abTfFbtCPe6wV8pbADZgFYiVyrj+yi6p89d6EUK30bcaZ
	nl+b5vmK4n6dKsP1wrFRkbq8m0v6HucgLTDbhKSs5/RpmJyZuP+Q9LM1oQMnL9HsbkrVrhGar1k3T
	oj+jfVL589T8kGMZL/cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy0S2-00062x-Ly; Sun, 24 Feb 2019 20:32:42 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy0Rz-00062I-6c; Sun, 24 Feb 2019 20:32:40 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 3810B14CFB314;
 Sun, 24 Feb 2019 12:32:31 -0800 (PST)
Date: Sun, 24 Feb 2019 12:32:30 -0800 (PST)
Message-Id: <20190224.123230.261167641058555597.davem@davemloft.net>
To: wen.yang99@zte.com.cn
Subject: Re: [PATCH 5/5] net: dsa: fix a leaked reference by adding missing
 of_node_put
From: David Miller <davem@davemloft.net>
In-Reply-To: <1550819742-32155-5-git-send-email-wen.yang99@zte.com.cn>
References: <1550819742-32155-1-git-send-email-wen.yang99@zte.com.cn>
 <1550819742-32155-5-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sun, 24 Feb 2019 12:32:31 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_123239_250330_2004EBD5 
X-CRM114-Status: UNSURE (   7.05  )
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
Cc: wang.yi59@zte.com.cn, andrew@lunn.ch, alexandre.belloni@bootlin.com,
 f.fainelli@gmail.com, michal.simek@xilinx.com, netdev@vger.kernel.org,
 linus.walleij@linaro.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, anirudh@xilinx.com,
 lorenzo.bianconi83@gmail.com, John.Linn@xilinx.com, vivien.didelot@gmail.com,
 kvalo@codeaurora.org, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Wen Yang <wen.yang99@zte.com.cn>
Date: Fri, 22 Feb 2019 15:15:42 +0800

> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
> index 8c431e0..89823f0 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -613,7 +613,7 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
>  	struct device_node *ports, *port;
>  	struct dsa_port *dp;
>  	u32 reg;
> -	int err;
> +	int err = 0;

Please preserve the reverse christmas tree ordering of variables here.

Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

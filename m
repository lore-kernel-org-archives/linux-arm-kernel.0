Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:58:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E778320665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k/d1PoN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E778320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VujCyJdgSBA/PpkHrn1N9ZR9vjRFy3LCjZGuNNVDm6g=; b=k/d1PoN8ssHJvF
	lQnTpHl7f+wbQ6utdZIwuC63cbR6YlHJIkByd0/WP7rylO/hfwL38anMPlrnyeU23Mk6JSeMS/2BD
	EYeNfsNZxqXMNhOBCz91+SoRhRwIhY6GxP789EMzHK9q1kHgXGAKsoQ/puTcGXL65Ov00epkCdRy9
	zh9/sXGYkObDbIc8CeNoWyI/Gc50Jx78V/vPFyMWcAtjacCjIwwDtn3tlWV5hQ7jXRxiSAKZXEiqe
	7n1BRO4Ug87bLRPvJ8js4DN3/7SKC3b6VbWJ3/LNktUPhLGHN4AzdjeK99WqL0fWV35QKp0G87GDt
	czBuxo56ftSmjem5z2QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghiLQ-0001Y6-CT; Thu, 10 Jan 2019 21:58:32 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghiLN-0001XO-5O; Thu, 10 Jan 2019 21:58:30 +0000
Received: from localhost (unknown [66.187.232.66])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 1A43A14D3EFA0;
 Thu, 10 Jan 2019 13:58:24 -0800 (PST)
Date: Thu, 10 Jan 2019 13:58:22 -0800 (PST)
Message-Id: <20190110.135822.559533664183421677.davem@davemloft.net>
To: frank-w@public-files.de
Subject: Re: [PATCH v2] net: ethernet: mediatek: fix warning in phy_start_aneg
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190109072028.30513-1-frank-w@public-files.de>
References: <20190109072028.30513-1-frank-w@public-files.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 10 Jan 2019 13:58:25 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_135829_218747_F03D222D 
X-CRM114-Status: UNSURE (   4.84  )
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
Cc: nbd@openwrt.org, nelson.chang@mediatek.com, netdev@vger.kernel.org,
 sean.wang@kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, john@phrozen.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Frank Wunderlich <frank-w@public-files.de>
Date: Wed,  9 Jan 2019 08:20:28 +0100

> From: Heiner Kallweit <hkallweit1@gmail.com>
> 
> linux 5.0-rc1 shows following warning on bpi-r2/mt7623 bootup:
 ...
> maybe other boards using this generic driver are affected
> 
> v2:
> optimization:
 ...
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied, thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:07:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C530B20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uHrSawnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530B20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RQxGrK1x9tbU5FbMwU/V5ogfkxiblYS28coN8m5vhv4=; b=uHrSawnQ37TcRp
	E6gUeeqQKB/7Uzq4NsKyZzHsE+34FFBEVevR2VZyCKTDB2bgbZsPk55be3GKkk5EJ16FpN0ZuaE8h
	YH1eesddXFB3GFZpNMyE7Jnpo4wheqs6hP4goehk2aBDhXc2IAMpWTyPt1Tp6v9zhedVVlWX+XKB+
	bh5Y9pNPEgd5RC0KEjhT2PB/H964HWUvZmFhDCBF9lHmyXhU5XRymjdLRYR6ircUlAZ33Fwl6dNzq
	ZxdXNs9DK/iXNAjwEHvGDT9Jw7U8vrw6HgW3BnEuzD1bEx6bPuJ23mchVFK5KFtqVObW/MwT0l6Y4
	mrQPVk5CRkl0L7vwweDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJBu-00017r-8n; Wed, 09 Jan 2019 19:07:02 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJBp-00010U-4u
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 19:07:00 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 8F8ED80C5;
 Wed,  9 Jan 2019 19:06:59 +0000 (UTC)
Date: Wed, 9 Jan 2019 11:06:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
Subject: Regression in v4.20 with net phy soft reset changes
Message-ID: <20190109190650.GT5544@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_110657_863129_D50ACBCA 
X-CRM114-Status: UNSURE (   6.16  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>,
 Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org,
 Rex Chang <rchang@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
a regression where suspend resume cycle fails to bring up Ethernet on at
least cpsw on am437x-sk-evm.

Keerthy noticed this may not happen on the first resume, but usually
happens after few suspend resume cycles. The most working suspend resume
cycles I've seen with the commit above is three.

Any ideas what might be going wrong?

Note that unrelated to the commit above, there may be other issues too
as the cpsw phy LED seems to come on only after about five seconds with
about total of 10 seconds before the Ethernet is up again.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

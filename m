Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB65C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3E42082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iZ3vuYO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3E42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AQxBT3kM1BfDem08+xf2woaN1mJ6bcfyNQoTODLdIyw=; b=iZ3vuYO1g85Dyy
	TUF/lfa4Npz7nt7uZ0y6dmUNiLJO6LmbZ5EKZSjRuNmcLrrpah3YGEQx7Ea2pOpFw75a6RbM6bBNJ
	lhizarfDel+N5jmy4Goo9xbMwvFWAN6dlNFvx+T3Ea4qGvLjSZCATMbe0so44igOSTtQ/4dyvNJtd
	8Ubd3cYbvJIO1PKiegqIOgG+Sh0xNE4I70X8tZCLmqBVNhm9UUCEHy6d8DI9wvi9GFYVu4dH4+yHV
	PWnHNz/MSs3dAytPfhtaExhjDI0l4zWd2kPxuyGhas8l4B6y9Drh5yvT9xLThYHSKle2C4GkiryHu
	53DLtVs3SASjek2+gj+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU67U-0008WM-Ji; Tue, 04 Dec 2018 08:31:52 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU67Q-0008UT-Uh
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:31:50 +0000
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
 id 9BBED4BD010; Tue,  4 Dec 2018 09:31:34 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Peter Chen <Peter.Chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 0/3] usb: chipidea: imx: improve oc handling
Date: Tue,  4 Dec 2018 09:31:28 +0100
Message-Id: <20181204083131.12524-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_003149_154764_2F798124 
X-CRM114-Status: UNSURE (   4.24  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-usb@vger.kernel.org,
 kernel@pengutronix.de, Matthew Starr <mstarr@hedonline.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

compared to v2 (which starts with Message-Id:
<20181202213325.26017-1-u.kleine-koenig@pengutronix.de>) I adapted patch
1 that the oc polarity is only determined if oc isn't disabled. This
results in the warning that is introduced in patch 2 not to be emitted
in this case.

Best regards
Uwe



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

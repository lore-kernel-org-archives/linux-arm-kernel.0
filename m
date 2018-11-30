Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF0820863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RikTf83U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF0820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uFk8Iyx5rKLUHn7ug9Y0Tsp+6x63O4qgySozLcAFzOs=; b=RikTf83UK9+lCi
	aweWTD0mAMdfXYmG8sWj0pDfZpbvKmuORD7gSV7tIIm5Bm81bT+9AZYN3/lt/IOHVM4eJMaFbCv4m
	ravqCU5Jb3+gSjycuqU0Uk0KEMj44+ebv3Nqzx3ffS+QaRT/dXIUPvv3mM6l52nN43VuqxXakPSdL
	9+HAwPd3kVf58TQsOQOx/If29DvCvqCpIYtzP4EcWI3WQeh7mqvtahrEOrf/cJ47yHdHKfR/HXFqy
	V7tAiKwDmaQenajio29thTDtB+/Vq80tnS74mNY5aa3FK1IpnCFnADhVp7BJEXg8bpxx74FRe5cN9
	85+AxhWWbilG2LrLXA8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScao-0004JH-NM; Fri, 30 Nov 2018 06:48:02 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScad-0003zd-Nq
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 06:47:53 +0000
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
 id 41B3C4ADA04; Fri, 30 Nov 2018 07:47:37 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Fri, 30 Nov 2018 07:47:04 +0100
Message-Id: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_224751_955019_65E86B63 
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
Cc: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

compared to v2 sent with Message-Id:
20181123085158.24753-1-u.kleine-koenig@pengutronix.de I squashed in the
change suggested by Robin (with s/filed/field/). Thanks for testing and
feedback.

Best regards
Uwe



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

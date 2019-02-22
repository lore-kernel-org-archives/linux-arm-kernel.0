Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A17C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:54:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E292075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kFYFrDht";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWjxNM9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E292075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yhe/2VtKvoLgx4tYHRL1H+APndQkDGfuDflyH7blxBw=; b=kFYFrDht++ohAg
	ux5orxA7rcCFnKTBVl6jz1IpCvZLv0Xi7+d18sgm30mSHmQ6WZldBUY87M1G5jCI5sTVIaLIQ1urF
	jP6pCwqcaO33Y3dN/XGQ5dC51jrJD/oplQL8qpPcTy3sONrsXM0FtqMe2tKYMUzEX0mi4016c3kXG
	3ZGsBofhgeM2pvJCEdPEd8jcBx3BYDXRxgUmdmaChr6ijpbtp0orwohsVpHSz17yJHUcrX1eCMBwF
	UBY7ssfnLMSfoPwVCLAvHkfIKva29dnm0/L2+4julEKSB3YgXMQAynvZZ5b9bSJiQLX+ZpilVRyli
	CiwURGhyC8tg8XB5t81A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxF1X-0002nz-JC; Fri, 22 Feb 2019 17:54:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxF1U-0002na-9W
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:54:09 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB14920700;
 Fri, 22 Feb 2019 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550858048;
 bh=UETKZU8Od6YXLiyfanKphhODfBQf+J+IJ/20YAB9bHo=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=SWjxNM9qVy4WeOI9CkcysZGuTPDSe4mb9Cklpx2qQ56ZssTtrGAr6g+y7DNhrYTxi
 z6Ous4I8CUqA66pllr26hwsN9jgbDB1A0YNFJx8+RbbFzE0BPPcdlUobGcoHyGGzHd
 sK25DB8x3kNCD8WQOhvHbAogqJCdKh7EAHRGcV78=
MIME-Version: 1.0
Subject: Re: [PATCH v3] clk: at91: optimize clk_round_rate() for AUDIO_PLL
Message-ID: <155085804711.77512.8497109759438222310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <70db24a03b552ca553e6435306d895644fb08545.1545131728.git.mirq-linux@rere.qmqm.pl>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <70db24a03b552ca553e6435306d895644fb08545.1545131728.git.mirq-linux@rere.qmqm.pl>
To: Michał Mirosław <mirq-linux@rere.qmqm.pl>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date: Fri, 22 Feb 2019 09:54:07 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_095408_347911_E406914A 
X-CRM114-Status: UNSURE (   6.53  )
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
Cc: Michael Turquette <mturquette@baylibre.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBNaWNoYcWCIE1pcm9zxYJhdyAoMjAxOC0xMi0xOCAwMzoyMDo0OCkKPiBTdG9wIHRo
ZSBzZWFyY2ggZm9yIHBhcmVudCByYXRlIHdoZW4gZXhhY3QgbWF0Y2ggaXMgZm91bmQuCj4gCj4g
VGhpcyBtYWtlcyBmb3IgMyBjbGtfcm91bmRfcmF0ZSgpIGNhbGxzIGluc3RlYWQgb2YgNjQgb2Yg
dGhlbSBvbgo+IFNBTUE1RDItYmFzZWQgYm9hcmQgd2hlbiBzZWFyY2hpbmcgZm9yIDEyLjI4OE1I
eiBjbG9jay4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9zxYJhdyA8bWlycS1saW51
eEByZXJlLnFtcW0ucGw+Cj4gLS0tCgpBcHBsaWVkIHRvIGNsay1uZXh0CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

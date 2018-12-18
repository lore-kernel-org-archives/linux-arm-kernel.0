Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521262184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GTVl4yXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521262184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3E59ZHarHSs5P6y9eioKq4OpwArbikIh5kdr9DRoSjc=; b=GTVl4yXmecgY3i
	I8j1OJf1cXStkVLdlenrffv3VpFfCTPPDf3GdN9LzxLmS1QIu8flbor4zHftvX4krDL/3aZw4zIgJ
	8YF5ExqsXUvfrOI3sca4QSlRfN0IZR3hoV6WDR332HsNpZ0uYzl/L/jLmpaHmtmgPDJ12mxZH2u3d
	es62IkwKewE6VDIxFCjw1G+7lZX+TqXSueFr0HisEkRpfzexvEeLJcjeX0Wkrwa5js1qmDf0b6/V6
	VeiMZy1tbeRaSQi7nP9dZTZeEAsSjOjjBCGL6qwvi5bS2Ngj0hd9q9uNuyEC8haFjE66SB2llkOOf
	uKc8Y2esPXtrLUU0EVuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDOW-00013m-HL; Tue, 18 Dec 2018 11:18:36 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDOS-00011i-Du
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:18:33 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gZDOC-0007Pt-UH; Tue, 18 Dec 2018 12:18:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gZDOB-0007xB-Um; Tue, 18 Dec 2018 12:18:15 +0100
Date: Tue, 18 Dec 2018 12:18:15 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: optimize clk_round_rate() for AUDIO_PLL
Message-ID: <20181218111815.7nkil4pfoqz2wh7z@pengutronix.de>
References: <772b3869cc992d894d8c1b4296f21100bcbed30d.1545075103.git.mirq-linux@rere.qmqm.pl>
 <154508897026.19322.14961293619238289668@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154508897026.19322.14961293619238289668@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_031832_623310_49FD3675 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Ludovic Desroches <ludovic.desroches@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpPbiBNb24sIERlYyAxNywgMjAxOCBhdCAwMzoyMjo1MFBNIC0wODAwLCBTdGVwaGVu
IEJveWQgd3JvdGU6Cj4gUXVvdGluZyBNaWNoYcWCIE1pcm9zxYJhdyAoMjAxOC0xMi0xNyAxMToz
NzowNSkKPiA+IFRoaXMgbWFrZXMgZm9yIDMgY2xrX3JvdW5kX3JhdGUoKSBjYWxscyBpbnN0ZWFk
IG9mIDY0IG9mIHRoZW0gb24KPiA+IFNBTUE1RDItYmFzZWQgYm9hcmQgd2hlbiBzZWFyY2hpbmcg
Zm9yIDEyLjI4OE1IeiBjbG9jay4KPiAKPiBPaywgYnV0IGlzIHRoYXQgYmV0dGVyPyBXb3JzZT8g
Q2FuIHlvdSBtb3JlIGNsZWFybHkgZGVzY3JpYmUgd2hhdCB5b3UncmUKPiBkb2luZyBoZXJlPyBB
bmQgaXQncyBub3QgYnJlYWtpbmcgc29tZSBvdGhlciBjb3JuZXIgY2FzZT8KCkkgdGhpbmsgdGhl
cmUgaXNuJ3QgZXZlbiBhIHBvbGljeSBob3cgY2xrX3JvdW5kX3JhdGUoKSBhY3R1YWxseSBiZWhh
dmVzLAppcyB0aGVyZT8gSWYgeW91IGNvdWxkIHJlbHkgb24gaXQgdG8gKHNheSkgYWx3YXlzIHJv
dW5kIGRvd24gY2FzZXMgbGlrZQp0aGVzZSBjb3VsZCBtYXliZSBiZSBoYW5kbGVkIGVhc2llcj8g
KEJ1dCBJIGRpZG4ndCByZWFsbHkgbG9vayBhdCB0aGUKcGF0Y2gsIHNvIHRoaXMgbWlnaHQgbm90
IGJlIG9uZSBvZiB0aGVzZSBjYXNlcy4pCgpCZXN0IHJlZ2FyZHMKVXdlCgotLSAKUGVuZ3V0cm9u
aXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEtsZWluZS1Lw7ZuaWcgICAg
ICAgICAgICB8CkluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8IGh0
dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUvICB8CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

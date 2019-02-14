Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E427C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:51:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2044D222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WFWhp4kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2044D222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k2EXqAgLUNkZQqrIIu6MfNh1BenNF578Bacc2F9WnTg=; b=WFWhp4kKJgSfhC
	D3DkLtzYKgi0rCSt91eIf2RURPYNq/w/A8Awf+uO2vwa/ux6vGwklqtyQaTpd8GAvPCGxJOLYjJNI
	BVeSTLd/+rzQK+rGPeQTf4voCvaDmBv+OsTaeJO0b9nqQFaK9ioEYznC5OhfHzxnICk4eigUAZM6Z
	4L/m+LRxKjLSYsD6HC9lbXw2+bwKCgwmFfrm6SVCIoZN7hUMaez8h1wPKovtgpZDHLh/0/+v1keVI
	UGS6GwJdGYaPRwO/oarhYIx6aMUQXpSAkOUcWXBCgYrkWC0lZ7rl4yXBU4q7UM8Xd+/mMTMOvj9BP
	U9cbxbjjYAndAdFiFtyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJIg-0004RF-7a; Thu, 14 Feb 2019 15:51:46 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJIb-0004QC-P5
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:51:43 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guJIP-0004OL-Et; Thu, 14 Feb 2019 16:51:29 +0100
Message-ID: <1550159489.2546.41.camel@pengutronix.de>
Subject: Re: [RFC 1/5] clk: imx: imx8mq: Fix the rate propagation for arm pll
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike
 Turquette <mturquette@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Angus Ainslie
 <angus.ainslie@puri.sm>, Anson Huang <anson.huang@nxp.com>
Date: Thu, 14 Feb 2019 16:51:29 +0100
In-Reply-To: <1550084693-9797-2-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075141_968041_08F102F2 
X-CRM114-Status: GOOD (  14.52  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAxMy4wMi4yMDE5LCAxOTowNSArMDAwMCBzY2hyaWViIEFiZWwgVmVz
YToKPiBUaGUgYXJtIHBsbCBieXBhc3MgbmVlZHMgdG8gcHJvcGFnYXRlIHRoZSByYXRlIHVwd2Fy
ZHMKPiBpbiBvcmRlciBmb3IgdGhlIGNwdWZyZXEgdG8gd29yay4KPiAKPiBGaXhlczogYjgwNTIy
MDQwY2QzZiAoImNsazogaW14OiBBZGQgY2xvY2sgZHJpdmVyIGZvciBpLk1YOE1RIENDTSIpCj4g
U2lnbmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4KClJldmlld2VkLWJ5
OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4gwqBkcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhtcS5jIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1xLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jCj4gaW5kZXggMzk4YWIw
Yi4uNTc0OTllZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jCj4g
KysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYwo+IEBAIC0zNDAsNyArMzQwLDcgQEAg
c3RhdGljIGludCBpbXg4bXFfY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCj4gwqAJY2xrc1tJTVg4TVFfRFJBTV9QTEwyX0RJVl0gPSBpbXhfY2xrX2RpdmlkZXIoImRy
YW1fcGxsMl9kaXYiLCAiZHJhbV9wbGwyIiwgYmFzZSArIDB4NjgsIDEsIDYpOwo+IMKgCj4gwqAJ
LyogUExMIGJ5cGFzcyBvdXQgKi8KPiAtCWNsa3NbSU1YOE1RX0FSTV9QTExfQllQQVNTXSA9IGlt
eF9jbGtfbXV4KCJhcm1fcGxsX2J5cGFzcyIsIGJhc2UgKyAweDI4LCAxNCwgMSwgYXJtX3BsbF9i
eXBhc3Nfc2VscywgQVJSQVlfU0laRShhcm1fcGxsX2J5cGFzc19zZWxzKSk7Cj4gKwljbGtzW0lN
WDhNUV9BUk1fUExMX0JZUEFTU10gPSBpbXhfY2xrX211eF9mbGFncygiYXJtX3BsbF9ieXBhc3Mi
LCBiYXNlICsgMHgyOCwgMTQsIDEsIGFybV9wbGxfYnlwYXNzX3NlbHMsIEFSUkFZX1NJWkUoYXJt
X3BsbF9ieXBhc3Nfc2VscyksIENMS19TRVRfUkFURV9QQVJFTlQpOwo+IMKgCWNsa3NbSU1YOE1R
X0dQVV9QTExfQllQQVNTXSA9IGlteF9jbGtfbXV4KCJncHVfcGxsX2J5cGFzcyIsIGJhc2UgKyAw
eDE4LCAxNCwgMSwgZ3B1X3BsbF9ieXBhc3Nfc2VscywgQVJSQVlfU0laRShncHVfcGxsX2J5cGFz
c19zZWxzKSk7Cj4gwqAJY2xrc1tJTVg4TVFfVlBVX1BMTF9CWVBBU1NdID0gaW14X2Nsa19tdXgo
InZwdV9wbGxfYnlwYXNzIiwgYmFzZSArIDB4MjAsIDE0LCAxLCB2cHVfcGxsX2J5cGFzc19zZWxz
LCBBUlJBWV9TSVpFKHZwdV9wbGxfYnlwYXNzX3NlbHMpKTsKPiDCoAljbGtzW0lNWDhNUV9BVURJ
T19QTEwxX0JZUEFTU10gPSBpbXhfY2xrX211eCgiYXVkaW9fcGxsMV9ieXBhc3MiLCBiYXNlICsg
MHgwLCAxNCwgMSwgYXVkaW9fcGxsMV9ieXBhc3Nfc2VscywgQVJSQVlfU0laRShhdWRpb19wbGwx
X2J5cGFzc19zZWxzKSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==

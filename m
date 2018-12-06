Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E47C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:11:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4605D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ktoPq/tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4605D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HtIkwQZB0rLCMe2M4pAlUqNc10dpZd356/+BqkvCnVQ=; b=ktoPq/tO5RZIxC
	gdhtANImIqzJQ/xAr6xmLPb3KiSM4gC/z9RyTbX4o3AWcfv99bj5yBq7BEjlN3Z5AgB+m+DqqnOim
	KZ22qIm9kyHutoBqjk5e3avMPYCUzMKlUCouzWdZCH+Dd/MasU2oYDZ1d8pAjez4m6nSY8hGfr/2c
	SdXYXDLKDM7NBF7R09HWBGYxjZgucmIQadsits+mHCphjf8Q96oNB0UVhtqy2amuXOL9LiUNIHgWQ
	kJbM6MULOV129XL8Pg1AmsdgsD4pm/d3wSauBMonVvaJvjHDXCctXV9WDJBe8o0RdDfNOR5P5fHiy
	1z77c9W6SOKInjTDgxEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrZQ-0004jr-AR; Thu, 06 Dec 2018 11:11:52 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrZN-0004i8-0Q
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:11:50 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUrZ3-0003Zt-Um; Thu, 06 Dec 2018 12:11:29 +0100
Message-ID: <1544094689.3709.59.camel@pengutronix.de>
Subject: Re: [PATCH 2/5] irqchip/irq-imx-gpcv2: Share reg offset calculation
 code
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Marc Zyngier
 <marc.zyngier@arm.com>
Date: Thu, 06 Dec 2018 12:11:29 +0100
In-Reply-To: <20181206073125.7255-3-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
 <20181206073125.7255-3-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_031149_207183_FD8F0A3B 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozMSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IE1vdmUgaWRlbnRpY2FsIG9mZnNldCBjYWxjdWxhdGlvbiBjb2RlIGludG8gYSBz
bWFsbCBoZWxwZXIgZnVuY3Rpb24KPiBhbmQgbWFrZSB1c2Ugb2YgaXQgaW4gdGhlIHJlc3Qgb2Yg
dGhlIGNvZGUuCj4gCj4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
Cj4gPiBDYzogSmFzb24gQ29vcGVyIDxqYXNvbkBsYWtlZGFlbW9uLm5ldD4KPiA+IENjOiBNYXJj
IFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPgo+IENjOiBjcGhlYWx5QGdtYWlsLmNvbQo+
IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlCj4gPiBDYzogTGVvbmFyZCBDcmVzdGV6IDxsZW9u
YXJkLmNyZXN0ZXpAbnhwLmNvbT4KPiA+IENjOiAiQS5zLiBEb25nIiA8YWlzaGVuZy5kb25nQG54
cC5jb20+Cj4gPiBDYzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPgo+IENjOiBs
aW51eC1pbXhAbnhwLmNvbQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEFu
ZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+CgpOaWNlIGNsZWFudXAhCgpS
ZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cgo+IC0tLQo+
IMKgZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYyB8IDE4ICsrKysrKysrKystLS0tLS0t
LQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMgYi9kcml2ZXJz
L2lycWNoaXAvaXJxLWlteC1ncGN2Mi5jCj4gaW5kZXggY2JlZDAwMzE5MzE1Li5iMjYyYmE4YjI2
NTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYwo+ICsrKyBi
L2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMKPiBAQCAtMjgsNiArMjgsMTEgQEAgc3Ry
dWN0IGdwY3YyX2lycWNoaXBfZGF0YSB7Cj4gwqAKPiDCoHN0YXRpYyBzdHJ1Y3QgZ3BjdjJfaXJx
Y2hpcF9kYXRhICppbXhfZ3BjdjJfaW5zdGFuY2U7Cj4gwqAKPiArc3RhdGljIHZvaWQgX19pb21l
bSAqZ3BjdjJfaWR4X3RvX3JlZyhzdHJ1Y3QgZ3BjdjJfaXJxY2hpcF9kYXRhICpjZCwgaW50IGkp
Cj4gK3sKPiA+ICsJcmV0dXJuIGNkLT5ncGNfYmFzZSArIGNkLT5jcHUyd2FrZXVwICsgaSAqIDQ7
Cj4gK30KPiArCj4gwqBzdGF0aWMgaW50IGdwY3YyX3dha2V1cF9zb3VyY2Vfc2F2ZSh2b2lkKQo+
IMKgewo+ID4gwqAJc3RydWN0IGdwY3YyX2lycWNoaXBfZGF0YSAqY2Q7Cj4gQEAgLTM5LDcgKzQ0
LDcgQEAgc3RhdGljIGludCBncGN2Ml93YWtldXBfc291cmNlX3NhdmUodm9pZCkKPiA+IMKgCQly
ZXR1cm4gMDsKPiDCoAo+ID4gwqAJZm9yIChpID0gMDsgaSA8IElNUl9OVU07IGkrKykgewo+ID4g
LQkJcmVnID0gY2QtPmdwY19iYXNlICsgY2QtPmNwdTJ3YWtldXAgKyBpICogNDsKPiA+ICsJCXJl
ZyA9IGdwY3YyX2lkeF90b19yZWcoY2QsIGkpOwo+ID4gwqAJCWNkLT5zYXZlZF9pcnFfbWFza1tp
XSA9IHJlYWRsX3JlbGF4ZWQocmVnKTsKPiA+IMKgCQl3cml0ZWxfcmVsYXhlZChjZC0+d2FrZXVw
X3NvdXJjZXNbaV0sIHJlZyk7Cj4gPiDCoAl9Cj4gQEAgLTUwLDE3ICs1NSwxNCBAQCBzdGF0aWMg
aW50IGdwY3YyX3dha2V1cF9zb3VyY2Vfc2F2ZSh2b2lkKQo+IMKgc3RhdGljIHZvaWQgZ3BjdjJf
d2FrZXVwX3NvdXJjZV9yZXN0b3JlKHZvaWQpCj4gwqB7Cj4gPiDCoAlzdHJ1Y3QgZ3BjdjJfaXJx
Y2hpcF9kYXRhICpjZDsKPiA+IC0Jdm9pZCBfX2lvbWVtICpyZWc7Cj4gPiDCoAlpbnQgaTsKPiDC
oAo+ID4gwqAJY2QgPSBpbXhfZ3BjdjJfaW5zdGFuY2U7Cj4gPiDCoAlpZiAoIWNkKQo+ID4gwqAJ
CXJldHVybjsKPiDCoAo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgSU1SX05VTTsgaSsrKSB7Cj4gPiAt
CQlyZWcgPSBjZC0+Z3BjX2Jhc2UgKyBjZC0+Y3B1Mndha2V1cCArIGkgKiA0Owo+ID4gLQkJd3Jp
dGVsX3JlbGF4ZWQoY2QtPnNhdmVkX2lycV9tYXNrW2ldLCByZWcpOwo+ID4gLQl9Cj4gPiArCWZv
ciAoaSA9IDA7IGkgPCBJTVJfTlVNOyBpKyspCj4gPiArCQl3cml0ZWxfcmVsYXhlZChjZC0+c2F2
ZWRfaXJxX21hc2tbaV0sIGdwY3YyX2lkeF90b19yZWcoY2QsIGkpKTsKPiDCoH0KPiDCoAo+IMKg
c3RhdGljIHN0cnVjdCBzeXNjb3JlX29wcyBpbXhfZ3BjdjJfc3lzY29yZV9vcHMgPSB7Cj4gQEAg
LTk3LDcgKzk5LDcgQEAgc3RhdGljIHZvaWQgaW14X2dwY3YyX2lycV91bm1hc2soc3RydWN0IGly
cV9kYXRhICpkKQo+ID4gwqAJdTMyIHZhbDsKPiDCoAo+ID4gwqAJcmF3X3NwaW5fbG9jaygmY2Qt
PnJsb2NrKTsKPiA+IC0JcmVnID0gY2QtPmdwY19iYXNlICsgY2QtPmNwdTJ3YWtldXAgKyBkLT5o
d2lycSAvIDMyICogNDsKPiA+ICsJcmVnID0gZ3BjdjJfaWR4X3RvX3JlZyhjZCwgZC0+aHdpcnEg
LyAzMik7Cj4gPiDCoAl2YWwgPSByZWFkbF9yZWxheGVkKHJlZyk7Cj4gPiDCoAl2YWwgJj0gfigx
IDw8IGQtPmh3aXJxICUgMzIpOwo+ID4gwqAJd3JpdGVsX3JlbGF4ZWQodmFsLCByZWcpOwo+IEBA
IC0xMTMsNyArMTE1LDcgQEAgc3RhdGljIHZvaWQgaW14X2dwY3YyX2lycV9tYXNrKHN0cnVjdCBp
cnFfZGF0YSAqZCkKPiA+IMKgCXUzMiB2YWw7Cj4gwqAKPiA+IMKgCXJhd19zcGluX2xvY2soJmNk
LT5ybG9jayk7Cj4gPiAtCXJlZyA9IGNkLT5ncGNfYmFzZSArIGNkLT5jcHUyd2FrZXVwICsgZC0+
aHdpcnEgLyAzMiAqIDQ7Cj4gPiArCXJlZyA9IGdwY3YyX2lkeF90b19yZWcoY2QsIGQtPmh3aXJx
IC8gMzIpOwo+ID4gwqAJdmFsID0gcmVhZGxfcmVsYXhlZChyZWcpOwo+ID4gwqAJdmFsIHw9IDEg
PDwgKGQtPmh3aXJxICUgMzIpOwo+ID4gwqAJd3JpdGVsX3JlbGF4ZWQodmFsLCByZWcpOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=

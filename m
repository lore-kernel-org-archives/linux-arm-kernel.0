Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A354C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:19:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B15C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bDQJnXSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B15C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cSK47XMsd7BstWV1twuDRHX4WcxbmeapqntCNBoBf2I=; b=bDQJnXSkUp1ehd
	gGnB1dWtFpB70PvS5za8IkJonv2jzgJyAnW1Lr19QOjTZx5WSUl3n3BaKyFHUs9CnGu/ijQv8c6yw
	/cQz9TQLnh4GTOFYNerg66OhcylPss4WBVBiyBh11kuNfz/5FHTVR/kUQ/BocsS7K4Vy5Msb4Qwsw
	xvXeh1Zp9+7KwAEdQkr/88YwKBrYCT+E5UBMIVowtfNbiEYEUJXGrTUdAm5ZPvI+8bnO+Aqr1RESL
	4F7XzWB0bquVqOhSQz+5b3thzciHAiV09VgaBW+EezWcGqRXri6JS5ZuCBsEbE6HbwYa2gWsSE2J4
	6fl1fRNuYyO4ARcghb/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwYY-0001M9-JK; Mon, 03 Dec 2018 22:19:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwYV-0001Ks-0D
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:19:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C9D6620791; Mon,  3 Dec 2018 23:18:55 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id BDCEC207AD;
 Mon,  3 Dec 2018 23:18:44 +0100 (CET)
Date: Mon, 3 Dec 2018 23:18:44 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181203231844.0791bdee@xps13>
In-Reply-To: <1999610.6DN9RK2Tt3@aspire.rjw.lan>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
 <20181203163846.494904f9@xps13> <1999610.6DN9RK2Tt3@aspire.rjw.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_141907_316246_D4482371 
X-CRM114-Status: GOOD (  23.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUmFmYWVsLCBTdGVwaGVuLAoKIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3QHJqd3lzb2NraS5u
ZXQ+IHdyb3RlIG9uIE1vbiwgMDMgRGVjIDIwMTgKMjM6MDA6MjAgKzAxMDA6Cgo+IE9uIE1vbmRh
eSwgRGVjZW1iZXIgMywgMjAxOCA0OjM4OjQ2IFBNIENFVCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+
ID4gSGkgTG9yZW56bywKPiA+IAo+ID4gTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb20+IHdyb3RlIG9uIE1vbiwgMyBEZWMgMjAxOAo+ID4gMTA6Mjc6MDggKzAwMDA6
Cj4gPiAgIAo+ID4gPiBbK1JhZmFlbCwgU3VkZWVwXQo+ID4gPiAKPiA+ID4gT24gRnJpLCBOb3Yg
MjMsIDIwMTggYXQgMDM6MTg6MjRQTSArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90ZTogIAo+ID4g
PiA+IEFkZCBzdXNwZW5kIGFuZCByZXN1bWUgY2FsbGJhY2tzLiBUaGUgcHJpb3JpdHkgb2YgdGhl
c2UgYXJlCj4gPiA+ID4gIl9ub2lycSgpIiwgdG8gd29ya2Fyb3VuZCBlYXJseSBhY2Nlc3MgdG8g
dGhlIHJlZ2lzdGVycyBkb25lIGJ5IHRoZQo+ID4gPiA+IFBDSSBjb3JlIHRocm91Z2ggdGhlIC0+
cmVhZCgpLy0+d3JpdGUoKSBjYWxsYmFja3MgYXQgcmVzdW1lIHRpbWUuCj4gPiA+ID4gCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNv
bT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktYWFyZHZh
cmsuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNTIgaW5zZXJ0aW9ucygrKQo+ID4gPiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1hYXJkdmFyay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2ktYWFyZHZhcmsuYwo+ID4gPiA+IGluZGV4IDEwOGIzZjE1YzQxMC4uN2VjZjFhYzQwMzZi
IDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWFhcmR2YXJr
LmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1hYXJkdmFyay5jCj4g
PiA+ID4gQEAgLTExMDgsNiArMTEwOCw1NSBAQCBzdGF0aWMgaW50IGFkdmtfcGNpZV9zZXR1cF9j
bGsoc3RydWN0IGFkdmtfcGNpZSAqcGNpZSkKPiA+ID4gPiAgCXJldHVybiByZXQ7Cj4gPiA+ID4g
IH0KPiA+ID4gPiAgCj4gPiA+ID4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgYWR2a19wY2ll
X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQo+ID4gPiA+ICt7Cj4gPiA+ID4gKwlzdHJ1Y3Qg
YWR2a19wY2llICpwY2llID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4gPiA+ID4gKwo+ID4gPiA+
ICsJYWR2a19wY2llX2Rpc2FibGVfcGh5KHBjaWUpOwo+ID4gPiA+ICsKPiA+ID4gPiArCWNsa19k
aXNhYmxlX3VucHJlcGFyZShwY2llLT5jbGspOyAgICAKPiA+ID4gCj4gPiA+IEkgaGF2ZSBub3Rp
Y2VkIGl0IGlzIGNvbW1vbiBwcmFjdGljZSwgc3RpbGwsIEkgd291bGQgbGlrZSB0byBjaGVjayB3
aGV0aGVyCj4gPiA+IGl0IGlzIGFsbG93ZWQgdG8gY2FsbCBmdW5jdGlvbnMgdGhhdCBtYXkgc2xl
ZXAgaW4gYSBOT0lSUSBzdXNwZW5kL3Jlc3VtZQo+ID4gPiBjYWxsYmFjayA/ICAKPiA+IAo+ID4g
WW91IGFyZSByaWdodCB0aGlzIGlzIHdlaXJkLiBJIGRvdWJsZSBjaGVja2VkIGFuZCBmb3IgaW5z
dGFuY2UsCj4gPiBwY2llLW1lZGlhdGVrLmMsIHBjaS10ZWdyYS5jIGFuZCBwY2ktaW14Ni5jIGRv
IHRoZSBleGFjdCBzYW1lIHRoaW5nLiBUaGVyZSBhcmUKPiA+IHByb2JhYmx5IG90aGVyIGNhc2Vz
IHdoZXJlIGRyaXZlcnMgY2FsbCBmdW5jdGlvbnMgdGhhdCBtYXkgc2xlZXAgZnJvbSBhIE5PSVJR
Cj4gPiBjb250ZXh0LiBJIGFtIGludGVyZXN0ZWQgdG8ga25vdyBpZiB0aGlzIGlzIHZhbGlkIGFu
ZCBpZiBub3QsIHdoYXQgaXMgdGhlCj4gPiBhbHRlcm5hdGl2ZT8KPiA+ICAgCj4gCj4gWWVzLCBp
dCBpcyB2YWxpZC4gIF9ub2lycSBtZWFucyB0aGF0IHRoZSBoaWdoLWxldmVsIGFjdGlvbiBoYW5k
bGVycyB3aWxsIG5vdCBiZQo+IGludm9rZWQgZm9yIGludGVycnVwdHMgb2NjdXJyaW5nIGR1cmlu
ZyB0aGF0IHBlcmlvZCwgYnV0IHRoYXQgZG9lc24ndCBhcHBseSB0bwo+IHRpbWVyIGludGVycnVw
dHMuCj4gCj4gSU9XLCBkb24ndCBleHBlY3QgKnlvdXIqIElSUSBoYW5kbGVyIHRvIGJlIGludm9r
ZWQgdGhlbiAoaWYgdGhpcyBpcyBub3QgYSB0aW1lcgo+IElSUSksIGJ1dCB5b3UgY2FuIHNsZWVw
Lgo+IAo+IFRoYW5rcywKPiBSYWZhZWwKPiAKClRoYW5rIHlvdSBib3RoIGZvciB0aGUgZW5saWdo
dGVubWVudC4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

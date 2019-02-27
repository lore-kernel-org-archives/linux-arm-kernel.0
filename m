Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B339C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497212133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qHpvjJBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497212133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dR9AW8dQ+7XsBCrMxmjKOcydnjnpyb3O/niUATWtGjI=; b=qHpvjJBYHGn/36
	eSNMaoARfQykiXbABS6T1CyrA/RF1pfpXe79o6L8cYydVyYuooDPHn5xG3wgccHiiq5xh5cGM6rSk
	AJShCQQvxP8RlDURs+3CEV7D1DoDB1+FUpVNONwkqDD9SYUrcLcKwXVq8imMxNhfWJk3Fs9NlEwXY
	ofHn6SmsC4qkMsOBIJq923DhXNaDMHpZnJO1j/TRyehxkXxYfi2S5XG6uKEt5YaC+kDK0apGz680W
	EBA8AVMDiQ7MZu/wbarKxPx0bn4lXlUJ+AqCA8sncpsOARMOWyUmdzYXD6qdgiiJ7KR09B0mdTP4T
	rUmb7HKRotJBW0xBj9ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyvUR-0007l8-5X; Wed, 27 Feb 2019 09:26:59 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvUM-0007kC-Ua; Wed, 27 Feb 2019 09:26:56 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id F1EEB6000F;
 Wed, 27 Feb 2019 09:26:42 +0000 (UTC)
Date: Wed, 27 Feb 2019 10:26:42 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190227102642.4a1c8224@xps13>
In-Reply-To: <20190221121625.33a7f6c0@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
 <20190221121625.33a7f6c0@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_012655_286828_CAE3720E 
X-CRM114-Status: GOOD (  20.92  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gVGh1LCAyMSBGZWIgMjAxOQoxMjoxNjoyNSArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMTowMTo1MiArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+IAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbXRkL25hbmQu
aCBiL2luY2x1ZGUvbGludXgvbXRkL25hbmQuaAo+ID4gaW5kZXggMzBmMGZiMDJhYmUyLi45ZTNi
MDE4ZDBiODMgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L210ZC9uYW5kLmgKPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvbXRkL25hbmQuaAo+ID4gQEAgLTgyLDggKzgyLDE0IEBAIHN0cnVj
dCBuYW5kX3BvcyB7Cj4gPiAgCXVuc2lnbmVkIGludCBwYWdlOwo+ID4gIH07Cj4gPiAgCj4gPiAr
ZW51bSBuYW5kX3BhZ2VfaW9fcmVxX3R5cGUgewo+ID4gKwlOQU5EX1BBR0VfUkVBRCA9IDAsCj4g
PiArCU5BTkRfUEFHRV9XUklURSwKPiA+ICt9Owo+ID4gKwo+ID4gIC8qKgo+ID4gICAqIHN0cnVj
dCBuYW5kX3BhZ2VfaW9fcmVxIC0gTkFORCBJL08gcmVxdWVzdCBvYmplY3QKPiA+ICsgKiBAdHlw
ZTogdGhlIHR5cGUgb2YgcGFnZSBJL086IHJlYWQgb3Igd3JpdGUKPiA+ICAgKiBAcG9zOiB0aGUg
cG9zaXRpb24gdGhpcyBJL08gcmVxdWVzdCBpcyB0YXJnZXRpbmcKPiA+ICAgKiBAZGF0YW9mZnM6
IHRoZSBvZmZzZXQgd2l0aGluIHRoZSBwYWdlCj4gPiAgICogQGRhdGFsZW46IG51bWJlciBvZiBk
YXRhIGJ5dGVzIHRvIHJlYWQgZnJvbS93cml0ZSB0byB0aGlzIHBhZ2UKPiA+IEBAIC05OSw2ICsx
MDUsNyBAQCBzdHJ1Y3QgbmFuZF9wb3Mgewo+ID4gICAqIHNwZWNpZmljIGNvbW1hbmRzL29wZXJh
dGlvbnMuCj4gPiAgICovCj4gPiAgc3RydWN0IG5hbmRfcGFnZV9pb19yZXEgewo+ID4gKwllbnVt
IG5hbmRfcGFnZV9pb19yZXFfdHlwZSB0eXBlOyAgCj4gCj4gQ2FuIHlvdSBhZGQgdGhlIHJlcXR5
cGUgZW51bSBhbmQgdHlwZSBmaWVsZCAoKyBwYXRjaCB0aGUgaXRlcmF0b3IKPiBoZWxwZXJzKSBp
biBhIHNlcGFyYXRlIHBhdGNoPwoKU3VyZS4KCj4gCj4gPiAgCXN0cnVjdCBuYW5kX3BvcyBwb3M7
Cj4gPiAgCXVuc2lnbmVkIGludCBkYXRhb2ZmczsKPiA+ICAJdW5zaWduZWQgaW50IGRhdGFsZW47
Cj4gPiBAQCAtMTE2LDEzICsxMjMsMzUgQEAgc3RydWN0IG5hbmRfcGFnZV9pb19yZXEgewo+ID4g
IH07Cj4gPiAgCj4gPiAgLyoqCj4gPiAtICogc3RydWN0IG5hbmRfZWNjX3JlcSAtIE5BTkQgRUND
IHJlcXVpcmVtZW50cwo+ID4gKyAqIHN0cnVjdCBuYW5kX2VjY19jb25mIC0gTkFORCBFQ0MgY29u
ZmlndXJhdGlvbgo+ID4gKyAqIEBzdHJlbmd0aDogRUNDIHN0cmVuZ3RoCj4gPiArICogQHN0ZXBf
c2l6ZTogTnVtYmVyIG9mIGJ5dGVzIHBlciBzdGVwCj4gPiArICogQHRvdGFsOiBUb3RhbCBudW1i
ZXIgb2YgYnl0ZXMgdXNlZCBmb3Igc3RvcmluZyBFQ0MgY29kZXMsIHRoaXMgaXMgdXNlZCBieQo+
ID4gKyAqICAgICAgICAgZ2VuZXJpYyBPT0IgbGF5b3V0cwo+ID4gKyAqLwo+ID4gK3N0cnVjdCBu
YW5kX2VjY19jb25mIHsgIAo+IAo+IFBsZWFzZSBkbyB0aGUgcy9uYW5kX2VjY19yZXEvbmFuZF9l
Y2NfY29uZi8gaW4gYSBzZXBhcmF0ZSBwYXRjaC4KCk9rLgoKPiAKPiA+ICsJdW5zaWduZWQgaW50
IHN0cmVuZ3RoOwo+ID4gKwl1bnNpZ25lZCBpbnQgc3RlcF9zaXplOwo+ID4gKwl1bnNpZ25lZCBp
bnQgdG90YWw7ICAKPiAKPiBEbyB3ZSByZWFsbHkgbmVlZCB0byBhZGQgdGhpcyB0b3RhbCBmaWVs
ZCBoZXJlPyBMb29rcyBsaWtlIHNvbWV0aGluZwo+IHRoYXQgc2hvdWxkIGJlIGtlcHQgcHJpdmF0
ZSB0byB0aGUgRUNDIGVuZ2luZSBpbXBsZW1lbnRhdGlvbi4KCkl0IHdhcyBpbml0aWFsbHkgcHJp
dmF0ZSwgYnV0IEkgcmVhbGl6ZWQgaXQgd2FzIG5lZWRlZCBieSBnZW5lcmljIHBhcnRzCihpbmNs
dWRpbmcgZm9yIGluc3RhbmNlIHRoZSBnZW5lcmljIE9PQiBsYXlvdXRzKSBzbyBpdCBjb3VsZCBu
b3QgYmUKbWFkZSBwcml2YXRlLgoKSSBqdXN0IG1vdmVkIHRoZSAndG90YWwnIGVudHJ5IG91dCBv
ZiB0aGUgc3RydWN0IG5hbmRfZWNjX2NvbmYgYW5kCm1vdmVkIGl0IGluIHRoZSBzdHJ1Y3QgbmFu
ZF9lY2NfY3R4LiBJdCBpcyBzdGlsbCBwdWJsaWMgYnV0IG5vdCBpbiB0aGUKdmVyeSBnZW5lcmlj
ICJjb25mIiBzdHJ1Y3R1cmUgYW55bW9yZS4KCj4gCj4gPiArfTsKPiA+ICsKPiA+ICsvKioKPiA+
ICsgKiBzdHJ1Y3QgbmFuZF9lY2NfdXNlcl9jb25mIC0gVXNlciBkZXNpcmVkIEVDQyBjb25maWd1
cmF0aW9uCj4gPiArICogQG1vZGU6IEVDQyBtb2RlCj4gPiArICogQGFsZ286IEVDQyBhbGdvcml0
aG0KPiA+ICAgKiBAc3RyZW5ndGg6IEVDQyBzdHJlbmd0aAo+ID4gICAqIEBzdGVwX3NpemU6IEVD
QyBzdGVwL2Jsb2NrIHNpemUKPiA+ICsgKiBAbWF4aW1pemU6IEVDQyBwYXJhbWV0ZXJzIG11c3Qg
YmUgbWF4aW1pemVkIGRlcGVuZGluZyBvbiB0aGUgZGV2aWNlCj4gPiArICogICAgICAgICAgICBj
YXBhYmlsaXRpZXMKPiA+ICsgKiBAZmxhZ3M6IFVzZXIgZmxhZ3MKPiA+ICAgKi8KPiA+IC1zdHJ1
Y3QgbmFuZF9lY2NfcmVxIHsKPiA+ICtzdHJ1Y3QgbmFuZF9lY2NfdXNlcl9jb25mIHsKPiA+ICsJ
aW50IG1vZGU7ICAKPiAKPiBXZSBzaG91bGQgZGVmaW5pdGVseSBuYW1lIHRoYXQgb25lIGRpZmZl
cmVudGx5ICgncHJvdmlkZXInIG1heWJlKS4KCkNoYW5nZWQgdG8gcHJvdmlkZXIuCgo+IAo+ID4g
Kwl1bnNpZ25lZCBpbnQgYWxnbzsKPiA+ICAJdW5zaWduZWQgaW50IHN0cmVuZ3RoOwo+ID4gIAl1
bnNpZ25lZCBpbnQgc3RlcF9zaXplOwo+ID4gKwl1bnNpZ25lZCBpbnQgbWF4aW1pemU7Cj4gPiAr
CXVuc2lnbmVkIGludCBmbGFnczsgIAo+IAo+IG1heGltaXplIGNvdWxkIGJlIGEgZmxhZy4KCkl0
IGlzIG5vdy4KCj4gCj4gPiAgfTsKPiA+ICAKPiA+ICAjZGVmaW5lIE5BTkRfRUNDUkVRKHN0ciwg
c3RwKSB7IC5zdHJlbmd0aCA9IChzdHIpLCAuc3RlcF9zaXplID0gKHN0cCkgfQo+ID4gQEAgLTE1
NywxMSArMTg2LDc2IEBAIHN0cnVjdCBuYW5kX29wcyB7Cj4gPiAgCWJvb2wgKCppc2JhZCkoc3Ry
dWN0IG5hbmRfZGV2aWNlICpuYW5kLCBjb25zdCBzdHJ1Y3QgbmFuZF9wb3MgKnBvcyk7Cj4gPiAg
fTsgIAo+IAoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

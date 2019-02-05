Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:31:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE03E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkXY2j3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE03E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xCNPZtzHDsFdah7dYslLrU1sOq2UxcT1GbNQECSX+CM=; b=kkXY2j3T16O7Ln
	FuV/JBtIhA76ix/eTCho14zP3/0hYCJq75xniOGORcyCHDXRBCxyfe7+96DRyPYA30TCiuqc4Z34B
	3uG62zxuaGkH1lIJP8RVs93yuKkKqCSADGJ7k3Xw/h71WbtXkik7fVP98hb6OhxNPbWoHv3pKpNpG
	sOjD7ffEwEmvAn9to3HvxJ+mFrtRG2J/ARBRQCJE1OgZBUwZgbcABDgnOb+A+1scgPNMPPphvhSBq
	lQkuSnSRQ0GVeFOUMdIJCTOJFYIedyV1od45PZAF9IUEu17RsU3CVxq3k7RrIKZ8pQX7GzNBOXafR
	9uo0x2xlIRcm2RA0cFuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0or-0000mb-M7; Tue, 05 Feb 2019 13:31:21 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0on-0000ll-Eg; Tue, 05 Feb 2019 13:31:19 +0000
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8DD0D1C0016;
 Tue,  5 Feb 2019 13:31:07 +0000 (UTC)
Date: Tue, 5 Feb 2019 14:31:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: wen yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH] mtd: rawnand: mtk: fix object reference leaks in
 mtk_ecc_get
Message-ID: <20190205143106.751554e0@xps13>
In-Reply-To: <HK0PR02MB36345BDC344D1A6FE77B4576B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36345BDC344D1A6FE77B4576B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_053117_640277_7628E1D9 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "richard@nod.at" <richard@nod.at>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "xiaolei.li@mediatek.com" <xiaolei.li@mediatek.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgd2VuLAoKd2VuIHlhbmcgPHllbGxvd3JpdmVyMjAxMEBob3RtYWlsLmNvbT4gd3JvdGUgb24g
VHVlLCA1IEZlYiAyMDE5CjEwOjA1OjQ2ICswMDAwOgoKPiBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHN0cnVjdCBkZXZpY2UKPiB3aGVuIGl0IGZpbmRz
IGEgbWF0Y2ggdmlhIGdldF9kZXZpY2UsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbAo+IGdldF9k
ZXZpY2UoKSB0d2ljZS4KPiBXZSBhbHNvIHNob3VsZCBtYWtlIHN1cmUgdG8gZHJvcCB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSBkZXZpY2UKPiB0YWtlbiBieSBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkg
b24gZHJpdmVyIHVuYmluZC4KPiAKPiBGaXhlczogMWQ2YjFlNDY0OTUwICgibXRkOiBtZWRpYXRl
azogZHJpdmVyIGZvciBNVEsgU21hcnQgRGV2aWNlIikKPiBTaWduZWQtb2ZmLWJ5OiBXZW4gWWFu
ZyA8eWVsbG93cml2ZXIyMDEwQGhvdG1haWwuY29tPgo+IFN1Z2dlc3RlZC1ieTogQm9yaXMgQnJl
emlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+Cj4gQ2M6IFhpYW9sZWkgTGkgPHhpYW9sZWku
bGlAbWVkaWF0ZWsuY29tPgo+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVs
Lm9yZz4KPiBDYzogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KPiBD
YzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KPiBDYzogRGF2aWQgV29vZGhv
dXNlIDxkd213MkBpbmZyYWRlYWQub3JnPgo+IENjOiBCcmlhbiBOb3JyaXMgPGNvbXB1dGVyc2Zv
cnBlYWNlQGdtYWlsLmNvbT4KPiBDYzogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QGdtYWlsLmNv
bT4KPiBDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4KPiBDYzog
bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcK
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IC0tLQo+ICBkcml2ZXJzL210ZC9u
YW5kL3Jhdy9tdGtfZWNjLmMgfCAxMiArKysrKysrKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL25hbmQvcmF3L210a19lY2MuYyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L210a19lY2MuYwo+
IGluZGV4IDY0MzJiZDcuLjI1YmRjMTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9y
YXcvbXRrX2VjYy5jCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbXRrX2VjYy5jCj4gQEAg
LTI2NSwxNyArMjY1LDI1IEBAIHN0YXRpYyBzdHJ1Y3QgbXRrX2VjYyAqbXRrX2VjY19nZXQoc3Ry
dWN0IGRldmljZV9ub2RlICpucCkKPiAgewo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
djsKPiAgCXN0cnVjdCBtdGtfZWNjICplY2M7Cj4gKwlpbnQgcmV0Owo+ICAKPiAgCXBkZXYgPSBv
Zl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsKPiAtCWlmICghcGRldiB8fCAhcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldikpCj4gKwlpZiAoIXBkZXYpCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVQUk9C
RV9ERUZFUik7Cj4gKwlpZiAoIXBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpKSB7Cj4gKwkJcmV0
ID0gLUVQUk9CRV9ERUZFUjsKPiArCQlnb3RvIGVycl9wdXRfZGV2aWNlOwo+ICsJfQo+ICAKPiAt
CWdldF9kZXZpY2UoJnBkZXYtPmRldik7Cj4gIAllY2MgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShw
ZGV2KTsKPiAgCWNsa19wcmVwYXJlX2VuYWJsZShlY2MtPmNsayk7Cj4gIAltdGtfZWNjX2h3X2lu
aXQoZWNjKTsKPiAgCj4gIAlyZXR1cm4gZWNjOwo+ICsKPiArZXJyX3B1dF9kZXZpY2U6Cj4gKwlw
dXRfZGV2aWNlKCZwZGV2LT5kZXYpOwo+ICsJcmV0dXJuIEVSUl9QVFIocmV0KTsKClNhbWUgYXMg
YmVmb3JlLCBJIGRvbid0IHRoaW5rIGEgbGFiZWwgaXMgdXNlZnVsIGluIHRoaXMgc2l0dWF0aW9u
LgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

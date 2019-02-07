Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D8721902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="abunlh5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D8721902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oHc6n0s30+1RLlOGUITuixvRXsZxdjwZ70147IjssTc=; b=abunlh5zqJM58i
	c4x5UVgwuWv02FhU5An2x95VtS8xeIXc8584N3cCtsqoq2xtwRJY58gUD03EM8fptPxoJ0dnp1RAs
	58Oex4i7SgIbgRX0b6u1lcvU960yOgcQjE70BuZLZhqMSqrMvzG/lXXIyiifhTA3M9gasV2i5STp9
	EYPN1CiDvmcjQfTmdXPW1ojBmxHEWNVHEEez4xgodmu1JMMWsSgdS8OEZC3LjRuYjADriofLzNSML
	xHDCtZOGB/pmcS1t/eRSzQvQoiqpmvcLri27j0XrOJC60iOrCcQtugBzG+ipGRU76HB0IjjOIg5Bn
	0F0MxhSZ0tSS77GCU2AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjBy-0006aQ-Es; Thu, 07 Feb 2019 12:54:10 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjBn-0006QF-EA; Thu, 07 Feb 2019 12:54:08 +0000
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id D404020000E;
 Thu,  7 Feb 2019 12:53:55 +0000 (UTC)
Date: Thu, 7 Feb 2019 13:53:55 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wen Yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH v4 3/3] mtd: rawnand: mtk: fix possible object reference
 leak
Message-ID: <20190207135355.19fa523f@xps13>
In-Reply-To: <HK0PR02MB36348C5317C4DDC7C3262FF5B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <1549540786-12196-1-git-send-email-yellowriver2010@hotmail.com>
 <HK0PR02MB36348C5317C4DDC7C3262FF5B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_045401_312854_A8A19AD9 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "richard@nod.at" <richard@nod.at>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgV2VuLAoKV2VuIFlhbmcgPHllbGxvd3JpdmVyMjAxMEBob3RtYWlsLmNvbT4gd3JvdGUgb24g
VGh1LCA3IEZlYiAyMDE5CjEyOjAyOjUyICswMDAwOgoKPiBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHN0cnVjdCBkZXZpY2UKPiB3aGVuIGl0IGZpbmRz
IGEgbWF0Y2ggdmlhIGdldF9kZXZpY2UsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbAo+IGdldF9k
ZXZpY2UoKSB0d2ljZS4KPiBXZSBhbHNvIHNob3VsZCBtYWtlIHN1cmUgdG8gZHJvcCB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSBkZXZpY2UKPiB0YWtlbiBieSBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkg
b24gZHJpdmVyIHVuYmluZC4KPiAKPiBGaXhlczogMWQ2YjFlNDY0OTUwICgibXRkOiBtZWRpYXRl
azogZHJpdmVyIGZvciBNVEsgU21hcnQgRGV2aWNlIikKPiBTaWduZWQtb2ZmLWJ5OiBXZW4gWWFu
ZyA8eWVsbG93cml2ZXIyMDEwQGhvdG1haWwuY29tPgo+IC0tLQo+IHY0LT52MzogQWRkIHBlb3Bs
ZSBpbiBDYyBhbmQgcmVtb3ZlIGFsbCBsaW5lcy4KPiB2My0+djI6IEF2b2lkIHR3byB0aW1lcyBv
ZiBjYWxsaW5nIGdydGZvcm1fZ2V0X2RydmRhdGEoKQo+IHYyLT52MTogU2luY2UgdGhlcmUgaXMg
dGhlIG9ubHkgb25lIHVzZXIsIGxldCdzIHJlbW92ZSB0aGUgZXJyX3B1dF9kZXZpY2UgbGFiZWwu
Cj4gCj4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L210a19lY2MuYyB8IDkgKysrKysrLS0tCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L210a19lY2MuYyBiL2RyaXZlcnMvbXRkL25hbmQv
cmF3L210a19lY2MuYwo+IGluZGV4IDY0MzJiZDcuLmRiODA0ZmUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9tdGQvbmFuZC9yYXcvbXRrX2VjYy5jCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcv
bXRrX2VjYy5jCj4gQEAgLTI2NywxMSArMjY3LDE0IEBAIHN0YXRpYyBzdHJ1Y3QgbXRrX2VjYyAq
bXRrX2VjY19nZXQoc3RydWN0IGRldmljZV9ub2RlICpucCkKPiAgCXN0cnVjdCBtdGtfZWNjICpl
Y2M7Cj4gIAo+ICAJcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobnApOwo+IC0JaWYgKCFw
ZGV2IHx8ICFwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KSkKPiArCWlmICghcGRldikKPiAgCQly
ZXR1cm4gRVJSX1BUUigtRVBST0JFX0RFRkVSKTsKPiAtCgpQbGVhc2Uga2VlcCB0aGlzIGJsYW5r
IGxpbmUuCgo+IC0JZ2V0X2RldmljZSgmcGRldi0+ZGV2KTsKPiAgCWVjYyA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOwo+ICsJaWYgKCFlY2MpIHsKPiArCQlwdXRfZGV2aWNlKCZwZGV2LT5k
ZXYpOwo+ICsJCXJldHVybiBFUlJfUFRSKC1FUFJPQkVfREVGRVIpOwo+ICsJfQo+ICsKPiAgCWNs
a19wcmVwYXJlX2VuYWJsZShlY2MtPmNsayk7Cj4gIAltdGtfZWNjX2h3X2luaXQoZWNjKTsKPiAg
CgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

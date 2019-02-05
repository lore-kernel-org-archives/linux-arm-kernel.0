Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A1BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:17:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C254206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gepVro2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C254206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CP62A/e8s4BvnBKULhQCKTV3Yaqg9UI+HMCzOVi9yQw=; b=gepVro2SQMMzHc
	xsQ2fYcDJdFOMlkk8oiPeVM2nOp0VvAmbx1mxrth5xKphzYtL6bNIDyKIzmgBEyPolyc9i9KCg0mH
	I9ZQOoKxMCo9M92kJnpEdIOaBgJfh00ZXetO55gtoEpDvBGKup6b7QsZ4/1sMvDlUCqYznKo9+1FE
	J7G0JFIPm8IFsmxU/98BcGaOjQq4+7oGRLzSuHwt6sOECyk5czynhbXV7BPmbyqQKuVrDUXPKVwXx
	zkCPt842DCQ55pvHNnYmZffDMBWRl9V04/YsF0vT7eb9Y+rJt2dR7m+XYY40qUes2yHZwwaJrZSEM
	Zp5v4SrwEWEJ81VRtLdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0bM-0003F2-IC; Tue, 05 Feb 2019 13:17:24 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0bI-0003EM-5k; Tue, 05 Feb 2019 13:17:22 +0000
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8B836240011;
 Tue,  5 Feb 2019 13:17:10 +0000 (UTC)
Date: Tue, 5 Feb 2019 14:17:09 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: wen yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH v2] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Message-ID: <20190205141709.5a8b80d1@xps13>
In-Reply-To: <HK0PR02MB36342EEC848C39F479D0063CB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36342EEC848C39F479D0063CB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_051720_361223_EDDF467D 
X-CRM114-Status: GOOD (  16.05  )
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
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "richard@nod.at" <richard@nod.at>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
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

SGkgd2VuLAoKQ2FuIHlvdSBjaGFuZ2UgdGhlIGNvbW1pdCBtZXNzYWdlOgoKIm10ZDogcmF3bmFu
ZDogYXRtZWw6IGZpeCBwb3NzaWJsZSBvYmplY3QgcmVmZXJlbmNlIGxlYWsiCgp3ZW4geWFuZyA8
eWVsbG93cml2ZXIyMDEwQGhvdG1haWwuY29tPiB3cm90ZSBvbiBTdW4sIDMgRmViIDIwMTkKMTI6
NDE6NDQgKzAwMDA6Cgo+IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoKSB0YWtlcyBhIHJlZmVyZW5j
ZSB0byB0aGUgc3RydWN0IGRldmljZQo+IHdoZW4gaXQgZmluZHMgYSBtYXRjaCB2aWEgZ2V0X2Rl
dmljZSwgdGhlcmUgaXMgbm8gbmVlZCB0byBjYWxsCj4gZ2V0X2RldmljZSgpIHR3aWNlLgo+IFdl
IGFsc28gc2hvdWxkIG1ha2Ugc3VyZSB0byBkcm9wIHRoZSByZWZlcmVuY2UgdG8gdGhlIGRldmlj
ZQo+IHRha2VuIGJ5IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoKSBvbiBkcml2ZXIgdW5iaW5kLgo+
IAo+IEZpeGVzOiBmODhmYzEyMmNjMzQgKCJtdGQ6IG5hbmQ6IENsZWFudXAvcmV3b3JrIHRoZSBh
dG1lbF9uYW5kIGRyaXZlciIpCj4gU2lnbmVkLW9mZi1ieTogV2VuIFlhbmcgPHllbGxvd3JpdmVy
MjAxMEBob3RtYWlsLmNvbT4KPiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8YmJyZXpp
bGxvbkBrZXJuZWwub3JnPgo+IFJldmlld2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxs
b25Aa2VybmVsLm9yZz4KClVubGVzcyBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBCb3JpcyBkaWRu
J3QgZ2F2ZSBoaXMgUi1iIHlldC4KClsuLi5dCiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQv
bmFuZC9yYXcvYXRtZWwvcG1lY2MuYyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL3BtZWNj
LmMKPiBpbmRleCA1NTVhNzRlLi4xNDc3MzY4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbXRkL25h
bmQvcmF3L2F0bWVsL3BtZWNjLmMKPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9w
bWVjYy5jCj4gQEAgLTg3NiwxNiArODc2LDIyIEBAIHN0YXRpYyBzdHJ1Y3QgYXRtZWxfcG1lY2Mg
KmF0bWVsX3BtZWNjX2dldF9ieV9ub2RlKHN0cnVjdCBkZXZpY2UgKnVzZXJkZXYsCj4gIHsKPiAg
CXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7Cj4gIAlzdHJ1Y3QgYXRtZWxfcG1lY2MgKnBt
ZWNjLCAqKnB0cjsKPiArCWludCByZXQ7Cj4gIAo+ICAJcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5
X25vZGUobnApOwo+IC0JaWYgKCFwZGV2IHx8ICFwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KSkK
PiArCWlmICghcGRldikKPiAgCQlyZXR1cm4gRVJSX1BUUigtRVBST0JFX0RFRkVSKTsKPiArCWlm
ICghcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldikpIHsKPiArCQlyZXQgPSAtRVBST0JFX0RFRkVS
Owo+ICsJCWdvdG8gZXJyX3B1dF9kZXZpY2U7Cj4gKwl9Cj4gIAo+ICAJcHRyID0gZGV2cmVzX2Fs
bG9jKGRldm1fYXRtZWxfcG1lY2NfcHV0LCBzaXplb2YoKnB0ciksIEdGUF9LRVJORUwpOwo+IC0J
aWYgKCFwdHIpCj4gLQkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gKwlpZiAoIXB0cikgewo+
ICsJCXJldCA9IC1FTk9NRU07Cj4gKwkJZ290byBlcnJfcHV0X2RldmljZTsKPiArCX0KPiAgCj4g
LQlnZXRfZGV2aWNlKCZwZGV2LT5kZXYpOwo+ICAJcG1lY2MgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShwZGV2KTsKPiAgCj4gIAkqcHRyID0gcG1lY2M7Cj4gQEAgLTg5Myw2ICs4OTksMTAgQEAgc3Rh
dGljIHN0cnVjdCBhdG1lbF9wbWVjYyAqYXRtZWxfcG1lY2NfZ2V0X2J5X25vZGUoc3RydWN0IGRl
dmljZSAqdXNlcmRldiwKPiAgCWRldnJlc19hZGQodXNlcmRldiwgcHRyKTsKPiAgCj4gIAlyZXR1
cm4gcG1lY2M7Cj4gKwo+ICtlcnJfcHV0X2RldmljZToKPiArCXB1dF9kZXZpY2UoJnBkZXYtPmRl
dik7Cj4gKwlyZXR1cm4gRVJSX1BUUihyZXQpOwo+ICB9Cj4gIAo+ICBzdGF0aWMgY29uc3QgaW50
IGF0bWVsX3BtZWNjX3N0cmVuZ3Roc1tdID0geyAyLCA0LCA4LCAxMiwgMjQsIDMyIH07CgpXaXRo
IHRoZSBjb21taXQgdGl0bGUgY2hhbmdlZCwgeW91IGNhbiBhZGQgbXkKCkFja2VkLWJ5OiBNaXF1
ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgoKClRoYW5rcywKTWlxdcOobAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=

Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB9FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B07C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CGZM4CAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B07C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FlljmZk12dyDF2sUWjYsgdn1m8cR+oH/MXu1Ig2yVWo=; b=CGZM4CAydoXPRf
	ydmuKbx6UzEH5bTS9kzw8FASrPnMS2pOCcsrufNHx4MBz1lCEdh3HT6ivUKvGZHhQn/AgucYz3QMQ
	hKpWAC+EuAQfZ48cfUUfdBpwX9iXzP17bsQNbfLEI4GUrb6+GBkK6rpgdvr7mKHScPPUKPdd70i4L
	K09qAoyu+yBm/VecdFNRWyw9qWWFbRtPqinLXE/iWeL9dObPZ83wpIdqVyDQ9N3Xt88/zZp/d0GaW
	HZ8wG+5s6dPnKXQFIVhEhgdFzmmam23+dXsvrnvoTveU+b6Qw4MefFVOrjUR0oW2T/MzcxfsoySwm
	YiPAOHBRalnsugUKXElA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grs2u-00006N-A1; Thu, 07 Feb 2019 22:21:24 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grs2q-00005r-Pj; Thu, 07 Feb 2019 22:21:22 +0000
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1B7DD1BF206;
 Thu,  7 Feb 2019 22:21:14 +0000 (UTC)
Date: Thu, 7 Feb 2019 23:21:13 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wen Yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH v5 1/3] mtd: rawnand: atmel: fix possible object
 reference leak
Message-ID: <20190207232113.5dc026af@xps13>
In-Reply-To: <HK0PR02MB3634B38A3D04DCFFC09BDCB0B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB3634B38A3D04DCFFC09BDCB0B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_142120_980820_FD0EE25A 
X-CRM114-Status: GOOD (  17.37  )
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
VGh1LCA3IEZlYiAyMDE5CjExOjU2OjQ4ICswMDAwOgoKPiBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHN0cnVjdCBkZXZpY2UKPiB3aGVuIGl0IGZpbmRz
IGEgbWF0Y2ggdmlhIGdldF9kZXZpY2UsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbAo+IGdldF9k
ZXZpY2UoKSB0d2ljZS4KPiBXZSBhbHNvIHNob3VsZCBtYWtlIHN1cmUgdG8gZHJvcCB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSBkZXZpY2UKPiB0YWtlbiBieSBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkg
b24gZHJpdmVyIHVuYmluZC4KPiAKPiBGaXhlczogZjg4ZmMxMjJjYzM0ICgibXRkOiBuYW5kOiBD
bGVhbnVwL3Jld29yayB0aGUgYXRtZWxfbmFuZCBkcml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IFdl
biBZYW5nIDx5ZWxsb3dyaXZlcjIwMTBAaG90bWFpbC5jb20+Cj4gLS0tCj4gdjUtPnY0OiBBZGQg
bmV3IGxpbmUsIGFkZCBwZW9wbGUgaW4gQ2MgYW5kIHJlbW92ZSBhbGwgQ2MgbGluZXMuCj4gdjQt
PnYzOiBBdm9pZCB0d28gdGltZXMgb2YgY2FsbGluZyBncnRmb3JtX2dldF9kcnZkYXRhKCkKPiB2
My0+djI6IENoYW5nZSB0aGUgY29tbWl0IG1lc3NhZ2UuCj4gdjItPnYxOiBBZGQgbWlzc2luZyBG
aXhlcyB0YWcuCj4gCj4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL3BtZWNjLmMgfCAyMiAr
KysrKysrKysrKysrKysrLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9h
dG1lbC9wbWVjYy5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvcG1lY2MuYwo+IGluZGV4
IDU1NWE3NGUuLjk3ZTQ3ZWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRt
ZWwvcG1lY2MuYwo+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL3BtZWNjLmMKPiBA
QCAtODc2LDIzICs4NzYsMzMgQEAgc3RhdGljIHN0cnVjdCBhdG1lbF9wbWVjYyAqYXRtZWxfcG1l
Y2NfZ2V0X2J5X25vZGUoc3RydWN0IGRldmljZSAqdXNlcmRldiwKPiAgewo+ICAJc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldjsKPiAgCXN0cnVjdCBhdG1lbF9wbWVjYyAqcG1lY2MsICoqcHRy
Owo+ICsJaW50IHJldDsKPiAgCj4gIAlwZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShucCk7
Cj4gLQlpZiAoIXBkZXYgfHwgIXBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpKQo+ICsJaWYgKCFw
ZGV2KQo+ICAJCXJldHVybiBFUlJfUFRSKC1FUFJPQkVfREVGRVIpOwo+ICAKPiAtCXB0ciA9IGRl
dnJlc19hbGxvYyhkZXZtX2F0bWVsX3BtZWNjX3B1dCwgc2l6ZW9mKCpwdHIpLCBHRlBfS0VSTkVM
KTsKPiAtCWlmICghcHRyKQo+IC0JCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+IC0KPiAtCWdl
dF9kZXZpY2UoJnBkZXYtPmRldik7Cj4gIAlwbWVjYyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBk
ZXYpOwo+ICsJaWYgKCFwbWVjYykgewo+ICsJCXJldCA9IC1FUFJPQkVfREVGRVI7Cj4gKwkJZ290
byBlcnJfcHV0X2RldmljZTsKPiArCX0KPiArCj4gKwlwdHIgPSBkZXZyZXNfYWxsb2MoZGV2bV9h
dG1lbF9wbWVjY19wdXQsIHNpemVvZigqcHRyKSwgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIXB0cikg
ewo+ICsJCXJldCA9IC1FTk9NRU07Cj4gKwkJZ290byBlcnJfcHV0X2RldmljZTsKPiArCX0KPiAg
Cj4gIAkqcHRyID0gcG1lY2M7Cj4gIAo+ICAJZGV2cmVzX2FkZCh1c2VyZGV2LCBwdHIpOwo+ICAK
PiAgCXJldHVybiBwbWVjYzsKPiArCj4gK2Vycl9wdXRfZGV2aWNlOgo+ICsJcHV0X2RldmljZSgm
cGRldi0+ZGV2KTsKPiArCXJldHVybiBFUlJfUFRSKHJldCk7Cj4gIH0KPiAgCj4gIHN0YXRpYyBj
b25zdCBpbnQgYXRtZWxfcG1lY2Nfc3RyZW5ndGhzW10gPSB7IDIsIDQsIDgsIDEyLCAyNCwgMzIg
fTsKClNlcmllcyBhcHBsaWVkIHRvIG5hbmQvbmV4dC4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

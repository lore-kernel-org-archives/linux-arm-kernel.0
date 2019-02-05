Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E02C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:12:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903B92083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0J/Uq+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903B92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZDWdOZpjnyf966kR8lxxvEsytP3psUnRAtXGrwem/ns=; b=M0J/Uq+b6REZWl
	7wS7nJ0PiqBhrGvPwPQX5mrioY1PyYrKLBrlkpACoLgNT+AbHbnuUd7Fgf1Ji9aR9EfzC2weZX5Hu
	Gq0oXYbyB+jXDbo8LgLkKsLpybmCsuxsQJGTb7zM/DsPCg8yEE+YR3tWpix6lacy5bi8dYTmB2Lei
	ic5LoXrO0K+QB5culB1eoty9jGHwyY09eujLidJJREw+ALBUSGqp/ZUdkSJCeLvmGWkBa3zT586gK
	dxWUNrcocttYBp6azzxnu4HJ3rGnHF0mxaFz8zFtLeN/EOpoAC/2YfUJ1kVvDTv4jEvD51qBLcSXg
	r0uxffUjUkIJ9UxbwjPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr68f-0003d5-GP; Tue, 05 Feb 2019 19:12:09 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr68b-0003cD-50; Tue, 05 Feb 2019 19:12:06 +0000
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 92560240007;
 Tue,  5 Feb 2019 19:11:59 +0000 (UTC)
Date: Tue, 5 Feb 2019 20:11:58 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wen Yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: atmel: fix possible object reference leak
Message-ID: <20190205201158.3cbcc628@xps13>
In-Reply-To: <HK0PR02MB36344D81C6E66666EB60849DB26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36344D81C6E66666EB60849DB26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_111205_496728_476C8A4D 
X-CRM114-Status: GOOD (  19.84  )
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

SGkgV2VuLAoKRm9yIHRoZSBuZXh0IHZlcnNpb24gY2FuIHlvdSBwbGVhc2UgcG9zdCBhIHNlcmll
cyB3aXRoIHRoZSB0aHJlZQpjb21taXRzIHdoaWNoIGFyZSBmaXhpbmcgdGhlIHNhbWUgcmVmZXJl
bmNlIGxlYWs/IE5vIG5lZWQgdG8gYWRkIGEKY292ZXIgbGV0dGVyIHRob3VnaC4KCldlbiBZYW5n
IDx5ZWxsb3dyaXZlcjIwMTBAaG90bWFpbC5jb20+IHdyb3RlIG9uIFR1ZSwgNSBGZWIgMjAxOQox
NDozMjo0MSArMDAwMDoKCj4gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIHRha2VzIGEgcmVmZXJl
bmNlIHRvIHRoZSBzdHJ1Y3QgZGV2aWNlCj4gd2hlbiBpdCBmaW5kcyBhIG1hdGNoIHZpYSBnZXRf
ZGV2aWNlLCB0aGVyZSBpcyBubyBuZWVkIHRvIGNhbGwKPiBnZXRfZGV2aWNlKCkgdHdpY2UuCj4g
V2UgYWxzbyBzaG91bGQgbWFrZSBzdXJlIHRvIGRyb3AgdGhlIHJlZmVyZW5jZSB0byB0aGUgZGV2
aWNlCj4gdGFrZW4gYnkgb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIG9uIGRyaXZlciB1bmJpbmQu
Cj4gCj4gRml4ZXM6IGY4OGZjMTIyY2MzNCAoIm10ZDogbmFuZDogQ2xlYW51cC9yZXdvcmsgdGhl
IGF0bWVsX25hbmQgZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBXZW4gWWFuZyA8eWVsbG93cml2
ZXIyMDEwQGhvdG1haWwuY29tPgo+IFN1Z2dlc3RlZC1ieTogQm9yaXMgQnJlemlsbG9uIDxiYnJl
emlsbG9uQGtlcm5lbC5vcmc+Cj4gUmV2aWV3ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8YmJyZXpp
bGxvbkBrZXJuZWwub3JnPgo+IFJldmlld2VkLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5
bmFsQGJvb3RsaW4uY29tPgo+IEFja2VkLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFs
QGJvb3RsaW4uY29tPgo+IENjOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+Cj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8YmJyZXppbGxvbkBrZXJuZWwub3JnPgo+IENj
OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+IENjOiBSaWNoYXJk
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pgo+IENjOiBEYXZpZCBXb29kaG91c2UgPGR3bXcy
QGluZnJhZGVhZC5vcmc+Cj4gQ2M6IEJyaWFuIE5vcnJpcyA8Y29tcHV0ZXJzZm9ycGVhY2VAZ21h
aWwuY29tPgo+IENjOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPgo+IENjOiBO
aWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+Cj4gQ2M6IEFsZXhhbmRy
ZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4KPiBDYzogTHVkb3ZpYyBE
ZXNyb2NoZXMgPGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5jb20+Cj4gQ2M6IGxpbnV4LW10
ZEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gLS0tCj4gIGRyaXZl
cnMvbXRkL25hbmQvcmF3L2F0bWVsL3BtZWNjLmMgfCAxOCArKysrKysrKysrKysrKy0tLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL3BtZWNjLmMgYi9kcml2ZXJzL210
ZC9uYW5kL3Jhdy9hdG1lbC9wbWVjYy5jCj4gaW5kZXggNTU1YTc0ZS4uMTQ3NzM2OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVjYy5jCj4gKysrIGIvZHJpdmVy
cy9tdGQvbmFuZC9yYXcvYXRtZWwvcG1lY2MuYwo+IEBAIC04NzYsMTYgKzg3NiwyMiBAQCBzdGF0
aWMgc3RydWN0IGF0bWVsX3BtZWNjICphdG1lbF9wbWVjY19nZXRfYnlfbm9kZShzdHJ1Y3QgZGV2
aWNlICp1c2VyZGV2LAo+ICB7Cj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Owo+ICAJ
c3RydWN0IGF0bWVsX3BtZWNjICpwbWVjYywgKipwdHI7Cj4gKwlpbnQgcmV0Owo+ICAKPiAgCXBk
ZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsKPiAtCWlmICghcGRldiB8fCAhcGxhdGZv
cm1fZ2V0X2RydmRhdGEocGRldikpCj4gKwlpZiAoIXBkZXYpCj4gIAkJcmV0dXJuIEVSUl9QVFIo
LUVQUk9CRV9ERUZFUik7Cj4gKwlpZiAoIXBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpKSB7Cj4g
KwkJcmV0ID0gLUVQUk9CRV9ERUZFUjsKPiArCQlnb3RvIGVycl9wdXRfZGV2aWNlOwo+ICsJfQo+
ICAKPiAgCXB0ciA9IGRldnJlc19hbGxvYyhkZXZtX2F0bWVsX3BtZWNjX3B1dCwgc2l6ZW9mKCpw
dHIpLCBHRlBfS0VSTkVMKTsKPiAtCWlmICghcHRyKQo+IC0JCXJldHVybiBFUlJfUFRSKC1FTk9N
RU0pOwo+ICsJaWYgKCFwdHIpIHsKPiArCQlyZXQgPSAtRU5PTUVNOwo+ICsJCWdvdG8gZXJyX3B1
dF9kZXZpY2U7Cj4gKwl9Cj4gIAo+IC0JZ2V0X2RldmljZSgmcGRldi0+ZGV2KTsKPiAgCXBtZWNj
ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CgpJIGp1c3QgcmVhbGl6ZWQgaW4gdGhlIHRo
cmVlIGNhc2VzLCBhIGZpcnN0IGNhbGwKdG8gcGxhdGZvcm1fZ2V0X2RydmRhdGEoKSBpcyBkb25l
IHRvIGNoZWNrIGlmIHRoZSByZXR1cm5lZCBwb2ludGVyIGlzCnZhbGlkLCBhbmQgdGhlbiBhIHNl
Y29uZCBvbmUgaXMgZG9uZSB0byBhY3R1YWxseSByZXRyaWV2ZSB0aGUgcG9pbnRlci4KUGxlYXNl
IGF2b2lkIHRoaXMgcmVwZXRpdGlvbi4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

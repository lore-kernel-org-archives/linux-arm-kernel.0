Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A515C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD5E2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fe+xvCjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD5E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J0Z133GTjYsaSdkwU61ovYpY6YM5MwopOcbbH/6YsE4=; b=fe+xvCjDQe4D6r
	pV11NSFlY/Q/lDexTDC3n+0az5hds1whogVwMeQ0PIpelhyzDfsBJAOeI7nEffqdQQvrPNciFCDZq
	t7E0d/5kfDGcv4G3LSLC2twgSalN/PwRctdVktTdF8xiYLtJ/lAF2Qn129nYGZeCZk8hsakJBLb4P
	h7ZeUbdDyPlB8/OVIsI7s2dBwhUI1Ler0Tn9FHKaeNnKi1MmjVGJeYLbMUGwapu6YXCgqtUHON3t3
	wDFB7sJyFKnNk6Z0bc4M25SxYlFrt3lBTiRI96PLHXuVS59m5L8HHpNCQJmvhmy0aaYJFzGr61g9P
	581913c8ZfYSRvBJCStg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfuG-0000QZ-Ea; Thu, 07 Feb 2019 09:23:40 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfuC-0000PW-GG; Thu, 07 Feb 2019 09:23:38 +0000
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id ED4991BF206;
 Thu,  7 Feb 2019 09:23:29 +0000 (UTC)
Date: Thu, 7 Feb 2019 10:23:29 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wen Yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH v4 1/3] mtd: rawnand: atmel: fix possible object
 reference leak
Message-ID: <20190207102329.1b137198@xps13>
In-Reply-To: <HK0PR02MB363495256F9ADB049C795D7DB2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB363495256F9ADB049C795D7DB2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012336_875719_3F5FF0F8 
X-CRM114-Status: GOOD (  20.80  )
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

SGkgV2VuLAoKV2VuIFlhbmcgPHllbGxvd3JpdmVyMjAxMEBob3RtYWlsLmNvbT4gd3JvdGUgb24g
VGh1LCA3IEZlYiAyMDE5CjAzOjUwOjU1ICswMDAwOgoKPiBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHN0cnVjdCBkZXZpY2UKPiB3aGVuIGl0IGZpbmRz
IGEgbWF0Y2ggdmlhIGdldF9kZXZpY2UsIHRoZXJlIGlzIG5vIG5lZWQgdG8gY2FsbAo+IGdldF9k
ZXZpY2UoKSB0d2ljZS4KPiBXZSBhbHNvIHNob3VsZCBtYWtlIHN1cmUgdG8gZHJvcCB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSBkZXZpY2UKPiB0YWtlbiBieSBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkg
b24gZHJpdmVyIHVuYmluZC4KPiAKPiBGaXhlczogZjg4ZmMxMjJjYzM0ICgibXRkOiBuYW5kOiBD
bGVhbnVwL3Jld29yayB0aGUgYXRtZWxfbmFuZCBkcml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IFdl
biBZYW5nIDx5ZWxsb3dyaXZlcjIwMTBAaG90bWFpbC5jb20+Cj4gU3VnZ2VzdGVkLWJ5OiBCb3Jp
cyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4KClN1Z2dlc3RlZC1ieSBtZWFucyB0
aGF0IEJvcmlzIHN1Z2dlc3RlZCB5b3UgdG8gd3JpdGUgdGhpcyBwYXRjaCBpbiB0aGUKZmlyc3Qg
cGxhY2UuIElmIGhlIGp1c3QgbWFkZSBhIHJldmlldywgeW91IHNob3VsZCBkcm9wIHRoaXMgdGFn
LgoKPiBSZXZpZXdlZC1ieTogQm9yaXMgQnJlemlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+
Cj4gUmV2aWV3ZWQtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+
CgpOb25lIG9mIHVzIGdhdmUgb3VyIFJldmlld2VkLWJ5IG9mZmljaWFsbHksIHNvIHlvdSBjYW4g
ZHJvcCB0aGVzZSBsaW5lcy4KCj4gQWNrZWQtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXlu
YWxAYm9vdGxpbi5jb20+CgpJIGdhdmUgbXkgQWNrZWQtYnkgYmVjYXVzZSBJIHRob3VnaCBCb3Jp
cyB3b3VsZCB0YWtlIHRoZSBwYXRjaCwgYnV0CmFjdHVhbGx5IGhlIHdpbGwgbm90LCBzbyB5b3Ug
Y2FuIGRyb3AgdGhlIEFjay4KCj4gQ2M6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4KPiBDYzogQm9yaXMgQnJlemlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+
Cj4gQ2M6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Cj4gQ2M6IFJp
Y2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Cj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8
ZHdtdzJAaW5mcmFkZWFkLm9yZz4KPiBDYzogQnJpYW4gTm9ycmlzIDxjb21wdXRlcnNmb3JwZWFj
ZUBnbWFpbC5jb20+Cj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBnbWFpbC5jb20+Cj4g
Q2M6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4KPiBDYzogQWxl
eGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPgo+IENjOiBMdWRv
dmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4KPiBDYzogbGlu
dXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKClBsZWFzZSBh
ZGQgcGVvcGxlIGluIENjIHdoZW4geW91IHNlbmQgdGhlIHNlcmllcyBhbmQgcmVtb3ZlIGFsbCB0
aGVzZQpDYzogbGluZXMuCgo+IC0tLQo+IHY0LT52MzogQXZvaWQgdHdvIHRpbWVzIG9mIGNhbGxp
bmcgZ3J0Zm9ybV9nZXRfZHJ2ZGF0YSgpCj4gdjMtPnYyOiBDaGFuZ2UgdGhlIGNvbW1pdCBtZXNz
YWdlLgo+IHYyLT52MTogQWRkIG1pc3NpbmcgRml4ZXMgdGFnCj4gCj4gIGRyaXZlcnMvbXRkL25h
bmQvcmF3L2F0bWVsL3BtZWNjLmMgfCAyMSArKysrKysrKysrKysrKystLS0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L2F0bWVsL3BtZWNjLmMgYi9kcml2ZXJzL210ZC9uYW5k
L3Jhdy9hdG1lbC9wbWVjYy5jCj4gaW5kZXggNTU1YTc0ZS4uOWQzOTk3OCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVjYy5jCj4gKysrIGIvZHJpdmVycy9tdGQv
bmFuZC9yYXcvYXRtZWwvcG1lY2MuYwo+IEBAIC04NzYsMjMgKzg3NiwzMiBAQCBzdGF0aWMgc3Ry
dWN0IGF0bWVsX3BtZWNjICphdG1lbF9wbWVjY19nZXRfYnlfbm9kZShzdHJ1Y3QgZGV2aWNlICp1
c2VyZGV2LAo+ICB7Cj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Owo+ICAJc3RydWN0
IGF0bWVsX3BtZWNjICpwbWVjYywgKipwdHI7Cj4gKwlpbnQgcmV0Owo+ICAKPiAgCXBkZXYgPSBv
Zl9maW5kX2RldmljZV9ieV9ub2RlKG5wKTsKPiAtCWlmICghcGRldiB8fCAhcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldikpCj4gKwlpZiAoIXBkZXYpCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVQUk9C
RV9ERUZFUik7CgpOZXcgbGluZSBtaXNzaW5nIGhlcmUKCj4gKwlwbWVjYyA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOwo+ICsJaWYgKCFwbWVjYykgewo+ICsJCXJldCA9IC1FUFJPQkVfREVG
RVI7Cj4gKwkJZ290byBlcnJfcHV0X2RldmljZTsKPiArCX0KPiAgCj4gIAlwdHIgPSBkZXZyZXNf
YWxsb2MoZGV2bV9hdG1lbF9wbWVjY19wdXQsIHNpemVvZigqcHRyKSwgR0ZQX0tFUk5FTCk7Cj4g
LQlpZiAoIXB0cikKPiAtCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiAtCj4gLQlnZXRfZGV2
aWNlKCZwZGV2LT5kZXYpOwo+IC0JcG1lY2MgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsK
PiArCWlmICghcHRyKSB7Cj4gKwkJcmV0ID0gLUVOT01FTTsKPiArCQlnb3RvIGVycl9wdXRfZGV2
aWNlOwo+ICsJfQo+ICAKPiAgCSpwdHIgPSBwbWVjYzsKPiAgCj4gIAlkZXZyZXNfYWRkKHVzZXJk
ZXYsIHB0cik7Cj4gIAo+ICAJcmV0dXJuIHBtZWNjOwo+ICsKPiArZXJyX3B1dF9kZXZpY2U6Cj4g
KwlwdXRfZGV2aWNlKCZwZGV2LT5kZXYpOwo+ICsJcmV0dXJuIEVSUl9QVFIocmV0KTsKPiAgfQo+
ICAKPiAgc3RhdGljIGNvbnN0IGludCBhdG1lbF9wbWVjY19zdHJlbmd0aHNbXSA9IHsgMiwgNCwg
OCwgMTIsIDI0LCAzMiB9OwoKQWxsIHRoZSBjb21tZW50cyBhcHBseSB0byB0aGUgdHdvIG90aGVy
IHBhdGNoZXMuCgpPdGhlcndpc2UgbG9va3MgZ29vZC4KCgpUaGFua3MsCk1pcXXDqGwKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

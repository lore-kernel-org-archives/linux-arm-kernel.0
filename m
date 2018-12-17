Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E73C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFA1206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dLcchVjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFA1206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CHY2P0aePVNXaZib+27Op2oH77UM3a1WD71Ldv9art4=; b=dLcchVjmA3edjv
	O3+NA4Y7b1Ei/xc0e1hKlGe61Uf4SJamjisPVeqkKq3O5H7FnLhZXID6ebwxdFgTz7+EjHKsTfPBu
	WpdmU3Mu8WugAzf9rmFSm2NRJdvnv9IgRTtsjI0c0DVTWsV8b/lDUfYF7oONbkPsKsbjXM87dp9Wd
	/yg9lJG9blcDMCNiChiht/MDoRaJkWzHcWCVVyPG3VmjxIzxPp//WXjLpm8THGb8t/kz3rNuIpuQs
	I92SlgRBXCEp6pHR1KUGXg0Al1sh8RmPHdZ9YgRLKzqqJoib/OQz0zg00yvohIgEvN3TqR1Agj47x
	gUTHH5WHiWj3IedZBwfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoYR-0007zg-Ok; Mon, 17 Dec 2018 08:47:11 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoYN-0007yy-RY
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:47:09 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5AB5E2072F; Mon, 17 Dec 2018 09:46:54 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2536A2039F;
 Mon, 17 Dec 2018 09:46:54 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mvebu: only fail on missing clk if pwm is actually
 to be used
References: <20181217084313.15379-1-u.kleine-koenig@pengutronix.de>
Date: Mon, 17 Dec 2018 09:46:54 +0100
In-Reply-To: <20181217084313.15379-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 17 Dec 2018 09:43:13
 +0100")
Message-ID: <875zvsk0ap.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_004708_028504_19116C6A 
X-CRM114-Status: GOOD (  19.54  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
 stable@vger.kernel.org, linux-gpio@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
 Ralph Sennhauser <ralph.sennhauser@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCiAKIE9uIGx1bi4sIGTDqWMuIDE3IDIwMTgsIFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgoKPiBUaGUgZ3BpbyBJUCBvbiBBcm1hZGEg
MzcwIGF0IG9mZnNldCAweDE4MTgwIGhhcyBuZWl0aGVyIGEgY2xrIG5vciBwd20KPiByZWdpc3Rl
cnMuIFNvIHRoZXJlIGlzIG5vIG5lZWQgZm9yIGEgY2xrIGFzIHRoZSBwd20gaXNuJ3QgdXNlZCBh
bnlob3cuCj4gU28gb25seSBjaGVjayBmb3IgdGhlIGNsayBpbiB0aGUgcHJlc2VuY2Ugb2YgdGhl
IHB3bSByZWdpc3RlcnMuIFRoaXMgZml4ZXMKPiBhIGZhaWx1cmUgdG8gcHJvYmUgdGhlIGdwaW8g
ZHJpdmVyIGZvciB0aGUgYWJvdmUgbWVudGlvbmVkIGdwaW8gZGV2aWNlLgo+Cj4gRml4ZXM6IDc1
NzY0MmY5YTU4NCAoImdwaW86IG12ZWJ1OiBBZGQgbGltaXRlZCBQV00gc3VwcG9ydCIpCj4gU2ln
bmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25p
eC5kZT4KClJldmlld2VkLWJ5OiBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBib290
bGluLmNvbT4KClRoYW5rcywKCkdyZWdvcnkKCgo+IC0tLQo+ICBkcml2ZXJzL2dwaW8vZ3Bpby1t
dmVidS5jIHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpby1tdmVidS5jIGIv
ZHJpdmVycy9ncGlvL2dwaW8tbXZlYnUuYwo+IGluZGV4IDZlMDIxNDhjMjA4Yi4uYWRjNzY4Zjkw
OGYxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLW12ZWJ1LmMKPiArKysgYi9kcml2
ZXJzL2dwaW8vZ3Bpby1tdmVidS5jCj4gQEAgLTc3Myw5ICs3NzMsNiBAQCBzdGF0aWMgaW50IG12
ZWJ1X3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+ICAJCQkJICAgICAi
bWFydmVsbCxhcm1hZGEtMzcwLWdwaW8iKSkKPiAgCQlyZXR1cm4gMDsKPiAgCj4gLQlpZiAoSVNf
RVJSKG12Y2hpcC0+Y2xrKSkKPiAtCQlyZXR1cm4gUFRSX0VSUihtdmNoaXAtPmNsayk7Cj4gLQo+
ICAJLyoKPiAgCSAqIFRoZXJlIGFyZSBvbmx5IHR3byBzZXRzIG9mIFBXTSBjb25maWd1cmF0aW9u
IHJlZ2lzdGVycyBmb3IKPiAgCSAqIGFsbCB0aGUgR1BJTyBsaW5lcyBvbiB0aG9zZSBTb0NzIHdo
aWNoIHRoaXMgZHJpdmVyIHJlc2VydmVzCj4gQEAgLTc4Niw2ICs3ODMsOSBAQCBzdGF0aWMgaW50
IG12ZWJ1X3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+ICAJaWYgKCFy
ZXMpCj4gIAkJcmV0dXJuIDA7Cj4gIAo+ICsJaWYgKElTX0VSUihtdmNoaXAtPmNsaykpCj4gKwkJ
cmV0dXJuIFBUUl9FUlIobXZjaGlwLT5jbGspOwo+ICsKPiAgCS8qCj4gIAkgKiBVc2Ugc2V0IEEg
Zm9yIGxpbmVzIG9mIEdQSU8gY2hpcCB3aXRoIGlkIDAsIEIgZm9yIEdQSU8gY2hpcAo+ICAJICog
d2l0aCBpZCAxLiBEb24ndCBhbGxvdyBmdXJ0aGVyIEdQSU8gY2hpcHMgdG8gYmUgdXNlZCBmb3Ig
UFdNLgo+IC0tIAo+IDIuMTkuMgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCgotLSAKR3JlZ29yeSBDbGVtZW50
LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jv
b3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==

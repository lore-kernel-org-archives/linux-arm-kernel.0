Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2037C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:44:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864B521855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AObeiIMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864B521855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cN3w5VmGdMLvehvYnBuPJjYwsEZZBYtBMMofv97ncKE=; b=AObeiIMXrt47m/
	rWj9hTUDZwhEi/knN7TMZk5qTL+bXMhdf+P618ELX6GLZIBOjATa5MFxDYHYnefrnay4/b+vn43qc
	kVsu0ouNyj42c8FsIUcLY10iwzMjETlRUI6jr3/eh1iSLIJGVNKSNk0/aLRbKCgfTnJwBqtk/i4FI
	GM+z/edoRnBGw26CPo/i1TZd85Kdkmn9UhDKDlYPwYss7DFRLvdtbiVjwafyoapPmGbCVxr5U+UUB
	TUX/R58Ly5fRmiHBObmPy1yVWzc6HbyTSQ6Jg7QETvUyh6ixiJH/qK/48/RobLMrkoF/nB7PYLAxr
	Q56IHLTtsGmSq/KI6f9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKh3-0001JW-UG; Wed, 23 Jan 2019 15:43:57 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKh0-0001Iw-9s
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:43:55 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmKgu-0008R4-DT; Wed, 23 Jan 2019 16:43:48 +0100
Message-ID: <1548258228.28802.5.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/5] dma: imx-sdma: add clock ratio 1:1 check
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Wed, 23 Jan 2019 16:43:48 +0100
In-Reply-To: <20190123152310.11680-2-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-2-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_074354_514961_FBF2B294 
X-CRM114-Status: GOOD (  17.00  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAyMy4wMS4yMDE5LCAwODoyMyAtMDcwMCBzY2hyaWViIEFuZ3VzIEFp
bnNsaWUgKFB1cmlzbSk6Cj4gT24gaS5teDggbXNjYWxlIEIwIGNoaXAsIEFIQi9TRE1BIGNsb2Nr
IHJhdGlvIDI6MSBjYW4ndCBiZSBzdXBwb3J0dGVkLAo+IHNpbmNlIFNETUEgY2xvY2sgcmF0aW8g
aGFzIHRvIGJlIGluY3JlYXNlZCB0byAyNTBNaHosIEFIQiBjYW4ndCByZWFjaAo+IHRvIDUwME1o
eiwgc28gdXNlIDE6MSBpbnN0ZWFkLgo+IAo+ID4gQmFzZWQgb24gTlhQIGNvbW1pdCBNTEstMTY4
NDEtMSBieSBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+Cj4gCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbmd1cyBBaW5zbGllIChQdXJpc20pIDxhbmd1c0Bha2tlYS5jYT4KPiAtLS0KPiDCoGRy
aXZlcnMvZG1hL2lteC1zZG1hLmMgfCAyMyArKysrKysrKysrKysrKysrKysrLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jCj4g
aW5kZXggMGIzYTY3ZmY4ZTgyLi41MzFhOWQ4YjAzMmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9k
bWEvaW14LXNkbWEuYwo+ICsrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKPiBAQCAtNDQwLDYg
KzQ0MCw4IEBAIHN0cnVjdCBzZG1hX2VuZ2luZSB7Cj4gPiA+IMKgCXVuc2lnbmVkIGludAkJCWly
cTsKPiA+ID4gwqAJZG1hX2FkZHJfdAkJCWJkMF9waHlzOwo+ID4gPiDCoAlzdHJ1Y3Qgc2RtYV9i
dWZmZXJfZGVzY3JpcHRvcgkqYmQwOwo+ID4gKwkvKiBjbG9jayByYXRpbyBmb3IgQUhCOlNETUEg
Y29yZS4gMToxIGlzIDEsIDI6MSBpcyAwKi8KPiA+ID4gKwlib29sCQkJCWNsa19yYXRpbzsKPiDC
oH07Cj4gwqAKPiDCoHN0YXRpYyBpbnQgc2RtYV9jb25maWdfd3JpdGUoc3RydWN0IGRtYV9jaGFu
ICpjaGFuLAo+IEBAIC02NjIsOCArNjY0LDE0IEBAIHN0YXRpYyBpbnQgc2RtYV9ydW5fY2hhbm5l
bDAoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hKQo+ID4gwqAJCWRldl9lcnIoc2RtYS0+ZGV2LCAi
VGltZW91dCB3YWl0aW5nIGZvciBDSDAgcmVhZHlcbiIpOwo+IMKgCj4gPiDCoAkvKiBTZXQgYml0
cyBvZiBDT05GSUcgcmVnaXN0ZXIgd2l0aCBkeW5hbWljIGNvbnRleHQgc3dpdGNoaW5nICovCj4g
PiAtCWlmIChyZWFkbChzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJRykgPT0gMCkKPiA+IC0JCXdy
aXRlbF9yZWxheGVkKFNETUFfSF9DT05GSUdfQ1NNLCBzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJ
Ryk7Cj4gKwlpZiAocmVhZGwoc2RtYS0+cmVncyArIFNETUFfSF9DT05GSUcpID09IDApIHsKCklm
IHRoZSBBQ1IgYml0IGdldHMgc2V0IGluIHNkbWFfaW5pdCgpLCBkbyB3ZSBldmVyIGVuZCB1cCBp
biB0aGlzIGNvZGUKcGF0aD8gRnJvbSBhIHF1aWNrIGdsYW5jZSBpdCBzZWVtcyB3ZSBtaWdodCB3
cm9uZ2Z1bGx5IHNraXAgdGhlIENTTQplbmFibGUgaGVyZS4KCj4gKwkJaWYgKHNkbWEtPmNsa19y
YXRpbykKPiA+ICsJCQlyZWcgPSBTRE1BX0hfQ09ORklHX0NTTSB8IFNETUFfSF9DT05GSUdfQUNS
Owo+ID4gKwkJZWxzZQo+ICsJCQlyZWcgPSBTRE1BX0hfQ09ORklHX0NTTTsKClRoYXQncyBhIHBl
cnNvbmFsIHN0eWxlIHByZWZlcmVuY2UsIGJ1dCBJIHdvdWxkIHdyaXRlIHRoaXMgYXM6CgpyZWcg
PSBTRE1BX0hfQ09ORklHX0NTTTsKCmlmIChzZG1hLT5jbGtfcmF0aW8pOwoJcmVnIHw9IFNETUFf
SF9DT05GSUdfQUNSOwoKPiArCj4gPiArCQl3cml0ZWxfcmVsYXhlZChyZWcsIHNkbWEtPnJlZ3Mg
KyBTRE1BX0hfQ09ORklHKTsKPiA+ICsJfQo+IMKgCj4gPiDCoAlyZXR1cm4gcmV0Owo+IMKgfQo+
IEBAIC0xODQwLDYgKzE4NDgsMTEgQEAgc3RhdGljIGludCBzZG1hX2luaXQoc3RydWN0IHNkbWFf
ZW5naW5lICpzZG1hKQo+ID4gwqAJaWYgKHJldCkKPiA+IMKgCQlnb3RvIGRpc2FibGVfY2xrX2lw
ZzsKPiDCoAo+ID4gKwlpZiAoY2xrX2dldF9yYXRlKHNkbWEtPmNsa19haGIpID09IGNsa19nZXRf
cmF0ZShzZG1hLT5jbGtfaXBnKSkKPiA+ICsJCXNkbWEtPmNsa19yYXRpbyA9IDE7Cj4gPiArCWVs
c2UKPiArCQlzZG1hLT5jbGtfcmF0aW8gPSAwOwoKc2RtYSBpcyB6ZXJvZWQgYXQgYWxsb2NhdGlv
biwgc28gdGhlIGVsc2UgcGF0aCBoZXJlIGlzbid0IG5lY2Vzc2FyeS4KCj4gKwo+ID4gwqAJLyog
QmUgc3VyZSBTRE1BIGhhcyBub3Qgc3RhcnRlZCB5ZXQgKi8KPiA+IMKgCXdyaXRlbF9yZWxheGVk
KDAsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQzBQVFIpOwo+IMKgCj4gQEAgLTE4ODAsOCArMTg5Mywx
MCBAQCBzdGF0aWMgaW50IHNkbWFfaW5pdChzdHJ1Y3Qgc2RtYV9lbmdpbmUgKnNkbWEpCj4gPiDC
oAl3cml0ZWxfcmVsYXhlZCgweDQwNTAsIHNkbWEtPnJlZ3MgKyBTRE1BX0NITjBBRERSKTsKPiDC
oAo+ID4gwqAJLyogU2V0IGJpdHMgb2YgQ09ORklHIHJlZ2lzdGVyIGJ1dCB3aXRoIHN0YXRpYyBj
b250ZXh0IHN3aXRjaGluZyAqLwo+ID4gLQkvKiBGSVhNRTogQ2hlY2sgd2hldGhlciB0byBzZXQg
QUNSIGJpdCBkZXBlbmRpbmcgb24gY2xvY2sgcmF0aW9zICovCj4gPiAtCXdyaXRlbF9yZWxheGVk
KDAsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklHKTsKPiA+ICsJaWYgKHNkbWEtPmNsa19yYXRp
bykKPiA+ICsJCXdyaXRlbF9yZWxheGVkKFNETUFfSF9DT05GSUdfQUNSLCBzZG1hLT5yZWdzICsg
U0RNQV9IX0NPTkZJRyk7Cj4gPiArCWVsc2UKPiA+ICsJCXdyaXRlbF9yZWxheGVkKDAsIHNkbWEt
PnJlZ3MgKyBTRE1BX0hfQ09ORklHKTsKPiDCoAo+ID4gwqAJd3JpdGVsX3JlbGF4ZWQoY2NiX3Bo
eXMsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQzBQVFIpOwo+IMKgCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

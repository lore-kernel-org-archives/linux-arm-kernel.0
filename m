Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1CC282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B5F2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PlRYmuHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B5F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yxWwVDuw1sMcSwIDuLygWb0lB50Ac5v91Q8eikM5CjQ=; b=PlRYmuHCQ+EyZ5
	thOBQN7Nj4RDYITny3QM+OmOaEYDh68XOYiMT3haHT/+9XRm/Cr8TWOgBPgbg08bMAt7NLI0vX5AH
	v5gF2AbTh8xZeuGst/zNDOkLtiLkI0+2Dl1HVM864NUUyuzbb8JotpV8MOA/S7CQILHU65lvgmNaR
	3V07b+JkCM7RqrzMTPEw6my1x2tISsoI0aF24d49by982eIVc/UOTKM9RWLG9Klia2pouLGCA5Mc/
	7Z5nWljysuHwAz1kGJGEqA2FLCmhRfi5mzDtxjfJcxkymhIySmyUJFpTW1IgIPy9reM4LKQX6L4Z6
	wtoohaPMl1Ym0vBDOlkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glViM-00080j-UX; Mon, 21 Jan 2019 09:17:54 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glViJ-0007z9-G7
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:17:53 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1glViB-0007tO-OZ; Mon, 21 Jan 2019 10:17:43 +0100
Message-ID: <1548062262.2465.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Mon, 21 Jan 2019 10:17:42 +0100
In-Reply-To: <20190120023150.17138-3-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-3-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_011751_707194_0D07070F 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQW5ndXMsCgpBbSBTYW1zdGFnLCBkZW4gMTkuMDEuMjAxOSwgMTk6MzEgLTA3MDAgc2Nocmll
YiBBbmd1cyBBaW5zbGllIChQdXJpc20pOgo+IE9uIGkubXg4IG1zY2FsZSBCMCBjaGlwLCBBSEIv
U0RNQSBjbG9jayByYXRpbyAyOjEgY2FuJ3QgYmUgc3VwcG9ydHRlZCwKPiBzaW5jZSBTRE1BIGNs
b2NrIHJhdGlvIGhhcyB0byBiZSBpbmNyZWFzZWQgdG8gMjUwTWh6LCBBSEIgY2FuJ3QgcmVhY2gK
PiB0byA1MDBNaHosIHNvIHVzZSAxOjEgaW5zdGVhZC4KPiAKPiBiYXNlZCBvbiBOWFAgY29tbWl0
IE1MSy0xNjg0MS0xCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBBaW5zbGllIChQdXJpc20p
IDxhbmd1c0Bha2tlYS5jYT4KPiAtLS0KPiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9m
c2wtaW14LXNkbWEudHh0wqDCoHzCoMKgMSArCj4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCAyMCArKysrKysr
KysrKysrKystLS0tCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dAo+IGluZGV4IDNjOWE1N2E4NDQzYi4uMTc1NDRjMTgy
MGI3IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEv
ZnNsLWlteC1zZG1hLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kbWEvZnNsLWlteC1zZG1hLnR4dAo+IEBAIC02Nyw2ICs2Nyw3IEBAIE9wdGlvbmFsIHByb3Bl
cnRpZXM6Cj4gwqDCoMKgwqDCoHJlZyBpcyB0aGUgR1BSIHJlZ2lzdGVyIG9mZnNldC4KPiDCoMKg
wqDCoMKgc2hpZnQgaXMgdGhlIGJpdCBwb3NpdGlvbiBpbnNpZGUgdGhlIEdQUiByZWdpc3Rlci4K
PiDCoMKgwqDCoMKgdmFsIGlzIHRoZSB2YWx1ZSBvZiB0aGUgYml0ICgwIG9yIDEpLgo+ICstIGZz
bCxyYXRpby0xLTE6IEFIQi9TRE1BIGNvcmUgY2xvY2sgcmF0aW9uIDE6MSwgMjoxIHdpdGhvdXQg
dGhpcy4KCldoeSBkb2VzIHRoaXMgbmVlZCBhIHNlcGFyYXRlIERUIHByb3BlcnR5PyBTaG91bGRu
J3QgdGhlIGRyaXZlciBiZSBhYmxlCnRvIGluZmVyIHRoaXMgZnJvbSB0aGUgY2xvY2sgcmF0ZXMg
Z29pbmcgaW50byB0aGUgU0RNQSBoYXJkd2FyZT8KClJlZ2FyZHMsCkx1Y2FzCgo+IMKgRXhhbXBs
ZXM6Cj4gwqAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMv
ZG1hL2lteC1zZG1hLmMKPiBpbmRleCAwYjNhNjdmZjhlODIuLjY1ZGFkYTIxZDNjMSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jCj4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNk
bWEuYwo+IEBAIC00NDAsNiArNDQwLDggQEAgc3RydWN0IHNkbWFfZW5naW5lIHsKPiA+ID4gwqAJ
dW5zaWduZWQgaW50CQkJaXJxOwo+ID4gPiDCoAlkbWFfYWRkcl90CQkJYmQwX3BoeXM7Cj4gPiA+
IMKgCXN0cnVjdCBzZG1hX2J1ZmZlcl9kZXNjcmlwdG9yCSpiZDA7Cj4gPiArCS8qIGNsb2NrIHJh
dGlvIGZvciBBSEI6U0RNQSBjb3JlLiAxOjEgaXMgMSwgMjoxIGlzIDAqLwo+ID4gPiArCWJvb2wJ
CQkJY2xrX3JhdGlvOwo+IMKgfTsKPiDCoAo+IMKgc3RhdGljIGludCBzZG1hX2NvbmZpZ193cml0
ZShzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sCj4gQEAgLTY2Miw4ICs2NjQsMTQgQEAgc3RhdGljIGlu
dCBzZG1hX3J1bl9jaGFubmVsMChzdHJ1Y3Qgc2RtYV9lbmdpbmUgKnNkbWEpCj4gPiDCoAkJZGV2
X2VycihzZG1hLT5kZXYsICJUaW1lb3V0IHdhaXRpbmcgZm9yIENIMCByZWFkeVxuIik7Cj4gwqAK
PiA+IMKgCS8qIFNldCBiaXRzIG9mIENPTkZJRyByZWdpc3RlciB3aXRoIGR5bmFtaWMgY29udGV4
dCBzd2l0Y2hpbmcgKi8KPiA+IC0JaWYgKHJlYWRsKHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklH
KSA9PSAwKQo+ID4gLQkJd3JpdGVsX3JlbGF4ZWQoU0RNQV9IX0NPTkZJR19DU00sIHNkbWEtPnJl
Z3MgKyBTRE1BX0hfQ09ORklHKTsKPiA+ICsJaWYgKHJlYWRsKHNkbWEtPnJlZ3MgKyBTRE1BX0hf
Q09ORklHKSA9PSAwKSB7Cj4gPiArCQlpZiAoc2RtYS0+Y2xrX3JhdGlvKQo+ID4gKwkJCXJlZyA9
IFNETUFfSF9DT05GSUdfQ1NNIHwgU0RNQV9IX0NPTkZJR19BQ1I7Cj4gPiArCQllbHNlCj4gPiAr
CQkJcmVnID0gU0RNQV9IX0NPTkZJR19DU007Cj4gKwo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQocmVn
LCBzZG1hLT5yZWdzICsgU0RNQV9IX0NPTkZJRyk7Cj4gPiArCX0KPiDCoAo+ID4gwqAJcmV0dXJu
IHJldDsKPiDCoH0KPiBAQCAtMTg4MCw4ICsxODg4LDEwIEBAIHN0YXRpYyBpbnQgc2RtYV9pbml0
KHN0cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSkKPiA+IMKgCXdyaXRlbF9yZWxheGVkKDB4NDA1MCwg
c2RtYS0+cmVncyArIFNETUFfQ0hOMEFERFIpOwo+IMKgCj4gPiDCoAkvKiBTZXQgYml0cyBvZiBD
T05GSUcgcmVnaXN0ZXIgYnV0IHdpdGggc3RhdGljIGNvbnRleHQgc3dpdGNoaW5nICovCj4gPiAt
CS8qIEZJWE1FOiBDaGVjayB3aGV0aGVyIHRvIHNldCBBQ1IgYml0IGRlcGVuZGluZyBvbiBjbG9j
ayByYXRpb3MgKi8KPiA+IC0Jd3JpdGVsX3JlbGF4ZWQoMCwgc2RtYS0+cmVncyArIFNETUFfSF9D
T05GSUcpOwo+ID4gKwlpZiAoc2RtYS0+Y2xrX3JhdGlvKQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQo
U0RNQV9IX0NPTkZJR19BQ1IsIHNkbWEtPnJlZ3MgKyBTRE1BX0hfQ09ORklHKTsKPiA+ICsJZWxz
ZQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQoMCwgc2RtYS0+cmVncyArIFNETUFfSF9DT05GSUcpOwo+
IMKgCj4gPiDCoAl3cml0ZWxfcmVsYXhlZChjY2JfcGh5cywgc2RtYS0+cmVncyArIFNETUFfSF9D
MFBUUik7Cj4gwqAKPiBAQCAtMTk3NSw2ICsxOTg1LDggQEAgc3RhdGljIGludCBzZG1hX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiDCoAlpZiAoIXNkbWEpCj4gPiDCoAkJ
cmV0dXJuIC1FTk9NRU07Cj4gwqAKPiA+ICsJc2RtYS0+Y2xrX3JhdGlvID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKG5wLCAiZnNsLHJhdGlvLTEtMSIpOwo+ICsKPiA+IMKgCXNwaW5fbG9ja19pbml0
KCZzZG1hLT5jaGFubmVsXzBfbG9jayk7Cj4gwqAKPiA+IMKgCXNkbWEtPmRldiA9ICZwZGV2LT5k
ZXY7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==

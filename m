Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C75C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:11:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83E2218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sdrGPMeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83E2218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hROHMiBnvr6gbxtDAbmTWoGZgIVY542jLcJF05keTDo=; b=sdrGPMeFZCSuYj
	Eqhv802BWdsxULGL5RTCQqIkZ3C+uD+P1U9RHvghcVSq9HB9gzpZK4d3IeaXugjIDND7M3wkigfLD
	4TsqEkIeLxSDSTfUg7ZD6A2jJJJbhiQ0SjwTswxCyLVNQbH5g9z5J+McZomb+3gJ/5rqjlre5bdRO
	pmdv0Y8Isc4bBgRQiuig++A1S+WtWjTQMaFZIgWyW+BUs42/x/A4Hm06XjRfdE27A/M6yYl/mt8ki
	r2x/afI8o0SFCz08CagjtCheDTX5gqIg8s0zCHhSbZcct3CsC/NXCHZ4cfQj9FTwz2bD99DSdYnK1
	EJP6LlWwsF1hTRb7KghQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqaX-0000cF-AT; Wed, 30 Jan 2019 14:11:37 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqaT-0000bW-EP
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 14:11:35 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1goqaO-0002Hf-7t; Wed, 30 Jan 2019 15:11:28 +0100
Message-ID: <1548857486.6869.31.camel@pengutronix.de>
Subject: Re: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Dong Aisheng <dongas86@gmail.com>
Date: Wed, 30 Jan 2019 15:11:26 +0100
In-Reply-To: <CAA+hA=Q79RcUk=epBighR_jZCLxaNzRvc9Lukzrzby_Av6d9wQ@mail.gmail.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-5-git-send-email-aisheng.dong@nxp.com>
 <1548855138.6869.27.camel@pengutronix.de>
 <CAA+hA=Q79RcUk=epBighR_jZCLxaNzRvc9Lukzrzby_Av6d9wQ@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_061133_637330_8B05273D 
X-CRM114-Status: GOOD (  25.61  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAzMC4wMS4yMDE5LCAyMjowMyArMDgwMCBzY2hyaWViIERvbmcgQWlz
aGVuZzoKPiA+IE9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDk6MzMgUE0gTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+ID4gCj4gPiBBbSBNaXR0d29jaCwgZGVuIDMw
LjAxLjIwMTksIDEzOjA2ICswMDAwIHNjaHJpZWIgQWlzaGVuZyBEb25nOgo+ID4gPiBPbmUgaXJx
c3RlZXIgY2hhbm5lbCBjYW4gc3VwcG9ydCB1cCB0byA4IG91dHB1dCBpbnRlcnJ1cHRzLgo+ID4g
PiAKPiA+ID4gPiA+ID4gPiA+IENjOiBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29t
Pgo+ID4gPiA+ID4gPiA+ID4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Pgo+ID4gPiA+ID4gPiA+ID4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+
ID4gPiAKPiA+ID4gLS0tCj4gPiA+IENoYW5nZUxvZzoKPiA+ID4gdjEtPnYyOgo+ID4gPiDCoCog
Y2FsY3VsYXRlIGlycV9jb3VudCBieSBmc2wsbnVtLWlycXMgaW5zdGVhZCBvZiBwYXJzaW5nIGlu
dGVycnVwdHMKPiA+ID4gwqDCoMKgcHJvcGVydHkgZnJvbSBkZXZpY2V0cmVlIHRvIG1hdGNoIHRo
ZSBpbnB1dCBpbnRlcnJ1cHRzIGFuZCBvdXRwdXRzCj4gPiA+IMKgKiBpbXByb3ZlIG91dHB1dCBp
bnRlcnJ1cHQgaGFuZGxlciBieSBzZWFyY2hpbmcgb25seSB0d28gcmVnaXN0ZXJzCj4gPiA+IMKg
wqDCoHdpdGhpbnQgdGhlIHNhbWUgZ3JvdXAKPiA+ID4gLS0tCj4gPiA+IMKgZHJpdmVycy9pcnFj
aGlwL2lycS1pbXgtaXJxc3RlZXIuYyB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDE3IGRl
bGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEt
aW14LWlycXN0ZWVyLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jCj4gPiA+
IGluZGV4IDY3ZWQ4NjIuLmNjNDAwMzkgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hp
cC9pcnEtaW14LWlycXN0ZWVyLmMKPiA+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgt
aXJxc3RlZXIuYwo+ID4gPiBAQCAtMTAsNiArMTAsNyBAQAo+ID4gPiDCoCNpbmNsdWRlIDxsaW51
eC9pcnFjaGlwL2NoYWluZWRfaXJxLmg+Cj4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFp
bi5oPgo+ID4gPiDCoCNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiA+ID4gKyNpbmNsdWRlIDxs
aW51eC9vZl9pcnEuaD4KPiA+ID4gwqAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4KPiA+
ID4gwqAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KPiA+ID4gCj4gPiA+IEBAIC0yMSwxMCAr
MjIsMTMgQEAKPiA+ID4gPiDCoCNkZWZpbmUgQ0hBTl9NSU5URElTKHQpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKENUUkxfU1RSSURFX09GRih0LCAzKSArIDB4NCkKPiA+ID4gPiDCoCNkZWZpbmUg
Q0hBTl9NQVNUUlNUQVQodCnCoMKgKENUUkxfU1RSSURFX09GRih0LCAzKSArIDB4OCkKPiA+ID4g
PiArI2RlZmluZSBDSEFOX01BWF9PVVRQVVRfSU5UwqDCoMKgwqDCoMKgwqDCoDB4OAo+ID4gPiAK
PiA+ID4gKwo+ID4gPiDCoHN0cnVjdCBpcnFzdGVlcl9kYXRhIHsKPiA+ID4gPiA+IMKgIHZvaWQg
X19pb21lbcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCpyZWdzOwo+ID4gPiA+ID4gwqAgc3RydWN0
IGNsa8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqaXBnX2NsazsKPiA+ID4gPiA+IC0gaW50
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXJxOwo+ID4gPiA+ID4g
KyBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcnFbQ0hBTl9N
QVhfT1VUUFVUX0lOVF07Cj4gPiA+ID4gPiArIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlycV9jb3VudDsKPiA+ID4gPiA+IMKgIHJhd19zcGlubG9ja190wqDC
oMKgwqDCoMKgwqDCoMKgwqBsb2NrOwo+ID4gPiA+ID4gwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnX251bTsKPiA+ID4gPiA+IMKgIGludMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoYW5uZWw7Cj4gPiA+IAo+ID4gPiBA
QCAtODcsMjYgKzkxLDQ1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaXJxX2RvbWFpbl9vcHMgaW14
X2lycXN0ZWVyX2RvbWFpbl9vcHMgPSB7Cj4gPiA+ID4gPiDCoCAueGxhdGXCoMKgwqDCoMKgwqDC
oMKgwqDCoD0gaXJxX2RvbWFpbl94bGF0ZV9vbmVjZWxsLAo+ID4gPiAKPiA+ID4gwqB9Owo+ID4g
PiAKPiA+ID4gK3N0YXRpYyBpbnQgaW14X2lycXN0ZWVyX2dldF9od2lycV9iYXNlKHN0cnVjdCBp
cnFzdGVlcl9kYXRhICpkYXRhLCB1MzIgaXJxKQo+ID4gPiArewo+ID4gPiA+ICvCoMKgwqBpbnQg
aTsKPiA+ID4gCj4gPiA+ICsKPiA+ID4gPiArwqDCoMKgZm9yIChpID0gMDsgaSA8IGRhdGEtPmly
cV9jb3VudDsgaSsrKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZGF0YS0+
aXJxW2ldID09IGlycSkKPiA+ID4gCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBicmVhazsKPiA+IAo+ID4gcmV0dXJuIGkgKiA2NDsgaGVyZS4uLgo+ID4g
PiArwqDCoMKgwqDCoH0KPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoHJldHVybiBpICogNjQ7Cj4g
PiAKPiA+IC4uLiBhbmQgLUVJTlZBTCBvciBzb21ldGhpbmcgaGVyZSwgc28gd2UgZG9uJ3QgcmV0
dXJuIGEgb3V0IG9mIGJvdW5kcwo+ID4gaHdpcnEgYmFzZSBpZiB0aGUgbG9vcCBldmVyIGRvZXNu
J3QgbWF0Y2ggc29tZXRoaW5nPwo+ID4gCj4gCj4gR29vZCBzdWdnZXN0aW9uLCB3aWxsIGFkZCBp
dC4KPiAKPiA+ID4gK30KPiA+ID4gKwo+ID4gPiDCoHN0YXRpYyB2b2lkIGlteF9pcnFzdGVlcl9p
cnFfaGFuZGxlcihzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpCj4gPiA+IMKgewo+ID4gPiA+IMKgwqDC
oMKgc3RydWN0IGlycXN0ZWVyX2RhdGEgKmRhdGEgPSBpcnFfZGVzY19nZXRfaGFuZGxlcl9kYXRh
KGRlc2MpOwo+ID4gPiA+ICvCoMKgwqBpbnQgaHdpcnE7Cj4gPiA+ID4gwqDCoMKgwqBpbnQgaTsK
PiA+ID4gPiDCoMKgwqDCoGNoYWluZWRfaXJxX2VudGVyKGlycV9kZXNjX2dldF9jaGlwKGRlc2Mp
LCBkZXNjKTsKPiA+ID4gPiAtwqDCoMKgZm9yIChpID0gMDsgaSA8IGRhdGEtPnJlZ19udW0gKiAz
MjsgaSArPSAzMikgewo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IGlkeCA9IGlt
eF9pcnFzdGVlcl9nZXRfcmVnX2luZGV4KGRhdGEsIGkpOwo+ID4gPiA+ICvCoMKgwqBod2lycSA9
IGlteF9pcnFzdGVlcl9nZXRfaHdpcnFfYmFzZShkYXRhLCBpcnFfZGVzY19nZXRfaXJxKGRlc2Mp
KTsKPiA+ID4gCj4gPiA+ICsKPiA+ID4gPiArwqDCoMKgZm9yIChpID0gMDsgaSA8IDI7IGkrKykg
ewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IGlkeCA9IGlteF9pcnFzdGVlcl9n
ZXRfcmVnX2luZGV4KGRhdGEsIGh3aXJxKTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBsb25nIGlycW1hcDsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
bnQgcG9zLCB2aXJxOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGh3aXJxID49
IGRhdGEtPnJlZ19udW0gKiAzMikKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBicmVhazsKPiA+ID4gCj4gPiA+ICsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpcnFtYXAgPSByZWFkbF9yZWxheGVkKGRhdGEtPnJlZ3MgKwo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBDSEFOU1RBVFVTKGlkeCwgZGF0YS0+cmVnX251bSkpOwo+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX3NldF9iaXQocG9zLCAmaXJxbWFwLCAzMikgewo+ID4g
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHZpcnEgPSBpcnFfZmlu
ZF9tYXBwaW5nKGRhdGEtPmRvbWFpbiwgcG9zICsgaSk7Cj4gPiA+IAo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmlycSA9IGlycV9maW5kX21hcHBpbmco
ZGF0YS0+ZG9tYWluLCBwb3MgKyBod2lycSk7Cj4gPiAKPiA+IFRoZSBpcnEgaW5kZXggY2FsY3Vs
YXRpb24gbmVlZCB0byBiZSAicG9zICsgaSAqIDMyICsgaHdpcnEiLCBvdGhlcndpc2UKPiA+IHRo
aXMgd2lsbCBtYXAgdG8gdGhlIHdyb25nIHZpcnFzIGZvciB0aGUgc2Vjb25kIHJlZ2lzdGVyIGlu
IGVhY2ggZ3JvdXAuCj4gPiAKPiAKPiBGb3Igc2Vjb25kIHJlZ2lzdGVyIG1hcCwgaHdpcnEgd2ls
bCBwbHVzIDMyIGluIG5leHQgcm91bmQuCj4gU28gaSBjYW4ndCBzZWUgdGhpcyB3aWxsIG1hcCBh
IHdyb25nIHZpcnFzLgo+IEFuZCBpdCBsb29rcyB0byBtZSAiInBvcyArIGkgKiAzMiArIGh3aXJx
IiBpcyBlcXVhbCB0byAiaHdpcnEgKyAzMiIuCj4gQW0gaSBtaXNzZWQgc29tZXRoaW5nPwoKWW91
IGFyZSByaWdodCwgSSBmb3Jnb3QgYWJvdXQgdGhlIGh3aXJxIGJlaW5nIGluY3JlbWVudGVkIGlu
IHRoZSBsb29wCndoZW4gd3JpdGluZyB0aGlzIGNvbW1lbnQuCgo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2aXJxKQo+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ2VuZXJpY19o
YW5kbGVfaXJxKHZpcnEpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4g
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGh3aXJxICs9IDMyOwo+ID4gCj4gPiBD
b3VsZCBiZSBmb2xkZWQgaW50byB0aGUgbG9vcCBoZWFkLgo+ID4gCj4gCj4gWW91IG1lYW4g4oCc
Zm9yIChpID0gMDsgaSA8IDI7IGkrKywgaHdpcnEgKz0zMinigJ0gPwo+IEkgZmVlbCB0aGF0J3Mg
bm90IHF1aXRlIG5lY2Vzc2FyeS4KCkkgcGVyc29uYWxseSBmaW5kIHRoYXQgcXVpdGUgYSBiaXQg
Y2xlYXJlciB0aGFuIGluY3JlbWVudGluZyB0aGUgbG9vcAp2YXJpYWJsZXMgYXQgZGlmZmVyZW50
IHNwb3RzLiBBbmQgSSBwcm9iYWJseSB3b3VsZG4ndCBoYXZlIG1pc3NlZCBod2lycQpiZWluZyBp
bmNyZW1lbnRlZCBpbiB0aGUgbG9vcCBpZiBJIGhhZCBzZWVuIGl0IGluIHRoZSBoZWFkLgoKUmVn
YXJkcywKTHVjYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK

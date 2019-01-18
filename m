Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C025C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:53:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2D620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S/MEmJog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2D620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wpbtnqGe1p2UTUUEatnLhJHAYYTMkAtuwOFayIAmjvI=; b=S/MEmJog53AQ1w
	6Qi2sJFTHvSt9mhZPlsBMLAcjAOpFyCsw8qQ49Pbi40oJoKYpoPDYQ2TjhgGWr9krE2B/KGLeaAjU
	glRdsOLUBsZ4/ARX38jnW+KrvRs6gUWz5MBfxtti8w1i/K/EFyC8tBiIif1dXeTA2OTk0TvAt+A5P
	XvVfOfhk4nIqWzFoE83QStI9yc+6jKIDcwrB6cFNlVtdHI3qBQHQqGrjCMxZq9LWmaUa3JVzpoxM6
	4zETZGUi6Zn+t7t2vHEtS0rRdPXDkDCdLUzTzSSCurG67wNGTfoJG3UCM83THrvwbl+4Mk8iZRO6G
	0sEba398mXAR2/xp6W9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPuC-0002FY-Rw; Fri, 18 Jan 2019 08:53:36 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPu8-0002Eu-Ra
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:53:34 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gkPu5-0008Pr-Js; Fri, 18 Jan 2019 09:53:29 +0100
Message-ID: <1547801609.2626.5.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 18 Jan 2019 09:53:29 +0100
In-Reply-To: <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_005333_042560_3B3AA663 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDE4LjAxLjIwMTksIDA3OjUzICswMDAwIHNjaHJpZWIgQWlzaGVuZyBE
b25nOgo+IE9uZSBpcnFzdGVlciBjaGFubmVsIGNhbiBzdXBwb3J0IHVwIHRvIDggb3V0cHV0IGlu
dGVycnVwdHMuCgpUaGlzIGhhcyBiZWVuIGRpc2N1c3NlZCB3aGVuIHVwc3RyZWFtaW5nIHRoZSBk
cml2ZXIuIFRoZSBjb250cm9sbGVyIG1heQpzdXBwb3J0IG11bHRpcGxlIG91dHB1dCBJUlFzLCBi
dXQgb25seSBvbmUgdGhlbSBpcyBhY3R1YWxseSB1c2VkCmRlcGVuZGluZyBvbiB0aGUgQ0hBTkNU
UkwgY29uZmlnLiBUaGVyZSBpcyBubyB1c2UgaW4gaG9va2luZyB1cCBhbGwgdGhlCm91dHB1dCBJ
UlFzIGluIERULCBpZiBvbmx5IG9uZSBvZiB0aGVtIGlzIGFjdHVhbGx5IHVzZWQuIFNvbWUgb2Yg
dGhlCm91dHB1dHMgbWF5IG5vdCBldmVuIGJlIHZpc2libGUgdG8gdGhlIExpbnV4IHN5c3RlbSwg
YnV0IG1heSBiZWxvbmcgdG8KYSBDb3J0ZXggTTQgc3Vic3lzdGVtLiBBbGwgb2YgdGhvc2UgY29u
ZmlndXJhdGlvbnMgY2FuIGJlIGRlc2NyaWJlZCBpbgpEVCBieSBjaGFuZ2luZyB0aGUgdXBzdHJl
YW0gaW50ZXJydXB0IGFuZCAiZnNsLGNoYW5uZWwiIGluIGEgY29oZXJlbnQKd2F5LgoKUGxlYXNl
IGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyB0b3RhbGx5IHdyb25nLgoKUmVnYXJk
cywKTHVjYXMKCj4gQ2M6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+Cj4gPiBD
YzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cj4gPiBDYzogU2hhd24gR3Vv
IDxzaGF3bmd1b0BrZXJuZWwub3JnPgo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWly
cXN0ZWVyLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jIGIvZHJpdmVycy9p
cnFjaGlwL2lycS1pbXgtaXJxc3RlZXIuYwo+IGluZGV4IDFiZWJmMGEuLjU0ODAyZmEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtaXJxc3RlZXIuYwo+ICsrKyBiL2RyaXZl
cnMvaXJxY2hpcC9pcnEtaW14LWlycXN0ZWVyLmMKPiBAQCAtMTAsNiArMTAsNyBAQAo+IMKgI2lu
Y2x1ZGUgPGxpbnV4L2lycWNoaXAvY2hhaW5lZF9pcnEuaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9p
cnFkb21haW4uaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiArI2luY2x1ZGUgPGxp
bnV4L29mX2lycS5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+Cj4gwqAjaW5j
bHVkZSA8bGludXgvc3BpbmxvY2suaD4KPiDCoAo+IEBAIC0yMSwxMCArMjIsMTMgQEAKPiA+IMKg
I2RlZmluZSBDSEFOX01JTlRESVModCkJCShDVFJMX1NUUklERV9PRkYodCwgMykgKyAweDQpCj4g
PiDCoCNkZWZpbmUgQ0hBTl9NQVNUUlNUQVQodCkJKENUUkxfU1RSSURFX09GRih0LCAzKSArIDB4
OCkKPiDCoAo+ID4gKyNkZWZpbmUgQ0hBTl9NQVhfT1VUUFVUX0lOVAkweDgKPiArCj4gwqBzdHJ1
Y3QgaXJxc3RlZXJfZGF0YSB7Cj4gPiA+IMKgCXZvaWQgX19pb21lbQkJKnJlZ3M7Cj4gPiA+IMKg
CXN0cnVjdCBjbGsJCSppcGdfY2xrOwo+ID4gPiAtCWludAkJCWlycTsKPiA+ID4gKwlpbnQJCQlp
cnFbQ0hBTl9NQVhfT1VUUFVUX0lOVF07Cj4gPiA+ICsJaW50CQkJaXJxX2NvdW50Owo+ID4gPiDC
oAlyYXdfc3BpbmxvY2tfdAkJbG9jazsKPiA+ID4gwqAJaW50CQkJcmVnX251bTsKPiA+ID4gwqAJ
aW50CQkJY2hhbm5lbDsKPiBAQCAtMTE3LDcgKzEyMSw3IEBAIHN0YXRpYyBpbnQgaW14X2lycXN0
ZWVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiDCoAlzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7Cj4gPiDCoAlzdHJ1Y3QgaXJxc3RlZXJf
ZGF0YSAqZGF0YTsKPiA+IMKgCXN0cnVjdCByZXNvdXJjZSAqcmVzOwo+ID4gLQlpbnQgcmV0Owo+
ID4gKwlpbnQgaSwgcmV0Owo+IMKgCj4gPiDCoAlkYXRhID0gZGV2bV9remFsbG9jKCZwZGV2LT5k
ZXYsIHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOwo+ID4gwqAJaWYgKCFkYXRhKQo+IEBAIC0x
MzAsMTIgKzEzNCw2IEBAIHN0YXRpYyBpbnQgaW14X2lycXN0ZWVyX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiDCoAkJcmV0dXJuIFBUUl9FUlIoZGF0YS0+cmVncyk7Cj4g
PiDCoAl9Cj4gwqAKPiA+IC0JZGF0YS0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsK
PiA+IC0JaWYgKGRhdGEtPmlycSA8PSAwKSB7Cj4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gZ2V0IGlycVxuIik7Cj4gPiAtCQlyZXR1cm4gLUVOT0RFVjsKPiA+IC0JfQo+IC0K
PiA+IMKgCWRhdGEtPmlwZ19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImlwZyIpOwo+
ID4gwqAJaWYgKElTX0VSUihkYXRhLT5pcGdfY2xrKSkgewo+ID4gwqAJCXJldCA9IFBUUl9FUlIo
ZGF0YS0+aXBnX2Nsayk7Cj4gQEAgLTE3Nyw4ICsxNzUsMjMgQEAgc3RhdGljIGludCBpbXhfaXJx
c3RlZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgCQlyZXR1cm4g
LUVOT01FTTsKPiA+IMKgCX0KPiDCoAo+ID4gLQlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRf
ZGF0YShkYXRhLT5pcnEsIGlteF9pcnFzdGVlcl9pcnFfaGFuZGxlciwKPiA+IC0JCQkJCcKgZGF0
YSk7Cj4gPiArCWRhdGEtPmlycV9jb3VudCA9IG9mX2lycV9jb3VudChucCk7Cj4gPiArCWlmICgh
ZGF0YS0+aXJxX2NvdW50IHx8IGRhdGEtPmlycV9jb3VudCA+IENIQU5fTUFYX09VVFBVVF9JTlQp
IHsKPiA+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRhLT5pcGdfY2xrKTsKPiA+ICsJCXJl
dHVybiAtRUlOVkFMOwo+ID4gKwl9Cj4gKwo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgZGF0YS0+aXJx
X2NvdW50OyBpKyspIHsKPiA+ICsJCWRhdGEtPmlycVtpXSA9IGlycV9vZl9wYXJzZV9hbmRfbWFw
KG5wLCBpKTsKPiA+ICsJCWlmICghZGF0YS0+aXJxW2ldKSB7Cj4gPiArCQkJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGRhdGEtPmlwZ19jbGspOwo+ID4gKwkJCXJldHVybiAtRUlOVkFMOwo+ID4gKwkJ
fQo+ICsKPiA+ICsJCWlycV9zZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKGRhdGEtPmlycVtp
XSwKPiA+ICsJCQkJCQnCoGlteF9pcnFzdGVlcl9pcnFfaGFuZGxlciwKPiA+ICsJCQkJCQnCoGRh
dGEpOwo+ID4gKwl9Cj4gwqAKPiA+IMKgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGRhdGEp
Owo+IMKgCj4gQEAgLTE4OCw4ICsyMDEsMTIgQEAgc3RhdGljIGludCBpbXhfaXJxc3RlZXJfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiDCoHN0YXRpYyBpbnQgaW14X2lycXN0
ZWVyX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+IMKgewo+ID4gwqAJc3Ry
dWN0IGlycXN0ZWVyX2RhdGEgKmlycXN0ZWVyX2RhdGEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShw
ZGV2KTsKPiA+ICsJaW50IGk7Cj4gKwo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgaXJxc3RlZXJfZGF0
YS0+aXJxX2NvdW50OyBpKyspCj4gPiArCQlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0
YShpcnFzdGVlcl9kYXRhLT5pcnFbaV0sCj4gPiArCQkJCQkJwqBOVUxMLCBOVUxMKTsKPiDCoAo+
ID4gLQlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0YShpcnFzdGVlcl9kYXRhLT5pcnEs
IE5VTEwsIE5VTEwpOwo+ID4gwqAJaXJxX2RvbWFpbl9yZW1vdmUoaXJxc3RlZXJfZGF0YS0+ZG9t
YWluKTsKPiDCoAo+ID4gwqAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlycXN0ZWVyX2RhdGEtPmlw
Z19jbGspOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=

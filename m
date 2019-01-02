Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:27:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BD9218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UiHkZKG1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KUFtcbKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BD9218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZXFJH53/1oDEboIuPV88TUZVcYWcHbvUyl70icUohhI=; b=UiHkZKG10EQ3IUi8S9S5IYl5t
	SZu2sYrYrMIfJOMEo5okHDJ2KExrLMB18ArRI37/Q/L3Z7Ncv4kcSbJFzDc+IeChqaxN3l8p3UZ7g
	3eFCQNd68ggW5PEdWXbJv1Lm8I1+0zBgF8ofOGapcawk/Gs67E/uPyJX4x2QQBdcHsTH6A2QcZRCl
	nul5NbVIyFoDIECUKTaSB5sdDMc4VtRk94II1R6pxEKm5GjQHgNR/EA4JruL6PHvbdQt4W6eusODP
	9T6goajHS253NyK/dps/9Y1FVfbaBfXl6CV34bYRH15nh2ZYaXQxFIFO0nig4Jh/rA1DVMKu1rNoU
	cg9ynGuWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gefcL-00038y-Lk; Wed, 02 Jan 2019 12:27:25 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gefcH-00038W-KH
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 12:27:23 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x02CR3H2023476;
 Wed, 2 Jan 2019 06:27:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546432023;
 bh=lOs1pYtZZ4BDSEjaj8NL32uFIdC+voVOPDxUtK3XZqQ=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=KUFtcbKgX64YuIFQN/gkVghOgmt2bIcYbClq5J+EMbkunB6vvvuI8XJ3/8qk8uXwN
 hXCumOAtKLYIJGY1sE2jrArF4MWBx7k5mrc/wUpUDQ6ijRnjHWMAOMfzcTZwayaIbC
 ZKcSWfNwmgLyVrCVi6ovaOW5+jn9fXvc/bfjsK1I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x02CR29h028417
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 2 Jan 2019 06:27:03 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 2
 Jan 2019 06:27:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 2 Jan 2019 06:27:02 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x02CQwwT017314;
 Wed, 2 Jan 2019 06:26:59 -0600
Subject: Re: [RFC PATCH v4 12/13] irqchip: ti-sci-inta: Add support for
 Interrupt Aggregator driver
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, <marc.zyngier@arm.com>, Nishanth
 Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-12-lokeshvutla@ti.com>
 <9efbb01b-2ef9-13e7-f871-8db2c92844ee@ti.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <50da7038-9b1c-6910-2cf1-78fa98ddc3bd@ti.com>
Date: Wed, 2 Jan 2019 17:56:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9efbb01b-2ef9-13e7-f871-8db2c92844ee@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_042721_938809_0F429F77 
X-CRM114-Status: GOOD (  24.55  )
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
Cc: Tero Kristo <t-kristo@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUGV0ZXIsCgpPbiAwMi8wMS8xOSA1OjE5IFBNLCBQZXRlciBVamZhbHVzaSB3cm90ZToKPiAK
PiAKPiAKPiBPbiAyNy8xMi8yMDE4IDguMTMsIExva2VzaCBWdXRsYSB3cm90ZToKPj4gVGV4YXMg
SW5zdHJ1bWVudHMnIEszIGdlbmVyYXRpb24gU29DcyBoYXMgYW4gSVAgSW50ZXJydXB0IEFnZ3Jl
Z2F0b3IKPj4gd2hpY2ggaXMgYW4gaW50ZXJydXB0IGNvbnRyb2xsZXIgdGhhdCBkb2VzIHRoZSBm
b2xsb3dpbmc6Cj4+IC0gQ29udmVydHMgZXZlbnRzIHRvIGludGVycnVwdHMgdGhhdCBjYW4gYmUg
dW5kZXJzdG9vZCBieQo+PiAgICBhbiBpbnRlcnJ1cHQgcm91dGVyLgo+PiAtIEFsbG93cyBmb3Ig
bXVsdGlwbGV4aW5nIG9mIGV2ZW50cyB0byBpbnRlcnJ1cHRzLgo+Pgo+PiBDb25maWd1cmF0aW9u
IG9mIHRoZSBpbnRlcnJ1cHQgYWdncmVnYXRvciByZWdpc3RlcnMgY2FuIG9ubHkgYmUgZG9uZSBi
eQo+PiBhIHN5c3RlbSBjby1wcm9jZXNzb3IgYW5kIHRoZSBkcml2ZXIgbmVlZHMgdG8gc2VuZCBh
IG1lc3NhZ2UgdG8gdGhpcwo+PiBjbyBwcm9jZXNzb3Igb3ZlciBUSVNDSSBwcm90b2NvbC4KPj4K
Pj4gQWRkIHN1cHBvcnQgZm9yIEludGVycnVwdCBBZ2dyZWdhdG9yIGRyaXZlciBvdmVyIFRJU0NJ
IHByb3RvY29sLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBMb2tlc2ggVnV0bGEgPGxva2VzaHZ1dGxh
QHRpLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNp
QHRpLmNvbT4KPj4gLS0tCj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAxICsKPj4gICBkcml2ZXJzL2lycWNoaXAvS2NvbmZpZyAgICAgICAgICAgfCAgMTIgKwo+PiAg
IGRyaXZlcnMvaXJxY2hpcC9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArCj4+ICAgZHJpdmVycy9p
cnFjaGlwL2lycS10aS1zY2ktaW50YS5jIHwgNTYxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNTc1IGluc2VydGlvbnMoKykKPj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9pcnFjaGlwL2lycS10aS1zY2ktaW50YS5jCj4+Cj4+IGRpZmYg
LS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCj4+IGluZGV4IGFlYmNlNjE1MTUxZS4u
N2QxMjc4OGM4NDRhIDEwMDY0NAo+PiAtLS0gYS9NQUlOVEFJTkVSUwo+PiArKysgYi9NQUlOVEFJ
TkVSUwo+PiBAQCAtMTUwMjYsNiArMTUwMjYsNyBAQCBGOglkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRp
LXNjaS5jCj4+ICAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVw
dC1jb250cm9sbGVyL3RpLHNjaS1pbnRyLnR4dAo+PiAgIEY6CURvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci90aSxzY2ktaW50YS50eHQKPj4gICBG
Oglkcml2ZXJzL2lycWNoaXAvaXJxLXRpLXNjaS1pbnRyLmMKPj4gK0Y6CWRyaXZlcnMvaXJxY2hp
cC9pcnEtdGktc2NpLWludGEuYwo+PiAgIAo+PiAgIFRleGFzIEluc3RydW1lbnRzIEFTb0MgZHJp
dmVycwo+PiAgIE06CVBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5jb20+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZyBiL2RyaXZlcnMvaXJxY2hpcC9LY29u
ZmlnCj4+IGluZGV4IGE4ZDliZWQwMjU0Yi4uZDE2ZmQzOTQwOGFkIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2lycWNoaXAvS2NvbmZpZwo+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZwo+
PiBAQCAtNDE3LDYgKzQxNywxOCBAQCBjb25maWcgVElfU0NJX0lOVFJfSVJRQ0hJUAo+PiAgIAkg
IElmIHlvdSB3aXNoIHRvIHVzZSBpbnRlcnJ1cHQgcm91dGVyIGlycSByZXNvdXJjZXMgbWFuYWdl
ZCBieSB0aGUKPj4gICAJICBUSSBTeXN0ZW0gQ29udHJvbGxlciwgc2F5IFkgaGVyZS4gT3RoZXJ3
aXNlLCBzYXkgTi4KPj4gICAKPj4gK2NvbmZpZyBUSV9TQ0lfSU5UQV9JUlFDSElQCj4+ICsJYm9v
bAo+PiArCWRlcGVuZHMgb24gVElfU0NJX1BST1RPQ09MICYmIEFSQ0hfSzMKPj4gKwlzZWxlY3Qg
SVJRX0RPTUFJTgo+PiArCXNlbGVjdCBJUlFfRE9NQUlOX0hJRVJBUkNIWQo+PiArCXNlbGVjdCBL
M19JTlRBX01TSV9ET01BSU4KPj4gKwloZWxwCj4+ICsJICBUaGlzIGVuYWJsZXMgdGhlIGlycWNo
aXAgZHJpdmVyIHN1cHBvcnQgZm9yIEszIEludGVycnVwdCBhZ2dyZWdhdG9yCj4+ICsJICBvdmVy
IFRJIFN5c3RlbSBDb250cm9sIEludGVyZmFjZSBhdmFpbGFibGUgb24gc29tZSBuZXcgVEkncyBT
b0NzLgo+PiArCSAgSWYgeW91IHdpc2ggdG8gdXNlIGludGVycnVwdCBhZ2dyZWdhdG9yIGlycSBy
ZXNvdXJjZXMgbWFuYWdlZCBieSB0aGUKPj4gKwkgIFRJIFN5c3RlbSBDb250cm9sbGVyLCBzYXkg
WSBoZXJlLiBPdGhlcndpc2UsIHNheSBOLgo+PiArCj4+ICAgZW5kbWVudQo+PiAgIAo+PiAgIGNv
bmZpZyBTSUZJVkVfUExJQwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxl
IGIvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlCj4+IGluZGV4IGI0ZmYzNzZhMDhlZi4uYTY3OTQ5
MGE3MDU5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUKPj4gKysrIGIv
ZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlCj4+IEBAIC05NSwzICs5NSw0IEBAIG9iai0kKENPTkZJ
R19TSUZJVkVfUExJQykJCSs9IGlycS1zaWZpdmUtcGxpYy5vCj4+ICAgb2JqLSQoQ09ORklHX0lN
WF9JUlFTVEVFUikJCSs9IGlycS1pbXgtaXJxc3RlZXIubwo+PiAgIG9iai0kKENPTkZJR19NQURF
UkFfSVJRKQkJKz0gaXJxLW1hZGVyYS5vCj4+ICAgb2JqLSQoQ09ORklHX1RJX1NDSV9JTlRSX0lS
UUNISVApCSs9IGlycS10aS1zY2ktaW50ci5vCj4+ICtvYmotJChDT05GSUdfVElfU0NJX0lOVEFf
SVJRQ0hJUCkJKz0gaXJxLXRpLXNjaS1pbnRhLm8KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJx
Y2hpcC9pcnEtdGktc2NpLWludGEuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtdGktc2NpLWludGEu
Ywo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjc4YmZjODNh
MDc5YQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtdGktc2Np
LWludGEuYwo+PiBAQCAtMCwwICsxLDU2MSBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAKPj4gKy8qCj4+ICsgKiBUZXhhcyBJbnN0cnVtZW50cycgSzMgSW50ZXJydXB0
IEFnZ3JlZ2F0b3IgaXJxY2hpcCBkcml2ZXIKPj4gKyAqCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MTggVGV4YXMgSW5zdHJ1bWVudHMgSW5jb3Jwb3JhdGVkIC0gaHR0cDovL3d3dy50aS5jb20vCj4+
ICsgKglMb2tlc2ggVnV0bGEgPGxva2VzaHZ1dGxhQHRpLmNvbT4KPj4gKyAqLwo+PiArCj4+ICsj
aW5jbHVkZSA8bGludXgvZXJyLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4KPj4gKyNpbmNs
dWRlIDxsaW51eC9tc2kuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9pcnFjaGlwLmg+Cj4+ICsjaW5j
bHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNz
Lmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlcGFyYW0uaD4KPj4gKyNpbmNsdWRlIDxs
aW51eC9pcnFkb21haW4uaD4KPiAKPiBUbyBmaXggdGhpczoKPiAKPiBkcml2ZXJzL2lycWNoaXAv
aXJxLXRpLXNjaS1pbnRhLmM6IEluIGZ1bmN0aW9uIOKAmGludGFfbXNpX2lycV9oYW5kbGVy4oCZ
Ogo+IGRyaXZlcnMvaXJxY2hpcC9pcnEtdGktc2NpLWludGEuYzozMDg6ODogZXJyb3I6IOKAmElS
UUZfVFJJR0dFUl9ISUdI4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KTsgZGlkIHlvdSBtZWFuIOKAmElSUURfVFJJR0dFUl9NQVNL4oCZPwo+ICAgICAgICAgIElSUUZf
VFJJR0dFUl9ISUdIKQo+ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgICAgICAgSVJR
RF9UUklHR0VSX01BU0sKPiBkcml2ZXJzL2lycWNoaXAvaXJxLXRpLXNjaS1pbnRhLmM6MzA4Ojg6
IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBm
b3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCj4gZHJpdmVycy9pcnFjaGlwL2lycS10aS1z
Y2ktaW50YS5jOiBJbiBmdW5jdGlvbiDigJh0aV9zY2lfaW50YV9hbGxvY19wYXJlbnRfaXJx4oCZ
Ogo+IGRyaXZlcnMvaXJxY2hpcC9pcnEtdGktc2NpLWludGEuYzozNjA6Mjc6IGVycm9yOiDigJhJ
UlFGX1RSSUdHRVJfSElHSOKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlv
bik7IGRpZCB5b3UgbWVhbiDigJhJUlFEX1RSSUdHRVJfTUFTS+KAmT8KPiAgICBwYXJlbnRfZndz
cGVjLnBhcmFtWzJdID0gSVJRRl9UUklHR0VSX0hJR0g7Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIElS
UURfVFJJR0dFUl9NQVNLCj4gbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI3
NjogZHJpdmVycy9pcnFjaGlwL2lycS10aS1zY2ktaW50YS5vXSBFcnJvciAxCj4gCj4gQWRkIHRo
aXM6Cj4gI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgoKSSBkaWQgbm90IHNlZSBhbnkgc3Vj
aCBidWlsZCBlcnJvciBkdXJpbmcgbXkgdGVzdGluZyBhcyBzaG93biBiZWxvdy4gQnV0IGFncmVl
IAphYm91dCB0aGUgcmVwb3J0LiBXaWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24KCuKenCAgbGlu
dXggZ2l0OihuZXgtbWFzdGVyKSB2OG1ha2UgZGVmY29uZmlnCiAgIEhPU1RDQyAgc2NyaXB0cy9i
YXNpYy9maXhkZXAKICAgSE9TVENDICBzY3JpcHRzL2tjb25maWcvY29uZi5vCiAgIEhPU1RDQyAg
c2NyaXB0cy9rY29uZmlnL2NvbmZkYXRhLm8KICAgSE9TVENDICBzY3JpcHRzL2tjb25maWcvZXhw
ci5vCiAgIEhPU1RDQyAgc2NyaXB0cy9rY29uZmlnL3N5bWJvbC5vCiAgIEhPU1RDQyAgc2NyaXB0
cy9rY29uZmlnL3ByZXByb2Nlc3MubwogICBMRVggICAgIHNjcmlwdHMva2NvbmZpZy96Y29uZi5s
ZXguYwogICBZQUNDICAgIHNjcmlwdHMva2NvbmZpZy96Y29uZi50YWIuaAogICBIT1NUQ0MgIHNj
cmlwdHMva2NvbmZpZy96Y29uZi5sZXgubwogICBZQUNDICAgIHNjcmlwdHMva2NvbmZpZy96Y29u
Zi50YWIuYwogICBIT1NUQ0MgIHNjcmlwdHMva2NvbmZpZy96Y29uZi50YWIubwp2OCAgSE9TVExE
ICBzY3JpcHRzL2tjb25maWcvY29uZgoqKiogRGVmYXVsdCBjb25maWd1cmF0aW9uIGlzIGJhc2Vk
IG9uICdkZWZjb25maWcnCm1ha2UgIwojIGNvbmZpZ3VyYXRpb24gd3JpdHRlbiB0byAuY29uZmln
CiMKSSUgCiAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg4p6cICBsaW51eCBnaXQ6KG5l
eC1tYXN0ZXIpIHY4bWFrZSBJbWFnZSBkdGJzIC1qNCAtcwphcmNoL2FybTY0L2Jvb3QvZHRzL3Jv
Y2tjaGlwL3JrMzM5OS1ncnUtYm9iLmR0czoyNS45LTI5LjU6IFdhcm5pbmcgKGdyYXBoX3BvcnQp
OiAKL2VkcC1wYW5lbC9wb3J0czogZ3JhcGggcG9ydCBub2RlIG5hbWUgc2hvdWxkIGJlICdwb3J0
JwphcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzM5OS1ncnUta2V2aW4uZHRzOjQ2Ljkt
NTAuNTogV2FybmluZyAKKGdyYXBoX3BvcnQpOiAvZWRwLXBhbmVsL3BvcnRzOiBncmFwaCBwb3J0
IG5vZGUgbmFtZSBzaG91bGQgYmUgJ3BvcnQnCmFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszMzk5LXNhcHBoaXJlLWV4Y2F2YXRvci5kdHM6OTQuOS05OC41OiBXYXJuaW5nIAooZ3JhcGhf
cG9ydCk6IC9lZHAtcGFuZWwvcG9ydHM6IGdyYXBoIHBvcnQgbm9kZSBuYW1lIHNob3VsZCBiZSAn
cG9ydCcKPHN0ZGluPjoxMzM5OjI6IHdhcm5pbmc6ICN3YXJuaW5nIHN5c2NhbGwgb3Blbl90cmVl
IG5vdCBpbXBsZW1lbnRlZCBbLVdjcHBdCjxzdGRpbj46MTM0MjoyOiB3YXJuaW5nOiAjd2Fybmlu
ZyBzeXNjYWxsIG1vdmVfbW91bnQgbm90IGltcGxlbWVudGVkIFstV2NwcF0KPHN0ZGluPjoxMzQ1
OjI6IHdhcm5pbmc6ICN3YXJuaW5nIHN5c2NhbGwgZnNvcGVuIG5vdCBpbXBsZW1lbnRlZCBbLVdj
cHBdCjxzdGRpbj46MTM0ODoyOiB3YXJuaW5nOiAjd2FybmluZyBzeXNjYWxsIGZzY29uZmlnIG5v
dCBpbXBsZW1lbnRlZCBbLVdjcHBdCjxzdGRpbj46MTM1MToyOiB3YXJuaW5nOiAjd2FybmluZyBz
eXNjYWxsIGZzbW91bnQgbm90IGltcGxlbWVudGVkIFstV2NwcF0KPHN0ZGluPjoxMzU0OjI6IHdh
cm5pbmc6ICN3YXJuaW5nIHN5c2NhbGwgZnNwaWNrIG5vdCBpbXBsZW1lbnRlZCBbLVdjcHBdCuKe
nCAgbGludXggZ2l0OihuZXgtbWFzdGVyKQoKVGhhbmtzIGFuZCByZWdhcmRzLApMb2tlc2gKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK

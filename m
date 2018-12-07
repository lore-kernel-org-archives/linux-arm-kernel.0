Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B57C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:45:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E18020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lf6U1JNm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MQbIZius"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OKmHJjvngM9JosppK03QJooSjQ1cRLupcLMlfQ9t7aU=; b=Lf6U1JNmBrqjIO
	zcOausEX+SQLlNE+286jHBSTqlNwNStUxHKfiTEKEC+BT8sl3Y0SY04LmHtX3oVVz2PH2ZeXEou/X
	oYzAz7/3TfypWskZENf2BqvqWzlfyxl4FbXnPsIyvQL0S2KzYdOaWzVToAzkqHpmy5yv6oxW+A4FT
	6WGi2omzqkribzDVhA61HekKPY4cZCOjFhwh4uCkC/nq3uem61YUdZvvtLLsyX7NkUb90u9Mn1vGj
	vggmmac/wc86quIwub1wOG8nusBRgc4ZSW3rwjSlaGsSt0VTkyzRl4mUk7bmo5ONiM9mwBlwP6zhp
	Mg0KdQJOIvZ35NXSTBJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFVe-0002wg-By; Fri, 07 Dec 2018 12:45:34 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFVa-0002wB-AX
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:45:32 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB7CjB5H070918;
 Fri, 7 Dec 2018 06:45:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544186711;
 bh=ESyn3L7YEF3erRWdK5bLdWs+9a1zNuM+DuA7cjAG6FM=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=MQbIZiusP/y3sASXvwIAlhvjcrtTvxiIXmD2ffRhdMr0dDjOXYSG1JjYcvqI5UZ3f
 qV7Cy880+NWKhpIVkOf9/XZkdIC8c2b/03WFb8Aw8O414AtK1SX3PHlHnZLUDen1cQ
 fnf4EdhKwvQj1frWLBnIZTc7+M9Fobw0ZSBQXAUw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB7CjBkS028598
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 06:45:11 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 06:45:10 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 06:45:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7Cj7r1016203;
 Fri, 7 Dec 2018 06:45:08 -0600
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe them
 with ti-sysc
To: Tony Lindgren <tony@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com> <20181204231833.GF6707@atomide.com>
 <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
 <20181205190019.GG6707@atomide.com> <20181205230242.GH6707@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ae6c0180-ca44-c8d9-8a15-0b8debd99c9a@ti.com>
Date: Fri, 7 Dec 2018 14:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181205230242.GH6707@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_044530_466068_EA8AB2EC 
X-CRM114-Status: GOOD (  20.43  )
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
 =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VG9ueSwKCk9uIDA2LzEyLzIwMTggMS4wMiwgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiAqIFRvbnkg
TGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IFsxODEyMDUgMTk6MDBdOgo+PiBJIHRoaW5rIHdl
J3JlIG1pc3NpbmcgdGhlIHRvcCBsZXZlbCByYW5nZXMgZm9yIG1jYXNwIGwzIHBvcnQKPj4gYW5k
IHRoZSB0cmFuc2xhdGlvbiBnb2VzIHdyb25nIHRoZXJlLCBJJ2xsIGZpeCBpdCBob3BlZnVsbHkK
Pj4gdG9kYXkuCj4gCj4gQmVsb3cgaXMgYSBmaXggZm9yIGFtNDczeCB0aGF0IHdvcmtzIGZvciBt
ZSBhcyB0ZXN0ZWQgd2l0aAo+IGFtNDczeC1zay1ldm0uIENhcmUgdG8gdGVzdCBwbGVhc2U/Cgp0
aGUgcGF0Y2ggd29ya3MsIHRoYW5rcyEKClRlc3RlZC1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVy
LnVqZmFsdXNpQHRpLmNvbT4KCj4gSSdsbCBzZW5kIGFsc28gYSBzaW1pbGFyIGZpeCBmb3IgYW0z
MzV4IHNlcGFyYXRlbHkuIEFuZAo+IHRoZW4gZm9yIGRyYTcuIExvb2tzIGxpa2UgZm9yIGRyYTcg
d2UncmUgYWxzbyBtaXNzaW5nIHRoZQo+IG1jYXNwIG9wdGlvbmFsIGNsb2NrcyB0b28uCj4gCj4g
UmVnYXJkcywKPiAKPiBUb255Cj4gCj4gODwgLS0tLS0tLS0tLS0tCj4gRnJvbSB0b255IE1vbiBT
ZXAgMTcgMDA6MDA6MDAgMjAwMQo+IEZyb206IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5j
b20+Cj4gRGF0ZTogV2VkLCA1IERlYyAyMDE4IDE0OjA4OjIxIC0wODAwCj4gU3ViamVjdDogW1BB
VENIXSBBUk06IGR0czogQWRkIG1pc3NpbmcgcmFuZ2VzIGZvciBhbTQzN3ggbWNhc3AgbDMgcG9y
dHMKPiAKPiBXZSBuZWVkIHRvIGFkZCBtY2FzcCBsMyBwb3J0IHJhbmdlcyBmb3IgbWNhc3AgdG8g
dXNlIGEgY29ycmVjdCBsMwo+IGRhdGEgcG9ydCBhZGRyZXNzIGZvciBkbWEuCj4gCj4gRml4ZXM6
IGQ5NWFkZmQ0NTg1MyAoIkFSTTogZHRzOiBhbTQzN3g6IE1vdmUgbDQgY2hpbGQgZGV2aWNlcyB0
bwo+IHByb2JlIHRoZW0gd2l0aCB0aS1zeXNjIikKPiBSZXBvcnRlZC1ieTogUGV0ZXIgVWpmYWx1
c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBUb255IExpbmRncmVu
IDx0b255QGF0b21pZGUuY29tPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9hbTQzN3gtbDQu
ZHRzaSB8IDE0ICsrKysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
bTQzN3gtbDQuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FtNDM3eC1sNC5kdHNpCj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvYW00Mzd4LWw0LmR0c2kKPiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9hbTQzN3gtbDQuZHRzaQo+IEBAIC02MTMsNyArNjEzLDkgQEAKPiAgCXJhbmdlcyA9IDwweDAw
MDAwMDAwIDB4NDgwMDAwMDAgMHgxMDAwMDA+LAkvKiBzZWdtZW50IDAgKi8KPiAgCQkgPDB4MDAx
MDAwMDAgMHg0ODEwMDAwMCAweDEwMDAwMD4sCS8qIHNlZ21lbnQgMSAqLwo+ICAJCSA8MHgwMDIw
MDAwMCAweDQ4MjAwMDAwIDB4MTAwMDAwPiwJLyogc2VnbWVudCAyICovCj4gLQkJIDwweDAwMzAw
MDAwIDB4NDgzMDAwMDAgMHgxMDAwMDA+OwkvKiBzZWdtZW50IDMgKi8KPiArCQkgPDB4MDAzMDAw
MDAgMHg0ODMwMDAwMCAweDEwMDAwMD4sCS8qIHNlZ21lbnQgMyAqLwo+ICsJCSA8MHg0NjAwMDAw
MCAweDQ2MDAwMDAwIDB4NDAwMDAwPiwJLyogbDMgZGF0YSBwb3J0ICovCj4gKwkJIDwweDQ2NDAw
MDAwIDB4NDY0MDAwMDAgMHg0MDAwMDA+OwkvKiBsMyBkYXRhIHBvcnQgKi8KPiAgCj4gIAlzZWdt
ZW50QDAgewkJCQkJLyogMHg0ODAwMDAwMCAqLwo+ICAJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1
cyI7Cj4gQEAgLTY2NCw3ICs2NjYsOSBAQAo+ICAJCQkgPDB4MDAwMzQwMDAgMHgwMDAzNDAwMCAw
eDAwMTAwMD4sCS8qIGFwIDgwICovCj4gIAkJCSA8MHgwMDAzNTAwMCAweDAwMDM1MDAwIDB4MDAx
MDAwPiwJLyogYXAgODEgKi8KPiAgCQkJIDwweDAwMDM2MDAwIDB4MDAwMzYwMDAgMHgwMDEwMDA+
LAkvKiBhcCA4NCAqLwo+IC0JCQkgPDB4MDAwMzcwMDAgMHgwMDAzNzAwMCAweDAwMTAwMD47CS8q
IGFwIDg1ICovCj4gKwkJCSA8MHgwMDAzNzAwMCAweDAwMDM3MDAwIDB4MDAxMDAwPiwJLyogYXAg
ODUgKi8KPiArCQkJIDwweDQ2MDAwMDAwIDB4NDYwMDAwMDAgMHg0MDAwMDA+LAkvKiBsMyBkYXRh
IHBvcnQgKi8KPiArCQkJIDwweDQ2NDAwMDAwIDB4NDY0MDAwMDAgMHg0MDAwMDA+OwkvKiBsMyBk
YXRhIHBvcnQgKi8KPiAgCj4gIAkJdGFyZ2V0LW1vZHVsZUA4MDAwIHsJCQkvKiAweDQ4MDA4MDAw
LCBhcCA2IDEwLjAgKi8KPiAgCQkJY29tcGF0aWJsZSA9ICJ0aSxzeXNjIjsKPiBAQCAtODI2LDcg
KzgzMCw4IEBACj4gIAkJCWNsb2NrLW5hbWVzID0gImZjayI7Cj4gIAkJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+Owo+ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsKPiAtCQkJcmFuZ2VzID0gPDB4MCAweDM4
MDAwIDB4MjAwMD47Cj4gKwkJCXJhbmdlcyA9IDwweDAgMHgzODAwMCAweDIwMDA+LAo+ICsJCQkJ
IDwweDQ2MDAwMDAwIDB4NDYwMDAwMDAgMHg0MDAwMDA+Owo+ICAKPiAgCQkJbWNhc3AwOiBtY2Fz
cEAwIHsKPiAgCQkJCWNvbXBhdGlibGUgPSAidGksYW0zM3h4LW1jYXNwLWF1ZGlvIjsKPiBAQCAt
ODU3LDcgKzg2Miw4IEBACj4gIAkJCWNsb2NrLW5hbWVzID0gImZjayI7Cj4gIAkJCSNhZGRyZXNz
LWNlbGxzID0gPDE+Owo+ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsKPiAtCQkJcmFuZ2VzID0gPDB4
MCAweDNjMDAwIDB4MjAwMD47Cj4gKwkJCXJhbmdlcyA9IDwweDAgMHgzYzAwMCAweDIwMDA+LAo+
ICsJCQkJIDwweDQ2NDAwMDAwIDB4NDY0MDAwMDAgMHg0MDAwMDA+Owo+ICAKPiAgCQkJbWNhc3Ax
OiBtY2FzcEAwIHsKPiAgCQkJCWNvbXBhdGlibGUgPSAidGksYW0zM3h4LW1jYXNwLWF1ZGlvIjsK
PiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1
IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290
aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
